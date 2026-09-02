#!/bin/bash
ccbl -ga -fa writebooks.cbl
runcbl -c cblconfig writebooks.acu
xsltproc writebooks.xsl writebookfile.xml > writebookfile-transformed.xml