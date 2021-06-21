#INCLUDE "..\LIBS\FGL.CH"
#INCLUDE "FILEIO.CH"

*----------------------------------------------------------------------------
* Modulo de controple de janelas
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION LOADJAN(NomJan,Rt)
*----------------------------------------------------------------------------
* carrega matriz Jn[x] com os valores da janela
* qdo Rt for igual a 1 entaum a janela aberta atualmente ficara inativa, caso
* Rt for igual a 0 entaum a janela se fecha
*
* Jn[9]
* 1=nome_jan, 2=X1, 3=Y1, 4=X2, 5=Y2, 6=Cor do titulo, 7=Titulo,
* 8=Funcao de retorno, 9=Tipo da janela
*
* NObj[11]
* 1=Botoes, 2=inputs, 3=chkboxes, 4=selboxes, 5=textos, 6=imagens, 7=caixas,
* 8=linhas, 9=tbs, 10=tbcs

   LOCAL JanAbe, TdObj, T_ler, TQtd, NScr, T_Tam
   LOCAL JanCab := SPACE(32)          // Guarda cabecalho da janela
   LOCAL T_Obj  := {}

   NomJan := ALLTRIM(NomJan)

   IF !FILE(NomJan)
      RETURN
   ENDIF

   *------------ desativa ou apaga janela anterior --------------------------
   IF LEN(Jn[1]) > 0 .AND. Rt <> NIL
      IF Rt == 1
         DEAJAN(Jn[7])
      ELSEIF Rt == 0
         NScr := (SUBSTR(Jn[1],1,AT('.',Jn[1])-1)+'.SCR')
         RTELA(Jn[2], Jn[3], NScr)
      ENDIF
   ENDIF
   *------------ Zera as variaveis da janela atual --------------------------
   ZVARJ()
   *------------ Abre nova janela -------------------------------------------
   JanAbe := FOPEN(NomJan,0)

   FREAD(JanAbe,@JanCab,32)    // Cabecalho da janela

   *------------ Captura valores de coordenada da janela --------------------
   ASIZE(T_Obj,8)
   T_Tam := {3,3,3,3,10,3,100,1}

   FOR TdObj := 1 TO 8
      T_Ler := SPACE(T_Tam[TdObj])
      FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
      T_Obj[TdObj] := T_Ler
   NEXT TdObj

   FSEEK(JanAbe,76,1)

   Jn[1] := NomJan
   Jn[2] := VAL(T_Obj[1])
   Jn[3] := VAL(T_Obj[2])
   Jn[4] := VAL(T_Obj[3])
   Jn[5] := VAL(T_Obj[4])
   Jn[6] := VAL(T_Obj[6])
   Jn[7] := TXT2FNT(ALLTRIM(T_Obj[7]))
   Jn[8] := ALLTRIM(T_Obj[5])
   Jn[9] := VAL(T_Obj[8])

   *------------ Captura botoes da janela -----------------------------------
   ASIZE(T_Obj,10)
   T_Tam   := {3,3,3,3,4,50,10,1,1,12}
   NObj[1] := VAL(SUBSTR(JanCab,1,3))

   ASIZE(Bt,NObj[1])

   FOR TQtd := 1 TO NObj[1]

      FOR TdObj := 1 TO 10
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,112,1)

      Bt[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),VAL(T_Obj[4]),VAL(T_Obj[5]),TXT2FNT(ALLTRIM(T_Obj[6])),ALLTRIM(T_Obj[7]),ALLTRIM(T_Obj[8]),ALLTRIM(T_Obj[9]),ALLTRIM(T_Obj[10])}

   NEXT TQtd

   *------------ Captura inputs da janela -----------------------------------
   ASIZE(T_Obj,10)
   T_Tam   := {3,3,3,3,3,1,1,3,30,100}
   NObj[2] := VAL(SUBSTR(JanCab,4,3))

   ASIZE(In,NObj[2])

   FOR TQtd := 1 TO NObj[2]

      FOR TdObj := 1 TO 10
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,52,1)

      In[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),VAL(T_Obj[4]),VAL(T_Obj[5]),ALLTRIM(T_Obj[6]),ALLTRIM(T_Obj[7]),VAL(T_Obj[8]),TXT2FNT(ALLTRIM(T_Obj[9])),ALLTRIM(T_Obj[10])}

   NEXT TQtd

   *------------ Captura chkboxes -------------------------------------------
   ASIZE(T_Obj,8)
   T_Tam   := {3,3,3,100,3,10,1,1}
   NObj[3] := VAL(SUBSTR(JanCab,7,3))

   ASIZE(Cb,NObj[3])

   FOR TQtd := 1 TO NObj[3]

      FOR TdObj := 1 TO 8
         T_Ler := SPACE(T_Tam[TdObj])
         XRet := FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,78,1)

      Cb[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),TXT2FNT(ALLTRIM(T_Obj[4])),VAL(T_Obj[5]),ALLTRIM(T_Obj[6]),ALLTRIM(T_Obj[7]),ALLTRIM(T_Obj[8])}

   NEXT TQtd

   *------------ Captura Selboxes -------------------------------------------
   ASIZE(T_Obj,9)
   T_Tam   := {3,1,3,3,100,3,10,1,1}
   NObj[4] := VAL(SUBSTR(JanCab,10,3))

   ASIZE(Sb,NObj[4])

   FOR TQtd := 1 TO NObj[4]

      FOR TdObj := 1 TO 9
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,77,1)

      Sb[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),VAL(T_Obj[4]),TXT2FNT(ALLTRIM(T_Obj[5])),VAL(T_Obj[6]),ALLTRIM(T_Obj[7]),ALLTRIM(T_Obj[8]),ALLTRIM(T_Obj[9])}

   NEXT TQtd

   *------------ Captura Textos ---------------------------------------------
   ASIZE(T_Obj,5)
   T_Tam   := {3,3,3,100,1}
   NObj[5] := VAL(SUBSTR(JanCab,13,3))

   ASIZE(Tx,NObj[5])

   FOR TQtd := 1 TO NObj[5]

      FOR TdObj := 1 TO 5
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,92,1)

      Tx[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),TXT2FNT(ALLTRIM(T_Obj[4])),VAL(T_Obj[5])}

   NEXT TQtd

   *------------ Captura Imagens --------------------------------------------
   ASIZE(T_Obj,4)
   T_Tam   := {3,3,8,3}
   NObj[6] := VAL(SUBSTR(JanCab,16,3))

   ASIZE(Im,NObj[6])

   FOR TQtd := 1 TO NObj[6]

      FOR TdObj := 1 TO 4
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,185,1)

      Im[TQtd] := {VAL(T_Obj[1]), VAL(T_Obj[2]), ALLTRIM(T_Obj[3]), ALLTRIM(T_Obj[4])}

   NEXT TQtd

   *------------ Captura Caixas ---------------------------------------------
   ASIZE(T_Obj,7)
   T_Tam   := {3,3,3,3,3,1,100}
   NObj[7] := VAL(SUBSTR(JanCab,19,3))

   ASIZE(Cx,NObj[7])

   FOR TQtd := 1 TO NObj[7]

      FOR TdObj := 1 TO 7
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,86,1)

      Cx[TQtd] := {VAL(T_Obj[1]), VAL(T_Obj[2]), VAL(T_Obj[3]), VAL(T_Obj[4]), VAL(T_Obj[5]), ALLTRIM(T_Obj[6]), TXT2FNT(ALLTRIM(T_Obj[7]))}

   NEXT TQtd

   *------------ Captura Linhas ---------------------------------------------
   ASIZE(T_Obj,8)
   T_Tam   := {3,3,3,3,3}
   NObj[8] := VAL(SUBSTR(JanCab,22,3))

   ASIZE(Li,NObj[8])

   FOR TQtd := 1 TO NObj[8]

      FOR TdObj := 1 TO 5
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,187,1)

      Li[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),VAL(T_Obj[4]),VAL(T_Obj[5])}
   NEXT TQtd

   *------------ Captura TBrowses -------------------------------------------
   ASIZE(T_Obj,9)
   T_Tam   := {3,3,3,3,10,3}
   NObj[9] := VAL(SUBSTR(JanCab,25,3))

   ASIZE(Tb,NObj[9])

   FOR TQtd := 1 TO NObj[9]

      FOR TdObj := 1 TO 6
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,177,1)

      Tb[TQtd] := {VAL(T_Obj[1]),VAL(T_Obj[2]),VAL(T_Obj[3]),VAL(T_Obj[4]),ALLTRIM(T_Obj[5]),VAL(T_Obj[6])}
   NEXT TQtd

   *------------ Captura TBcs -----------------------------------------------
   ASIZE(T_Obj,9)
   T_Tam   := {3,3,10,30,10,1,3,1,10}
   NObj[10] := VAL(SUBSTR(JanCab,28,3))

   ASIZE(Tc,NObj[10])

   FOR TQtd := 1 TO NObj[10]

      FOR TdObj := 1 TO 9
         T_Ler := SPACE(T_Tam[TdObj])
         FREAD(JanAbe,@T_Ler, T_Tam[TdObj])
         T_Obj[TdObj] := T_Ler
      NEXT TdObj

      FSEEK(JanAbe,131,1)

      Tc[TQtd] := {VAL(T_Obj[2]),ALLTRIM(T_Obj[3]),TXT2FNT(ALLTRIM(T_Obj[4])),ALLTRIM(T_Obj[5]),ALLTRIM(T_Obj[6]),VAL(T_Obj[7]),VAL(T_Obj[8]),ALLTRIM(T_Obj[9])}

   NEXT TQtd

   FCLOSE(JanAbe)
   *-------------------------------------------------------------------------

