fileUpload.php – This is the server side PHP script that receives the file, renames the file (if a file of the same name already exists), moves the file to the selected location on the server and sets the permissions.

Or you could do similar with node.js:

api.js - Javascript file than can be run with node.js to start up a web api for file uploads using POST requests.

fileUpload.cbl – This uses the ATW-SCRIPT feature in 10.4 to execute Javascript in AcuToWeb. You will need to change the URL of the server on line 76. The Upload button executes Javascript that calls the native open file dialog of the browser and allows you to upload multiple files. It then creates a Javascript array of the filenames that have been uploaded (and renamed where necessary by the PHP script).

The FileNames button executes Javascript that gets the array of names and imports that into the COBOL program.