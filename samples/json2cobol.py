import json

def json_to_cobol(json_data, level=1, indent=0):
    cobol_code = ""
    for key, value in json_data.items():
        if isinstance(value, dict):
            cobol_code += " " * indent + f"{level:02} {key.replace('_', '-').upper()}.\n"
            cobol_code += json_to_cobol(value, level + 1, indent + 3)
        elif isinstance(value, list):
            cobol_code += " " * indent + f"{level:02} {key.replace('_', '-').upper()} OCCURS {len(value)} TIMES.\n"
            if value and isinstance(value[0], dict):
                cobol_code += json_to_cobol(value[0], level + 1, indent + 3)
        else:
            cobol_type = "PIC X" if isinstance(value, str) else "PIC 9"
            cobol_code += " " * indent + f"{level:02} {key.replace('_', '-').upper()} {cobol_type}({len(str(value))}).\n"
    return cobol_code

# Example JSON
json_input = '''
{
  "customer": {
    "name": "John Doe",
    "age": 30,
    "address": {
      "street": "123 Main St",
      "city": "Anytown",
      "state": "CA"
    },
    "orders": [
      { "id": 1, "amount": 100.50 },
      { "id": 2, "amount": 200.75 }
    ]
  }
}
'''

# Convert JSON to COBOL
data = json.loads(json_input)
cobol_output = json_to_cobol(data)
print(cobol_output)