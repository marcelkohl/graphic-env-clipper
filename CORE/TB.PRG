#INCLUDE "..\LIBS\FGL.CH"
*----------------------------------------------------------------------------
* Modulo de controle dos TBrowses
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION BUILD_TB(NuTb)
*----------------------------------------------------------------------------
* Monta Tb especificado em NuTb

   IF NObj[9] == 0
      RETURN
   ENDIF

   BUILD_TBC()
   PTBL(Gcr,15)
RETURN

*----------------------------------------------------------------------------
FUNCTION DEATITB()
*----------------------------------------------------------------------------
* Desativa Tb

   IF NObj[9] == 0
      RETURN
   ENDIF

   FGLSetWriteMode(FGL_OR)
   FGLSetPenStyle(FGL_OPAQUE)

   FGLSetPattern(CHR(170)+CHR(85)+CHR(170)+CHR(85)+CHR(170)+CHR(85)+CHR(170)+CHR(85))
   FGLSetColor(Cores[1])
   FGLFillRectangle(Tb[1,1]-1,Tb[1,2]-1,Tb[1,3]+1,Tb[1,4]+1)

   FGLSetWriteMode(FGL_SET)
   FGLSetPenStyle(FGL_SOLID)
RETURN

*----------------------------------------------------------------------------
FUNCTION BUILD_TBC(Ld)
*----------------------------------------------------------------------------
* Monta colunas do tb atual
* 1=Esquerda->Direita, 0=Direita->esquerda

   LOCAL TdC, TdL, QtL, CnC, Sm, Cll, Plv, RgA, FnA
   LOCAL Sai := 0

   SELE (Tb[1,5])

   PMS(0)

   TbVr[06] := 1
   RgA := RECNO()
   QtL := INT(((Tb[1,4] - Tb[1,2])) / 19)                   // Numero de linhas do tb

   SKIP -(TbVr[01]-1)

   IF Ld == NIL
      Ld := 1
   ENDIF

   BOX_DOWN(Tb[1,1], Tb[1,2], Tb[1,3], Tb[1,4], 15, 1)

   FOR TdL := 1 TO QtL
      Sai := 0

      *----------------- Monta Colunas da ESQUERDA para a DIREITA -----------
      IF Ld == 1
         CnC := Tb[1,1]

         FOR TdC := TbVr[04] TO Tb[1,6]
            Sm := (Tc[TdC,6]*11)

            IF CnC + Sm > Tb[1,3]
               Sm  := (Tb[1,3] - Tb[1,1]) - (CnC - Tb[1,1])
               Sai := 1
               TbVr[03] := TdC
               TbVr[05] := 1
               TbVr[06] := 0
            ENDIF

            *-------------- Monta Titulo da coluna na primeira linha --------
            IF TdL == 1
               BOX_UP(CnC, Tb[1,2], CnC + Sm,Tb[1,2]+19, clSilver)
               Plv := Tc[TdC,3]

               IF (CnC + LENPIX(Plv,2)) > CnC + Sm
                  Plv := SUBSTR(Plv,1,(Sm/11))
               ENDIF

               PRNT(CnC+5, Tb[1,2]+3, Plv, clBlack,, FALSE)

            *----------------- Monta Linhas ---------------------------------
            ELSE
               Plv := &(Tc[TdC,2])
               FnA := (Tc[TdC,4])

               *----------------- Monta palavra com funcao do tbc -----------
               IF LEN(FnA) > 0
                  Plv := &FnA(Plv)
               ENDIF

               Plv := TXT2FNT(Plv)

               *---------------Verifica se a palavra naum sai do Tc ---------
               IF (CnC + LENPIX(Plv,1)) > CnC + Sm
                  Plv := SUBSTR(Plv,1,(Sm/11))
               ENDIF

               Cll := Tb[1,2] + ((TdL -1)*20)

               // RECT(CnC + 1, Cll + 1, CnC + Sm - 1, Cll + 19, 1, 7)
               RECT(CnC, Cll, CnC + Sm, Cll + 20, 2, clSilver)
               PRNT(CnC + 5, Cll + 4, Plv, clBlack,, TRUE)
            ENDIF
            *----------------------------------------------------------------

            CnC := CnC + Sm

            IF Sai == 1
               EXIT
            ENDIF
         NEXT TdC

      *----------------- Monta Colunas da DIREITA para a ESQUERDA -----------
      ELSEIF Ld == 0
         CnC := Tb[1,3]
         TdC := TbVr[03]

         DO WHILE TdC >= 1
            Sm  := (Tc[TdC,6]*11)
            Cll := (Tb[1,2] + ((TdL-1)*20))

            IF (CnC - Sm) < Tb[1,1]
               Sm  := CnC - Tb[1,1]
               Sai := 1
               TbVr[05] := 0
               TbVr[06] := 0
            ENDIF

            *-------------- Monta Titulo da coluna na primeira linha --------
            IF TdL == 1
               BOX_UP(CnC - Sm, Tb[1,2], CnC,Tb[1,2]+19, clSilver)
               Plv := Tc[TdC,3]

               IF (Tb[1,1] + LENPIX(Plv,2)) > CnC
                  IF Sai <> 1
                     Plv := SUBSTR(Plv,LEN(Plv) - INT(Sm/11),LEN(Plv))
                  ELSE
                     Plv := ''
                  ENDIF
               ENDIF

               PRNT(CnC-Sm+5, Tb[1,2]+3, Plv, clBlack,, FALSE)
            *-------------- Monta linhas ------------------------------------
            ELSE
               Plv := &(Tc[TdC,2])
               FnA := (Tc[TdC,4])

               *----------------- Monta palavra com funcao do tbc -----------
               IF LEN(FnA) > 0
                  Plv := &FnA(Plv)
               ENDIF

               IF Sai == 1
                  Plv := SUBSTR(Plv,LEN(Plv) - INT(Sm/11),LEN(Plv))
               ENDIF

               Plv := TXT2FNT(Plv)

               RECT(CnC - Sm, Cll, CnC, Cll + 20, 2, clSilver)
               PRNT(CnC - Sm+5, Cll + 3, Plv, clBlack,, TRUE)

               IF Sai == 1
                  EXIT
               ENDIF
            ENDIF

            CnC := CnC - Sm
            TdC := TdC - 1

         ENDDO
      ENDIF
      *----------------------------------------------------------------------

      IF TdL > 1
         SKIP
      ENDIF

      IF EOF() .AND. Tdl > 1
         EXIT
      ENDIF

   NEXT TdL

   TbVr[12] := (TdL - 1)

   IF TbVr[06] == 1 .AND. Ld == 1
      TbVr[03] := (TdC - 1)
   ELSEIF TbVr[06] == 0 .AND. Ld == 0
      TbVr[04] := TdC
   ENDIF

   GO RgA
   PMS(1)
