*----------------------------------------------------------------------------
* Modulo de controle dos select boxes
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION BUILD_SELBOX()
*----------------------------------------------------------------------------
* Monta SelectBoxes

   LOCAL TdS, Ct
   LOCAL SbD := CHR(12)+CHR(12)+'    0000      007&7700   07&&&&7780  0&&7&7&770 0&&7&7&7&7800&7&7&7&778007&7&7&77780077&7&778780 0&7&778780  0877777880   00888800      0000    '
   LOCAL SbS := CHR(12)+CHR(12)+'    0000      00888800   0888888780  0880000870 0880000008700880000007700880000007&0087000000&&0 0880000&&0  087877&&&0   0077&&00      0000    '
   LOCAL SdD := CHR(12)+CHR(12)+'    8888      88777788   8777777778  8777777778 877777777778877777777778877777777778877777777778 8777777778  8777777778   88777788      8888    '
   LOCAL SdS := CHR(12)+CHR(12)+'    8888      88777788   8777777778  8778888778 877888888778877888888778877888888778877888888778 8778888778  8777777778   88777788      8888    '


   IF NObj[4] == 0
      RETURN
   ENDIF

   FOR TdS := 1 TO NObj[4]

      IF Sb[TdS,9] == 'S'
         Ct := Colors[Sb[TdS,6]]

         IF Sb[TdS,8] == 'S'
            DRAWIMG(SbS,Sb[Tds,4]-1,Sb[Tds,3]-1)
         ELSE
            DRAWIMG(SbD,Sb[Tds,4]-1,Sb[Tds,3]-1)
         ENDIF
      ELSE
         Ct := clDkGray

         IF Sb[TdS,8] == 'S'
            DRAWIMG(SdS,Sb[Tds,4]-1,Sb[Tds,3]-1)
         ELSE
            DRAWIMG(SdD,Sb[Tds,4]-1,Sb[Tds,3]-1)
         ENDIF
      ENDIF

      PRNT(Sb[TdS,3]+16, Sb[TdS,4]-1, Sb[TdS,5], Ct,, FALSE)
   NEXT TdS

RETURN

*----------------------------------------------------------------------------
FUNCTION DEATISEB()
*----------------------------------------------------------------------------
* Desativa Select boxes

   LOCAL SdD := CHR(12)+CHR(12)+'    8888      88777788   8777777778  8777777778 877777777778877777777778877777777778877777777778 8777777778  8777777778   88777788      8888    '
   LOCAL SdS := CHR(12)+CHR(12)+'    8888      88777788   8777777778  8778888778 877888888778877888888778877888888778877888888778 8778888778  8777777778   88777788      8888    '

   IF NObj[4] == 0
      RETURN
   ENDIF

   FOR TdS := 1 TO NObj[4]

      IF Sb[TdS,8] == 'S'
         DRAWIMG(SdS,Sb[Tds,4]-1,Sb[Tds,3]-1)
      ELSE
         DRAWIMG(SdD,Sb[Tds,4]-1,Sb[Tds,3]-1)
      ENDIF

      PRNT(Sb[TdS,3]+16, Sb[TdS,4]-1, Sb[TdS,5], clDkGray,, FALSE)
   NEXT TdS

RETURN

*----------------------------------------------------------------------------
FUNCTION SBCLK()
*----------------------------------------------------------------------------
* verifica clique sobre o selectbox

   LOCAL TdS
   LOCAL SdD := CHR(12)+CHR(12)+'    0000      00888800   0888888880  0888888880 088888888880088888888880088888888880088888888880 0888888880  0888888880   00888800      0000    '

   IF NObj[4] == 0
      RETURN
   ENDIF

   FOR TdS := 1 TO NObj[4]
      IF MX >= Sb[TdS,3] .AND. MY >= Sb[TdS,4] .AND. MX <= Sb[TdS,3]+12 .AND. MY <= Sb[TdS,4]+11 .AND. Sb[TdS,9] == 'S'
         PMS(0)
         DRAWIMG(SdD,Sb[TdS,4]-1,Sb[TdS,3]-1)
         PMS(1)
         SbP := TdS
      ENDIF
   NEXT TdS

RETURN

*----------------------------------------------------------------------------
FUNCTION SBUNCLK()
*----------------------------------------------------------------------------
* verifica clique sobre o selectbox

   LOCAL TdS, Img, Fnc
   LOCAL SbD := CHR(12)+CHR(12)+'    0000      007&7700   07&&&&7780  0&&7&7&770 0&&7&7&7&7800&7&7&7&778007&7&7&77780077&7&778780 0&7&778780  0877777880   00888800      0000    '
   LOCAL SbS := CHR(12)+CHR(12)+'    0000      00888800   0888888780  0880000870 0880000008700880000007700880000007&0087000000&&0 0880000&&0  087877&&&0   0077&&00      0000    '

   IF SbP == 0
      RETURN
   ENDIF

   *------------------- se botao do mouse foi solto sobre o selbox ----------
   IF MX >= Sb[SbP,3] .AND. MY >= Sb[SbP,4] .AND. MX <= Sb[SbP,3]+12 .AND. MY <= Sb[SbP,4]+11 .AND. Sb[SbP,9] == 'S'

      *------------ Procura o selbox selecionado, antigo --------------------
      FOR TdS := 1 TO NObj[4]
         IF Sb[TdS,8] == 'S' .AND. Sb[TdS,2] == Sb[SbP,2]

            PMS(0)
            DRAWIMG(SbD,Sb[TdS,4]-1,Sb[TdS,3]-1)
            Sb[TdS,8] := 'N'
            PMS(1)

         ENDIF
      NEXT TdS

      *-------- Atualiza selbox pressionado e executa funcao dele -----------
      Sb[SbP,8] := 'S'
      Img := SbS

      Fnc := Sb[SbP,7]

      IF LEN(Fnc) > 0
         &Fnc()
      ENDIF
      *----------------------------------------------------------------------

   *--------------- se botao do mouse nao foi solto sobre o selbox ----------
   ELSE
      *------------ remonta o selectbox coomo estava antes ------------------
      IF Sb[SbP,8] == 'S'
         Img := SbS
      ELSE
         Img := SbD
      ENDIF
      *----------------------------------------------------------------------

   ENDIF
   *-------------------------------------------------------------------------

   PMS(0)
   DRAWIMG(Img,Sb[SbP,4]-1,Sb[SbP,3]-1)
   SbP := 0
   PMS(1)

RETURN
