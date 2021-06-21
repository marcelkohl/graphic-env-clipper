#INCLUDE "..\LIBS\FGL.CH"

FUNCTION SET_BUTTON_GLOBALS()
  PUBLIC IDX_BTN_KEYPRESS := 5
  PUBLIC IDX_BTN_ACTIVE := 8
RETURN

FUNCTION BUILD_BUTTON(idxBtn)
   LOCAL TdBo, TmTx, TmBt, Cl

   SET_BUTTON_GLOBALS()

   IF NObj[OBJ_BUTTON] == 0
      RETURN
   ENDIF

   IF idxBtn == NIL
      FOR TdBo := 1 TO NObj[OBJ_BUTTON]
         IF Bt[TdBo, IDX_BTN_ACTIVE] == 'S'
            BOX_UP(Bt[TdBo,2],Bt[TdBo,3],Bt[TdBo,2]+Bt[TdBo,4],Bt[TdBo,3]+20,NIL)
            Cl := clBlack
         ELSE
            Cl := clDkGray
         ENDIF

         RECT(Bt[TdBo,2],Bt[TdBo,3],Bt[TdBo,2]+Bt[TdBo,4],Bt[TdBo,3]+20,2,Cl)

         TmTx := ((LENPIX(ALLTRIM(Bt[TdBo,6]),2))/2) + 3
         TmBt := (Bt[TdBo,4]/2)

         PRNT((Bt[TdBo,2]+TmBt)-TmTx+3, Bt[TdBo,3]+3, Bt[TdBo,6], Cl,, FALSE)
      NEXT TdBo
   ENDIF
RETURN

FUNCTION DISABLE_BUTTONS()
   LOCAL TdBo, TmTx, TmBt, Cl

   FOR TdBo := 1 TO NObj[OBJ_BUTTON]
      IF Bt[TdBo, IDX_BTN_ACTIVE] == 'S'
         RECT(Bt[TdBo,2]+1,Bt[TdBo,3]+1,Bt[TdBo,2]+Bt[TdBo,4]-1,Bt[TdBo,3]+19,2,clSilver)
         RECT(Bt[TdBo,2],Bt[TdBo,3],Bt[TdBo,2]+Bt[TdBo,4],Bt[TdBo,3]+20,2,clDkGray)
         TmTx := ((LENPIX(ALLTRIM(Bt[TdBo,6]),2))/2) + 3
         TmBt := (Bt[TdBo,4]/2)
         PRNT((Bt[TdBo,2]+TmBt)-TmTx+3, Bt[TdBo,3]+3, Bt[TdBo,6], clDkGray,, FALSE)
      ENDIF
   NEXT TdBo
RETURN

FUNCTION BUTTON_CLICK()
   LOCAL TdBo

   IF NObj[OBJ_BUTTON] == 0
      RETURN
   ENDIF

   FOR TdBo := 1 TO NObj[OBJ_BUTTON]
      IF MX >= Bt[TdBo,2] .AND. MY >= Bt[Tdbo,3] .AND. MX <= Bt[TdBo,2]+Bt[TdBo,4] .AND. MY <= Bt[TdBo,3]+20
         IF Bt[TdBo, IDX_BTN_ACTIVE] == 'S'
            PMS(0)
            BOX_DOWN(Bt[TdBo,2]+1,Bt[TdBo,3]+1,Bt[TdBo,2]+Bt[TdBo,4]-1,Bt[TdBo,3]+19,NIL,3)
            PMS(1)
            PBt[1] := Bt[TdBo,2]
            PBt[2] := Bt[TdBo,3]
            PBt[3] := Bt[TdBo,2]+Bt[TdBo,4]
            PBt[4] := Bt[TdBo,3]+20
            PBt[5] := TdBo
         ELSE
            AFILL(PBt,NIL)
         ENDIF
      ENDIF
   NEXT TdBo
RETURN

FUNCTION BUTTON_UNCLICK()
   LOCAL Fnc

   IF NObj[OBJ_BUTTON] == 0 .OR. PBt[1] == NIL
      RETURN
   ENDIF

   PMS(0)
   BOX_UP(Bt[PBt[5],2],Bt[PBt[5],3],Bt[PBt[5],2]+Bt[PBt[5],4],Bt[PBt[5],3]+20,NIL)
   PMS(1)

   IF MX >= PBt[1] .AND. MY >= PBt[2] .AND. MX <= PBt[3] .AND. MY <= PBt[4]
      callback := Bt[PBt[5],7]

      IF LEN(callback) > 0
         SJAN(Jn[1])
         &callback()
      ENDIF
   ENDIF
RETURN

FUNCTION BUTTON_KEYPRESS(Keypress)
   LOCAL TdBo, callback

   FOR TdBo := 1 TO NObj[OBJ_BUTTON]
      IF Bt[TdBo, IDX_BTN_KEYPRESS] == Keypress
         IF Bt[TdBo, IDX_BTN_ACTIVE] == 'S'
            callback := Bt[TdBo,7]

            IF LEN(ALLTRIM(callback)) > 0
               Tecla := 0
               SJAN(Jn[1])
               &callback()
            ENDIF
         ENDIF
      ENDIF
   NEXT TdBo
RETURN
