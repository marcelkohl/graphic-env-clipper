#INCLUDE "LIBS\FGL.CH"

FUNCTION SET_GLOBALS()
  PUBLIC OBJ_BUTTON := 1
  PUBLIC OBJ_DIVIDER := 8
  PUBLIC OBJ_BOX := 7
  PUBLIC TRUE := 1
  PUBLIC FALSE := 0
  PUBLIC ACTIVE := TRUE
  PUBLIC INACTIVE := FALSE
  PUBLIC KEEP_ALIVE  := TRUE

  PUBLIC Gcr      := 9
  PUBLIC Vsa      := '1.0'
  PUBLIC S_CdFu   := 0
  PUBLIC S_NmFu   := ''
  PUBLIC Cores    := {clBlack,clNavy,clGreen,clTeal,clMaroon,clPurple,clOlive,clSilver,clGray,clBlue,clLime,clAqua,clRed,clFuchsia,clYellow,clWhite,clLtGray}
  PUBLIC MPres    := 0          // Variavel q indica se mouse foi clicado
  PUBLIC aMState, NAt
  PUBLIC MenuAti  := 0          // identifica se menu principal estah ativo (1) ou naum (0)
  PUBLIC HoraAnt  := '00:00'    // Marca hora anterior
  PUBLIC aFonte   := FGLFontLoad('ASSETS\SYSTEMB.FNT')
  PUBLIC bFonte   := FGLFontLoad('ASSETS\SYSTEM.FNT')
//  PUBLIC Tecla    := 0          // Captura tecla do modulo principal
  PUBLIC Mn_Tela  := {}         // Guarda tela do menu da barra de ferramentas
  PUBLIC Sb_Tela  := {}         // Guarda tela de submenu da barra de ferramentas
  PUBLIC MenuBar[21,20,5]       // Opcoes dos menus
  PUBLIC MenuTam[21,4]          // coordenadas dos menus
  PUBLIC PontoG   := 1
  PUBLIC MenuG    := 1

  PUBLIC Sb_Menu  := 0          // Identifica o submenu aberto
  PUBLIC Remonta  := 0          // Identifica se alguma janela deve ser montada

  PUBLIC MX :=0, MY := 0        // Variaveis de coordenadas do mouse
  PUBLIC MsB

  PUBLIC Mse      := 2
  PUBLIC XOld     := 0
  PUBLIC YOld     := 0

  PUBLIC NObj[10]               // Guarda numero de quantidade de todos os objetos
  AFILL(NObj,0)

  PUBLIC Jn[9]                  // Guarda valores da janela
  AFILL(Jn,0)
  Jn[1] := ''
  Jn[7] := ''
  Jn[8] := ''

  PUBLIC Bt := {}               // Guarda valores dos botoes
  PUBLIC PBt[5]                 // guarda coordenadas de algum objeto pressionado

  PUBLIC InC := 0               // Contador do pisca do input
  PUBLIC InA := 0               // Indica qual o input atual
  PUBLIC InP := 0               // Posicao do cursor do input em pixels
  PUBLIC InL := 0               // Posicao do cursor do input em caracteres
  PUBLIC InF := 0               // Marca qtos numeros jah foram digitados no input financeiro depois do ponto

  PUBLIC CkP := 0               // Verifica se checkbox estah pressionado
  PUBLIC SbP := 0               // Verifica se selectbox estah pressionado

  PUBLIC TbVr := {1,1,1,1,1,1,0,0,1,1,1,0,0,0}


  PUBLIC TBr1 := FGLLoadBMP('ST4.BMP')     // barras de espera tipo MAC
  PUBLIC TBr2 := FGLLoadBMP('ST4.BMP')
  PUBLIC TBr3 := FGLLoadBMP('ST4.BMP')
  PUBLIC BtJ1 := FGLLoadBMP('ASSETS\ST4.BMP')
  PUBLIC BtJ2 := FGLLoadBMP('ASSETS\ST4.BMP')

  PUBLIC Bt := {}
  PUBLIC In := {}
  PUBLIC Cb := {}
  PUBLIC Sb := {}
  PUBLIC Tx := {}
  PUBLIC Im := {}
  PUBLIC Cx := {}
  PUBLIC Li := {}
  PUBLIC Tb := {}
  PUBLIC Tc := {}

  PUBLIC TtVn := 0
  PUBLIC TtPr := 0
RETURN
