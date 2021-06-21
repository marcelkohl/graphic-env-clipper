*----------------------------------------------------------------------------
* Modulo de controle dos check boxes
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION BUILD_CHKBOX(NCb)
*----------------------------------------------------------------------------
* Monta Checkboxes

   LOCAL TdC, Ct, Ini, Fim, Cr
   LOCAL CkS := CHR(12)+CHR(13)+'                        00          008         008         008    00   008      00 008        0008          08           8                                 '
   LOCAL CkD := CHR(12)+CHR(13)+'                        88          88          88          88     88   88       88 88         888           8                                              '

   IF NObj[3] == 0
      RETURN
   ENDIF

   *-------------- Verifica do checkbox a ser montado -----------------------
   IF NCb == NIL
      Ini := 1
      Fim := NObj[3]
   ELSE
      Ini := NCb
      Fim := NCb
   ENDIF
   *-------------- Monta os checkboxes --------------------------------------

   FOR TdC := Ini TO Fim

      IF Cb[TdC,8] == 'S'
         Cr := Cores[Cb[TdC,5]+1]
         BOX_UP(Cb[TdC,2],Cb[TdC,3],Cb[TdC,2]+12,Cb[TdC,3]+11,NIL)

         IF Cb[TdC,7] == 'S'
            DRAWIMG(CkS,Cb[TdC,3]-1,Cb[TdC,2]-1)
         ENDIF
      ELSE
         Cr := clDkGray
         RECT(Cb[TdC,2],Cb[TdC,3],Cb[TdC,2]+12,Cb[TdC,3]+11,2,clDkGray)

         IF Cb[TdC,7] == 'S'
            DRAWIMG(CkD,Cb[TdC,3]-1,Cb[TdC,2]-1)
         ENDIF
      ENDIF

      PRNT(Cb[TdC,2]+16, Cb[TdC,3]-1, Cb[TdC,4], Cr,, FALSE)
   NEXT TdC

RETURN

*----------------------------------------------------------------------------
FUNCTION DEATICKB()
*----------------------------------------------------------------------------
* Desativa check boxes

   LOCAL TdC, Ct
   LOCAL CkS := CHR(12)+CHR(13)+'                        00          008         008         008    00   008      00 008        0008          08           8                                 '
   LOCAL CkD := CHR(12)+CHR(13)+'                        88          88          88          88     88   88       88 88         888           8                                              '

   IF NObj[3] == 0
      RETURN
   ENDIF

   FOR TdC := 1 TO NObj[3]
      RECT(Cb[TdC,2],Cb[TdC,3],Cb[TdC,2]+12,Cb[TdC,3]+11,1,clSilver)
      RECT(Cb[TdC,2],Cb[TdC,3],Cb[TdC,2]+12,Cb[TdC,3]+11,2,clDkGray)

      IF Cb[TdC,7] == 'S'
         DRAWIMG(CkD,Cb[TdC,3]-1,Cb[TdC,2]-1)
      ENDIF

      PRNT(Cb[TdC,2]+16, Cb[TdC,3]-1, Cb[TdC,4], clDkGray,, FALSE)
   NEXT TdC

RETURN

*----------------------------------------------------------------------------
FUNCTION CBCLK()
*----------------------------------------------------------------------------
* verifica clique sobre o chkbox

   LOCAL TdC
   IF NObj[3] == 0
      RETURN
   ENDIF

   FOR TdC := 1 TO NObj[3]
      IF MX >= Cb[TdC,2] .AND. MY >= Cb[TdC,3] .AND. MX <= Cb[TdC,2]+12 .AND. MY <= Cb[TdC,3]+11 .AND. Cb[TdC,8] == 'S'
         PMS(0)
         RECT(Cb[TdC,2]+1,Cb[TdC,3]+1,Cb[TdC,2]+10,Cb[TdC,3]+9,1,clDkGray)
         PMS(1)
         CkP := TdC
      ENDIF
   NEXT TdC

RETURN

*----------------------------------------------------------------------------
FUNCTION CBUNCLK()
*----------------------------------------------------------------------------
* verifica se mouse foi solto sobre o chkbox

   LOCAL CkS := CHR(12)+CHR(13)+'                        00          008         008         008    00   008      00 008        0008          08           8                                 '
   LOCAL Fnc

   IF CkP == 0 .OR. NObj[3] == 0
      RETURN
   ENDIF

   PMS(0)
   BOX_UP(Cb[CkP,2],Cb[CkP,3],Cb[CkP,2]+12,Cb[CkP,3]+11,clSilver)

   *--------------- se soltou dentro do chkbox de onde clicou ---------------
   IF MX >= Cb[CkP,2] .AND. MY >= Cb[CkP,3] .AND. MX <= Cb[CkP,2]+12 .AND. MY <= Cb[CkP,3]+11
      IF Cb[CkP,7] == 'S'
         Cb[CkP,7] := 'N'
      ELSE
         DRAWIMG(CkS,Cb[CkP,3]-1,Cb[CkP,2]-1)
         Cb[CkP,7] := 'S'
      ENDIF

      Fnc := Cb[CkP,6]

      IF LEN(Fnc) > 0
         &Fnc()
      ENDIF
   *----------------- se soltou fora do chkbox de onde clicou ---------------
   ELSEIF Cb[CkP,7] == 'S'
      DRAWIMG(CkS,Cb[CkP,3]-1,Cb[CkP,2]-1)
   ENDIF

   PMS(1)
   CkP := 0
RETURN
