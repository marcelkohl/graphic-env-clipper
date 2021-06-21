#INCLUDE "..\LIBS\FGL.CH"

FUNCTION BUILD_BOX()
   LOCAL TdC, Tp

   IF NObj[OBJ_BOX] == 0
      RETURN
   ENDIF

   FOR TdC := 1 TO NObj[OBJ_BOX]
      IF Cx[TdC,6] == 'V'
         Tp := 2
      ELSE
         Tp := 1
      ENDIF

      RECT(Cx[TdC,1],Cx[TdC,2],Cx[TdC,3],Cx[TdC,4],Tp,Cores[Cx[TdC,5]+1])

      IF LEN(Cx[TdC,7]) > 0
         PRNT(Cx[TdC,1]+7, Cx[TdC,2]-7, Cx[TdC,7], clBlack, clSilver, FALSE)
      ENDIF
   NEXT TdC
RETURN

FUNCTION DISABLE_BOX()
   LOCAL TdC

   IF NObj[OBJ_BOX] == 0
      RETURN
   ENDIF

   FOR TdC := 1 TO NObj[OBJ_BOX]
      IF Cx[TdC,6] == 'V'
         RECT(Cx[TdC,1], Cx[TdC,2], Cx[TdC,3], Cx[TdC,4], 2, clDkGray)
         IF LEN(Cx[TdC,7]) > 0
            PRNT(Cx[TdC,1]+7, Cx[TdC,2]-7, Cx[TdC,7], clDkGray, clSilver, FALSE)
         ENDIF
      ENDIF
   NEXT TdC
RETURN