RETURN

*----------------------------------------------------------------------------
FUNCTION BUILD_WINDOW()
*----------------------------------------------------------------------------
* Monta janela de nome atribuida a Jn[1]

   LOCAL NScr

   *----------------------- Salva janela, se ela ainda naum foi salva -------
   NScr := (SUBSTR(Jn[1],1,AT('.',Jn[1])-1)+'.SCR')
   IF !(FILE('TEMP\'+NScr))
      STELA(Jn[2],Jn[3],Jn[4] + 1,Jn[5] + 1,NScr)
   ENDIF
   *-------------------------------------------------------------------------
   PMS(0)
   IF Jn[9] == 1
      JAN3D_A(Jn[2],Jn[3],Jn[4],Jn[5],Jn[7],Jn[6])
   ELSEIF Jn[9] == 2
      JAN3D_B(Jn[2],Jn[3],Jn[4],Jn[5],Jn[7],Jn[6])
   ENDIF

   PRXIN(13)
   PMS(1)
RETURN

*----------------------------------------------------------------------------
FUNCTION JAN3D_A(X1,Y1,X2,Y2,Titulo,Cor)
*----------------------------------------------------------------------------
* Monta janelas do tipo 1

   RECT(X1,Y1,X2,Y2,1,clSilver)
   RECT(X1+4,Y1+22,X2-4,Y2-4,1,clSilver)
   FGLShowDIB(X1+5,Y1+5,BtJ1,FGL_IMG_MAPONCURRENT)

   ATIJAN(Jn[7])
RETURN

*----------------------------------------------------------------------------
FUNCTION JAN3D_B(X1,Y1,X2,Y2,Titulo,Cor)
*----------------------------------------------------------------------------
* Monta janelas do tipo 2

   BOX_UP(X1,Y1,X2,Y1+22,clSilver)
   BOX_UP(X1,Y1+22,X2,Y2,clSilver)

   ATIJAN(Jn[7])
RETURN

*----------------------------------------------------------------------------
FUNCTION ATIJAN(Titulo)
*----------------------------------------------------------------------------
* Ativa Janela atual

   LOCAL TodasLin, TamaText, TamaJane, S_X1, S_X2

   IF LEN(Jn[1]) == 0
      RETURN
   ENDIF

   *------------------------- Ativa janela do tipo 1 ------------------------
   IF Jn[9] == 1
      CAIXABO(Jn[2]+4,Jn[3]+4,Jn[2]+17,Jn[3]+17)
      BOX_DOWN(Jn[2]+4, Jn[3]+22, Jn[4]-4, Jn[5]-4,NIL,2)
      BOX_UP(Jn[2], Jn[3], Jn[4], Jn[5],NIL)
      FGLShowDIB(Jn[2]+5,Jn[3]+5,BtJ1,FGL_IMG_MAPONCURRENT)

      S_X1 := 25
      S_X2 := 8
   *------------------------- Ativa janela do tipo 2 ------------------------
   ELSEIF Jn[9] == 2
      BOX_UP(Jn[2], Jn[3], Jn[4], Jn[3]+22, NIL)
      BOX_UP(Jn[2], Jn[3]+22, Jn[4], Jn[5], NIL)

      S_X1 := 7
      S_X2 := 7
   *------------------ Ativa janela do tipo 4 c/ contador de registros ------
   ENDIF

   *------------------------- Ativa em todas as janelas ---------------------

   TamaText := ((LENPIX(ALLTRIM(Titulo),2))/2) + 3
   TamaJane := (Jn[4]-Jn[2])/2

   FOR TodasLin := 1 TO 12 STEP 2
      LINE(Jn[2]+S_X1,Jn[3]+TodasLin+4,Jn[4]-S_X2,Jn[3]+TodasLin+4,clWhite)
      LINE(Jn[2]+S_X1+1,Jn[3]+TodasLin+5,Jn[4]-S_X2-1,Jn[3]+TodasLin+5,clDkGray)
   NEXT TodasLin

   LINE(Jn[2]+2,Jn[5]+1,Jn[4]+1,Jn[5]+1,clBlack)
   LINE(Jn[4]+1,Jn[5],Jn[4]+1,Jn[3]+2,clBlack)
   RECT(Jn[2], Jn[3], Jn[4], Jn[5], 0, clBlack)
   RECT((Jn[2]+TamaJane)-TamaText,Jn[3]+2,(Jn[4]-TamaJane)+TamaText,Jn[3]+16,1,clSilver)

   PRNT((Jn[2]+TamaJane)-TamaText+3, Jn[3]+3, Titulo, Jn[6],, FALSE)

   *--------- Ativa botoes novamente-----------------------------------------
   BUILD_BOX()
   BUILD_BUTTON()
   BUILD_INPUT()
   BUILD_CHKBOX()
   BUILD_SELBOX()
   BUILD_LABEL()
   BUILD_IMAGE()
   BUILD_TB()
   SET_DIVIDERS(ACTIVE)
   *-------------------------------------------------------------------------
RETURN

*----------------------------------------------------------------------------
FUNCTION DEAJAN(Titulo)
*----------------------------------------------------------------------------
* Desativa Janela atual

   LOCAL TamaText, TamaJane

   IF LEN(Jn[1]) == 0
      RETURN
   ENDIF
   PMS(0)
   *-------------------- Desativa janela do tipo 1 --------------------------
   IF Jn[9] == 1
      RECT(Jn[2]+5, Jn[3]+23, Jn[4]-5, Jn[5]-5, 0, clDkGray)
      RECT(Jn[2]+4, Jn[3]+22, Jn[4]-4, Jn[5]-4, 0, clSilver)

   *-------------------- Desativa janela do tipo 2 --------------------------
   ELSEIF Jn[9] == 2

      LINE(Jn[2],Jn[3]+21,Jn[4],Jn[3]+21,clSilver)
      LINE(Jn[2],Jn[3]+22,Jn[4],Jn[3]+22,clDkGray)
      LINE(Jn[2],Jn[3]+23,Jn[4],Jn[3]+23,clSilver)

   ENDIF

   *-------------------- Desativa para todas as janelas ---------------------
   RECT(Jn[2]+4, Jn[3]+4, Jn[4]-4, Jn[3]+17, 1, clSilver)
   RECT(Jn[2]+1, Jn[3]+1, Jn[4]-1, Jn[5]-1, 0, clSilver)
   RECT(Jn[2], Jn[3], Jn[4], Jn[5], 0, clDkGray)

   LINE(Jn[2]+2,Jn[5]+1,Jn[4]+1,Jn[5]+1,clDkGray)
   LINE(Jn[4]+1,Jn[5],Jn[4]+1,Jn[3]+2,clDkGray)

   TamaText := ((LENPIX(ALLTRIM(Titulo),2))/2) + 3
   TamaJane := (Jn[4]-Jn[2])/2

   PRNT((Jn[2]+TamaJane)-TamaText+3, Jn[3]+3, Titulo, clDkGray,, FALSE)

   DISABLE_BUTTONS()
   *--------- Desativa inputs -----------------------------------------------
   DEATINP()
   *--------- Desativa check boxes-------------------------------------------
   DEATICKB()
   *--------- Desativa Select boxes------------------------------------------
   DEATISEB()
   *--------- Desativa Caixas -----------------------------------------------
   DISABLE_BOX()
   *--------- Desativa Tb ---------------------------------------------------
   DEATITB()
   *--------- Desativa linhas -----------------------------------------------
   SET_DIVIDERS(INACTIVE)
   *-------------------------------------------------------------------------
   PMS(1)
RETURN

*----------------------------------------------------------------------------
FUNCTION JANAVI(X1,Y1,X2,Y2)
*----------------------------------------------------------------------------

   LOCAL TodasCol := 1

   BOX_UP(X1,Y1,X2,Y2,clSilver)
   BOX_DOWN(X1+2,Y1+13,X2-2,Y2-2,7,2)

   DO WHILE TodasCol < (X2 - X1) - 6

      FGLSetPixel(X1+TodasCol+3,Y1+4,Cores[16])
      FGLSetPixel(X1+TodasCol+4,Y1+5,Cores[9])

      FGLSetPixel(X1+TodasCol+3,Y1+7,Cores[16])
      FGLSetPixel(X1+TodasCol+4,Y1+8,Cores[9])

      FGLSetPixel(X1+TodasCol+3,Y1+10,Cores[16])
      FGLSetPixel(X1+TodasCol+4,Y1+11,Cores[9])

      TodasCol := TodasCol + 5
   ENDDO

   LINE(X1+2,Y2+1,X2+1,Y2+1,clBlack)
   LINE(X2+1,Y2,X2+1,Y1+2,clBlack)

RETURN

*----------------------------------------------------------------------------
FUNCTION JANFECHA(keypress)
*----------------------------------------------------------------------------
* fecha janela atual

   LOCAL Funcao, NScr

   IF LEN(ALLTRIM(Jn[1])) == 0 .OR. TbVr[07] == 1
      RETURN
   ENDIF

   IF (MX >= Jn[2]+4 .AND. MX <= Jn[2]+17 .AND. MY >= Jn[3]+4 .AND. MY <= Jn[3]+17 .AND. Jn[9] == 1) .OR. keypress == 27

      Funcao := Jn[8]        // Captura funcao da janela atual antes q ela seja fechada

      *-------------------- Restaura tela anterior --------------------------
      NScr := (SUBSTR(Jn[1],1,AT('.',Jn[1])-1)+'.SCR')
      RTELA(Jn[2], Jn[3], NScr)
      *----------------- salva valores dos objetos --------------------------
      SJAN(Jn[1])
      *----------------- Zera vaiaveis --------------------------------------
      ZVARJ()
      *---------------- Executa fuincao de fechamento se houver -------------
      IF LEN(Funcao) > 0
         &Funcao()
      ENDIF

   ELSEIF Jn[9] == 1
      PMS(0)
      BOX_UP(Jn[2]+5,Jn[3]+5,Jn[2]+16,Jn[3]+16, clSilver)
      FGLShowDIB(Jn[2]+5,Jn[3]+5,BtJ1,FGL_IMG_MAPONCURRENT)
      PMS(1)
   ENDIF

RETURN

*----------------------------------------------------------------------------
FUNCTION VJANFECHA()
*----------------------------------------------------------------------------
* verifica se tecla de fechar janela foi pressionada

   IF LEN(ALLTRIM(Jn[1])) == 0 .OR. (Jn[9] <> 1 .AND. Jn[9] <> 4)
      RETURN
   ENDIF

   IF MX >= Jn[2]+4 .AND. MX <= Jn[2]+17 .AND. MY >= Jn[3]+4 .AND. MY <= Jn[3]+17
      PMS(0)
      FGLShowDIB(Jn[2]+5,Jn[3]+5,BtJ2,FGL_IMG_MAPONCURRENT)
//      RECT(Jn[2]+6,Jn[3]+6,Jn[2]+15,Jn[3]+15,1,8)
      PMS(1)
   ENDIF

RETURN

*----------------------------------------------------------------------------
FUNCTION ZVARJ()
*----------------------------------------------------------------------------
* Zera as variaveis da janela atual

   Jn[2] := 0
   Jn[3] := 0
   Jn[4] := 0
   Jn[5] := 0
   Jn[8] := ''
   Jn[6] := 0
   Jn[7] := ''
   Jn[9] := 0
   Jn[1] := ''

   *-------------------- Variaveis do Tb ------------------------------------
   TbVr[01] := 1
   TbVr[02] := 1
   TbVr[03] := 1
   TbVr[04] := 1
   TbVr[05] := 1
   TbVr[06] := 1
   *-------------------------------------------------------------------------

   AFILL(PBt,NIL)
   AFILL(NObj,0)

   InA := 0
   CkP := 0
   SbP := 0

RETURN

*----------------------------------------------------------------------------
FUNCTION SJAN(NJan)
*----------------------------------------------------------------------------
* Salva valores dos objetos da janela atual

   LOCAL Arqu,TdO,Cabe,Buf,NBuf

   *--------- Verifica arquivo e captura informacoes sobre ele --------------

   NJan := ALLTRIM(NJan)

   IF !(FILE(NJan))
      RETURN
   ENDIF

   Arqu := FOPEN(NJan,2)
   FSEEK(Arqu,0,0)

   Cabe := SPACE(32)
   FREAD(Arqu,@Cabe,32)         // Le o cabecalho da janela

   *-------------------------------------------------------------------------
   Buf := (NObj[1] * 202)       // Passa o objeto botoes
   FSEEK(Arqu,(234+Buf),0)
   *------------------------ Salva inputs -----------------------------------
   FOR TdO := 1 TO NObj[2]
      Buf  := SPACE(202)
      FREAD(Arqu,@Buf,202)
      NBuf := SUBSTR(Buf,1,50)+In[TdO,10]+SPACE(100-LEN(In[TdO,10]))+SUBSTR(Buf,150,50)+CHR(13)+CHR(10)
      FSEEK(Arqu,-202,1)
      FWRITE(Arqu,NBuf,202)
   NEXT TdO
   *------------------------ Salva Checkboxes -------------------------------
   FOR TdO := 1 TO NObj[3]
      Buf  := SPACE(202)
      FREAD(Arqu,@Buf,202)
      NBuf := SUBSTR(Buf,1,122)+Cb[TdO,7]+SUBSTR(Buf,124,77)+CHR(13)+CHR(10)
      FSEEK(Arqu,-202,1)
      FWRITE(Arqu,NBuf,202)
   NEXT TdO
   *------------------------ Salva Selectboxes ------------------------------
   FOR TdO := 1 TO NObj[4]
      Buf  := SPACE(202)
      FREAD(Arqu,@Buf,202)
      NBuf := SUBSTR(Buf,1,123)+Sb[TdO,8]+SUBSTR(Buf,125,76)+CHR(13)+CHR(10)
      FSEEK(Arqu,-202,1)
      FWRITE(Arqu,NBuf,202)
   NEXT TdO
   *-------------------------------------------------------------------------

   FCLOSE(Arqu)
RETURN

*----------------------------------------------------------------------------
FUNCTION FECJAN()
*----------------------------------------------------------------------------
* Fecha janela mandado pelo programa

   LOCAL NScr

   NScr := (SUBSTR(Jn[1],1,AT('.',Jn[1])-1)+'.SCR')
   RTELA(Jn[2], Jn[3], NScr)
   SJAN(Jn[1])
   ZVARJ()

RETURN
