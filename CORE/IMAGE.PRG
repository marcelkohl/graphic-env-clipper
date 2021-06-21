#INCLUDE "..\LIBS\FGL.CH"
*----------------------------------------------------------------------------
* Modulo de controle das imagens
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION BUILD_IMAGE(NuIm)
*----------------------------------------------------------------------------
* monta imagens

   LOCAL TdI, Ini, Fim, TImg

   IF NObj[6] == 0
      RETURN
   ENDIF

   *---------------- Verifica qual imagem sera montada ----------------------
   IF NuIm == NIL
      Ini := 1
      Fim := NObj[6]
   ELSE
      Ini := NuIm
      Fim := NuIm
   ENDIF
   *---------------- Monta as imagens ---------------------------------------
   FOR TdI := Ini TO Fim
      TImg := FGLLoadBMP('IMAGES\'+(Im[TdI,3]+'.'+Im[TdI,4]))
      FGLShowDIB(Im[TdI,1],Im[TdI,2],TImg,FGL_IMG_MAPONCURRENT)
   NEXT TdI
   *-------------------------------------------------------------------------
RETURN
