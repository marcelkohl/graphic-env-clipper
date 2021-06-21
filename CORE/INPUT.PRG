#INCLUDE "..\LIBS\FGL.CH"

*----------------------------------------------------------------------------
* Modulo de controle dos inputs
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION BUILD_INPUT(NI,Tp)
*----------------------------------------------------------------------------
* funcao q monta inputs
* NI = Numero do input
* Tp = Tipo de escrita do input, NIL=normal, 1= de traz para frente

   LOCAL TdIn, Cl, Tl, Ini, Fim, Plv

   IF NObj[2] == 0
      RETURN
   ENDIF


   *------------ Verifica inicio e fim de montagem de inputs ----------------
   IF NI == NIL
      Fim := NObj[2]
      Ini := 1
   ELSE
      Ini := NI
      Fim := NI
   ENDIF
   *-------------------------------------------------------------------------

   FOR TdIn := Ini TO Fim
      IF In[TdIn,6] == 'S'
         RECT(In[TdIn,2]+1, In[TdIn,3]+1, In[TdIn,2]+In[TdIn,4]-1, In[TdIn,3]+18,1,clWhite)
         Cl := clBlack
      ELSE
         RECT(In[TdIn,2]+1, In[TdIn,3]+1, In[TdIn,2]+In[TdIn,4]-1, In[TdIn,3]+18,1,clSilver)
         Cl := clDkGray
      ENDIF

      Tl := LENPIX(In[TdIn,9],2) + 5

      PRNT(In[TdIn,2]-Tl, In[TdIn,3]+3, In[TdIn,9], clBlack, NIL, FALSE)

      RECT(In[TdIn,2], In[TdIn,3], In[TdIn,2]+In[TdIn,4], In[TdIn,3]+19,0,Cl)

      *---------------- Verifica se o input eh do tipo senha ----------------
      IF In[TdIn,7] == 'X'
         Plv := REPLICATE(CHR(149),LEN(In[TdIn,10]))
      ELSE
         Plv := TXT2FNT(In[TdIn,10])
      ENDIF

      *--------------- Escreve dierente para inputs financeiros e demais ----
      IF In[TdIn,7] == 'F'
         Tp := 1
      ELSE
         Tp := NIL
      ENDIF
      *----------------------------------------------------------------------
      IF Tp <> NIL
         PRNT(In[TdIn,2]+In[TdIn,4]-LENPIX(In[TdIn,10],1)-3, In[TdIn,3]+3, Plv, Cl, NIL, TRUE)
      ELSE
         PRNT(In[TdIn,2]+5, In[TdIn,3]+3, Plv, Cl, NIL, TRUE)
      ENDIF

   NEXT TdIn

RETURN

*----------------------------------------------------------------------------
FUNCTION DEATINP()
*----------------------------------------------------------------------------
* funcao q desativa inputs

   LOCAL TdIn, Tl,Plv

   FOR TdIn := 1 TO NObj[2]
      IF In[TdIn,6] == 'S'
         RECT(In[TdIn,2], In[TdIn,3], In[TdIn,2]+In[TdIn,4], In[TdIn,3]+19,1,clSilver)
         RECT(In[TdIn,2], In[TdIn,3], In[TdIn,2]+In[TdIn,4], In[TdIn,3]+19,0,clDkGray)

         *------------------------ Verifica se input eh do tipo senha -------
         IF In[TdIn,7] == 'X'
            Plv := REPLICATE(CHR(149),LEN(In[TdIn,10]))
         ELSE
            Plv := TXT2FNT(In[TdIn,10])
         ENDIF

         *------------ Inputs financeiros tem tratamento diferente ----------
         IF In[TdIn,7] == 'F'
            PRNT(In[TdIn,2]+In[TdIn,4]-LENPIX(In[TdIn,10],1)-3, In[TdIn,3]+3, Plv, clDkGray, NIL, TRUE)
         ELSE
            PRNT(In[TdIn,2]+5, In[TdIn,3]+3, Plv, clDkGray, NIL, TRUE)
         ENDIF
         *-------------------------------------------------------------------
      ENDIF

      Tl := LENPIX(In[TdIn,9],2) + 5
      PRNT(In[TdIn,2]-Tl, In[TdIn,3]+3, In[TdIn,9], clDkGray, NIL, FALSE)

   NEXT TdIn