RETURN

*----------------------------------------------------------------------------
FUNCTION TBTCL(keypress)
*----------------------------------------------------------------------------
* Verifica keypress pressionada

   LOCAL FLin, NlT, FnC
   LOCAL Ftb := {}
   LOCAL Tcl := 0
   LOCAL Ttc := 0
   LOCAL TSF := 0
   LOCAL TSI := 0
   LOCAL Mtt := CHR(24)+CHR(5)+CHR(4)+CHR(19)+CHR(3)+CHR(18)+CHR(13)+CHR(28)

   IF NObj[9] == 0
      RETURN
   ENDIF

   IF (!(CHR(keypress)$Mtt) .AND. keypress > 0) .OR. ((keypress == 4 .OR. keypress == 19) .AND. TbVr[07] == 1)
      IF Tc[TbVr[02],7] == 1
         IF TbVr[07] == 0                      // Verifica se o input jah estah ativado
            TbVr[08] := &(Tc[TbVr[02],2])           // Captura palavra do dbf
            FnC := Tc[TbVr[02],4]              // captura funcao de abertura

            IF LEN(FnC) > 0
               TbVr[08] := ALLTRIM(&FnC(TbVr[08]))        // Mescla palavra com funcao
            ELSE
               TbVr[08] := ALLTRIM(TbVr[08])
            ENDIF

            TbVr[07] := 1                   // Marca q o input do TBc estah ativo
            TbVr[09] := 0
            TbVr[10] := 0
            TbVr[11] := 0
            PTBL(14,0,TbVr[08])
         ENDIF

         TBESC(keypress)
         RETURN
      ENDIF
   ENDIF

   TBIGRV(keypress)
   TbVr[07] := 0
   PTBL(15,0)

   *------------ tecla para baixo ----------------------------------------
   IF keypress == 24
      SKIP

      IF EOF()
         SKIP -1
         PTBL(Gcr,15)
         RETURN
      ENDIF

      FLin := INT(((TbVr[01] + 1) * 19)+Tb[1,2]+19)

      IF FLin > Tb[1,4]
         PMS(0)
         FGLScroll(Tb[1,1] + 1, Tb[1,2] + 20, Tb[1,3] - 1, Tb[1,4] - 4,0,20)
         PMS(1)
      ELSE
         Tcl := 1
      ENDIF
      *----------- Tecla para cima ------------------------------------------
   ELSEIF keypress == 5
      SKIP -1

      IF BOF()
         PTBL(Gcr,15)
         RETURN
      ENDIF

      FLin := INT(((TbVr[01]-1) * 19)+Tb[1,2]+19)

      IF (FLin-19) <= Tb[1,2]
         PMS(0)
         FGLScroll(Tb[1,1] + 1, Tb[1,2] + 20, Tb[1,3] - 1, Tb[1,4] - 4,0,-20)
         PMS(1)
      ELSE
         Tcl := - 1
      ENDIF
   *------------- Tecla para direita ----------------------------------------
   ELSEIF keypress == 4 .AND. TbVr[02] < Tb[1,6]

      IF TbVr[02] == TbVr[03]
         TbVr[03] := TbVr[03] + 1
      ENDIF
                                                     // visivel no tb, entaum pula para a proxima coluna , ainda naum visivel
      TbVr[02] := TbVr[02] + 1

      IF TbVr[06] == 0 .AND. TbVr[02] == TbVr[03]
         BUILD_TBC(0)
      ENDIF

   *------------- Tecla para esquerda ---------------------------------------
   ELSEIF keypress == 19 .AND. TbVr[02] > 1

      IF TbVr[02] == TbVr[04]
         TbVr[04] := TbVr[04] - 1
      ENDIF

      TbVr[02] := TbVr[02] - 1

      IF TbVr[06] == 0 .AND. TbVr[02] == TbVr[04]
         BUILD_TBC(1)
      ENDIF

   *------------- Tecla Pgdown ----------------------------------------------
   ELSEIF keypress == 3
      NlT := INT((Tb[1,4] - Tb[1,2])/19)

      SKIP (NlT-TbVr[01])
      TbVr[01] := 1

      IF TbVr[05] == 0
         BUILD_TBC(0)
      ELSE
         BUILD_TBC(1)
      ENDIF
   *------------- Tecla PgUp ------------------------------------------------
   ELSEIF keypress == 18
      NlT := INT((Tb[1,4] - Tb[1,2])/19)

      SKIP -((NlT+TbVr[01])-2)

      TbVr[01] := 1

      IF TbVr[05] == 0
         BUILD_TBC(0)
      ELSE
         BUILD_TBC(1)
      ENDIF

   ENDIF
   *-------------------------------------------------------------------------

   TbVr[01] := TbVr[01] + Tcl
   PTBL(Gcr,15)
   TbVr[03] := TbVr[03] + TSF
   TbVr[04] := TbVr[04] + TSI

