#!/bin/sh
 
filename=$(ls "$1" | sed 's/\(.*\)\..*/\1/')
 
if [ "" = "$filename" ]
then
  echo "Datei nicht gefunden. Ende."
  exit 1
fi
 
tempname="/tmp/pdf2book"
 
pdfjam --outfile ".$filename.pdf" --paper letterpaper "$filename.pdf"

#pdf2ps "$filename.pdf" "$tempname.1.ps"
pdf2ps ".$filename.pdf" "$tempname.1.ps"
rm ".$filename.pdf"
 
if [ "$2" = "" ]
  then psbook -q "$tempname.1.ps" "$tempname.2.ps";
  else psbook -q -s$2 "$tempname.1.ps" "$tempname.2.ps";
fi
 
psnup -q -2 "$tempname.2.ps" "$tempname.1.ps"
 
ps2pdf "$tempname.1.ps" "$filename.book.pdf"