RETURN

*----------------------------------------------------------------------------
FUNCTION INPIS()
*----------------------------------------------------------------------------
* Faz com q o input pisque

   LOCAL X,Y

   IF NObj[2] == 0 .OR. InA == 0
      RETURN
   ENDIF

   InC := InC + 1
   X := In[InA,2]
   Y := In[InA,3]

   IF InC == 500
      LINE(X+4+InP,Y+3,X+4+InP,Y+16,clBlack)
   ELSEIF InC == 1000
      LINE(X+4+InP,Y+3,X+4+InP,Y+16,clWhite)
      InC := 0
   ENDIF

RETURN

*----------------------------------------------------------------------------
FUNCTION INESC(Let)
*----------------------------------------------------------------------------
* Escreve no input

   LOCAL Ma  := ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~!@#$%^&*()_+{}:'+CHR(34)+'<>?|`-=[];'+CHR(39)+',./\�䤃���������������������奶�����������ؙ�����逘��'
   LOCAL ISm, TmD                           // Tmd eh a variavel q conta a qtd de numeros deposi do ponto no input financeiro

   IF NObj[2] == 0
      RETURN
   ENDIF

   *----------------------- Apaga o cursor anterior -------------------------
   IF InA > 0
      InC := 999
      INPIS()
   ENDIF
   *-----------------------Se for uma letra valida para escrita... ----------
   IF CHR(Let)$Ma
      *-----------------------Se input for numerico ... ---------------------
      IF (In[InA,7] == 'N' .OR. In[InA,7] == 'D') .AND. !(CHR(Let)$'1234567890')
         RETURN
      *---------Trantamento especial para inputs data qdo se digita ---------
      ELSEIF In[InA,7] == 'D'                                           // Conta pixels adicionais para certas posicoes no campo de data
         IF InL == 2 .OR. InL == 5
            In[InA,10] := STUFF(In[InA,10],(InL+1),1,'/')
            InL := InL + 1
            InP := InP + LENPIX(TXT2FNT('/'),1)
         ENDIF
      *------- tratamento especial para inputs financeiros qdo se digita ----
      ELSEIF In[InA,7] == 'F'
         IF '.'$In[InA,10] .AND. InF == 0
            In[InA,10] := ''
            InL        := 0
         ELSEIF (InF > 0 .AND. CHR(Let) == '.') .OR. InF > 2 .OR. !(CHR(Let)$'1234567890.')
            RETURN
         ELSEIF (LEN(In[InA,10]) + 3) == In[InA,5] .AND. !('.'$In[InA,10]) .AND. CHR(Let) <> '.'
            In[InA,10] := In[InA,10] + '.'
            InL := InL + 1
            InF := InF + 1
         ENDIF
      *----------------------------------------------------------------------
      ELSEIF In[InA,7] == 'A'
         Let := ASC(UPP(CHR(Let)))
      ENDIF

      IF (In[InA,7] == 'N' .OR. In[InA,7] == 'D') .AND. InL < In[InA,5]    // para campos data, e numericos a letra digitada eh sobreposta
         In[InA,10] := STUFF(In[InA,10],(InL+1),1,CHR(Let))
      ELSEIF LEN(In[InA,10]) < In[InA,5]                                 // para campos alfanumericos a letra digitada eh inserida
         In[InA,10] := STUFF(In[InA,10],(InL+1),0,CHR(Let))
      ELSE
         RETURN
      ENDIF

      IF In[InA,7] == 'X'                  // Conta pixels especial para inputs de senha
         InP := InP + 5
      ELSEIF In[InA,7] == 'F'              // Para inputs financeiros, cursor sempre no final do input
         InP := In[InA,4] - 6

         IF '.'$In[InA,10]                 // depois do ponto
            InF := InF + 1
         ENDIF
      ELSE
         InP := InP + LENPIX(TXT2FNT(CHR(Let)),1)
      ENDIF

      InL := InL + 1

      *--------- Monta Input atual ---------------------------------------
      PMS(0)

      IF In[InA,7] == 'F'
         BUILD_INPUT(InA,1)                    // monta input de traz para frente qdo o campo eh financeiro
      ELSE
         BUILD_INPUT(InA)
      ENDIF
      PMS(1)
      *-------------------------------------------------------------------
   ENDIF
   *---------- Se Tecla == ENTER, ou setas para cima ou para baixo ----------
   IF Let == 13 .OR. Let == 24 .OR. Let == 5
      PRXIN(Let)

   *------------ Se Tecla == End --------------------------------------------
   ELSEIF Let == 6 .AND. In[InA,7] <> 'F'
      IF In[InA,7] == 'X'                                        // Conta pixels especial para inputs de senha
         InP := LENPIX(REPLICATE(CHR(149),LEN(In[InA,10])),1)
      ELSE
         InP := LENPIX(TXT2FNT(In[InA,10]),1)
      ENDIF

      InL := LEN(In[InA,10])
   *------------ Se Tecla == Home -------------------------------------------
   ELSEIF Let == 1 .AND. In[InA,7] <> 'F'
      InP := 0
      InL := 0
   *------------ Se Tecla == esquerda ---------------------------------------
   ELSEIF Let == 19 .AND. InP > 0 .AND. In[InA,7] <> 'F'
      IF In[InA,7] == 'X'                                  // Conta pixels especial para inputs de senha
         InP := InP - 5
      ELSE
         InP := InP - LENPIX(TXT2FNT(SUBSTR(In[InA,10],InL,1)),1)
      ENDIF

      InL := InL - 1
   *------------ Se Tecla == direita ----------------------------------------
   ELSEIF Let == 4 .AND. InL < LEN(In[InA,10]) .AND. In[InA,7] <> 'F'

      IF In[InA,7] == 'X'
         InP := InP + 5                                    // Conta pixels especial para inputs de senha
      ELSE
         InP := InP + LENPIX(TXT2FNT(SUBSTR(In[InA,10],(InL+1),1)),1)
      ENDIF

      InL := InL + 1
   *------------ Se Tecla == Delete -----------------------------------------
   ELSEIF Let == 7 .AND. In[InA,7] <> 'D' .AND. In[InA,7] <> 'F'
      In[InA,10] := STUFF(In[InA,10],(InL+1),1,'')

      PMS(0)
      BUILD_INPUT(InA)
      PMS(1)
   *------------ Se Tecla == Backspace --------------------------------------
   ELSEIF Let == 8 .AND. InL > 0 .AND. In[InA,7] <> 'D'

      IF In[InA,7] == 'F' .AND. '.'$In[InA,10] .AND. InF == 0
         In[InA,10] := ''
         InL        := 0
         PMS(0)
         BUILD_INPUT(InA,1)
         PMS(1)
         RETURN
      ELSEIF In[InA,7] == 'X'
         InP := InP - 5
      ELSEIF In[InA,7] <> 'F'
         InP := InP - LENPIX(TXT2FNT(SUBSTR(In[InA,10],InL,1)),1)
      ELSEIF In[InA,7] == 'F'
         IF '.'$In[InA,10]
           InF := InF - 1
         ENDIF
      ENDIF

      In[InA,10] := STUFF(In[InA,10],InL,1,'')
      InL := InL - 1
      *--------------- Atualiza diferente para input financeiro -------------
      PMS(0)

      IF In[InA,7] == 'F'
         BUILD_INPUT(InA,1)
      ELSE
         BUILD_INPUT(InA)
      ENDIF

      PMS(1)
      *----------------------------------------------------------------------
   ENDIF
   *-------------------------------------------------------------------------