RETURN

*----------------------------------------------------------------------------
FUNCTION PTBL(Cr, Cp, Pv, Ld)
*----------------------------------------------------------------------------
* Pinta Linha do TB
* Cr = Cor do grifo

   LOCAL TCol, CnL, CnC, TCr, TCp, Tpx, FnA, TdC, Sm, Plv
   LOCAL Sai := 0

   IF Cr == NIL .OR. Cp == NIL
      RETURN
   ENDIF

   PMS(0)
   CnL := Tb[1,2] + (TbVr[01] * 20)

   *---------------- Monta linha da ESQUERDA -> DIREITA ---------------------
   IF TbVr[05] == 1
      CnC := Tb[1,1]

      FOR TdC := TbVr[04] TO TbVr[03]
         Sm  := (Tc[TdC,6] * 11)
         *------------------- Mescla o valor do DBF com a funcao ------------
         Plv := &(Tc[TdC,2])
         FnA := (Tc[TdC,4])

         IF LEN(FnA) > 0
            Plv := &FnA(Plv)
         ENDIF

         *------------------- Verifica a area do TB -------------------------
         IF TdC == TbVr[02]
            TCr := Cr
            TCp := Cp

            IF TbVr[07] == 0
               TbVr[13] := CnC
            ENDIF

            IF Pv <> NIL
               Plv := Pv
            ENDIF
         ELSE
            TCr := 15
            TCp := 0
         ENDIF

         Plv := TXT2FNT(plv)

         IF CnC + Sm > Tb[1,3]
            Sm  := (Tb[1,3] - Tb[1,1]) - (CnC - Tb[1,1])
            Sai := 1
         ENDIF

         IF (CnC + LENPIX(Plv,1)) > CnC + Sm
            Plv := SUBSTR(Plv,1,(Sm/11))
         ENDIF

         *------------------- Desenha linha ---------------------------------

         RECT(CnC + 1, CnL+1, CnC + Sm - 1, Cnl + 19, 1, Cores[TCr+1])

         IF Ld <> NIL .AND. TbVr[02] == TdC
            Tpx := Sm - LENPIX(Plv,1)
            PRNT(CnC + Tpx - 5, CnL+4, Plv, Cores[TCp+1],, TRUE)
         ELSE
            PRNT(CnC + 5, CnL+4, Plv, Cores[TCp+1],, TRUE)
         ENDIF
         *-------------------------------------------------------------------

         CnC := CnC + Sm

         IF Sai == 1
            EXIT
         ENDIF
      NEXT TdC
   *---------------- Monta linha da DIREITA -> ESQUERDA ---------------------
   ELSE
      TdC := TbVr[03]
      CnC := Tb[1,3]

      DO WHILE TdC >= 1
         Sm  := (Tc[TdC,6]*11)

         *------------------- Mescla o valor do DBF com a funcao ------------
         Plv := &(Tc[TdC,2])
         FnA := (Tc[TdC,4])

         IF LEN(FnA) > 0
            Plv := &FnA(Plv)
         ENDIF

         *------------------- Pinta linha -----------------------------------
         IF TdC == TbVr[02]
            TCr := Cr
            TCp := Cp

            IF TbVr[07] == 0
               TbVr[13] := CnC - Sm
            ENDIF

            IF Pv <> NIL
               Plv := Pv
            ENDIF

         ELSE
            TCr := 15
            TCp := 0
         ENDIF

         Plv := TXT2FNT(Plv)

         IF (CnC - Sm) < Tb[1,1]
            Sm  := CnC - Tb[1,1]
            Sai := 1
            Plv := SUBSTR(Plv,LEN(Plv) - INT(Sm/11),LEN(Plv))
         ENDIF

         RECT(CnC - Sm+1, Cnl+1, CnC-1, Cnl + 19, 1, Cores[TCr+1])

         IF Ld <> NIL .AND. TbVr[02] == TdC
            Tpx := LENPIX(Plv,1)
            PRNT(CnC - Tpx-5, CnL+3, Plv, Cores[TCp+1],, TRUE)
         ELSE
            PRNT(CnC - Sm+5, CnL+3, Plv, Cores[TCp+1],, TRUE)
         ENDIF
         *-------------------------------------------------------------------

         TdC := TdC - 1
         CnC := CnC - Sm

         IF Sai == 1
            EXIT
         ENDIF
      ENDDO
   ENDIF

   PMS(1)
