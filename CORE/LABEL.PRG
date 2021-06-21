*----------------------------------------------------------------------------
* Modulo de controle dos textos
*----------------------------------------------------------------------------

*----------------------------------------------------------------------------
FUNCTION BUILD_LABEL(NuTx)
*----------------------------------------------------------------------------
* Monta textos

   LOCAL TdT, Ini, Fim

   IF NObj[5] == 0
      RETURN
   ENDIF

   *--------------- Verifica quais os textos seram escritos -----------------
   IF NuTx == NIL
      Ini := 1
      Fim := NObj[5]
   ELSE
      Ini := NuTx
      Fim := NuTx
   ENDIF
   *-------------- Monta textos ---------------------------------------------
   FOR TdT := Ini TO Fim
      PRNT(Tx[TdT,1], Tx[TdT,2], Tx[TdT,4], Tx[TdT,3],,Tx[TdT,5])
   NEXT TdT
   *-------------------------------------------------------------------------
RETURN