RETURN

*----------------------------------------------------------------------------
FUNCTION INCLK()
*----------------------------------------------------------------------------
* busca input qdo mouse foi clicado

   LOCAL TdI, TmD

   IF NObj[2] == 0
      RETURN
   ENDIF

   PMS(0)
   *-------------------- Procura pelo input clicado -------------------------
   FOR TdI := 1 TO NObj[2]
      IF MX >= In[TdI,2] .AND. MY >= In[TdI,3] .AND. MX <= (In[TdI,2] + In[TdI,4]) .AND. MY <=In[TdI,3] + 19
         IF In[TdI,6] == 'S'
            *-------------- Zera o cursor anterior --------------------------
            IF InA > 0
               InC := 999
               INPIS()
            ENDIF

            InP := 0
            InL := 0
            *--------------- Se input anterior era numerico... --------------
            IF InA > 0 .AND. In[InA,7] == 'N'
               BUILD_INPUT(InA,1)
            *--------------- Se input anterior era financeiro... ------------
            ELSEIF InA > 0 .AND. In[InA,7] == 'F'
               TmD := LEN(ALLTRIM(SUBSTR(In[InA,10],(AT('.',In[InA,10])+1),2)))

               IF '.'$In[InA,10] .AND. Tmd < 2
                  In[InA,10] := In[InA,10] + REPLICATE('0',2-TmD)
               ELSEIF !('.'$In[InA,10])
                  In[InA,10] := In[InA,10] + '.00'
               ENDIF

               BUILD_INPUT(InA,1)
            ENDIF
            *--------------- Apaga marcador do input ------------------------
            IF InA > 0
               RECT(In[InA,2]-1, In[InA,3]-1, In[InA,2]+In[InA,4]+1, In[InA,3]+20,0,clSilver)
            ENDIF
            *--------------- Pinta input novo -------------------------------
            InA := TdI
            *----------------- Monta input diferente para financeiro --------
            IF In[InA,7] == 'F'
               InP := In[InA,4] - 6
               InL := LEN(In[InA,10])
               InF := 0
               BUILD_INPUT(InA,1)
            ELSE
               BUILD_INPUT(InA)
            ENDIF
            *----------------------------------------------------------------
            RECT(In[InA,2]-1, In[InA,3]-1, In[InA,2]+In[InA,4]+1, In[InA,3]+20, 0, Cores[Gcr+1])
            EXIT
            *----------------------------------------------------------------
         ENDIF
      ENDIF
   NEXT TdI
   *-------------------------------------------------------------------------
   PMS(1)
