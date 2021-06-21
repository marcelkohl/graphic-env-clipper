#INCLUDE "LIBS\FGL.CH"
#INCLUDE "FILEIO.CH"

*----------------------------------------------------------------------------
FUNCTION TXT2FNT(Palavra)
*----------------------------------------------------------------------------
   LOCAL NLetEspec := {227,245,241,226,234,238,244,251,224,232,236,242,249,228,235,239,246,252,225,233,237,243,250,231,195,213,209,194,202,206,212,219,192,200,204,210,217,196,203,207,214,220,193,201,205,211,218,199,255,253,221}
   LOCAL CLetEspec := '�䤃���������������������奶�����������ؙ�����逘��'
   LOCAL PalaFinal := ''
   LOCAL TodasLet

   IF Palavra == NIL
      RETURN
   ENDIF

   FOR TodasLet := 1 TO LEN(Palavra)
      IF (SUBSTR(Palavra,TodasLet,1)$CLetEspec)
         PalaFinal := PalaFinal + CHR(NLetEspec[AT(SUBSTR(Palavra,TodasLet,1),CLetEspec)])
      ELSE
         PalaFinal := PalaFinal + SUBSTR(Palavra,TodasLet,1)
      ENDIF
   NEXT TodasLet

RETURN

*----------------------------------------------------------------------------
FUNCTION DRAWIMG(MatImg, X1, Y1)
*----------------------------------------------------------------------------
* desenha matrizes

   LOCAL I_TamX   := ASC(SUBSTR(MatImg,1,1))
   LOCAL I_TamY   := ASC(SUBSTR(MatImg,2,1))
   LOCAL CoresDif := "123456789!@#$%&"
   LOCAL Contador := 2
   LOCAL Linha    := 1
   LOCAL Cor, TodasLin, TodasCol

   FOR TodasLin := 1 TO I_TamX
      FOR TodasCol := 1 TO I_TamY

         Contador := Contador + 1
         Cor := SUBSTR(MatImg, Contador,1)

         IF Cor <> ' '
            Cor := AT(Cor,CoresDif)
            FGLSetPixel(Y1 + TodasCol, X1 + TodasLin,Cores[Cor + 1])
         ENDIF


      NEXT TodasCol
   NEXT TodasLin

RETURN

