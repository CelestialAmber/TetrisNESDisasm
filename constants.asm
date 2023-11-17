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

LFFFF := $FFFF

MMC1_4K_CHR := $10
MMC1_32K_PRG := $08
MMC1_V_MIRROR := $02

BUTTON_A := $80
BUTTON_B := $40
BUTTON_SELECT := $20
BUTTON_START := $10
BUTTON_UP := $08
BUTTON_DOWN := $04
BUTTON_LEFT := $02
BUTTON_RIGHT := $01
BUTTON_DPAD := BUTTON_UP | BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT

.enum
TITLE_MENU_TILESET
TYPEB_ENDING_TILESET
TYPEA_ENDING_TILESET
GAME_TILESET
.endenum

EMPTY_TILE := $EF

RENDER_HIGH_SCORE_LETTER := $80
RENDER_STATS := $40
RENDER_SCORE := $04
RENDER_LEVEL := $02
RENDER_LINES := $01