RETURN

*----------------------------------------------------------------------------
FUNCTION PRXIN(Let)
*----------------------------------------------------------------------------
* Procura pelo proximo input

   LOCAL ISm, TmD
   LOCAL CnI := InA

   IF NObj[2] == 0
      RETURN
   ENDIF

   *---------------- Verifica se deve contar par cima ou para baixo ---------
   IF Let == 5
      ISm := -1
   ELSE
      ISm := 1
   ENDIF

   *---------------- encontra proximo input ---------------------------------
   DO WHILE .T.
      CnI := CnI + ISm

      IF CnI == InA
         RETURN
      ELSEIF CnI > NObj[2]
         CnI := 1
      ELSEIF CnI == 0
         CnI := NObj[2]
      ENDIF

      IF In[CnI,6] == 'S'
         InP := 0
         InL := 0
         PMS(0)
         *--------------- Se input anterior era numerico... -----------------
         IF InA > 0 .AND. In[InA,7] == 'N'
            BUILD_INPUT(InA,1)
         *--------------- Se input anterior era financeiro... ---------------
         ELSEIF InA > 0 .AND. In[InA,7] == 'F'
            TmD := LEN(ALLTRIM(SUBSTR(In[InA,10],(AT('.',In[InA,10])+1),2)))

            IF '.'$In[InA,10] .AND. Tmd < 2
               In[InA,10] := In[InA,10] + REPLICATE('0',2-TmD)
            ELSEIF !('.'$In[InA,10])
               In[InA,10] := In[InA,10] + '.00'
            ENDIF

            BUILD_INPUT(InA,1)
         ENDIF
         *--------------- Apaga marcador do input ---------------------------
         IF InA > 0
            RECT(In[InA,2]-1, In[InA,3]-1, In[InA,2]+In[InA,4]+1, In[InA,3]+20,0,clSilver)
         ENDIF
         *--------------- Pinta input novo ----------------------------------
         InA := CnI
         *----------------- Monta input diferente para financeiro -----------
         IF In[InA,7] == 'F'
            InP := In[InA,4] - 6
            InL := LEN(In[InA,10])
            InF := 0
            BUILD_INPUT(InA,1)
         ELSE
            BUILD_INPUT(InA)
         ENDIF
         *----------------------------------------------------------------
         RECT(In[InA,2]-1, In[InA,3]-1, In[InA,2]+In[InA,4]+1, In[InA,3]+20,0, Cores[Gcr+1])
         PMS(1)

         RETURN
         *-------------------------------------------------------------------
      ENDIF
   ENDDO
   *-------------------------------------------------------------------------
RETURN