RETURN

*----------------------------------------------------------------------------
FUNCTION TBCLK()
*----------------------------------------------------------------------------
* segue o clique do mouse no tb

   LOCAL Tlc, TdC, Sm, CnC

   IF NObj[9] == 0
      RETURN
   ENDIF

   IF !(MX > Tb[1,1] .AND. MX < Tb[1,3] .AND. MY > Tb[1,2]+20 .AND. MY < Tb[1,4])
      RETURN
   ENDIF

   PTBL(15,0)
   TbVr[07] := 0

   *-------------- Verifica linha pressionada -------------------------------
   Tlc := INT((MY - Tb[1,2]) / 20)

   IF Tlc < INT((Tb[1,4] - Tb[1,2]) / 20) .AND. Tlc <= TbVr[12]
      SKIP (Tlc - TbVr[01])
      TbVr[01] := Tlc
   ENDIF

   *---------------- Verifica da esquerda -> direita coluna pressionada -----
   IF TbVr[05] == 1
      Sm  := 0
      CnC := Tb[1,1]

      FOR TdC := TbVr[04] TO TbVr[03]
         Sm := Tc[TdC,6] * 11

         IF MX > CnC .AND. MX < CnC + Sm
            TbVr[02] := TdC
            EXIT
         ENDIF

         CnC := CnC + Sm
      NEXT TdC

      IF TdC == TbVr[03] .AND. TbVr[06] == 0
         TbVr[03] := TdC
         BUILD_TBC(0)
      ENDIF
   *---------------- Verifica da direita -> esquerda coluna pressionada -----
   ELSE
      Sm  := 0
      CnC := Tb[1,3]
      TdC := TbVr[03]

      DO WHILE TdC >= TbVr[04]
         Sm := (Tc[TdC,6] * 11)

         IF MX > Cnc-Sm .AND. MX < CnC
            TbVr[02] := TdC
            EXIT
         ENDIF

         CnC := CnC - Sm
         TdC := TdC - 1
      ENDDO

      IF TdC == TbVr[04] .AND. TbVr[06] == 0
         TbVr[04] := TdC
         BUILD_TBC(1)
      ENDIF
   ENDIF
   *-------------------------------------------------------------------------

   PTBL(Gcr,15)
