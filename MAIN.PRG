*---------------------------------------
* Graphics Multitask Core for Clipper
* Author: Marcel V. Kohls
* Date: 16-02-1998
*---------------------------------------

#INCLUDE "LIBS\FGL.CH"

FGLSetMode(FGL_GRAPHICS_640_480_16)

// SETCANCEL(.F.)
SET SCORE OFF
SET CENTURY ON
SET DELETE ON
SET DATE TO FRENCH
SET DECIMALS TO 2

SET_GLOBALS()

FGLSetColor(clTeal)
FGLFillRectangle(0, 0, 640, 460)

SET PROCEDURE TO WINDOW
SET PROCEDURE TO BUTTON
SET PROCEDURE TO INPUT
SET PROCEDURE TO PHARMA
SET PROCEDURE TO CHKBOX
SET PROCEDURE TO SELBOX
SET PROCEDURE TO LABEL
SET PROCEDURE TO IMAGE
SET PROCEDURE TO BOX
SET PROCEDURE TO DIVIDER
SET PROCEDURE TO TB

LOADJAN('SAMPLE.JNL')

PMS(TRUE)
MAIN_ENV()
FGLSetMode(FGL_TEXT)
RETURN

FUNCTION MAIN_ENV()
DO WHILE .T.
   *-------------- Monta janela exposta a variavel --------------------------
   IF LEN(Jn[1]) > 0
      BUILD_WINDOW()
   ENDIF

   *-------------- Laco principal do sistema --------------------------------
   DO WHILE .T.
      keypress := INKEY()

      *------------- Verifica se mouse foi pressionado -------------------------
      aMState := FGLMState()

      IF XOld <> aMState[1] .OR. YOld <> aMState[2]
         PMS(FALSE)
         XOld := aMState[1]
         YOld := aMState[2]
         PMS(TRUE)
      ENDIF

      IF MPres == FALSE .AND. aMState[STATE_LEF] == BUTTON_DOW
         MX    := aMState[1]
         MY    := aMState[2]

         VJANFECHA()
         INCLK()
         CBCLK()
         SBCLK()
         TBCLK()
         BUTTON_CLICK()

         MPres := TRUE
      ENDIF

      *------------- Verifica se mouse foi largado -----------------------------
      IF MPres == TRUE .AND. aMState[STATE_LEF] == BUTTON_UP
         MX    := aMState[1]
         MY    := aMState[2]

         JANFECHA(FALSE)
         BUTTON_UNCLICK()
         CBUNCLK()
         SBUNCLK()

         MPres := FALSE
      ELSEIF keypress <> 0
         IF keypress == 27
            TBIGRV(keypress)
            JANFECHA(keypress)
         ELSE
            INESC(keypress)
            TBTCL(keypress)
            BUTTON_KEYPRESS(keypress)
         ENDIF
      ENDIF

      IF Remonta == TRUE
         Remonta := FALSE
         EXIT
      ELSEIF KEEP_ALIVE == FALSE
         KEEP_ALIVE := TRUE
         RETURN
      ENDIF

      IF MenuAti == FALSE
         INPIS()
         TBIPIS()
      ENDIF

   ENDDO
ENDDO
