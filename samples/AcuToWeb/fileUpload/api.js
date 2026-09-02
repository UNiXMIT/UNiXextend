// REQUIREMENTS
// Install node.js - https://nodejs.dev/learn/how-to-install-nodejs
// Install busboy - https://www.npmjs.com/package/busboy
// Start Web Server - node api.js
// This sample saves all incoming files to disk

const { randomFillSync } = require('crypto');
const fs = require('fs');
const http = require('http');
const path = require('path');
const busboy = require('busboy');

// Location to save uploaded files
const saveLocation = '/tmp'

const random = (() => {
  const buf = Buffer.alloc(16);
  return () => randomFillSync(buf).toString('hex');
})();

http.createServer((req, res) => {
  if (req.method === 'POST') {
    const bb = busboy({ headers: req.headers });
    bb.on('file', (name, file, info) => {
      finalName = (info.filename + '.' + `${random()}`);
      const saveTo = path.join(saveLocation, finalName);
      file.pipe(fs.createWriteStream(saveTo));
    });
    bb.on('close', () => {
      res.writeHead(200, { 'Connection': 'close',
                           'uploadedFile': finalName,
                           'Access-Control-Allow-Origin': '*',
                           'Access-Control-Expose-Headers': 'uploadedFile'
      });
      res.end(`File Uploaded!`);
    });
    req.pipe(bb);
    return;
  }
  res.writeHead(404);
  res.end();
}).listen(8081, () => {
  console.log('Listening for requests on port 8081');
});