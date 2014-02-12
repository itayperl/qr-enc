Encoder/decoder for arbitrary data in QR codes.

The encoder script receives any file and writes a PDF file with a bunch of QR
codes holding the file's content. 

The decoder takes a scan of these QR codes and restores the original file.

Dependencies:
-------------
- [qrencode](http://fukuchi.org/works/qrencode) (encoder only)
- [zbar](http://zbar.sourceforge.net) (decoder only)
- ImageMagick
- Bash