RETURN

*----------------------------------------------------------------------------
FUNCTION TBESC(Let)
*----------------------------------------------------------------------------
* Escreve no input

   LOCAL Ma  := ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+{}:'+CHR(34)+'<>?|`-=[];'+CHR(39)+',./\�䤃���������������������奶�����������ؙ�����逘��'
   LOCAL ISm, TmD                           // Tmd eh a variavel q conta a qtd de numeros deposi do ponto no input financeiro

   IF NObj[9] == 0
      RETURN
   ENDIF

   TbVr[14] := 999
   TBIPIS()
   *-----------------------Se for uma letra valida para escrita... ----------
   IF CHR(Let)$Ma
      *-----------------------Se input for numerico ... ---------------------
      IF (Tc[TbVr[02],5] == 'N' .OR. Tc[TbVr[02],5] == 'D') .AND. !(CHR(Let)$'1234567890')
         RETURN
      *---------Trantamento especial para inputs data qdo se digita ---------
      ELSEIF Tc[TbVr[02],5] == 'D'                                           // Conta pixels adicionais para certas posicoes no campo de data
         IF TbVr[09] == 2 .OR. TbVr[09] == 5
            TbVr[08] := STUFF(TbVr[08],(TbVr[09]+1),1,'/')
            TbVr[09] := TbVr[09] + 1
            TbVr[10] := TbVr[10] + LENPIX(TXT2FNT('/'),1)
         ENDIF
      *------- tratamento especial para inputs financeiros qdo se digita ----
      ELSEIF Tc[TbVr[02],5] == 'F'
         IF '.'$TbVr[08] .AND. TbVr[11] == 0
            TbVr[08] := ''
            TbVr[09] := 0
         ELSEIF (TbVr[11] > 0 .AND. CHR(Let) == '.') .OR. TbVr[11] > 2 .OR. !(CHR(Let)$'1234567890.')
            RETURN
         ELSEIF (LEN(TbVr[08]) + 3) == Tc[TbVr[02],6] .AND. !('.'$TbVr[08]) .AND. CHR(Let) <> '.'
            TbVr[08] := TbVr[08] + '.'
            TbVr[09] := TbVr[09] + 1
            TbVr[11] := TbVr[11] + 1
         ENDIF
      *----------------------------------------------------------------------
      ELSEIF Tc[TbVr[02],5] == 'A'
         Let := ASC(UPP(CHR(Let)))
      ENDIF

      IF (Tc[TbVr[02],5] == 'N' .OR. Tc[TbVr[02],5] == 'D') .AND. TbVr[09] < Tc[TbVr[02],6]    // para campos data, e numericos a letra digitada eh sobreposta
         TbVr[08] := STUFF(TbVr[08],(TbVr[09]+1),1,CHR(Let))
      ELSEIF LEN(TbVr[08]) < Tc[TbVr[02],6]                                 // para campos alfanumericos a letra digitada eh inserida
         TbVr[08] := STUFF(TbVr[08],(TbVr[09]+1),0,CHR(Let))
      ELSE
         RETURN
      ENDIF

      IF Tc[TbVr[02],5] == 'F'              // Para inputs financeiros, cursor sempre no final do input
         TbVr[10] := (Tc[TbVr[02],6]*11) - 6

         IF '.'$TbVr[08]                    // depois do ponto
            TbVr[11] := TbVr[11] + 1
         ENDIF
      ELSE
         TbVr[10] := TbVr[10] + LENPIX(TXT2FNT(CHR(Let)),1)
      ENDIF

      TbVr[09] := TbVr[09] + 1

      *--------- Monta Input atual ---------------------------------------
      IF Tc[TbVr[02],5] == 'F'
         PTBL(14,0,TbVr[08],1)
      ELSE
         PTBL(14,0,TbVr[08])
      ENDIF
      *-------------------------------------------------------------------
   ENDIF
   *---------- Se Tecla == ENTER, ou setas para cima ou para baixo ----------
   IF Let == 13 .OR. Let == 24 .OR. Let == 5
      PRXIN(Let)

   *------------ Se Tecla == End --------------------------------------------
   ELSEIF Let == 6 .AND. Tc[TbVr[02],5] <> 'F'
      TbVr[10] := LENPIX(TXT2FNT(TbVr[08]),1)
      TbVr[09] := LEN(TbVr[08])
   *------------ Se Tecla == Home -------------------------------------------
   ELSEIF Let == 1 .AND. Tc[TbVr[02],5] <> 'F'
      TbVr[10] := 0
      TbVr[09] := 0
   *------------ Se Tecla == esquerda ---------------------------------------
   ELSEIF Let == 19 .AND. TbVr[10] > 0 .AND. Tc[TbVr[02],5] <> 'F'
      TbVr[10] := TbVr[10] - LENPIX(TXT2FNT(SUBSTR(TbVr[08],TbVr[09],1)),1)
      TbVr[09] := TbVr[09] - 1
   *------------ Se Tecla == direita ----------------------------------------
   ELSEIF Let == 4 .AND. TbVr[09] < LEN(TbVr[08]) .AND. Tc[TbVr[02],5] <> 'F'
      TbVr[10] := TbVr[10] + LENPIX(TXT2FNT(SUBSTR(TbVr[08],(TbVr[09]+1),1)),1)
      TbVr[09] := TbVr[09] + 1
   *------------ Se Tecla == Delete -----------------------------------------
   ELSEIF Let == 7 .AND. Tc[TbVr[02],5] <> 'D' .AND. Tc[TbVr[02],5] <> 'F'
      TbVr[08] := STUFF(TbVr[08],(TbVr[09]+1),1,'')

      PTBL(14,0,TbVr[08])
   *------------ Se Tecla == Backspace --------------------------------------
   ELSEIF Let == 8 .AND. TbVr[09] > 0 .AND. Tc[TbVr[02],5] <> 'D'

      IF Tc[TbVr[02],5] == 'F' .AND. '.'$TbVr[08] .AND. TbVr[11] == 0
         TbVr[08] := ''
         TbVr[09] := 0
         PTBL(14,0,TbVr[08],1)
         RETURN
      ELSEIF Tc[TbVr[02],5] <> 'F'
         TbVr[10] := TbVr[10] - LENPIX(TXT2FNT(SUBSTR(TbVr[08],TbVr[09],1)),1)
      ELSEIF Tc[TbVr[02],5] == 'F'
         IF '.'$TbVr[08]
           TbVr[11] := TbVr[11] - 1
         ENDIF
      ENDIF

      TbVr[08] := STUFF(TbVr[08],TbVr[09],1,'')
      TbVr[09] := TbVr[09] - 1
      *--------------- Atualiza diferente para input financeiro -------------

      IF Tc[TbVr[02],5] == 'F'
         PTBL(14,0,TbVr[08],1)
      ELSE
         PTBL(14,0,TbVr[08])
      ENDIF

      *----------------------------------------------------------------------
   ENDIF
   *-------------------------------------------------------------------------
RETURN

*----------------------------------------------------------------------------
FUNCTION TBIGRV(keypress)
*----------------------------------------------------------------------------
* Grava input do TB

   LOCAL Fnc

   IF TbVr[07] == 0
      RETURN
   ENDIF

   IF keypress <> 27
      FnC   := Tc[TbVr[02],8]                    // captura funcao de fechamento

      IF LEN(FnC) > 0
         TbVr[08] := &FnC(TbVr[08])        // Mescla palavra com funcao
      ENDIF

      IF TbVr[08] <> NIL
         RLOCK()
         REPLACE &(Tc[TbVr[02],2]) WITH TbVr[08]
         DBCOMMIT()
         UNLOCK
      ENDIF
   ENDIF

   // Tecla := 0
   TbVr[07]   := 0
   PTBL(Gcr,15)
RETURN

*----------------------------------------------------------------------------
FUNCTION TBIPIS()
*----------------------------------------------------------------------------
* Pisca do input

   LOCAL X, Y

   IF TbVr[07] == 0 .OR. NObj[9] == 0
      RETURN
   ENDIF

   TbVr[14] := TbVr[14] + 1
   X := TbVr[13]
   Y := Tb[1,2]+((TbVr[01])*20)

   IF TbVr[14] == 500
      LINE(X+4+TbVr[10],Y+3,X+4+TbVr[10],Y+16,clBlack)
   ELSEIF TbVr[14] == 1000
      LINE(X+4+TbVr[10],Y+3,X+4+TbVr[10],Y+16,clYellow)
      TbVr[14] := 0
   ENDIF

RETURN
