FUNCTION SET_DIVIDERS(style)
   LOCAL TdL,Cr

   IF NObj[OBJ_DIVIDER] == 0
      RETURN
   ENDIF

   FOR TdL := 1 TO NObj[OBJ_DIVIDER]
      IF style == ACTIVE
         Cr := Cores[Li[TdL, 5]+1]
      ELSE
         Cr := clDkGray
      ENDIF

      LINE(Li[TdL,1], Li[TdL,2], Li[TdL,3], Li[TdL,4],Cr)
   NEXT TdL
RETURN
