PPUCTRL         := $2000
PPUMASK         := $2001
PPUSTATUS       := $2002
OAMADDR         := $2003
OAMDATA         := $2004
PPUSCROLL       := $2005
PPUADDR         := $2006
PPUDATA         := $2007
SQ1_VOL         := $4000
SQ1_SWEEP       := $4001
SQ1_LO          := $4002
SQ1_HI          := $4003
SQ2_VOL         := $4004
SQ2_SWEEP       := $4005
SQ2_LO          := $4006
SQ2_HI          := $4007
TRI_LINEAR      := $4008
TRI_LO          := $400A
TRI_HI          := $400B
NOISE_VOL       := $400C
NOISE_LO        := $400E
NOISE_HI        := $400F
DMC_FREQ        := $4010
DMC_RAW         := $4011
DMC_START       := $4012                        ; start << 6 + $C000
DMC_LEN         := $4013                        ; len << 4 + 1
OAMDMA          := $4014
SND_CHN         := $4015
JOY1            := $4016
JOY2_APUFC      := $4017                        ; read: bits 0-4 joy data lines (bit 0 being normal controller), bits 6-7 are FC inhibit and mode

MMC1_Control    := $9FFF
MMC1_CHR0       := $BFFF
MMC1_CHR1       := $DFFF
MMC1_PRG        := $FFF0

LFFFF := $FFFF

BUTTON_A := $80
BUTTON_B := $40
BUTTON_SELECT := $20
BUTTON_START := $10
BUTTON_UP := $08
BUTTON_DOWN := $04
BUTTON_LEFT := $02
BUTTON_RIGHT := $01
BUTTON_DPAD := BUTTON_UP | BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT

MMC1_4KCHR_32KPRG_H_MIRROR := $10

PRG_32K_BANK := $00

CHR_TITLE_MENU   = $00
CHR_TYPEB_ENDING = $01
CHR_TYPEA_ENDING = $02
CHR_GAME         = $03

RENDER_HIGH_SCORE_LETTER := $80
RENDER_STATS := $40
RENDER_SCORE := $04
RENDER_LEVEL := $02
RENDER_LINES := $01

.ifndef PAL
PAL = 0
.endif

.ifndef NWC
NWC = 0
.endif

.if PAL = 1

DAS_DELAY := $08
DAS_RESET := $0C
ENDING_SLEEP_TIME_1 := $66
ENDING_SLEEP_TIME_2 := $33
ENDING_SLEEP_TIME_3 := $1
INITIAL_AUTOREPEAT_Y := $B4
LEGAL_SLEEP_TIME := $CC
MENU_CURSOR_MASK := $01
SFX_LEVELUP_INIT := $05
SFX_LINE_COMPLETE_INIT := $04
SFX_LINECLEAR_INIT := $03
SFX_TETRIS_INIT := $04

.else

DAS_DELAY := $0A
DAS_RESET := $10
ENDING_SLEEP_TIME_1 := $80
ENDING_SLEEP_TIME_2 := $40
ENDING_SLEEP_TIME_3 := $2
INITIAL_AUTOREPEAT_Y := $A0
LEGAL_SLEEP_TIME := $FF
MENU_CURSOR_MASK := $03
SFX_LEVELUP_INIT := $06
SFX_LINE_COMPLETE_INIT := $05
SFX_LINECLEAR_INIT := $04
SFX_TETRIS_INIT := $05

.endif

; tile IDs
tile1 = $7B
tile2 = $7C
tile3 = $7D
tileEmpty = $EF ; blank tile used for empty squares
tileHidden = $FF ; blank tile used to hide minos

; Piece IDs
tPiece = $00
jPiece = $01
zPiece = $02
oPiece = $03
sPiece = $04
lPiece = $05
iPiece = $06

; Orientations
tUp    = $00
tRight = $01
tDown  = $02
tLeft  = $03
jLeft  = $04
jUp    = $05
jRight = $06
jDown  = $07
zHoriz = $08
zVert  = $09
oFixed = $0A
sHoriz = $0B
sVert  = $0C
lRight = $0D
lDown  = $0E
lLeft  = $0F
lUp    = $10
iVert  = $11
iHoriz = $12
hidden = $13
