#INCLUDE "..\LIBS\FGL.CH"

FUNCTION BOX_UP(colIni, rowIni, colFin, rowFin, fillColor)
   IF fillColor <> NIL
      RECT(colIni, rowIni, colFin, rowFin, 1, fillColor)
   ENDIF

   RECT(colIni, rowIni, colFin, rowFin, 2, clBlack)

   LINE(colIni+1, rowIni+1, colIni+1, rowFin-1, clWhite)
   LINE(colIni+1, rowIni+1, colFin-1, rowIni+1, clWhite)
   LINE(colFin-1, rowIni+1, colFin-1, rowFin-1, clDkGray)
   LINE(colFin-1, rowFin-1, colIni+1, rowFin-1, clDkGray)
RETURN

FUNCTION BOX_DOWN(colIni, rowIni, colFin, rowFin, fillColor, type)
   LOCAL leftUpCorners := 0, rightDownCorners := 0

   IF fillColor <> NIL
      RECT(colIni, rowIni, colFin, rowFin, 1, fillColor)
   ENDIF

   IF type == 1       // border outside
      leftUpCorners := -1
      rightDownCorners := +1
   ELSEIF type == 2   // border inside
      leftUpCorners := +1
      rightDownCorners := -1
   ENDIF

   RECT(colIni+leftUpCorners, rowIni+leftUpCorners, colFin+rightDownCorners, rowFin+rightDownCorners, 2, clBlack)

   LINE(colIni, rowIni, colIni, rowFin, clDkGray)
   LINE(colIni, rowIni, colFin, rowIni, clDkGray)
   LINE(colFin, rowIni, colFin, rowFin, clWhite)
   LINE(colFin, rowFin, colIni, rowFin, clWhite)
RETURN

FUNCTION LINE(colIni, rowIni, colFin, rowFin, Color)
   FGLSetColor(Color)
   FGLLine(colIni, rowIni, colFin, rowFin)
RETURN

FUNCTION RECT(colIni, rowIni, colFin, rowFin, Type, Color)
* FILL == 1

   IF Type == 1
      FGLSetColor(Color)
      FGLFillRectangle(colIni, rowIni, colFin, rowFin)
   ELSE
      FGLRectangle(colIni, rowIni, colFin, rowFin, Color)
   ENDIF
RETURN

FUNCTION CAIXABO(colIni, rowIni, colFin, rowFin)
   LINE(colIni, rowIni, colFin, rowIni, clDkGray)
   LINE(colIni, rowIni, colIni, rowFin, clDkGray)
   LINE(colIni, rowFin, colFin, rowFin, clWhite)
   LINE(colFin, rowFin, colFin, rowIni, clWhite)

   LINE(colIni+2, rowIni+2, colFin-2, rowIni+2, clWhite)
   LINE(colIni+2, rowIni+2, colIni+2, rowFin-2, clWhite)
   LINE(colIni+2, rowFin-2, colFin-2, rowFin-2, clDkGray)
   LINE(colFin-2, rowFin-2, colFin-2, rowIni+2, clDkGray)

   RECT(colIni+1, rowIni+1, colFin-1, rowFin-1, 0, clBlack)
RETURN

FUNCTION PRNT(col, row , text, color1, color2, isBold)
   IF isBold == TRUE
      FGLFontSet(bFonte)
   ELSE
      FGLFontSet(aFonte)
   ENDIF

   IF color2 == NIL
      FGLWriteAt(col, row, color1,, text)
   ELSE
      FGLWriteAt(col, row, color1, color2, text)
   ENDIF
RETURN