*----------------------------------------------------------------------------
FUNCTION LENPIX(Palavra,TipoLet)
*----------------------------------------------------------------------------
* retorna o tamanho da palavra em pixels

   LOCAL TamaPala := LEN(Palavra)
   LOCAL LarguLet := 0
   LOCAL AlturLet := 0
   LOCAL LarguTot := 0
   LOCAL TodasLet, NumeLet
   LOCAL MatAlfab := ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+{}:'+CHR(34)+'<>?|`-=[];'+CHR(39)+',./\'+CHR(227)+CHR(245)+CHR(241)+CHR(226)+CHR(234)+CHR(238)+CHR(244)+CHR(251)+CHR(224)+CHR(232)+CHR(236)+CHR(242)+CHR(249)+CHR(228)+CHR(235)+CHR(239)+CHR(246)+CHR(252)+CHR(225)+CHR(233)+CHR(237)+CHR(243)+CHR(250)+CHR(231)+CHR(195)+CHR(213)+CHR(209)+CHR(194)+CHR(202)+CHR(206)+CHR(212)+CHR(219)+CHR(192)+CHR(200)+CHR(204)+CHR(210)+CHR(217)+CHR(196)+CHR(203)+CHR(207)+CHR(214)+CHR(220)+CHR(193)+CHR(201)+CHR(205)+CHR(211)+CHR(218)+CHR(199)+CHR(255)+CHR(253)+CHR(221)+CHR(149)
   LOCAL Sistema  := {2,5,5,4,5,5,3,5,5,1,2,4,1,07,5,5,5,5,3,4,3,5,5,7,5,5,4,6,5,6,6,5,5,6,6,3,4,5,4,7,6,7,5,7,6,5,5,6,5,09,5,5,5,5,5,5,5,5,5,5,5,5,5,7,3,9,7,5,10,7,6,5,3,3,5,7,4,4,3,3,7,7,4,3,5,3,7,3,3,3,1,3,3,3,3,5,5,5,5,5,1,5,5,5,5,1,5,5,5,5,1,5,5,5,5,1,5,5,4,6,7,7,8,5,3,7,7,6,5,3,7,6,6,5,3,7,6,6,5,3,7,6,6,5,5,5,4}
   LOCAL SistemaB := {2,6,6,5,6,6,3,6,6,2,4,6,2,10,6,6,6,6,4,5,4,6,6,8,6,6,5,7,6,6,7,5,5,7,7,4,5,6,5,9,6,7,6,7,7,6,6,7,6,10,6,6,6,6,6,6,6,6,6,6,6,6,6,8,2,9,8,6,12,8,8,6,4,4,6,8,6,6,2,5,8,8,5,6,5,4,8,4,4,2,2,2,2,5,5,6,6,6,6,6,2,6,6,6,6,2,6,6,6,6,2,6,6,6,6,2,6,6,5,7,7,6,7,5,4,7,7,7,5,4,7,7,7,5,4,7,7,7,5,4,7,7,6,6,6,6,4}

   FOR TodasLet := 1 TO TamaPala

       NumeLet := AT(SUBSTR(Palavra,TodasLet,1),MatAlfab)

       IF TipoLet == 1
          LarguTot := LarguTot + Sistema[NumeLet] + 1
       ELSE
          LarguTot := LarguTot + SistemaB[NumeLet] + 1
       ENDIF

   NEXT TodasLet

RETURN(LarguTot)

*----------------------------------------------------------------------------
FUNCTION STELA(X1,Y1,X2,Y2,Arq)
*----------------------------------------------------------------------------
* salva tela em arquivo

   LOCAL Tela := {}
   LOCAL nHandle, Tama, I

   PMS(0)
   Tela := FGLGetBackground(X1,Y1,X2,Y2)
   PMS(1)

   nHandle := FCREATE('TEMP\'+Arq,0)
   FSEEK(nHandle,0,0)

   FWRITE(nHandle,Tela[1],3)
   FWRITE(nHandle,STRZERO(Tela[2],4),LEN(STRZERO(Tela[2],4)))
   FWRITE(nHandle,STRZERO(Tela[3],4),LEN(STRZERO(Tela[3],4)))

   FWRITE(nHandle,STRZERO(Tela[6],4),LEN(STRZERO(Tela[3],4)))
   FWRITE(nHandle,STRZERO(Tela[7],4),LEN(STRZERO(Tela[3],4)))

   FOR I := 1 TO Tela[7]
      Tama := LEN(Tela[4,I])
      FWRITE(nHandle,Tela[4,I],Tama)
   NEXT I

   FCLOSE(nHandle)
RETURN

*----------------------------------------------------------------------------
FUNCTION RTELA(X1, Y1, Arq)
*----------------------------------------------------------------------------
* le a tela salva pelo stela

   LOCAL Arquivo
   LOCAL Tela := {}
   LOCAL Valo := {}
   LOCAL Lido, TamEle, NumEle, Todos, Cabe

   Arquivo := FOPEN('TEMP\'+Arq,0)
   FSEEK(Arquivo,0,0)

   Lido := SPACE(19)
   FREAD(Arquivo,@Lido,19)
   Cabe := Lido

   *---------- captura valores de 4 -----------------------------------------
   NumEle := VAL(SUBSTR(Lido,16,4))             // Numerpo de elementos
   TamEle := VAL(SUBSTR(Lido,08,4))             // Tamanho de cada elemento
   Lido   := SPACE(TamEle)

   FOR Todos := 1 TO NumEle
      FREAD(Arquivo,@Lido,TamEle)
      AADD(Valo, Lido)
   NEXT Todos

   *---------- coloca valores na matriz -------------------------------------
   AADD(Tela, SUBSTR(Cabe,1,3))            // Valor DDB
   AADD(Tela, VAL(SUBSTR(Cabe,04,4)))      // Valor em 2
   AADD(Tela, VAL(SUBSTR(Cabe,08,4)))      // Valor em 3
   AADD(Tela, Valo)                        // Valor em 4
   AADD(Tela, NIL)                         // Valor em 5
   AADD(Tela, VAL(SUBSTR(Cabe,12,4)))      // Valor em 6
   AADD(Tela, VAL(SUBSTR(Cabe,16,4)))      // Valor em 6

   FCLOSE(Arquivo)

   PMS(0)
   FGLPutBackground(X1,Y1,Tela)
   PMS(1)

   DELETE FILE ('TEMP\'+Arq)
RETURN

*----------------------------------------------------------------------------
FUNCTION UPP(Let)
*----------------------------------------------------------------------------
* retorna maiuscula da letra escolhida

  LOCAL MLet := Let
  LOCAL MaS  := ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+{}:'+CHR(34)+'<>?|`-=[];'+CHR(39)+',./\'
  LOCAL MaC  := '�䤃����������������������'
  LOCAL MaX  := '�奶�����������ؙ������� �'

  IF Let$MaS
     MLet := UPPER(Let)
  ELSEIF Let$MaC
     MLet := SUBSTR(MaX,AT(Let,MaC),1)
  ENDIF

