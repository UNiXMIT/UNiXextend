# XML EXPORT FILE is not working when using an XSLT Stylesheet
## Environment
Enterprise Developer  
Visual COBOL  
AcuCOBOL-GT extend  
Windows  
Linux/UNIX  

## Situation
When using XML EXPORT FILE with an XSLT Stylesheet, the XML created is incorrect/empty.  

## Resolution
The XSLT should be checked for any issues, outside of XML EXTENSIONS.  
The XSLT can be checked in a number of ways. One way is to use Visual Studio.  
The Visual Studio XML editor lets an XSLT stylesheet be associated with an XML document, perform the transformation, and view the output. The resulting output from the XSLT transformation is displayed in a new document window.  

1. Open an XML document in the XML editor.

2. Associate an XSLT style sheet with the XML document:

    - Add an xml-stylesheet processing instruction to the XML document. For example, add the following line to the document prolog: 
    ```
    <?xml-stylesheet type='text/xsl' href='filename.xsl'?>
    ```
    
    or

    - Add the XSLT style sheet using the Properties window. With the XML file open in the editor, right-click anywhere in the editor and choose Properties. In the Properties window, click in the Stylesheet field and choose the browse button (...). Select the XSLT style sheet, and then choose Open.

3. On the menu bar, choose XML > Start XSLT Without Debugging. Or, press Ctrl+Alt+F5.  

If the XSLT is correct, the output from the XSLT transformation is displayed in a new document window.  

https://learn.microsoft.com/en-us/visualstudio/xml-tools/how-to-execute-an-xslt-transformation-from-the-xml-editor?view=vs-2022  