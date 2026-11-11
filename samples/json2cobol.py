"""Generate AcuCOBOL data items and JSON PARSE name mappings.

Usage: python json2cobol.py response.json --output response.cbl
       python json2cobol.py < response.json

The generated sizes are based on the examples, not an API schema. Increase
them for values and array lengths that may occur in future responses.
ACUCOBOL reports a nonzero JSON status when an array length differs from its
OCCURS count, even when the array fits; see the JSON PARSE documentation.
The input must be an object. Nulls, booleans, empty objects or arrays,
nested arrays, incompatible types and numbers over 18 digits are rejected
because their representation cannot be inferred safely from this example.
"""

import argparse
import json
import re
import sys
from decimal import Decimal
from pathlib import Path


class ConversionError(ValueError):
    """The example cannot be represented safely by this converter."""


def _object_without_duplicates(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ConversionError(f"duplicate JSON key: {key!r}")
        result[key] = value
    return result


def _invalid_constant(value):
    raise ConversionError(f"invalid JSON number: {value}")


class Converter:
    def __init__(self, min_string=20, min_occurs=1):
        if min_string < 1 or min_occurs < 1:
            raise ConversionError("minimum sizes must be positive")
        self.min_string = min_string
        self.min_occurs = min_occurs
        self.used_names = {"JSON-DATA"}
        self.declarations = []
        self.mappings = []

    def name_for(self, key):
        # A prefix avoids COBOL reserved words and digit-only identifiers.
        stem = re.sub(r"[^A-Za-z0-9]+", "-", key).strip("-").upper()
        stem = (stem or "FIELD")[:22].rstrip("-")
        base = "J-" + stem
        name = base
        number = 2
        while name in self.used_names:
            suffix = f"-{number}"
            name = base[: 30 - len(suffix)].rstrip("-") + suffix
            number += 1
        self.used_names.add(name)
        return name

    def add_field(self, key, values, level, path):
        if level > 49:
            raise ConversionError(f"{path}: nesting exceeds COBOL level 49")
        if any(ord(char) < 32 or ord(char) == 127 for char in key):
            raise ConversionError(f"{path}: control characters in keys are unsupported")
        literal = "'" + key.replace("'", "''") + "'"
        if len(literal.encode("utf-8")) > 48:
            raise ConversionError(f"{path}: JSON key is too long for a fixed-format literal")

        name = self.name_for(key)
        self.mappings.append((name, literal))
        indent = " " * (7 + 2 * ((level - 5) // 5))
        prefix = f"{indent}{level:02d} {name}"

        if any(value is None for value in values):
            raise ConversionError(f"{path}: null values need an explicit COBOL representation")
        if all(isinstance(value, dict) for value in values):
            self.declarations.append(prefix + ".")
            self.add_object(values, level + 5, path)
        elif all(isinstance(value, list) for value in values):
            if any(not value for value in values):
                raise ConversionError(f"{path}: cannot infer the type of an empty array")
            elements = [element for array in values for element in array]
            count = max(self.min_occurs, *(len(array) for array in values))
            occurs = f" OCCURS {count} TIMES"
            if all(isinstance(element, dict) for element in elements):
                self.declarations.append(prefix + occurs + ".")
                self.add_object(elements, level + 5, path + "[]")
            elif any(isinstance(element, (dict, list)) for element in elements):
                raise ConversionError(f"{path}: mixed or nested arrays are unsupported")
            else:
                self.declarations.append(
                    prefix + occurs + " " + self.picture(elements, path + "[]") + "."
                )
        elif any(isinstance(value, (dict, list)) for value in values):
            raise ConversionError(f"{path}: incompatible value types in examples")
        else:
            self.declarations.append(prefix + " " + self.picture(values, path) + ".")

    def add_object(self, objects, level, path):
        fields = {}
        for obj in objects:
            for key, value in obj.items():
                fields.setdefault(key, []).append(value)
        if not fields:
            raise ConversionError(f"{path}: cannot infer fields from an empty object")
        for key, values in fields.items():
            self.add_field(key, values, level, f"{path}[{key!r}]")

    def picture(self, values, path):
        if all(isinstance(value, str) for value in values):
            size = max(self.min_string, *(len(value.encode("utf-8")) for value in values))
            return f"PIC X({size})"
        if all(isinstance(value, (int, Decimal)) and not isinstance(value, bool)
               for value in values):
            numbers = [Decimal(value) for value in values]
            integer_digits = max(1, *(number.adjusted() + 1 for number in numbers))
            decimal_digits = max(0, *(-number.as_tuple().exponent for number in numbers))
            if integer_digits + decimal_digits > 18:
                raise ConversionError(f"{path}: numeric precision exceeds 18 digits")
            sign = "S" if any(number.is_signed() for number in numbers) else ""
            fraction = f"V9({decimal_digits})" if decimal_digits else ""
            return f"PIC {sign}9({integer_digits}){fraction}"
        raise ConversionError(f"{path}: unsupported or incompatible scalar types")

    def convert(self, data):
        if not isinstance(data, dict):
            raise ConversionError("the JSON root must be an object")
        self.add_object([data], 5, "$")
        lines = ["       01 JSON-DATA.", *self.declarations, "",
                 "           JSON PARSE RESPONSE-DATA INTO JSON-DATA",
                 "               NAME JSON-DATA OMITTED"]
        for name, literal in self.mappings:
            lines.extend((f"                {name} IS", f"                    {literal}"))
        lines.extend(("               ON EXCEPTION",
                      '                   DISPLAY "JSON PARSE failed"',
                      "           END-JSON."))
        if any(len(line.encode("utf-8")) > 72 for line in lines):
            raise ConversionError("generated line exceeds fixed-format column 72")
        return "\n".join(lines) + "\n"


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("input", nargs="?", help="UTF-8 JSON file (default: standard input)")
    parser.add_argument("-o", "--output", help="UTF-8 output file (default: standard output)")
    parser.add_argument("--min-string", type=int, default=20,
                        help="minimum PIC X size in bytes (default: 20)")
    parser.add_argument("--min-occurs", type=int, default=1,
                        help="minimum array capacity (default: 1)")
    args = parser.parse_args(argv)
    try:
        if args.input:
            text = Path(args.input).read_text(encoding="utf-8-sig")
        else:
            sys.stdin.reconfigure(encoding="utf-8-sig")
            text = sys.stdin.read()
        data = json.loads(text, parse_float=Decimal,
                          parse_constant=_invalid_constant,
                          object_pairs_hook=_object_without_duplicates)
        output = Converter(args.min_string, args.min_occurs).convert(data)
        if args.output:
            if args.input and Path(args.input).resolve() == Path(args.output).resolve():
                raise ConversionError("input and output files must be different")
            Path(args.output).write_text(output, encoding="utf-8")
        else:
            sys.stdout.reconfigure(encoding="utf-8")
            sys.stdout.write(output)
    except (OSError, UnicodeError, json.JSONDecodeError, ConversionError) as error:
        parser.exit(2, f"{parser.prog}: error: {error}\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
