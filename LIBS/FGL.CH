/***
*
* FGL.CH
* Standard Ferns' Graphics Library v3.0 definitions.
*
* Copyright (c) 1994-1996, Ferns Paanakker.
* All rights reserved.
*
***/
#ifndef FGL_INCLUDE
#define FGL_INCLUDE

// Backward compatible with version 1.5
#xtranslate FGLPutBackground(<X>,<Y>,<Img>) => FGLShowDDB(<X>,<Y>,<Img>)

// The define for color settings
#define RGB(R,G,B)    ((B*256*256)+(G*256)+R)

// standard color definitions. Try to use these as much as possible!

#define clAqua      16776960    //RGB(  0,255,255)
#define clBlack     0           //RGB(  0,  0,  0)
#define clBlue      16711680    //RGB(  0,  0,255)
#define clDkGray    8421504     //RGB(128,128,128)
#define clFuchsia   16711935    //RGB(255,  0,255)
#define clGray      8421504     //RGB(128,128,128)
#define clGreen     32768       //RGB(  0,128,  0)
#define clLime      65280       //RGB(  0,255,  0)
#define clLtGray    12632256    //RGB(192,192,192)
#define clMaroon    128         //RGB(128,  0,  0)
#define clNavy      8388608     //RGB(  0,  0,128)
#define clOlive     32896       //RGB(  0,128,128)
#define clPurple    8388736     //RGB(128,  0,128)
#define clRed       255         //RGB(255,  0,  0)
#define clSilver    12632256    //RGB(192,192,192)
#define clTeal      8421376     //RGB(128,128,  0)
#define clWhite     16777215    //RGB(255,255,255)
#define clYellow    65535       //RGB(255,255,  0)

// You can use these for standard colors.
// static cl3DDkShadow    := clBlack
// static cl3DLight       := clWhite
// static clActiveBorder  := clWhite
// static clAppWorkSpace  := clLtGray
// static clBackground    := clMaroon
// static clBtnFace       := clDkGray
// static clBtnHighLight  := clWhite
// static clBtnShadow     := clBlack
// static clBtnText       := clBlack
// static clCaptionText   := clGreen
// static clGrayText      := clLtGray
// static clHLight        := clRed
// static clHLightText    := clWhite
// static clInactBorder   := clBlue
// static clInactCaption  := clNavy
// static clInactCText    := clDkGray
// static clInfoBk        := clWhite
// static clInfoText      := clBlack
// static clMenu          := clLtGray
// static clMenuText      := clBlack
// static clScrollBar     := clGray
// static clWindow        := clWhite
// static clWindowFrame   := clBlack
// static clWindowText    := clBlack


// Alphanumeric modes
#define  FGL_TEXT_NORMAL     3

// graphical modes
#define  FGL_GRAPHICS_640_480_16    18
// #define  FGL_GRAPHICS_800_600_16    258
// #define  FGL_GRAPHICS_640_400_256   256
// #define  FGL_GRAPHICS_640_480_256   257
// #define  FGL_GRAPHICS_640_480_32k   272

#define  FGL_TEXT  0
#define  FGL_GRAPH 1

// Mode set returns
#define  FGL_MODE_TEXT_ROW    1
#define  FGL_MODE_TEXT_COL    2
#define  FGL_MODE_GRAPH_MAXY  3
#define  FGL_MODE_GRAPH_MAXX  4
#define  FGL_MODE_GRAPH_ROW   3   // These two are there for LightLib
#define  FGL_MODE_GRAPH_COL   4   // Compatibility
#define  FGL_MODE_FONT_HEIGHT 5
#define  FGL_MODE_FONT_WIDTH  6
#define  FGL_MODE_NUMCOLORS   7
#define  FGL_MODE_IN_USE      8
#define  FGL_MODE_GRAPHIC     9
#define  FGL_MODE_FOREGROUND  10
#define  FGL_MODE_BACKGROUND  11

// For FGLSetPal to load a standard palette.
#define  FGL_PALET_STANDARD             -1

// Possible Mouse states
#define STATE_X                1
#define STATE_Y                2
#define STATE_ROW              3
#define STATE_COL              4
#define STATE_LEF              5
#define STATE_RIG              6
#define STATE_VSB              7
#define STATE_DRV              8

// Mouse button states
#define BUTTON_DOW             1
#define BUTTON_UP              0

// Mouse initial states and positions
#define INIT_ST                 {0,0,0,0,FGLM_BUTTON_UP,FGLM_BUTTON_UP,.F.,0}

// DIB/DDB structure (called a bitmap)
#define FGL_BMP_SIGNATURE  1
#define FGL_BMP_WIDTH      6
#define FGL_BMP_HEIGHT     7

#define FGL_BMP_IS_DIB  'DIB'
#define FGL_BMP_IS_DDB  'DDB'

// Different penstyles
#define FGL_SOLID           0
#define FGL_DITHER          1
#define FGL_OPAQUE          2
#define FGL_TRANSPARENT     3

// Different writemodes.
#define FGL_SET   0
#define FGL_AND    1
#define FGL_OR     2
#define FGL_XOR    3

// Constants to add to RGB()
#define FGL_DITHER16   16777216
#define FGL_INDEX      536870912

// For transparant colors
#define FGL_TRANS  -1

// Possible bitmap modes (for palette modes).
#define FGL_IMG_DITHER        0
#define FGL_IMG_TOTALNEWMAP   1
#define FGL_IMG_NEWMAP240     2
#define FGL_IMG_MAPONCURRENT  4

// font identifier defines
#define FGL_FNT_IS_FND   'FND'
#define FGL_FNT_IS_FNT   'FNT'

// Font Array Structure
#define FGL_FNT_SIGNATURE              1
#define FGL_FNT_CARGO                  2
#define FGL_FNT_FIXED                  3
#define FGL_FNT_NAME                   4
#define FGL_FNT_BOLD                   5
#define FGL_FNT_ITALIC                 6
#define FGL_FNT_STRIKEOUT              7
#define FGL_FNT_HEIGHT                 8
#define FGL_FNT_AVGWIDTH               9
#define FGL_FNT_SIZE                  10

#endif

/* The end */