RETURN(MLet)

*----------------------------------------------------------------------------
FUNCTION CTON(CNu)
*----------------------------------------------------------------------------
* caracter para numero
RETURN(VAL(CNu))

*----------------------------------------------------------------------------
FUNCTION NTOC(Num)
*----------------------------------------------------------------------------
* Numero para caracter

   LOCAL VRet
   VRet := STRZERO(Num)
   VRet := TRANSFORM(Num,REPLICATE('9',LEN(VRet)))

RETURN(VRet)

*----------------------------------------------------------------------------
FUNCTION FTOC(Num)
*----------------------------------------------------------------------------
* Numero para caracter

   LOCAL VRet
   LOCAL Masc

   VRet := STRZERO(Num)
   Masc := REPLICATE('9',LEN(VRet)-2)+'.'+'99'

   VRet := TRANSFORM(Num,Masc)
RETURN(VRet)

*----------------------------------------------------------------------------
FUNCTION CTOF(Num)
*----------------------------------------------------------------------------
* Caracter financeiro para numero
RETURN(VAL(Num))

*----------------------------------------------------------------------------
FUNCTION DECRNUM(Nmr,Tm,Op)
*----------------------------------------------------------------------------

   LOCAL VRt := ''
   LOCAL Td, NuAt, Mtz
   LOCAL Crp := {'9','0','5','7','6','8','3','4','1','2'}
   LOCAL Drp := {'1','8','9','6','7','2','4','3','5','0'}

   IF Op == NIL
      Mtz := Crp
   ELSE
      Mtz := Drp
   ENDIF

   Nmr := TRANSFORM(Nmr,REPLICATE('9',Tm))

   FOR Td := 1 TO Tm
      NuAt := SUBSTR(Nmr, Td, 1)
      VRt := VRt + Mtz[VAL(NuAt)+1]
   NEXT Todos
RETURN(VAL(VRt))

*----------------------------------------------------------------------------
FUNCTION NTOD(Data)
*----------------------------------------------------------------------------
* Transforma numero para data

   LOCAL Ano, Mes, Dia

   Data := TRANSFORM(Data,'99999999')
   Ano  := SUBSTR(Data,1,4)
   Mes  := SUBSTR(Data,5,2)
   Dia  := SUBSTR(Data,7,2)
   Data := Dia + '/' + Mes +'/' + Ano
RETURN(Data)

*----------------------------------------------------------------------------
FUNCTION DTON(Data)
*----------------------------------------------------------------------------
* Transforma data para numero

   LOCAL Dia, Mes, Ano

   Data := TRANSFORM(Data,'99/99/9999')
   Dia  := SUBSTR(Data,1,2)
   Mes  := SUBSTR(Data,4,2)
   Ano  := SUBSTR(Data,7,4)
   Data := VAL(Ano+Mes+Dia)
RETURN(Data)

*----------------------------------------------------------------------------
FUNCTION PMS(LoD)
*----------------------------------------------------------------------------
   LOCAL St1

   IF LoD == Mse
      RETURN
   ENDIF

   Mse := LoD

   FGLSetWriteMode(FGL_XOR)

   St1 := CHR(16) + CHR(16)+;
   "&&              "+;
   "&7&             "+;
   "&77&            "+;
   "&777&           "+;
   "&7777&          "+;
   "&77777&         "+;
   "&777777&        "+;
   "&7777777&       "+;
   "&77777777&      "+;
   "&777777777&     "+;
   "&77777&&&&&     "+;
   "&77&&77&        "+;
   "&7& &77&        "+;
   "&&   &77&       "+;
   "     &77&       "+;
   "      &&&       "

   DRAWIMG(St1,YOld,XOld)

   FGLSetWriteMode(FGL_SET)
RETURN

*----------------------------------------------------------------------------
FUNCTION FECDBFS()
*----------------------------------------------------------------------------
* fecha dbfs pendentes
   FECJAN()
   DBCOMMIT()
   CLOSE ALL

   // ABREDBFS()
RETURN
