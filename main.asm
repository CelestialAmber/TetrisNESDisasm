        .setcpu "6502"

.include "constants.asm"

tmp1            := $0000
tmp2            := $0001
tmp3            := $0002
tmpBulkCopyToPpuReturnAddr:= $0005
patchToPpuAddr  := $0014
rng_seed        := $0017
spawnID         := $0019
spawnCount      := $001A
verticalBlankingInterval:= $0033
unused_0E       := $0034                              ; Always $0E

.if NWC = 1

tetriminoX      := $0060
tetriminoY      := $0061
currentPiece    := $0062
levelNumber     := $0064
fallTimer       := $0065
autorepeatX     := $0066
startLevel      := $0067
playState       := $0068
vramRow         := $0069
completedRow    := $006A
autorepeatY     := $006E
holdDownPoints  := $006F
lines           := $0070
rowY            := $0072
score           := $0073
completedLines  := $0076
lineIndex       := $0077
curtainRow      := $0078
startHeight     := $0079
garbageHole     := $007A

.else

tetriminoX      := $0040                        ; Player data is $20 in size. It is copied here from $60 or $80, processed, then copied back
tetriminoY      := $0041
currentPiece    := $0042                        ; Current piece as an orientation ID
levelNumber     := $0044
fallTimer       := $0045
autorepeatX     := $0046
startLevel      := $0047
playState       := $0048
vramRow         := $0049                        ; Next playfield row to copy. Set to $20 when playfield copy is complete
completedRow    := $004A                        ; Row which has been cleared. 0 if none complete
autorepeatY     := $004E
holdDownPoints  := $004F
lines           := $0050
rowY            := $0052
score           := $0053
completedLines  := $0056
lineIndex       := $0057                        ; Iteration count of playState_checkForCompletedRows
curtainRow      := $0058
startHeight     := $0059
garbageHole     := $005A                        ; Position of hole in received garbage

.endif

player1_tetriminoX:= $0060
player1_tetriminoY:= $0061
player1_currentPiece:= $0062
player1_levelNumber:= $0064
player1_fallTimer:= $0065
player1_autorepeatX:= $0066
player1_startLevel:= $0067
player1_playState:= $0068
player1_vramRow := $0069
player1_completedRow:= $006A
player1_autorepeatY:= $006E
player1_holdDownPoints:= $006F
player1_lines   := $0070
player1_rowY    := $0072
player1_score   := $0073
player1_completedLines:= $0076
player1_lineIndex := $0077
player1_curtainRow:= $0078
player1_startHeight:= $0079
player1_garbageHole:= $007A
player2_tetriminoX:= $0080
player2_tetriminoY:= $0081
player2_currentPiece:= $0082
player2_levelNumber:= $0084
player2_fallTimer:= $0085
player2_autorepeatX:= $0086
player2_startLevel:= $0087
player2_playState:= $0088
player2_vramRow := $0089
player2_completedRow:= $008A
player2_autorepeatY:= $008E
player2_holdDownPoints:= $008F
player2_lines   := $0090
player2_rowY    := $0092
player2_score   := $0093
player2_completedLines:= $0096
player2_curtainRow:= $0098
player2_startHeight:= $0099
player2_garbageHole:= $009A
spriteXOffset   := $00A0
spriteYOffset   := $00A1
spriteIndexInOamContentLookup:= $00A2
outOfDateRenderFlags:= $00A3                    ; Bit 0-lines 1-level 2-score 6-stats 7-high score entry letter
twoPlayerPieceDelayCounter:= $00A4              ; 0 is not delaying
twoPlayerPieceDelayPlayer:= $00A5
twoPlayerPieceDelayPiece:= $00A6                       ; The future value of nextPiece, once the delay completes
gameModeState   := $00A7                        ; For values, see playState_checkForCompletedRows
generalCounter  := $00A8                        ; canon is legalScreenCounter2
generalCounter2 := $00A9
generalCounter3 := $00AA
generalCounter4 := $00AB
generalCounter5 := $00AC
selectingLevelOrHeight:= $00AD                  ; 0-level, 1-height
originalY       := $00AE
dropSpeed       := $00AF
tmpCurrentPiece := $00B0                        ; Only used as a temporary
frameCounter    := $00B1
oamStagingLength:= $00B3
newlyPressedButtons:= $00B5                     ; Active player's buttons
heldButtons     := $00B6                        ; Active player's buttons
activePlayer    := $00B7                        ; Which player is being processed (data in $40)
playfieldAddr   := $00B8                        ; HI byte is leftPlayfield in canon. Current playfield being processed: $0400 (left; 1st player) or $0500 (right; 2nd player)
allegro         := $00BA
pendingGarbage  := $00BB                        ; Garbage waiting to be delivered to the current player. This is exchanged with pendingGarbageInactivePlayer when swapping players.
pendingGarbageInactivePlayer := $00BC           ; canon is totalGarbage
renderMode      := $00BD
numberOfPlayers := $00BE
nextPiece       := $00BF                        ; Stored by its orientation ID
gameMode        := $00C0                        ; 0=legal, 1=title, 2=type menu, 3=level menu, 4=play and ending and high score, 5=demo, 6=start demo
gameType        := $00C1                        ; A=0, B=1
musicType       := $00C2                        ; 0-3; 3 is off
sleepCounter    := $00C3                        ; canon is legalScreenCounter1
ending          := $00C4
ending_customVars:= $00C5                       ; Different usages depending on Type A and B and Type B concert
ending_currentSprite:= $00CC
ending_typeBCathedralFrameDelayCounter:= $00CD
demo_heldButtons:= $00CE
demo_repeats    := $00CF
demoButtonsAddr := $00D1                        ; Current address within demoButtonsTable
demoIndex       := $00D3
highScoreEntryNameOffsetForLetter:= $00D4       ; Relative to current row
highScoreEntryRawPos:= $00D5                    ; High score position 0=1st type A, 1=2nd... 4=1st type B... 7=4th/extra type B
highScoreEntryNameOffsetForRow:= $00D6          ; Relative to start of table
highScoreEntryCurrentLetter:= $00D7
lineClearStatsByType:= $00D8                    ; bcd. one entry for each of single, double, triple, tetris
totalScore      := $00DC
displayNextPiece:= $00DF
AUDIOTMP1       := $00E0
AUDIOTMP2       := $00E1
AUDIOTMP3       := $00E2
AUDIOTMP4       := $00E3
AUDIOTMP5       := $00E4
musicChanTmpAddr:= $00E6
music_unused2   := $00EA                        ; Always 0
soundRngSeed    := $00EB                        ; Set, but not read
currentSoundEffectSlot:= $00ED                  ; Temporary
musicChannelOffset:= $00EE                      ; Temporary. Added to $4000-3 for MMIO
currentAudioSlot:= $00EF                        ; Temporary
unreferenced_buttonMirror := $00F1              ; Mirror of $F5-F8
newlyPressedButtons_player1:= $00F5             ; $80-a $40-b $20-select $10-start $08-up $04-down $02-left $01-right
newlyPressedButtons_player2:= $00F6
heldButtons_player1:= $00F7
heldButtons_player2:= $00F8
joy1Location    := $00FB                        ; normal=0; 1 or 3 for expansion
ppuScrollY      := $00FC                        ; Set to 0 many places, but not read
ppuScrollX      := $00FD                        ; Set to 0 many places, but not read
currentPpuMask  := $00FE
currentPpuCtrl  := $00FF
stack           := $0100
oamStaging      := $0200                        ; format: https://wiki.nesdev.com/w/index.php/PPU_programmer_reference#OAM
statsByType     := $03F0
playfield       := $0400
playfieldForSecondPlayer:= $0500
musicStagingSq1Lo:= $0680
musicStagingSq1Hi:= $0681
audioInitialized:= $0682
musicPauseSoundEffectLengthCounter:= $0683
musicStagingSq2Lo:= $0684
musicStagingSq2Hi:= $0685
musicStagingTriLo:= $0688
musicStagingTriHi:= $0689
resetSq12ForMusic:= $068A                       ; 0-off. 1-sq1. 2-sq1 and sq2
musicPauseSoundEffectCounter:= $068B
musicStagingNoiseLo:= $068C
musicStagingNoiseHi:= $068D
musicDataNoteTableOffset:= $0690                ; AKA start of musicData, of size $0A
musicDataDurationTableOffset:= $0691
musicDataChanPtr:= $0692
musicChanControl:= $069A                        ; high 3 bits are for LO offset behavior. Low 5 bits index into musicChanVolControlTable, minus 1. Technically size 4, but usages of the next variable 'cheat' since that variable's first index is unused
musicChanVolume := $069D                        ; Must not use first index. First and second index are unused. High nibble always used; low nibble may be used depending on control and frame
musicDataChanPtrDeref:= $06A0                   ; deref'd musicDataChanPtr+musicDataChanPtrOff
musicDataChanPtrOff:= $06A8
musicDataChanInstructionOffset:= $06AC
musicDataChanInstructionOffsetBackup:= $06B0
musicChanNoteDurationRemaining:= $06B4
musicChanNoteDuration:= $06B8
musicChanProgLoopCounter:= $06BC                ; As driven by bytecode instructions
musicStagingSq1Sweep:= $06C0                    ; Used as if size 4, but since Tri/Noise does nothing when written for sweep, the other two entries can have any value without changing behavior
musicChanNote:= $06C3
musicChanInhibit:= $06C8                        ; Always zero
musicTrack_dec  := $06CC                        ; $00-$09
musicChanVolFrameCounter:= $06CD                ; Pos 0/1 are unused
musicChanLoFrameCounter:= $06D1                 ; Pos 3 unused
soundEffectSlot0FrameCount:= $06D5              ; Number of frames
soundEffectSlot0FrameCounter:= $06DA            ; Current frame
soundEffectSlot0SecondaryCounter:= $06DF        ; nibble index into noiselo_/noisevol_table
soundEffectSlot1SecondaryCounter:= $06E0
soundEffectSlot2SecondaryCounter:= $06E1
soundEffectSlot3SecondaryCounter:= $06E2
soundEffectSlot0TertiaryCounter:= $06E3
soundEffectSlot1TertiaryCounter:= $06E4
soundEffectSlot2TertiaryCounter:= $06E5
soundEffectSlot3TertiaryCounter:= $06E6
soundEffectSlot0Tmp:= $06E7
soundEffectSlot1Tmp:= $06E8
soundEffectSlot2Tmp:= $06E9
soundEffectSlot3Tmp:= $06EA
soundEffectSlot0Init:= $06F0                    ; NOISE sound effect. 2-game over curtain. 3-ending rocket. For mapping, see soundEffectSlot0Init_table
soundEffectSlot1Init:= $06F1                    ; SQ1 sound effect. Menu, move, rotate, clear sound effects. For mapping, see soundEffectSlot1Init_table
soundEffectSlot2Init:= $06F2                    ; SQ2 sound effect. For mapping, see soundEffectSlot2Init_table
soundEffectSlot3Init:= $06F3                    ; TRI sound effect. For mapping, see soundEffectSlot3Init_table
soundEffectSlot4Init:= $06F4                    ; Unused. Assume meant for DMC sound effect. Uses some data from slot 2
musicTrack      := $06F5                        ; $FF turns off music. $00 continues selection. $01-$0A for new selection
soundEffectSlot0Playing:= $06F8                 ; Used if init is zero
soundEffectSlot1Playing:= $06F9
soundEffectSlot2Playing:= $06FA
soundEffectSlot3Playing:= $06FB
soundEffectSlot4Playing:= $06FC
currentlyPlayingMusicTrack:= $06FD              ; Copied from musicTrack
unreferenced_soundRngTmp:= $06FF
highScoreNames  := $0700
highScoreScoresA:= $0730
highScoreScoresB:= $073C
highScoreLevels := $0748
initMagic       := $0750                        ; Initialized to a hard-coded number. When resetting, if not correct number then it knows this is a cold boot

.feature force_range ; allows -1 vs <-1 (used in orientationTable)

.segment        "PRG_chunk1": absolute

; incremented to reset MMC1 reg
initRam:ldx     #$00
        jmp     initRamContinued

nmi:    pha
        txa
        pha
        tya
        pha
        lda     #$00
        sta     oamStagingLength
        jsr     render
        dec     sleepCounter
        lda     sleepCounter
        cmp     #$FF
        bne     @jumpOverIncrement
        inc     sleepCounter
@jumpOverIncrement:
        jsr     copyOamStagingToOam
        lda     frameCounter
        clc
        adc     #$01
        sta     frameCounter
        lda     #$00
        adc     frameCounter+1
        sta     frameCounter+1
.if NWC <> 1
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
.endif
        lda     #$00
        sta     ppuScrollX
        sta     PPUSCROLL
        sta     ppuScrollY
        sta     PPUSCROLL
        lda     #$01
        sta     verticalBlankingInterval
        jsr     pollControllerButtons
        pla
        tay
        pla
        tax
        pla
irq:    rti

render: lda     renderMode
        jsr     switch_s_plus_2a
        .addr   render_mode_legal_and_title_screens
        .addr   render_mode_menu_screens
        .addr   render_mode_congratulations_screen
        .addr   render_mode_play_and_demo
        .addr   render_mode_ending_animation
initRamContinued:
        ldy     #$06
        sty     tmp2
        ldy     #$00
        sty     tmp1
        lda     #$00
@zeroOutPages:
        sta     (tmp1),y
        dey
        bne     @zeroOutPages
        dec     tmp2
        bpl     @zeroOutPages
        lda     initMagic
        cmp     #$12
        bne     @initHighScoreTable
        lda     initMagic+1
        cmp     #$34
        bne     @initHighScoreTable
        lda     initMagic+2
        cmp     #$56
        bne     @initHighScoreTable
        lda     initMagic+3
        cmp     #$78
        bne     @initHighScoreTable
        lda     initMagic+4
        cmp     #$9A
        bne     @initHighScoreTable
        jmp     @continueWarmBootInit

        ldx     #$00
; Only run on cold boot
@initHighScoreTable:
        lda     defaultHighScoresTable,x
        cmp     #$FF
        beq     @continueColdBootInit
        sta     highScoreNames,x
        inx
        jmp     @initHighScoreTable

@continueColdBootInit:
        lda     #$12
        sta     initMagic
        lda     #$34
        sta     initMagic+1
        lda     #$56
        sta     initMagic+2
        lda     #$78
        sta     initMagic+3
        lda     #$9A
        sta     initMagic+4
@continueWarmBootInit:
        ldx     #$89
        stx     rng_seed
        dex
        stx     rng_seed+1
        ldy     #$00
        sty     ppuScrollX
        sty     PPUSCROLL
        ldy     #$00
        sty     ppuScrollY
        sty     PPUSCROLL
.if NWC = 1
        lda     #$80
.else
        lda     #$90
.endif
        sta     currentPpuCtrl
        sta     PPUCTRL
        lda     #$06
        sta     PPUMASK
.if NWC = 1
        sta     currentPpuMask
.endif
        jsr     LE006
        jsr     updateAudio2
        lda     #$C0
        sta     stack
        lda     #$80
        sta     stack+1
        lda     #$35
        sta     stack+3
        lda     #$AC
        sta     stack+4
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        lda     #$20
        jsr     LAA82
        lda     #$24
        jsr     LAA82
        lda     #$28
        jsr     LAA82
        lda     #$2C
        jsr     LAA82
        lda     #tileEmpty
        ldx     #>playfield
        ldy     #>playfieldForSecondPlayer
        jsr     memset_page
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$0E
        sta     unused_0E
        lda     #$00
        sta     gameModeState
        sta     gameMode
        lda     #$01
        sta     numberOfPlayers
        lda     #$00
        sta     frameCounter+1
@mainLoop:
        jsr     branchOnGameMode
        cmp     gameModeState
        bne     @checkForDemoDataExhaustion
        jsr     updateAudioWaitForNmiAndResetOamStaging
@checkForDemoDataExhaustion:
        lda     gameMode
        cmp     #$05
        bne     @continue
        lda     demoButtonsAddr+1
        cmp     #>demoTetriminoTypeTable
        bne     @continue
        lda     #>demoButtonsTable
        sta     demoButtonsAddr+1
        lda     #$00
        sta     frameCounter+1
        lda     #$01
        sta     gameMode
@continue:
        jmp     @mainLoop

gameMode_playAndEndingHighScore_jmp:
        jsr     gameMode_playAndEndingHighScore
        rts

branchOnGameMode:
        lda     gameMode
        jsr     switch_s_plus_2a
        .addr   gameMode_legalScreen
        .addr   gameMode_titleScreen
        .addr   gameMode_gameTypeMenu
        .addr   gameMode_levelMenu
        .addr   gameMode_playAndEndingHighScore_jmp
        .addr   gameMode_playAndEndingHighScore_jmp
        .addr   gameMode_startDemo
gameModeState_updatePlayer1:
        jsr     makePlayer1Active
        jsr     branchOnPlayStatePlayer1
        jsr     stageSpriteForCurrentPiece
        jsr     savePlayer1State
        jsr     stageSpriteForNextPiece
        inc     gameModeState
        rts

gameModeState_updatePlayer2:
        lda     numberOfPlayers
        cmp     #$02
        bne     @ret
        jsr     makePlayer2Active
        jsr     branchOnPlayStatePlayer2
        jsr     stageSpriteForCurrentPiece
        jsr     savePlayer2State
@ret:   inc     gameModeState
        rts

gameMode_playAndEndingHighScore:
        lda     gameModeState
        jsr     switch_s_plus_2a
        .addr   gameModeState_initGameBackground
        .addr   gameModeState_initGameState
        .addr   gameModeState_updateCountersAndNonPlayerState
        .addr   gameModeState_handleGameOver
        .addr   gameModeState_updatePlayer1
        .addr   gameModeState_updatePlayer2
        .addr   gameModeState_checkForResetKeyCombo
        .addr   gameModeState_startButtonHandling
        .addr   gameModeState_vblankThenRunState2
branchOnPlayStatePlayer1:
        lda     playState
        jsr     switch_s_plus_2a
        .addr   playState_unassignOrientationId
        .addr   playState_playerControlsActiveTetrimino
        .addr   playState_lockTetrimino
        .addr   playState_checkForCompletedRows
        .addr   playState_noop
        .addr   playState_updateLinesAndStatistics
        .addr   playState_bTypeGoalCheck
        .addr   playState_receiveGarbage
        .addr   playState_spawnNextTetrimino
        .addr   playState_noop
        .addr   playState_updateGameOverCurtain
        .addr   playState_incrementPlayState
playState_playerControlsActiveTetrimino:
        jsr     shift_tetrimino
        jsr     rotate_tetrimino
        jsr     drop_tetrimino
        rts

branchOnPlayStatePlayer2:
        lda     playState
        jsr     switch_s_plus_2a
        .addr   playState_unassignOrientationId
        .addr   playState_player2ControlsActiveTetrimino
        .addr   playState_lockTetrimino
        .addr   playState_checkForCompletedRows
        .addr   playState_noop
        .addr   playState_updateLinesAndStatistics
        .addr   playState_bTypeGoalCheck
        .addr   playState_receiveGarbage
        .addr   playState_spawnNextTetrimino
        .addr   playState_noop
        .addr   playState_updateGameOverCurtain
        .addr   playState_incrementPlayState
playState_player2ControlsActiveTetrimino:
        jsr     shift_tetrimino
        jsr     rotate_tetrimino
        jsr     drop_tetrimino
        rts

gameMode_legalScreen:
        jsr     updateAudio2
        lda     #$00
        sta     renderMode
.if NWC = 1
        lda     #$FF
.else
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank0
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   legal_screen_palette
        jsr     bulkCopyToPpu
        .addr   legal_screen_nametable
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$00
.endif
        ldx     #>oamStaging
        ldy     #>oamStaging
        jsr     memset_page
.if NWC <> 1
        lda     #LEGAL_SLEEP_TIME
        jsr     sleep_for_a_vblanks
        lda     #LEGAL_SLEEP_TIME
        sta     generalCounter
@waitForStartButton:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        beq     @continueToNextScreen
        jsr     updateAudioWaitForNmiAndResetOamStaging
        dec     generalCounter
        bne     @waitForStartButton
@continueToNextScreen:
.endif
        inc     gameMode
        rts

gameMode_titleScreen:
        jsr     updateAudio2
        lda     #$00
        sta     renderMode
        sta     $D0
        sta     displayNextPiece
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
.if NWC = 1
        lda     #$80
        sta     PPUCTRL
        sta     currentPpuCtrl
.else
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank0
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank1
.endif
        jsr     bulkCopyToPpu
        .addr   menu_palette
        jsr     bulkCopyToPpu
        .addr   title_screen_nametable
.if NWC = 1
        lda     $7005
        sta     generalCounter
@shuffleSeed:
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        dec     generalCounter
        bne     @shuffleSeed
.endif
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
.if NWC = 1
        lda     #$FF
.else
        lda     #$00
.endif
        ldx     #>oamStaging
        ldy     #>oamStaging
        jsr     memset_page
        lda     #$00
        sta     frameCounter+1
.if NWC = 1
        lda     #$80
        jsr     sleep_for_a_vblanks
.else
@waitForStartButton:
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        beq     @startButtonPressed
        lda     frameCounter+1
        cmp     #$05
        beq     @timeout
        jmp     @waitForStartButton

; Show menu screens
@startButtonPressed:
        lda     #$02
        sta     soundEffectSlot1Init
.endif
        inc     gameMode
        rts
.if NWC <> 1
; Start demo
@timeout:
        lda     #$02
        sta     soundEffectSlot1Init
        lda     #$06
        sta     gameMode
        rts
.endif

render_mode_legal_and_title_screens:
        lda     currentPpuCtrl
        and     #$FC
        sta     currentPpuCtrl
.if NWC <> 1
        lda     #$00
        sta     ppuScrollX
        sta     PPUSCROLL
        sta     ppuScrollY
        sta     PPUSCROLL
        rts

        lda     #$00
        sta     player1_levelNumber
        lda     #$00
        sta     gameType
        lda     #$04
        lda     gameMode
.endif
        rts

gameMode_gameTypeMenu:
.if NWC <> 1
        inc     initRam
        lda     #MMC1_4KCHR_32KPRG_H_MIRROR
        jsr     setMMC1Control
.endif
        lda     #$01
        sta     renderMode
.if NWC <> 1
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        jsr     bulkCopyToPpu
        .addr   menu_palette
        jsr     bulkCopyToPpu
        .addr   game_type_menu_nametable
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank0
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank1
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        ldx     musicType
        lda     musicSelectionTable,x
        jsr     setMusicTrack
L830B:  lda     #$FF
        ldx     #>oamStaging
        ldy     #>oamStaging
        jsr     memset_page
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_RIGHT
        bne     @rightNotPressed
        lda     #$01
        sta     gameType
        lda     #$01
        sta     soundEffectSlot1Init
        jmp     @leftNotPressed

@rightNotPressed:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_LEFT
        bne     @leftNotPressed
        lda     #$00
        sta     gameType
        lda     #$01
        sta     soundEffectSlot1Init
@leftNotPressed:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_DOWN
        bne     @downNotPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     musicType
        cmp     #$03
        beq     @upNotPressed
        inc     musicType
        ldx     musicType
        lda     musicSelectionTable,x
        jsr     setMusicTrack
@downNotPressed:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_UP
        bne     @upNotPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     musicType
        beq     @upNotPressed
        dec     musicType
        ldx     musicType
        lda     musicSelectionTable,x
        jsr     setMusicTrack
@upNotPressed:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        bne     @startNotPressed
        lda     #$02
        sta     soundEffectSlot1Init
.endif
        inc     gameMode
        rts

.if NWC <> 1
@startNotPressed:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_B
        bne     @bNotPressed
        lda     #$02
        sta     soundEffectSlot1Init
        lda     #$00
        sta     frameCounter+1
        dec     gameMode
        rts

@bNotPressed:
        ldy     #$00
        lda     gameType
        asl     a
        sta     generalCounter
        asl     a
        adc     generalCounter
        asl     a
        asl     a
        asl     a
        asl     a
        clc
        adc     #$3F
        sta     spriteXOffset
        lda     #$3F
        sta     spriteYOffset
        lda     #$01
        sta     spriteIndexInOamContentLookup
        lda     frameCounter
        and     #MENU_CURSOR_MASK
        bne     @flickerCursorPair1
        lda     #$02
        sta     spriteIndexInOamContentLookup
@flickerCursorPair1:
        jsr     loadSpriteIntoOamStaging
        lda     musicType
        asl     a
        asl     a
        asl     a
        asl     a
        clc
        adc     #$8F
        sta     spriteYOffset
        lda     #$53
        sta     spriteIndexInOamContentLookup
        lda     #$67
        sta     spriteXOffset
        lda     frameCounter
        and     #MENU_CURSOR_MASK
        bne     @flickerCursorPair2
        lda     #$02
        sta     spriteIndexInOamContentLookup
@flickerCursorPair2:
        jsr     loadSpriteIntoOamStaging
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jmp     L830B
.endif

gameMode_levelMenu:
.if NWC <> 1
        inc     initRam
        lda     #MMC1_4KCHR_32KPRG_H_MIRROR
        jsr     setMMC1Control
        jsr     updateAudio2
.endif
        lda     #$01
        sta     renderMode
.if NWC <> 1
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank0
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   menu_palette
        jsr     bulkCopyToPpu
        .addr   level_menu_nametable
        lda     gameType
        bne     @skipTypeBHeightDisplay
        jsr     bulkCopyToPpu
        .addr   height_menu_nametablepalette_patch
@skipTypeBHeightDisplay:
        jsr     showHighScores
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$00
        sta     PPUSCROLL
        lda     #$00
        sta     PPUSCROLL
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$00
        sta     originalY
        sta     dropSpeed
@forceStartLevelToRange:
        lda     player1_startLevel
        cmp     #$0A
        bcc     gameMode_levelMenu_processPlayer1Navigation
        sec
        sbc     #$0A
        sta     player1_startLevel
        jmp     @forceStartLevelToRange

gameMode_levelMenu_processPlayer1Navigation:
.endif
        lda     #$00
        sta     activePlayer
        lda     player1_startLevel
        sta     startLevel
        lda     player1_startHeight
        sta     startHeight
        lda     originalY
        sta     selectingLevelOrHeight
        lda     newlyPressedButtons_player1
        sta     newlyPressedButtons
.if NWC <> 1
        jsr     gameMode_levelMenu_handleLevelHeightNavigation
.endif
        lda     startLevel
        sta     player1_startLevel
        lda     startHeight
        sta     player1_startHeight
        lda     selectingLevelOrHeight
        sta     originalY
.if NWC <> 1
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        bne     @checkBPressed
        lda     heldButtons_player1
        cmp     #BUTTON_A+BUTTON_START
        bne     @startAndANotPressed
        lda     player1_startLevel
        clc
        adc     #$0A
        sta     player1_startLevel
@startAndANotPressed:
.endif
        lda     #$00
        sta     gameModeState
.if NWC <> 1
        lda     #$02
        sta     soundEffectSlot1Init
.endif
        inc     gameMode
        rts

.if NWC <> 1
@checkBPressed:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_B
        bne     @chooseRandomHole_player1
        lda     #$02
        sta     soundEffectSlot1Init
        dec     gameMode
        rts

@chooseRandomHole_player1:
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        lda     rng_seed
        and     #$0F
        cmp     #$0A
        bpl     @chooseRandomHole_player1
        sta     player1_garbageHole
@chooseRandomHole_player2:
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        lda     rng_seed
        and     #$0F
        cmp     #$0A
        bpl     @chooseRandomHole_player2
        sta     player2_garbageHole
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jmp     gameMode_levelMenu_processPlayer1Navigation

; Starts by checking if right pressed
gameMode_levelMenu_handleLevelHeightNavigation:
        lda     newlyPressedButtons
        cmp     #BUTTON_RIGHT
        bne     @checkLeftPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     selectingLevelOrHeight
        bne     @rightPressedForHeightSelection
        lda     startLevel
        cmp     #$09
        beq     @checkLeftPressed
        inc     startLevel
        jmp     @checkLeftPressed

@rightPressedForHeightSelection:
        lda     startHeight
        cmp     #$05
        beq     @checkLeftPressed
        inc     startHeight
@checkLeftPressed:
        lda     newlyPressedButtons
        cmp     #BUTTON_LEFT
        bne     @checkDownPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     selectingLevelOrHeight
        bne     @leftPressedForHeightSelection
        lda     startLevel
        beq     @checkDownPressed
        dec     startLevel
        jmp     @checkDownPressed

@leftPressedForHeightSelection:
        lda     startHeight
        beq     @checkDownPressed
        dec     startHeight
@checkDownPressed:
        lda     newlyPressedButtons
        cmp     #BUTTON_DOWN
        bne     @checkUpPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     selectingLevelOrHeight
        bne     @downPressedForHeightSelection
        lda     startLevel
        cmp     #$05
        bpl     @checkUpPressed
        clc
        adc     #$05
        sta     startLevel
        jmp     @checkUpPressed

@downPressedForHeightSelection:
        lda     startHeight
        cmp     #$03
        bpl     @checkUpPressed
        inc     startHeight
        inc     startHeight
        inc     startHeight
@checkUpPressed:
        lda     newlyPressedButtons
        cmp     #BUTTON_UP
        bne     @checkAPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     selectingLevelOrHeight
        bne     @upPressedForHeightSelection
        lda     startLevel
        cmp     #$05
        bmi     @checkAPressed
        sec
        sbc     #$05
        sta     startLevel
        jmp     @checkAPressed

@upPressedForHeightSelection:
        lda     startHeight
        cmp     #$03
        bmi     @checkAPressed
        dec     startHeight
        dec     startHeight
        dec     startHeight
@checkAPressed:
        lda     gameType
        beq     @showSelection
        lda     newlyPressedButtons
        cmp     #BUTTON_A
        bne     @showSelection
        lda     #$01
        sta     soundEffectSlot1Init
        lda     selectingLevelOrHeight
        eor     #$01
        sta     selectingLevelOrHeight
@showSelection:
        lda     selectingLevelOrHeight
        bne     @showSelectionLevel
        lda     frameCounter
        and     #MENU_CURSOR_MASK
        beq     @skipShowingSelectionLevel
@showSelectionLevel:
        ldx     startLevel
        lda     levelToSpriteYOffset,x
        sta     spriteYOffset
        lda     #$00
        sta     spriteIndexInOamContentLookup
        ldx     startLevel
        lda     levelToSpriteXOffset,x
        sta     spriteXOffset
        lda     activePlayer
        cmp     #$01
        bne     @stageLevelSelectCursor
        clc
        lda     spriteYOffset
        adc     #$50
        sta     spriteYOffset
@stageLevelSelectCursor:
        jsr     loadSpriteIntoOamStaging
@skipShowingSelectionLevel:
        lda     gameType
        beq     @ret
        lda     selectingLevelOrHeight
        beq     @showSelectionHeight
        lda     frameCounter
        and     #MENU_CURSOR_MASK
        beq     @ret
@showSelectionHeight:
        ldx     startHeight
        lda     heightToPpuHighAddr,x
        sta     spriteYOffset
        lda     #$00
        sta     spriteIndexInOamContentLookup
        ldx     startHeight
        lda     heightToPpuLowAddr,x
        sta     spriteXOffset
        lda     activePlayer
        cmp     #$01
        bne     @stageHeightSelectCursor
        clc
        lda     spriteYOffset
        adc     #$50
        sta     spriteYOffset
@stageHeightSelectCursor:
        jsr     loadSpriteIntoOamStaging
@ret:   rts
.endif

levelToSpriteYOffset:
        .byte   $53,$53,$53,$53,$53,$63,$63,$63
        .byte   $63,$63
levelToSpriteXOffset:
        .byte   $34,$44,$54,$64,$74,$34,$44,$54
        .byte   $64,$74
heightToPpuHighAddr:
        .byte   $53,$53,$53,$63,$63,$63
heightToPpuLowAddr:
        .byte   $9C,$AC,$BC,$9C,$AC,$BC
musicSelectionTable:
        .byte   $03,$04,$05,$FF,$06,$07,$08,$FF
render_mode_menu_screens:
        lda     currentPpuCtrl
        and     #$FC
        sta     currentPpuCtrl
.if NWC <> 1
        sta     PPUCTRL
        lda     #$00
        sta     ppuScrollX
        sta     PPUSCROLL
        sta     ppuScrollY
        sta     PPUSCROLL
.endif
        rts

gameModeState_initGameBackground:
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
.if NWC = 1
        lda     #$98
        sta     PPUCTRL
        sta     currentPpuCtrl
.endif
        lda     #CHR_GAME
        jsr     changeCHRBank0
        lda     #CHR_GAME
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   game_palette
        jsr     bulkCopyToPpu
        .addr   game_nametable
        lda     #$20
        sta     PPUADDR
        lda     #$83
        sta     PPUADDR
        lda     gameType
        bne     @typeB
        lda     #$0A
        sta     PPUDATA
        lda     #$20
        sta     PPUADDR
        lda     #$B8
        sta     PPUADDR
        lda     highScoreScoresA
        jsr     twoDigsToPPU
        lda     highScoreScoresA+1
        jsr     twoDigsToPPU
        lda     highScoreScoresA+2
        jsr     twoDigsToPPU
        jmp     gameModeState_initGameBackground_finish

@typeB: lda     #$0B
        sta     PPUDATA
        lda     #$20
        sta     PPUADDR
        lda     #$B8
        sta     PPUADDR
        lda     highScoreScoresB
        jsr     twoDigsToPPU
        lda     highScoreScoresB+1
        jsr     twoDigsToPPU
        lda     highScoreScoresB+2
        jsr     twoDigsToPPU
        ldx     #$00
@nextPpuAddress:
        lda     game_typeb_nametable_patch,x
        inx
        sta     PPUADDR
        lda     game_typeb_nametable_patch,x
        inx
        sta     PPUADDR
@nextPpuData:
        lda     game_typeb_nametable_patch,x
        inx
        cmp     #$FE
        beq     @nextPpuAddress
        cmp     #$FD
        beq     @endOfPpuPatching
        sta     PPUDATA
        jmp     @nextPpuData

@endOfPpuPatching:
        lda     #$23
        sta     PPUADDR
        lda     #$3B
        sta     PPUADDR
        lda     startHeight
        and     #$0F
        sta     PPUDATA
        jmp     gameModeState_initGameBackground_finish

gameModeState_initGameBackground_finish:
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$01
        sta     player1_playState
        sta     player2_playState
        lda     player1_startLevel
        sta     player1_levelNumber
        lda     player2_startLevel
        sta     player2_levelNumber
        inc     gameModeState
        rts

game_typeb_nametable_patch:
        .byte   $22,$F7,$38,$39,$39,$39,$39,$39
        .byte   $39,$3A,$FE,$23,$17,$3B,$11,$0E
        .byte   $12,$10,$11,$1D,$3C,$FE,$23,$37
        .byte   $3B,$FF,$FF,$FF,$FF,$FF,$FF,$3C
        .byte   $FE,$23,$57,$3D,$3E,$3E,$3E,$3E
        .byte   $3E,$3E,$3F,$FD
gameModeState_initGameState:
        lda     #tileEmpty
        ldx     #>playfield
        ldy     #>playfield
        jsr     memset_page
        ldx     #$0F
        lda     #$00
; statsByType
@initStatsByType:
        sta     statsByType-1,x
        dex
        bne     @initStatsByType
        lda     #$05
        sta     player1_tetriminoX
        sta     player2_tetriminoX
        lda     #$00
        sta     player1_tetriminoY
        sta     player2_tetriminoY
        sta     player1_vramRow
        sta     player2_vramRow
        sta     player1_fallTimer
        sta     player2_fallTimer
        sta     pendingGarbage
        sta     pendingGarbageInactivePlayer
        sta     player1_score
        sta     player1_score+1
        sta     player1_score+2
        sta     player2_score
        sta     player2_score+1
        sta     player2_score+2
        sta     player1_lines
        sta     player1_lines+1
        sta     player2_lines
        sta     player2_lines+1
        sta     twoPlayerPieceDelayCounter
        sta     lineClearStatsByType
        sta     lineClearStatsByType+1
        sta     lineClearStatsByType+2
        sta     lineClearStatsByType+3
        sta     allegro
        sta     demo_heldButtons
        sta     demo_repeats
        sta     demoIndex
        sta     demoButtonsAddr
        sta     spawnID
        lda     #>demoButtonsTable
        sta     demoButtonsAddr+1
        lda     #$03
        sta     renderMode
        lda     #INITIAL_AUTOREPEAT_Y
        sta     player1_autorepeatY
        sta     player2_autorepeatY
        jsr     chooseNextTetrimino
        sta     player1_currentPiece
        sta     player2_currentPiece
        jsr     incrementPieceStat
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        jsr     chooseNextTetrimino
        sta     nextPiece
        sta     twoPlayerPieceDelayPiece
        lda     gameType
        beq     @skipTypeBInit
        lda     #$25
        sta     player1_lines
        sta     player2_lines
@skipTypeBInit:
        lda     #RENDER_STATS+RENDER_SCORE+RENDER_LEVEL+RENDER_LINES
        sta     outOfDateRenderFlags
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     initPlayfieldIfTypeB
        ldx     musicType
        lda     musicSelectionTable,x
        jsr     setMusicTrack
        inc     gameModeState
        rts

; Copies $60 to $40
makePlayer1Active:
        lda     #$01
        sta     activePlayer
        lda     #>playfield
        sta     playfieldAddr+1
        lda     newlyPressedButtons_player1
        sta     newlyPressedButtons
        lda     heldButtons_player1
        sta     heldButtons
        ldx     #$1F
@copyByteFromMirror:
        lda     player1_tetriminoX,x
        sta     tetriminoX,x
        dex
        cpx     #$FF
        bne     @copyByteFromMirror
        rts

; Copies $80 to $40
makePlayer2Active:
        lda     #$02
        sta     activePlayer
        lda     #>playfieldForSecondPlayer
        sta     playfieldAddr+1
        lda     newlyPressedButtons_player2
        sta     newlyPressedButtons
        lda     heldButtons_player2
        sta     heldButtons
        ldx     #$1F
@whileXNotNeg1:
        lda     player2_tetriminoX,x
        sta     tetriminoX,x
        dex
        cpx     #$FF
        bne     @whileXNotNeg1
        rts

; Copies $40 to $60
savePlayer1State:
        ldx     #$1F
@copyByteToMirror:
        lda     tetriminoX,x
        sta     player1_tetriminoX,x
        dex
        cpx     #$FF
        bne     @copyByteToMirror
        lda     numberOfPlayers
        cmp     #$01
        beq     @ret
        ldx     pendingGarbage
        lda     pendingGarbageInactivePlayer
        sta     pendingGarbage
        stx     pendingGarbageInactivePlayer
@ret:   rts

; Copies $40 to $80
savePlayer2State:
        ldx     #$1F
@whileXNotNeg1:
        lda     tetriminoX,x
        sta     player2_tetriminoX,x
        dex
        cpx     #$FF
        bne     @whileXNotNeg1
        ldx     pendingGarbage
        lda     pendingGarbageInactivePlayer
        sta     pendingGarbage
        stx     pendingGarbageInactivePlayer
        rts

initPlayfieldIfTypeB:
        lda     gameType
        bne     initPlayfieldForTypeB
        jmp     endTypeBInit

initPlayfieldForTypeB:
        lda     #$0C
        sta     generalCounter  ; decrements

typeBRows:
        lda     generalCounter
        beq     initCopyPlayfieldToPlayer2
        lda     #$14
        sec
        sbc     generalCounter
        sta     generalCounter2  ; row (20 - generalCounter)
        lda     #$00
        sta     player1_vramRow
        sta     player2_vramRow
        lda     #$09
        sta     generalCounter3 ; column

typeBGarbageInRow:
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        lda     rng_seed
        and     #$07
        tay
        lda     rngTable,y
        sta     generalCounter4 ; random square or blank
        ldx     generalCounter2
        lda     multBy10Table,x
        clc
        adc     generalCounter3
        tay
        lda     generalCounter4
        sta     playfield,y
        lda     generalCounter3
        beq     typeBGuaranteeBlank
        dec     generalCounter3
        jmp     typeBGarbageInRow

typeBGuaranteeBlank:
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        lda     rng_seed
        and     #$0F
        cmp     #$0A
        bpl     typeBGuaranteeBlank

        sta     generalCounter5 ; blanked column
        ldx     generalCounter2
        lda     multBy10Table,x
        clc
        adc     generalCounter5
        tay
        lda     #tileEmpty
        sta     playfield,y
        jsr     updateAudioWaitForNmiAndResetOamStaging
        dec     generalCounter
        bne     typeBRows

initCopyPlayfieldToPlayer2:
        ldx     #$C8
copyPlayfieldToPlayer2:
        lda     playfield,x
        sta     playfieldForSecondPlayer,x
        dex
        bne     copyPlayfieldToPlayer2

; Player1 Blank Lines
        ldx     player1_startHeight
        lda     typeBBlankInitCountByHeightTable,x
        tay
        lda     #tileEmpty

typeBBlankInitPlayer1:
        sta     playfield,y
        dey
        cpy     #$FF
        bne     typeBBlankInitPlayer1

; Player2 Blank Lines
        ldx     player2_startHeight
        lda     typeBBlankInitCountByHeightTable,x
        tay
        lda     #tileEmpty
typeBBlankInitPlayer2:
        sta     playfieldForSecondPlayer,y
        dey
        cpy     #$FF
        bne     typeBBlankInitPlayer2
endTypeBInit:
        rts

typeBBlankInitCountByHeightTable:
        .byte   $C8,$AA,$96,$78,$64,$50
rngTable:
        .byte   tileEmpty,tile1,tileEmpty,tile2
        .byte   tile3,tile3,tileEmpty,tileEmpty
gameModeState_updateCountersAndNonPlayerState:
        lda     #CHR_GAME
        jsr     changeCHRBank0
        lda     #CHR_GAME
        jsr     changeCHRBank1
        lda     #$00
        sta     oamStagingLength
        inc     player1_fallTimer
        inc     player2_fallTimer
        lda     twoPlayerPieceDelayCounter
        beq     @checkSelectButtonPressed
        inc     twoPlayerPieceDelayCounter
@checkSelectButtonPressed:
        lda     newlyPressedButtons_player1
        and     #BUTTON_SELECT
        beq     @ret
        lda     displayNextPiece
.if NWC <> 1
        eor     #$01
        sta     displayNextPiece
.endif
@ret:   inc     gameModeState
        rts

rotate_tetrimino:
        lda     currentPiece
        sta     originalY
        clc
        lda     currentPiece
        asl     a
        tax
        lda     newlyPressedButtons
        and     #BUTTON_A
        cmp     #BUTTON_A
        bne     @aNotPressed
        inx
        lda     rotationTable,x
        sta     currentPiece
        jsr     isPositionValid
        bne     @restoreOrientationID
        lda     #$05
        sta     soundEffectSlot1Init
        jmp     @ret

@aNotPressed:
        lda     newlyPressedButtons
        and     #BUTTON_B
        cmp     #BUTTON_B
        bne     @ret
        lda     rotationTable,x
        sta     currentPiece
        jsr     isPositionValid
        bne     @restoreOrientationID
        lda     #$05
        sta     soundEffectSlot1Init
        jmp     @ret

@restoreOrientationID:
        lda     originalY
        sta     currentPiece
@ret:   rts

rotationTable:
        .byte   tLeft, tRight  ; from tUp
        .byte   tUp, tDown     ; from tRight
        .byte   tRight, tLeft  ; from tDown
        .byte   tDown, tUp     ; from tLeft

        .byte   jDown, jUp     ; from jLeft
        .byte   jLeft, jRight  ; from jUp
        .byte   jUp, jDown     ; from jRight
        .byte   jRight, jLeft  ; from jDown

        .byte   zVert, zVert   ; from zHoriz
        .byte   zHoriz, zHoriz ; from zVert

        .byte   oFixed, oFixed ; from oFixed

        .byte   sVert, sVert   ; from sHoriz
        .byte   sHoriz, sHoriz ; from sVert

        .byte   lUp, lDown     ; from lRight
        .byte   lRight, lLeft  ; from lDown
        .byte   lDown, lUp     ; from lLeft
        .byte   lLeft, lRight  ; from lUp

        .byte   iHoriz, iHoriz ; from iVert
        .byte   iVert, iVert   ; from iHoriz

drop_tetrimino:
        lda     autorepeatY
        bpl     @notBeginningOfGame
        lda     newlyPressedButtons
        and     #BUTTON_DOWN
        beq     @incrementAutorepeatY
        lda     #$00
        sta     autorepeatY
@notBeginningOfGame:
        bne     @autorepeating
@playing:
        lda     heldButtons
        and     #BUTTON_LEFT+BUTTON_RIGHT
        bne     @lookupDropSpeed
        lda     newlyPressedButtons
        and     #BUTTON_DPAD
        cmp     #BUTTON_DOWN
        bne     @lookupDropSpeed
        lda     #$01
        sta     autorepeatY
        jmp     @lookupDropSpeed

@autorepeating:
        lda     heldButtons
        and     #BUTTON_DPAD
        cmp     #BUTTON_DOWN
        beq     @downPressed
        lda     #$00
        sta     autorepeatY
        sta     holdDownPoints
        jmp     @lookupDropSpeed

@downPressed:
        inc     autorepeatY
        lda     autorepeatY
        cmp     #$03
        bcc     @lookupDropSpeed
        lda     #$01
        sta     autorepeatY
        inc     holdDownPoints
@drop:  lda     #$00
        sta     fallTimer
        lda     tetriminoY
        sta     originalY
        inc     tetriminoY
        jsr     isPositionValid
        beq     @ret
        lda     originalY
        sta     tetriminoY
        lda     #$02
        sta     playState
        jsr     updatePlayfield
@ret:   rts

@lookupDropSpeed:
        lda     #$01
        ldx     levelNumber
        cpx     #$1D
        bcs     @noTableLookup
        lda     framesPerDropTable,x
@noTableLookup:
        sta     dropSpeed
        lda     fallTimer
        cmp     dropSpeed
        bpl     @drop
        jmp     @ret

@incrementAutorepeatY:
        inc     autorepeatY
        jmp     @ret

framesPerDropTable:
.if PAL = 1
    .byte   $24,$20,$1D,$19,$16,$12,$0F,$0B
    .byte   $07,$05,$04,$04,$04,$03,$03,$03
    .byte   $02,$02,$02,$01,$01,$01,$01,$01
    .byte   $01,$01,$01,$01,$01,$01
.else
    .byte   $30,$2B,$26,$21,$1C,$17,$12,$0D
    .byte   $08,$06,$05,$05,$05,$04,$04,$04
    .byte   $03,$03,$03,$02,$02,$02,$02,$02
    .byte   $02,$02,$02,$02,$02,$01
.endif

unreferenced_framesPerDropTable:
        .byte   $01,$01
shift_tetrimino:
        lda     tetriminoX
        sta     originalY
        lda     heldButtons
        and     #BUTTON_DOWN
        bne     @ret
        lda     newlyPressedButtons
        and     #BUTTON_LEFT+BUTTON_RIGHT
        bne     @resetAutorepeatX
        lda     heldButtons
        and     #BUTTON_LEFT+BUTTON_RIGHT
        beq     @ret
        inc     autorepeatX
        lda     autorepeatX
        cmp     #DAS_RESET
        bmi     @ret
        lda     #DAS_DELAY
        sta     autorepeatX
        jmp     @buttonHeldDown

@resetAutorepeatX:
        lda     #$00
        sta     autorepeatX
@buttonHeldDown:
        lda     heldButtons
        and     #BUTTON_RIGHT
        beq     @notPressingRight
        inc     tetriminoX
        jsr     isPositionValid
        bne     @restoreX
        lda     #$03
        sta     soundEffectSlot1Init
        jmp     @ret

@notPressingRight:
        lda     heldButtons
        and     #BUTTON_LEFT
        beq     @ret
        dec     tetriminoX
        jsr     isPositionValid
        bne     @restoreX
        lda     #$03
        sta     soundEffectSlot1Init
        jmp     @ret

@restoreX:
        lda     originalY
        sta     tetriminoX
        lda     #DAS_RESET
        sta     autorepeatX
@ret:   rts

stageSpriteForCurrentPiece:
        lda     tetriminoX
        asl     a
        asl     a
        asl     a
        adc     #$60
        sta     generalCounter3 ; x position of center block
        lda     numberOfPlayers
        cmp     #$01
        beq     @calculateYPixel
        lda     generalCounter3
        sec
        sbc     #$40
        sta     generalCounter3 ; if 2 player mode, player 1's field is more to the left
        lda     activePlayer
        cmp     #$01
        beq     @calculateYPixel
        lda     generalCounter3
        adc     #$6F
        sta     generalCounter3 ; and player 2's field is more to the right
@calculateYPixel:
        clc
        lda     tetriminoY
        rol     a
        rol     a
        rol     a
        adc     #$2F
        sta     generalCounter4 ; y position of center block
        lda     currentPiece
        sta     generalCounter5
        clc
        lda     generalCounter5
        rol     a
        rol     a
        sta     generalCounter
        rol     a
        adc     generalCounter
        tax ; x contains index into orientation table
        ldy     oamStagingLength
        lda     #$04
        sta     generalCounter2 ; iterate through all four minos
@stageMino:
        lda     orientationTable,x
        asl     a
        asl     a
        asl     a
        clc
        adc     generalCounter4
        sta     oamStaging,y ; stage y coordinate of mino
        sta     originalY
        inc     oamStagingLength
        iny
        inx
        lda     orientationTable,x
        sta     oamStaging,y ; stage block type of mino
        inc     oamStagingLength
        iny
        inx
        lda     #$02
        sta     oamStaging,y ; stage palette/front priority
        lda     originalY
        cmp     #$2F ; compares with smallest allowed y position on the screen, not the field
        bcs     @validYCoordinate
        inc     oamStagingLength
        dey
        lda     #$FF
        sta     oamStaging,y ; make tile invisible
        iny
        iny
        lda     #$00
        sta     oamStaging,y ; make x coordinate 0 for some reason
        jmp     @finishLoop

@validYCoordinate:
        inc     oamStagingLength
        iny
        lda     orientationTable,x
        asl     a
        asl     a
        asl     a
        clc
        adc     generalCounter3
        sta     oamStaging,y ; stage actual x coordinate
@finishLoop:
        inc     oamStagingLength
        iny
        inx
        dec     generalCounter2
        bne     @stageMino
        rts

orientationTable:
        ; y offset, tile ID, x offset per mino per orientation
        .byte    0, tile1,-1, 0, tile1, 0, 0, tile1, 1,-1, tile1, 0 ; $00 t up
        .byte   -1, tile1, 0, 0, tile1, 0, 0, tile1, 1, 1, tile1, 0 ; $01 t right
        .byte    0, tile1,-1, 0, tile1, 0, 0, tile1, 1, 1, tile1, 0 ; $02 t down (spawn)
        .byte   -1, tile1, 0, 0, tile1,-1, 0, tile1, 0, 1, tile1, 0 ; $03 t left

        .byte   -1, tile3, 0, 0, tile3, 0, 1, tile3,-1, 1, tile3, 0 ; $04 j left
        .byte   -1, tile3,-1, 0, tile3,-1, 0, tile3, 0, 0, tile3, 1 ; $05 j up
        .byte   -1, tile3, 0,-1, tile3, 1, 0, tile3, 0, 1, tile3, 0 ; $06 j right
        .byte    0, tile3,-1, 0, tile3, 0, 0, tile3, 1, 1, tile3, 1 ; $07 j down (spawn)

        .byte    0, tile2,-1, 0, tile2, 0, 1, tile2, 0, 1, tile2, 1 ; $08 z horizontal (spawn)
        .byte   -1, tile2, 1, 0, tile2, 0, 0, tile2, 1, 1, tile2, 0 ; $09 z vertical

        .byte    0, tile1,-1, 0, tile1, 0, 1, tile1,-1, 1, tile1, 0 ; $0A o (spawn)

        .byte    0, tile3, 0, 0, tile3, 1, 1, tile3,-1, 1, tile3, 0 ; $0B s horizontal (spawn)
        .byte   -1, tile3, 0, 0, tile3, 0, 0, tile3, 1, 1, tile3, 1 ; $0C s vertical

        .byte   -1, tile2, 0, 0, tile2, 0, 1, tile2, 0, 1, tile2, 1 ; $0D l right
        .byte    0, tile2,-1, 0, tile2, 0, 0, tile2, 1, 1, tile2,-1 ; $0E l down (spawn)
        .byte   -1, tile2,-1,-1, tile2, 0, 0, tile2, 0, 1, tile2, 0 ; $0F l left
        .byte   -1, tile2, 1, 0, tile2,-1, 0, tile2, 0, 0, tile2, 1 ; $10 l up

        .byte   -2, tile1, 0,-1, tile1, 0, 0, tile1, 0, 1, tile1, 0 ; $11 i vertical
        .byte    0, tile1,-2, 0, tile1,-1, 0, tile1, 0, 0, tile1, 1 ; $12 i horizontal (spawn)

        ; Hidden orientation used during line clear animation and game over curtain
        .byte    0, tileHidden, 0, 0, tileHidden, 0, 0, tileHidden, 0, 0, tileHidden, 0 ; $13

; unused sprite staging routine
        lda     spriteIndexInOamContentLookup
        asl     a
        asl     a
        sta     generalCounter
        asl     a
        clc
        adc     generalCounter
        tay
        ldx     oamStagingLength
        lda     #$04
        sta     generalCounter2
L8B9D:  lda     orientationTable,y
        clc
        asl     a
        asl     a
        asl     a
        adc     spriteYOffset
        sta     oamStaging,x
        inx
        iny
        lda     orientationTable,y
        sta     oamStaging,x
        inx
        iny
        lda     #$02
        sta     oamStaging,x
        inx
        lda     orientationTable,y
        clc
        asl     a
        asl     a
        asl     a
        adc     spriteXOffset
        sta     oamStaging,x
        inx
        iny
        dec     generalCounter2
        bne     L8B9D
        stx     oamStagingLength
        rts

stageSpriteForNextPiece:
        lda     displayNextPiece
        bne     @ret
        lda     #$C8
        sta     spriteXOffset
        lda     #$77
        sta     spriteYOffset
        ldx     nextPiece
        lda     orientationToSpriteTable,x
        sta     spriteIndexInOamContentLookup
        jmp     loadSpriteIntoOamStaging

@ret:   rts

; Only cares about orientations selected by spawnTable
orientationToSpriteTable:
        .byte   $00,$00,$06,$00,$00,$00,$00,$09
        .byte   $08,$00,$0B,$07,$00,$00,$0A,$00
        .byte   $00,$00,$0C
; Same as orientationToSpriteTable except sprites have different offsets
unreferenced_orientationToSpriteTable:
        .byte   $00,$00,$0F,$00,$00,$00,$00,$12
        .byte   $11,$00,$14,$10,$00,$00,$13,$00
        .byte   $00,$00,$15
unreferenced_data2:
        .byte   $00,$FF,$FE,$FD,$FC,$FD,$FE,$FF
        .byte   $00,$01,$02,$03,$04,$05,$06,$07
        .byte   $08,$09,$0A,$0B,$0C,$0D,$0E,$0F
        .byte   $10,$11,$12,$13
loadSpriteIntoOamStaging:
        clc
        lda     spriteIndexInOamContentLookup
        rol     a
        tax
        lda     oamContentLookup,x
        sta     generalCounter
        inx
        lda     oamContentLookup,x
        sta     generalCounter2
        ldx     oamStagingLength
        ldy     #$00
@whileNotFF:
        lda     (generalCounter),y
        cmp     #$FF
        beq     @ret
        clc
        adc     spriteYOffset
        sta     oamStaging,x
        inx
        iny
        lda     (generalCounter),y
        sta     oamStaging,x
        inx
        iny
        lda     (generalCounter),y
        sta     oamStaging,x
        inx
        iny
        lda     (generalCounter),y
        clc
        adc     spriteXOffset
        sta     oamStaging,x
        inx
        iny
        lda     #$04
        clc
        adc     oamStagingLength
        sta     oamStagingLength
        jmp     @whileNotFF

@ret:   rts

oamContentLookup:
        .addr   sprite00LevelSelectCursor
        .addr   sprite01GameTypeCursor
        .addr   sprite02Blank
        .addr   sprite03PausePalette6
        .addr   sprite05PausePalette4
        .addr   sprite05PausePalette4
        .addr   sprite06TPiece
        .addr   sprite07SPiece
        .addr   sprite08ZPiece
        .addr   sprite09JPiece
        .addr   sprite0ALPiece
        .addr   sprite0BOPiece
        .addr   sprite0CIPiece
        .addr   sprite0EHighScoreNameCursor
        .addr   sprite0EHighScoreNameCursor
        .addr   sprite0FTPieceOffset
        .addr   sprite10SPieceOffset
        .addr   sprite11ZPieceOffset
        .addr   sprite12JPieceOffset
        .addr   sprite13LPieceOffset
        .addr   sprite14OPieceOffset
        .addr   sprite15IPieceOffset
        .addr   sprite16KidIcarus1
        .addr   sprite17KidIcarus2
        .addr   sprite18Link1
        .addr   sprite19Link2
        .addr   sprite1ASamus1
        .addr   sprite1BSamus2
        .addr   sprite1CDonkeyKong_armsClosed
        .addr   sprite1DDonkeyKong1
        .addr   sprite1EDonkeyKong2
        .addr   sprite1FBowser1
        .addr   sprite20Bowser2
        .addr   sprite21PrincessPeach1
        .addr   sprite22PrincessPeach2
        .addr   sprite23CathedralRocketJet1
        .addr   sprite24CathedralRocketJet2
        .addr   sprite25CloudLarge
        .addr   sprite26CloudSmall
        .addr   sprite27Mario1
        .addr   sprite28Mario2
        .addr   sprite29Luigi1
        .addr   sprite2ALuigi2
        .addr   sprite2CDragonfly1
        .addr   sprite2CDragonfly1
        .addr   sprite2DDragonfly2
        .addr   sprite2EDove1
        .addr   sprite2FDove2
        .addr   sprite30Airplane1
        .addr   sprite31Airplane2
        .addr   sprite32Ufo1
        .addr   sprite33Ufo2
        .addr   sprite34Pterosaur1
        .addr   sprite35Pterosaur2
        .addr   sprite36Blimp1
        .addr   sprite37Blimp2
        .addr   sprite38Dragon1
        .addr   sprite39Dragon2
        .addr   sprite3ABuran1
        .addr   sprite3BBuran2
        .addr   sprite3CHelicopter1
        .addr   sprite3DHelicopter2
        .addr   sprite3ESmallRocket
        .addr   sprite3FSmallRocketJet1
        .addr   sprite40SmallRocketJet2
        .addr   sprite41MediumRocket
        .addr   sprite42MediumRocketJet1
        .addr   sprite43MediumRocketJet2
        .addr   sprite44LargeRocket
        .addr   sprite45LargeRocketJet1
        .addr   sprite46LargeRocketJet2
        .addr   sprite47BuranRocket
        .addr   sprite48BuranRocketJet1
        .addr   sprite49BuranRocketJet2
        .addr   sprite4ACathedralRocket
        .addr   sprite4BOstrich1
        .addr   sprite4COstrich2
        .addr   sprite4DCathedralEasternDome
        .addr   sprite4ECathedralNorthernDome
        .addr   sprite4FCathedralCentralDome
        .addr   sprite50CathedralWesternDome
        .addr   sprite51CathedralDomeRocketJet1
        .addr   sprite52CathedralDomeRocketJet2
        .addr   sprite53MusicTypeCursor
        .addr   sprite54Penguin1
        .addr   sprite55Penguin2
        .addr   isPositionValid
        .addr   isPositionValid
        .addr   isPositionValid
        .addr   isPositionValid
; Sprites are sets of 4 bytes in the OAM format, terminated by FF. byte0=y, byte1=tile, byte2=attrs, byte3=x
sprite00LevelSelectCursor:
        .byte   $00,$FC,$20,$00,$00,$FC,$20,$08
        .byte   $08,$FC,$20,$00,$08,$FC,$20,$08
        .byte   $FF
sprite01GameTypeCursor:
        .byte   $00,$27,$00,$00,$00,$27,$40,$3A
        .byte   $FF
; Used as a sort of NOOP for cursors
sprite02Blank:
        .byte   $00,$FF,$00,$00,$FF
sprite03PausePalette6:
        .byte   $00,$19,$02,$00,$00,$0A,$02,$08
        .byte   $00,$1E,$02,$10,$00,$1C,$02,$18
        .byte   $00,$0E,$02,$20,$FF
sprite05PausePalette4:
        .byte   $00,$19,$00,$00,$00,$0A,$00,$08
        .byte   $00,$1E,$00,$10,$00,$1C,$00,$18
        .byte   $00,$0E,$00,$20,$FF
sprite06TPiece:
        .byte   $00,$7B,$02,$FC,$00,$7B,$02,$04
        .byte   $00,$7B,$02,$0C,$08,$7B,$02,$04
        .byte   $FF
sprite07SPiece:
        .byte   $00,$7D,$02,$04,$00,$7D,$02,$0C
        .byte   $08,$7D,$02,$FC,$08,$7D,$02,$04
        .byte   $FF
sprite08ZPiece:
        .byte   $00,$7C,$02,$FC,$00,$7C,$02,$04
        .byte   $08,$7C,$02,$04,$08,$7C,$02,$0C
        .byte   $FF
sprite09JPiece:
        .byte   $00,$7D,$02,$FC,$00,$7D,$02,$04
        .byte   $00,$7D,$02,$0C,$08,$7D,$02,$0C
        .byte   $FF
sprite0ALPiece:
        .byte   $00,$7C,$02,$FC,$00,$7C,$02,$04
        .byte   $00,$7C,$02,$0C,$08,$7C,$02,$FC
        .byte   $FF
sprite0BOPiece:
        .byte   $00,$7B,$02,$00,$00,$7B,$02,$08
        .byte   $08,$7B,$02,$00,$08,$7B,$02,$08
        .byte   $FF
sprite0CIPiece:
        .byte   $04,$7B,$02,$F8,$04,$7B,$02,$00
        .byte   $04,$7B,$02,$08,$04,$7B,$02,$10
        .byte   $FF
sprite0EHighScoreNameCursor:
        .byte   $00,$FC,$21,$00,$FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite0FTPieceOffset:
        .byte   $02,$7B,$02,$FC,$02,$7B,$02,$04
        .byte   $02,$7B,$02,$0C,$0A,$7B,$02,$04
        .byte   $FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite10SPieceOffset:
        .byte   $00,$7D,$02,$06,$00,$7D,$02,$0E
        .byte   $08,$7D,$02,$FE,$08,$7D,$02,$06
        .byte   $FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite11ZPieceOffset:
        .byte   $00,$7C,$02,$FA,$00,$7C,$02,$02
        .byte   $08,$7C,$02,$02,$08,$7C,$02,$0A
        .byte   $FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite12JPieceOffset:
        .byte   $08,$7D,$02,$00,$08,$7D,$02,$08
        .byte   $08,$7D,$02,$10,$10,$7D,$02,$10
        .byte   $FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite13LPieceOffset:
        .byte   $08,$7C,$02,$F8,$08,$7C,$02,$00
        .byte   $08,$7C,$02,$08,$10,$7C,$02,$F8
        .byte   $FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite14OPieceOffset:
        .byte   $00,$7B,$02,$00,$00,$7B,$02,$08
        .byte   $08,$7B,$02,$00,$08,$7B,$02,$08
        .byte   $FF
; Unused, but referenced from unreferenced_orientationToSpriteTable
sprite15IPieceOffset:
        .byte   $08,$7B,$02,$F8,$08,$7B,$02,$00
        .byte   $08,$7B,$02,$08,$08,$7B,$02,$10
        .byte   $FF
sprite16KidIcarus1:
        .byte   $F0,$95,$01,$10,$F8,$A3,$01,$00
        .byte   $F8,$A4,$01,$08,$F8,$A5,$01,$10
        .byte   $FF
sprite17KidIcarus2:
        .byte   $F8,$83,$01,$00,$F8,$84,$01,$08
        .byte   $F8,$85,$01,$10,$FF
sprite18Link1:
        .byte   $F0,$90,$00,$00,$F8,$A0,$00,$00
        .byte   $FF
sprite19Link2:
        .byte   $F0,$C4,$00,$00,$F8,$D4,$00,$00
        .byte   $FF
sprite1ASamus1:
        .byte   $E8,$28,$00,$08,$E8,$2A,$00,$10
        .byte   $F0,$C8,$03,$10,$F8,$D6,$03,$00
        .byte   $F8,$D7,$03,$08,$F8,$D8,$03,$10
        .byte   $FF
sprite1BSamus2:
        .byte   $E8,$28,$00,$08,$E8,$2A,$00,$10
        .byte   $F0,$B9,$03,$10,$F8,$F6,$03,$00
        .byte   $F8,$F7,$03,$08,$F8,$F8,$03,$10
        .byte   $FF
; Unused. Strange there isn't an unused arms open as well
sprite1CDonkeyKong_armsClosed:
        .byte   $E8,$C9,$02,$00,$E8,$CB,$02,$10
        .byte   $F0,$D9,$02,$00,$F0,$DB,$02,$10
        .byte   $F8,$E9,$02,$00,$F8,$EB,$02,$10
        .byte   $FF
sprite1DDonkeyKong1:
        .byte   $E8,$46,$02,$F8,$E8,$47,$02,$00
        .byte   $E8,$CB,$02,$10,$F0,$56,$02,$F8
        .byte   $F0,$57,$02,$00,$F0,$DB,$02,$10
        .byte   $F8,$87,$02,$00,$F8,$EB,$02,$10
        .byte   $FF
sprite1EDonkeyKong2:
        .byte   $E8,$C9,$02,$00,$E8,$66,$02,$10
        .byte   $E8,$67,$02,$18,$F0,$D9,$02,$00
        .byte   $F0,$76,$02,$10,$F0,$77,$02,$18
        .byte   $F8,$E9,$02,$00,$F8,$86,$02,$10
        .byte   $FF
sprite1FBowser1:
        .byte   $F8,$E1,$00,$08,$F8,$E2,$00,$10
        .byte   $00,$F1,$00,$08,$00,$C5,$00,$10
        .byte   $00,$D5,$00,$18,$FF
sprite20Bowser2:
        .byte   $F8,$E4,$00,$08,$F8,$E5,$00,$10
        .byte   $00,$F4,$00,$08,$00,$F5,$00,$10
        .byte   $00,$F3,$00,$18,$FF
sprite21PrincessPeach1:
        .byte   $00,$63,$01,$00,$00,$64,$01,$08
        .byte   $FF
sprite22PrincessPeach2:
        .byte   $00,$73,$01,$00,$00,$74,$01,$08
        .byte   $FF
sprite23CathedralRocketJet1:
        .byte   $08,$A8,$23,$18,$08,$A9,$23,$20
        .byte   $FF
sprite24CathedralRocketJet2:
        .byte   $08,$AA,$23,$10,$08,$AB,$23,$18
        .byte   $08,$AC,$23,$20,$08,$AD,$23,$28
        .byte   $10,$BA,$23,$10,$10,$BB,$23,$18
        .byte   $10,$BC,$23,$20,$10,$BD,$23,$28
        .byte   $FF
; Seems unused
sprite25CloudLarge:
        .byte   $00,$60,$21,$00,$00,$61,$21,$08
        .byte   $00,$62,$21,$10,$08,$70,$21,$00
        .byte   $08,$71,$21,$08,$08,$72,$21,$10
        .byte   $FF
; Seems unused. Broken? Seems $81 should be $81
sprite26CloudSmall:
        .byte   $00,$80,$21,$00,$00,$81,$21,$08
        .byte   $FF
sprite27Mario1:
        .byte   $F0,$30,$03,$00,$F0,$31,$03,$08
        .byte   $F0,$32,$03,$10,$F8,$40,$03,$00
        .byte   $F8,$41,$03,$08,$F8,$42,$03,$10
        .byte   $00,$50,$03,$00,$00,$51,$03,$08
        .byte   $00,$52,$03,$10,$FF
sprite28Mario2:
        .byte   $F8,$23,$03,$00,$F8,$24,$03,$08
        .byte   $F8,$25,$03,$10,$00,$33,$03,$00
        .byte   $00,$34,$03,$08,$00,$35,$03,$10
        .byte   $FF
sprite29Luigi1:
        .byte   $F0,$30,$00,$00,$F0,$31,$00,$08
        .byte   $F0,$32,$00,$10,$F8,$29,$00,$00
        .byte   $F8,$41,$00,$08,$F8,$2B,$00,$10
        .byte   $00,$2C,$00,$00,$00,$2D,$00,$08
        .byte   $00,$2E,$00,$10,$FF
sprite2ALuigi2:
        .byte   $F0,$32,$40,$00,$F0,$31,$40,$08
        .byte   $F0,$30,$40,$10,$F8,$2B,$40,$00
        .byte   $F8,$41,$40,$08,$F8,$29,$40,$10
        .byte   $00,$2E,$40,$00,$00,$2D,$40,$08
        .byte   $00,$2C,$40,$10,$FF
sprite2CDragonfly1:
        .byte   $00,$20,$23,$00,$FF
sprite2DDragonfly2:
        .byte   $00,$21,$23,$00,$FF
sprite2EDove1:
        .byte   $F8,$22,$21,$00,$F8,$23,$21,$08
        .byte   $00,$32,$21,$00,$00,$33,$21,$08
        .byte   $FF
sprite2FDove2:
        .byte   $F8,$24,$21,$00,$F8,$25,$21,$08
        .byte   $00,$34,$21,$00,$00,$35,$21,$08
        .byte   $FF
; Unused
sprite30Airplane1:
        .byte   $F8,$26,$21,$F0,$F8,$27,$21,$F8
        .byte   $00,$36,$21,$F0,$00,$37,$21,$F8
        .byte   $FF
; Unused
sprite31Airplane2:
        .byte   $F8,$28,$21,$F0,$F8,$27,$21,$F8
        .byte   $00,$29,$21,$F0,$00,$37,$21,$F8
        .byte   $FF
sprite32Ufo1:
        .byte   $F8,$46,$21,$F0,$F8,$47,$21,$F8
        .byte   $00,$56,$21,$F0,$00,$57,$21,$F8
        .byte   $FF
sprite33Ufo2:
        .byte   $F8,$46,$21,$F0,$F8,$47,$21,$F8
        .byte   $00,$66,$21,$F0,$00,$67,$21,$F8
        .byte   $FF
sprite34Pterosaur1:
        .byte   $F8,$43,$22,$00,$F8,$44,$22,$08
        .byte   $F8,$45,$22,$10,$00,$53,$22,$00
        .byte   $00,$54,$22,$08,$00,$55,$22,$10
        .byte   $FF
sprite35Pterosaur2:
        .byte   $F8,$63,$22,$00,$F8,$64,$22,$08
        .byte   $F8,$65,$22,$10,$00,$73,$22,$00
        .byte   $00,$74,$22,$08,$00,$75,$22,$10
        .byte   $FF
sprite36Blimp1:
        .byte   $F8,$40,$21,$E8,$F8,$41,$21,$F0
        .byte   $F8,$42,$21,$F8,$00,$50,$21,$E8
        .byte   $00,$51,$21,$F0,$00,$52,$21,$F8
        .byte   $FF
sprite37Blimp2:
        .byte   $F8,$40,$21,$E8,$F8,$41,$21,$F0
        .byte   $F8,$42,$21,$F8,$00,$50,$21,$E8
        .byte   $00,$30,$21,$F0,$00,$52,$21,$F8
        .byte   $FF
sprite38Dragon1:
        .byte   $F8,$90,$23,$08,$F8,$A2,$23,$10
        .byte   $00,$91,$23,$F0,$00,$92,$23,$F8
        .byte   $00,$B0,$23,$00,$00,$A0,$23,$08
        .byte   $00,$B2,$23,$10,$00,$B3,$23,$18
        .byte   $08,$C0,$23,$00,$08,$C1,$23,$08
        .byte   $FF
sprite39Dragon2:
        .byte   $F8,$A1,$23,$08,$F8,$A2,$23,$10
        .byte   $00,$91,$23,$F0,$00,$92,$23,$F8
        .byte   $00,$B0,$23,$00,$00,$B1,$23,$08
        .byte   $00,$B2,$23,$10,$00,$B3,$23,$18
        .byte   $08,$C0,$23,$00,$08,$C1,$23,$08
        .byte   $FF
sprite3ABuran1:
        .byte   $F8,$D3,$21,$F0,$00,$E1,$21,$E0
        .byte   $00,$E2,$21,$E8,$00,$E3,$21,$F0
        .byte   $08,$F0,$21,$D8,$08,$F1,$21,$E0
        .byte   $08,$F2,$21,$E8,$08,$F3,$21,$F0
        .byte   $08,$D1,$21,$F8,$08,$D2,$21,$00
        .byte   $FF
sprite3BBuran2:
        .byte   $F8,$D3,$21,$F0,$00,$E1,$21,$E0
        .byte   $00,$E2,$21,$E8,$00,$E3,$21,$F0
        .byte   $08,$F0,$21,$D8,$08,$F1,$21,$E0
        .byte   $08,$F2,$21,$E8,$08,$F3,$21,$F0
        .byte   $08,$D0,$21,$F8,$FF
; Unused
sprite3CHelicopter1:
        .byte   $F8,$83,$23,$E8,$F8,$84,$23,$F0
        .byte   $F8,$85,$23,$F8,$00,$93,$23,$E8
        .byte   $00,$94,$23,$F0,$FF
; Unused
sprite3DHelicopter2:
        .byte   $F8,$A3,$23,$E8,$F8,$A4,$23,$F0
        .byte   $F8,$A5,$23,$F8,$00,$93,$23,$E8
        .byte   $00,$94,$23,$F0,$FF
sprite3ESmallRocket:
        .byte   $00,$A6,$23,$00,$FF
sprite3FSmallRocketJet1:
        .byte   $08,$A7,$23,$00,$FF
sprite40SmallRocketJet2:
        .byte   $08,$F4,$23,$00,$FF
sprite41MediumRocket:
        .byte   $F8,$B4,$21,$00,$00,$C4,$21,$00
        .byte   $FF
sprite42MediumRocketJet1:
        .byte   $08,$D4,$23,$00,$FF
sprite43MediumRocketJet2:
        .byte   $08,$E4,$23,$00,$FF
sprite44LargeRocket:
        .byte   $E8,$B5,$23,$00,$E8,$B6,$23,$08
        .byte   $F0,$C5,$23,$00,$F0,$C6,$23,$08
        .byte   $F8,$D5,$23,$00,$F8,$D6,$23,$08
        .byte   $00,$E5,$23,$00,$00,$E6,$23,$08
        .byte   $FF
sprite45LargeRocketJet1:
        .byte   $08,$F5,$23,$00,$08,$F6,$23,$08
        .byte   $FF
sprite46LargeRocketJet2:
        .byte   $08,$B7,$23,$00,$08,$B8,$23,$08
        .byte   $FF
sprite47BuranRocket:
        .byte   $D0,$C2,$21,$08,$D0,$C3,$21,$10
        .byte   $D8,$CB,$21,$08,$D8,$EB,$21,$10
        .byte   $E0,$DB,$21,$08,$E0,$FB,$21,$10
        .byte   $E8,$C7,$21,$00,$E8,$C8,$21,$08
        .byte   $E8,$C9,$21,$10,$E8,$CA,$21,$18
        .byte   $F0,$D7,$21,$00,$F0,$D8,$21,$08
        .byte   $F0,$D9,$21,$10,$F0,$DA,$21,$18
        .byte   $F8,$E7,$21,$00,$F8,$E8,$21,$08
        .byte   $F8,$E9,$21,$10,$F8,$EA,$21,$18
        .byte   $00,$F7,$21,$00,$00,$F8,$21,$08
        .byte   $00,$F9,$21,$10,$00,$FA,$21,$18
        .byte   $FF
sprite48BuranRocketJet1:
        .byte   $08,$2A,$23,$08,$08,$2B,$23,$10
        .byte   $FF
sprite49BuranRocketJet2:
        .byte   $08,$2C,$23,$08,$08,$2D,$23,$10
        .byte   $10,$2E,$23,$08,$10,$2F,$23,$10
        .byte   $FF
sprite4ACathedralRocket:
        .byte   $C8,$38,$23,$20,$D0,$39,$23,$08
        .byte   $D0,$3B,$23,$18,$D0,$3C,$23,$20
        .byte   $D0,$3E,$23,$30,$D0,$3F,$23,$38
        .byte   $D8,$48,$23,$00,$D8,$49,$23,$08
        .byte   $D8,$4A,$23,$10,$D8,$4B,$23,$18
        .byte   $D8,$4C,$23,$20,$D8,$4D,$23,$28
        .byte   $D8,$4E,$20,$30,$D8,$4F,$20,$38
        .byte   $E0,$58,$23,$00,$E0,$59,$23,$08
        .byte   $E0,$5A,$23,$10,$E0,$5B,$23,$18
        .byte   $E0,$5C,$23,$20,$E0,$5D,$23,$28
        .byte   $E0,$5E,$20,$30,$E0,$5F,$20,$38
        .byte   $E8,$68,$23,$00,$E8,$69,$23,$08
        .byte   $E8,$6A,$23,$10,$E8,$6B,$23,$18
        .byte   $E8,$6C,$23,$20,$E8,$6D,$23,$28
        .byte   $E8,$6E,$23,$30,$E8,$6F,$23,$38
        .byte   $F0,$78,$23,$00,$F0,$79,$23,$08
        .byte   $F0,$7A,$23,$10,$F0,$7B,$23,$18
        .byte   $F0,$7C,$23,$20,$F0,$7D,$23,$28
        .byte   $F0,$7E,$23,$30,$F0,$7F,$23,$38
        .byte   $F8,$88,$20,$00,$F8,$89,$20,$08
        .byte   $F8,$8A,$20,$10,$F8,$8B,$20,$18
        .byte   $F8,$8C,$20,$20,$F8,$8D,$20,$28
        .byte   $F8,$8E,$20,$30,$F8,$8F,$20,$38
        .byte   $00,$98,$20,$00,$00,$99,$20,$08
        .byte   $00,$9A,$20,$10,$00,$9B,$20,$18
        .byte   $00,$9C,$20,$20,$00,$9D,$20,$28
        .byte   $00,$9E,$20,$30,$00,$9F,$20,$38
        .byte   $FF
sprite4BOstrich1:
        .byte   $E0,$91,$21,$08,$E0,$92,$21,$10
        .byte   $E8,$A0,$21,$00,$E8,$A1,$21,$08
        .byte   $E8,$A2,$21,$10,$F0,$B0,$21,$00
        .byte   $F0,$B1,$21,$08,$F0,$B2,$21,$10
        .byte   $F8,$C0,$21,$00,$F8,$C1,$21,$08
        .byte   $F8,$C2,$21,$10,$00,$D0,$21,$00
        .byte   $00,$D2,$21,$10,$FF
sprite4COstrich2:
        .byte   $E0,$C4,$21,$08,$E0,$C5,$21,$10
        .byte   $E8,$D3,$21,$00,$E8,$D4,$21,$08
        .byte   $E8,$D5,$21,$10,$F0,$E3,$21,$00
        .byte   $F0,$E4,$21,$08,$F0,$E5,$21,$10
        .byte   $F8,$F3,$21,$00,$F8,$F4,$21,$08
        .byte   $F8,$F5,$21,$10,$00,$B3,$21,$00
        .byte   $00,$B4,$21,$08,$FF
; Saint Basil's is shown from the NNW. https://en.wikipedia.org/wiki/File:Sant_Vasily_cathedral_in_Moscow.JPG Use https://www.moscow-driver.com/photos/moscow_sightseeing/st_basil_cathedral/model_and_plan_of_cathedral_chapels to determine names of chapels
sprite4DCathedralEasternDome:
        .byte   $F0,$39,$22,$04,$F8,$AA,$22,$00
        .byte   $F8,$AB,$22,$08,$00,$BA,$22,$00
        .byte   $00,$BB,$22,$08,$FF
sprite4ECathedralNorthernDome:
        .byte   $F0,$3A,$23,$04,$F8,$AC,$23,$00
        .byte   $F8,$AD,$23,$08,$00,$BC,$23,$00
        .byte   $00,$BD,$23,$08,$FF
sprite4FCathedralCentralDome:
        .byte   $F0,$38,$23,$08,$F8,$49,$23,$00
        .byte   $F8,$4A,$23,$08,$00,$3B,$23,$00
        .byte   $00,$3C,$23,$08,$FF
sprite50CathedralWesternDome:
        .byte   $F8,$4E,$20,$00,$F8,$4F,$20,$08
        .byte   $00,$5E,$20,$00,$00,$5F,$20,$08
        .byte   $FF
sprite51CathedralDomeRocketJet1:
        .byte   $08,$5B,$23,$04,$FF
sprite52CathedralDomeRocketJet2:
        .byte   $08,$48,$23,$04,$10,$58,$23,$04
        .byte   $FF
sprite53MusicTypeCursor:
        .byte   $00,$27,$00,$00,$00,$27,$40,$4A
        .byte   $FF
sprite54Penguin1:
        .byte   $E8,$A9,$21,$00,$E8,$AA,$21,$08
        .byte   $F0,$B8,$21,$F8,$F0,$B9,$21,$00
        .byte   $F0,$BA,$21,$08,$F8,$C9,$21,$00
        .byte   $F8,$CA,$21,$08,$F8,$CB,$21,$10
        .byte   $00,$D9,$21,$00,$00,$DA,$21,$08
        .byte   $FF
sprite55Penguin2:
        .byte   $E8,$AD,$21,$00,$E8,$AE,$21,$08
        .byte   $F0,$BC,$21,$F8,$F0,$BD,$21,$00
        .byte   $F0,$BE,$21,$08,$F8,$CD,$21,$00
        .byte   $F8,$CE,$21,$08,$F8,$CF,$21,$10
        .byte   $00,$DD,$21,$00,$00,$DE,$21,$08
        .byte   $FF
isPositionValid:
        lda     tetriminoY
        asl     a
        sta     generalCounter
        asl     a
        asl     a
        clc
        adc     generalCounter
        adc     tetriminoX
        sta     generalCounter
        lda     currentPiece
        asl     a
        asl     a
        sta     generalCounter2
        asl     a
        clc
        adc     generalCounter2
        tax
        ldy     #$00
        lda     #$04
        sta     generalCounter3
; Checks one square within the tetrimino
@checkSquare:
        lda     orientationTable,x
        clc
        adc     tetriminoY
        adc     #$02
        cmp     #$16
        bcs     @invalid
        lda     orientationTable,x
        asl     a
        sta     generalCounter4
        asl     a
        asl     a
        clc
        adc     generalCounter4
        clc
        adc     generalCounter
        sta     selectingLevelOrHeight
        inx
        inx
        lda     orientationTable,x
        clc
        adc     selectingLevelOrHeight
        tay
        lda     (playfieldAddr),y
        cmp     #tileEmpty
        bcc     @invalid
        lda     orientationTable,x
        clc
        adc     tetriminoX
        cmp     #$0A
        bcs     @invalid
        inx
        dec     generalCounter3
        bne     @checkSquare
        lda     #$00
        sta     generalCounter
        rts

@invalid:
        lda     #$FF
        sta     generalCounter
        rts

render_mode_play_and_demo:
        lda     player1_playState
        cmp     #$04
        bne     @playStateNotDisplayLineClearingAnimation
        lda     #>playfield
        sta     playfieldAddr+1
        lda     player1_rowY
        sta     rowY
        lda     player1_completedRow
        sta     completedRow
        lda     player1_completedRow+1
        sta     completedRow+1
        lda     player1_completedRow+2
        sta     completedRow+2
        lda     player1_completedRow+3
        sta     completedRow+3
        lda     player1_playState
        sta     playState
        jsr     updateLineClearingAnimation
        lda     rowY
        sta     player1_rowY
        lda     playState
        sta     player1_playState
        lda     #$00
        sta     player1_vramRow
        jmp     @renderPlayer2Playfield

@playStateNotDisplayLineClearingAnimation:
        lda     player1_vramRow
        sta     vramRow
        lda     #>playfield
        sta     playfieldAddr+1
        jsr     copyPlayfieldRowToVRAM
        jsr     copyPlayfieldRowToVRAM
        jsr     copyPlayfieldRowToVRAM
        jsr     copyPlayfieldRowToVRAM
        lda     vramRow
        sta     player1_vramRow
@renderPlayer2Playfield:
        lda     numberOfPlayers
        cmp     #$02
        bne     @renderLines
        lda     player2_playState
        cmp     #$04
        bne     @player2PlayStateNotDisplayLineClearingAnimation
        lda     #>playfieldForSecondPlayer
        sta     playfieldAddr+1
        lda     player2_rowY
        sta     rowY
        lda     player2_completedRow
        sta     completedRow
        lda     player2_completedRow+1
        sta     completedRow+1
        lda     player2_completedRow+2
        sta     completedRow+2
        lda     player2_completedRow+3
        sta     completedRow+3
        lda     player2_playState
        sta     playState
        jsr     updateLineClearingAnimation
        lda     rowY
        sta     player2_rowY
        lda     playState
        sta     player2_playState
        lda     #$00
        sta     player2_vramRow
        jmp     @renderLines

@player2PlayStateNotDisplayLineClearingAnimation:
        lda     player2_vramRow
        sta     vramRow
        lda     #>playfieldForSecondPlayer
        sta     playfieldAddr+1
        jsr     copyPlayfieldRowToVRAM
        jsr     copyPlayfieldRowToVRAM
        jsr     copyPlayfieldRowToVRAM
        jsr     copyPlayfieldRowToVRAM
        lda     vramRow
        sta     player2_vramRow
@renderLines:
        lda     outOfDateRenderFlags
        and     #RENDER_LINES
        beq     @renderLevel
        lda     numberOfPlayers
        cmp     #$02
        beq     @renderLinesTwoPlayers
        lda     #$20
        sta     PPUADDR
        lda     #$73
        sta     PPUADDR
        lda     player1_lines+1
        sta     PPUDATA
        lda     player1_lines
        jsr     twoDigsToPPU
        lda     outOfDateRenderFlags
        and     #~RENDER_LINES
        sta     outOfDateRenderFlags
        jmp     @renderLevel

@renderLinesTwoPlayers:
        lda     #$20
        sta     PPUADDR
        lda     #$68
        sta     PPUADDR
        lda     player1_lines+1
        sta     PPUDATA
        lda     player1_lines
        jsr     twoDigsToPPU
        lda     #$20
        sta     PPUADDR
        lda     #$7A
        sta     PPUADDR
        lda     player2_lines+1
        sta     PPUDATA
        lda     player2_lines
        jsr     twoDigsToPPU
        lda     outOfDateRenderFlags
        and     #~RENDER_LINES
        sta     outOfDateRenderFlags
@renderLevel:
        lda     outOfDateRenderFlags
        and     #RENDER_LEVEL
        beq     @renderScore
        lda     numberOfPlayers
        cmp     #$02
        beq     @renderScore
        ldx     player1_levelNumber
        lda     levelDisplayTable,x
        sta     generalCounter
        lda     #$22
        sta     PPUADDR
        lda     #$BA
        sta     PPUADDR
        lda     generalCounter
        jsr     twoDigsToPPU
        jsr     updatePaletteForLevel
        lda     outOfDateRenderFlags
        and     #~RENDER_LEVEL
        sta     outOfDateRenderFlags
@renderScore:
        lda     numberOfPlayers
        cmp     #$02
        beq     @renderStats
        lda     outOfDateRenderFlags
        and     #RENDER_SCORE
        beq     @renderStats
        lda     #$21
        sta     PPUADDR
        lda     #$18
        sta     PPUADDR
        lda     player1_score+2
        jsr     twoDigsToPPU
        lda     player1_score+1
        jsr     twoDigsToPPU
        lda     player1_score
        jsr     twoDigsToPPU
        lda     outOfDateRenderFlags
        and     #~RENDER_SCORE
        sta     outOfDateRenderFlags
@renderStats:
        lda     numberOfPlayers
        cmp     #$02
        beq     @renderTetrisFlashAndSound
        lda     outOfDateRenderFlags
        and     #RENDER_STATS
        beq     @renderTetrisFlashAndSound
        lda     #$00
        sta     tmpCurrentPiece
@renderPieceStat:
        lda     tmpCurrentPiece
        asl     a
        tax
        lda     pieceToPpuStatAddr,x
        sta     PPUADDR
        lda     pieceToPpuStatAddr+1,x
        sta     PPUADDR
        lda     statsByType+1,x
        sta     PPUDATA
        lda     statsByType,x
        jsr     twoDigsToPPU
        inc     tmpCurrentPiece
        lda     tmpCurrentPiece
        cmp     #$07
        bne     @renderPieceStat
        lda     outOfDateRenderFlags
        and     #~RENDER_STATS
        sta     outOfDateRenderFlags
@renderTetrisFlashAndSound:
        lda     #$3F
        sta     PPUADDR
        lda     #$0E
        sta     PPUADDR
        ldx     #$00
        lda     completedLines
        cmp     #$04
        bne     @setPaletteColor
        lda     frameCounter
        and     #$03
        bne     @setPaletteColor
        ldx     #$30
        lda     frameCounter
        and     #$07
        bne     @setPaletteColor
        lda     #$09
        sta     soundEffectSlot1Init
@setPaletteColor:
        stx     PPUDATA
        ldy     #$00
        sty     ppuScrollX
        sty     PPUSCROLL
        ldy     #$00
        sty     ppuScrollY
        sty     PPUSCROLL
        rts

pieceToPpuStatAddr:
        .dbyt   $2186,$21C6,$2206,$2246
        .dbyt   $2286,$22C6,$2306
levelDisplayTable:
        .byte   $00,$01,$02,$03,$04,$05,$06,$07
        .byte   $08,$09,$10,$11,$12,$13,$14,$15
        .byte   $16,$17,$18,$19,$20,$21,$22,$23
        .byte   $24,$25,$26,$27,$28,$29
multBy10Table:
        .byte   $00,$0A,$14,$1E,$28,$32,$3C,$46
        .byte   $50,$5A,$64,$6E,$78,$82,$8C,$96
        .byte   $A0,$AA,$B4,$BE
; addresses
vramPlayfieldRows:
        .word   $20C6,$20E6,$2106,$2126
        .word   $2146,$2166,$2186,$21A6
        .word   $21C6,$21E6,$2206,$2226
        .word   $2246,$2266,$2286,$22A6
        .word   $22C6,$22E6,$2306,$2326
twoDigsToPPU:
        sta     generalCounter
        and     #$F0
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        sta     PPUDATA
        lda     generalCounter
        and     #$0F
        sta     PPUDATA
        rts

copyPlayfieldRowToVRAM:
        ldx     vramRow
        cpx     #$15
        bpl     @ret
        lda     multBy10Table,x
        tay
        txa
        asl     a
        tax
        inx
        lda     vramPlayfieldRows,x
        sta     PPUADDR
        dex
        lda     numberOfPlayers
        cmp     #$01
        beq     @onePlayer
        lda     playfieldAddr+1
        cmp     #$05
        beq     @playerTwo
        lda     vramPlayfieldRows,x
        sec
        sbc     #$02
        sta     PPUADDR
        jmp     @copyRow

@playerTwo:
        lda     vramPlayfieldRows,x
        clc
        adc     #$0C
        sta     PPUADDR
        jmp     @copyRow

@onePlayer:
        lda     vramPlayfieldRows,x
        clc
        adc     #$06
        sta     PPUADDR
@copyRow:
        ldx     #$0A
@copyByte:
        lda     (playfieldAddr),y
        sta     PPUDATA
        iny
        dex
        bne     @copyByte
        inc     vramRow
        lda     vramRow
        cmp     #$14
        bmi     @ret
        lda     #$20
        sta     vramRow
@ret:   rts

updateLineClearingAnimation:
        lda     frameCounter
        and     #$03
        bne     @ret
        lda     #$00
        sta     generalCounter3
@whileCounter3LessThan4:
        ldx     generalCounter3
        lda     completedRow,x
        beq     @nextRow
        asl     a
        tay
        lda     vramPlayfieldRows,y
        sta     generalCounter
        lda     numberOfPlayers
        cmp     #$01
        bne     @twoPlayers
        lda     generalCounter
        clc
        adc     #$06
        sta     generalCounter
        jmp     @updateVRAM

@twoPlayers:
        lda     playfieldAddr+1
        cmp     #>playfield
        bne     @player2
        lda     generalCounter
        sec
        sbc     #$02
        sta     generalCounter
        jmp     @updateVRAM

@player2:
        lda     generalCounter
        clc
        adc     #$0C
        sta     generalCounter
@updateVRAM:
        iny
        lda     vramPlayfieldRows,y
        sta     generalCounter2
        sta     PPUADDR
        ldx     rowY
        lda     leftColumns,x
        clc
        adc     generalCounter
        sta     PPUADDR
        lda     #$FF
        sta     PPUDATA
        lda     generalCounter2
        sta     PPUADDR
        ldx     rowY
        lda     rightColumns,x
        clc
        adc     generalCounter
        sta     PPUADDR
        lda     #$FF
        sta     PPUDATA
@nextRow:
        inc     generalCounter3
        lda     generalCounter3
        cmp     #$04
        bne     @whileCounter3LessThan4
        inc     rowY
        lda     rowY
        cmp     #$05
        bmi     @ret
        inc     playState
@ret:   rts

leftColumns:
        .byte   $04,$03,$02,$01,$00
rightColumns:
        .byte   $05,$06,$07,$08,$09
; Set Background palette 2 and Sprite palette 2
updatePaletteForLevel:
        lda     player1_levelNumber
@mod10: cmp     #$0A
        bmi     @copyPalettes
        sec
        sbc     #$0A
        jmp     @mod10

@copyPalettes:
        asl     a
        asl     a
        tax
        lda     #$00
        sta     generalCounter
@copyPalette:
        lda     #$3F
        sta     PPUADDR
        lda     #$08
        clc
        adc     generalCounter
        sta     PPUADDR
        lda     colorTable,x
        sta     PPUDATA
        lda     colorTable+1,x
        sta     PPUDATA
        lda     colorTable+1+1,x
        sta     PPUDATA
        lda     colorTable+1+1+1,x
        sta     PPUDATA
        lda     generalCounter
        clc
        adc     #$10
        sta     generalCounter
        cmp     #$20
        bne     @copyPalette
        rts

; 4 bytes per level (bg, fg, c3, c4)
colorTable:
        .dbyt   $0F30,$2112,$0F30,$291A
        .dbyt   $0F30,$2414,$0F30,$2A12
        .dbyt   $0F30,$2B15,$0F30,$222B
        .dbyt   $0F30,$0016,$0F30,$0513
        .dbyt   $0F30,$1612,$0F30,$2716
; This increment and clamping is performed in copyPlayfieldRowToVRAM instead of here
noop_disabledVramRowIncr:
        rts

        inc     player1_vramRow
        lda     player1_vramRow
        cmp     #$14
        bmi     @player2
        lda     #$20
        sta     player1_vramRow
@player2:
        inc     player2_vramRow
        lda     player2_vramRow
        cmp     #$14
        bmi     @ret
        lda     #$20
        sta     player2_vramRow
@ret:   rts

playState_spawnNextTetrimino:
        lda     vramRow
        cmp     #$20
        bmi     @ret
        lda     numberOfPlayers
        cmp     #$01
        beq     @spawnPiece
        lda     twoPlayerPieceDelayCounter
        cmp     #$00
        bne     @twoPlayerWaiting
        inc     twoPlayerPieceDelayCounter
        lda     activePlayer
        sta     twoPlayerPieceDelayPlayer
        jsr     chooseNextTetrimino
        sta     twoPlayerPieceDelayPiece
        jmp     @ret

@twoPlayerWaiting:
        lda     twoPlayerPieceDelayPlayer
        cmp     activePlayer
        bne     @ret
        lda     twoPlayerPieceDelayCounter
        cmp     #$1C
        bne     @ret
@spawnPiece:
        lda     #$00
        sta     twoPlayerPieceDelayCounter
        sta     fallTimer
        sta     tetriminoY
        lda     #$01
        sta     playState
        lda     #$05
        sta     tetriminoX
        ldx     nextPiece
        lda     spawnOrientationFromOrientation,x
        sta     currentPiece
        jsr     incrementPieceStat
        lda     numberOfPlayers
        cmp     #$01
        beq     @onePlayerPieceSelection
        lda     twoPlayerPieceDelayPiece
        sta     nextPiece
        jmp     @resetDownHold

@onePlayerPieceSelection:
        jsr     chooseNextTetrimino
        sta     nextPiece
@resetDownHold:
        lda     #$00
        sta     autorepeatY
@ret:   rts

chooseNextTetrimino:
        lda     gameMode
        cmp     #$05
        bne     pickRandomTetrimino
        ldx     demoIndex
        inc     demoIndex
        lda     demoTetriminoTypeTable,x
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        and     #$07
        tax
        lda     spawnTable,x
        rts

pickRandomTetrimino:
        jsr     @realStart
        rts

@realStart:
.if NWC = 1
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
.endif
        inc     spawnCount
        lda     rng_seed
        clc
        adc     spawnCount
        and     #$07
        cmp     #$07
        beq     @invalidIndex
        tax
        lda     spawnTable,x
        cmp     spawnID
        bne     useNewSpawnID
@invalidIndex:
        ldx     #rng_seed
        ldy     #$02
        jsr     generateNextPseudorandomNumber
        lda     rng_seed
        and     #$07
        clc
        adc     spawnID
L992A:  cmp     #$07
        bcc     L9934
        sec
        sbc     #$07
        jmp     L992A

L9934:  tax
        lda     spawnTable,x
useNewSpawnID:
        sta     spawnID
        rts

tetriminoTypeFromOrientation:
        .byte   tPiece, tPiece, tPiece, tPiece
        .byte   jPiece, jPiece, jPiece, jPiece
        .byte   zPiece, zPiece
        .byte   oPiece
        .byte   sPiece, sPiece
        .byte   lPiece, lPiece, lPiece, lPiece
        .byte   iPiece, iPiece
spawnTable:
        .byte   tDown, jDown, zHoriz, oFixed, sHoriz, lDown, iHoriz
; unused portion of spawnTable:
.if NWC = 1
        .byte   $12
.else
        .byte   $02
.endif
spawnOrientationFromOrientation:
        .byte   tDown, tDown, tDown, tDown
        .byte   jDown, jDown, jDown, jDown
        .byte   zHoriz, zHoriz
        .byte   oFixed
        .byte   sHoriz, sHoriz
        .byte   lDown, lDown, lDown, lDown
        .byte   iHoriz, iHoriz

incrementPieceStat:
        tax
        lda     tetriminoTypeFromOrientation,x
        asl     a
        tax
        lda     statsByType,x
        clc
        adc     #$01
        sta     generalCounter
        and     #$0F
        cmp     #$0A
        bmi     L9996
        lda     generalCounter
        clc
        adc     #$06
        sta     generalCounter
        cmp     #$A0
        bcc     L9996
        clc
        adc     #$60
        sta     generalCounter
        lda     statsByType+1,x
        clc
        adc     #$01
        sta     statsByType+1,x
L9996:  lda     generalCounter
        sta     statsByType,x
        lda     outOfDateRenderFlags
        ora     #RENDER_STATS
        sta     outOfDateRenderFlags
        rts

playState_lockTetrimino:
        jsr     isPositionValid
        beq     @notGameOver
        lda     #$02
        sta     soundEffectSlot0Init
        lda     #$0A
        sta     playState
        lda     #$F0
        sta     curtainRow
        jsr     updateAudio2
        rts

@notGameOver:
        lda     vramRow
        cmp     #$20
        bmi     @ret
        lda     tetriminoY
        asl     a
        sta     generalCounter
        asl     a
        asl     a
        clc
        adc     generalCounter
        adc     tetriminoX
        sta     generalCounter
        lda     currentPiece
        asl     a
        asl     a
        sta     generalCounter2
        asl     a
        clc
        adc     generalCounter2
        tax
        ldy     #$00
        lda     #$04
        sta     generalCounter3
; Copies a single square of the tetrimino to the playfield
@lockSquare:
        lda     orientationTable,x
        asl     a
        sta     generalCounter4
        asl     a
        asl     a
        clc
        adc     generalCounter4
        clc
        adc     generalCounter
        sta     selectingLevelOrHeight
        inx
        lda     orientationTable,x
        sta     generalCounter5
        inx
        lda     orientationTable,x
        clc
        adc     selectingLevelOrHeight
        tay
        lda     generalCounter5
        sta     (playfieldAddr),y
        inx
        dec     generalCounter3
        bne     @lockSquare
        lda     #$00
        sta     lineIndex
        jsr     updatePlayfield
        jsr     updateMusicSpeed
        inc     playState
@ret:   rts

playState_updateGameOverCurtain:
        lda     curtainRow
        cmp     #$14
        beq     @curtainFinished
        lda     frameCounter
        and     #$03
        bne     @ret
        ldx     curtainRow
        bmi     @incrementCurtainRow
        lda     multBy10Table,x
        tay
        lda     #$00
        sta     generalCounter3
        lda     #hidden
        sta     currentPiece
@drawCurtainRow:
        lda     #$4F
        sta     (playfieldAddr),y
        iny
        inc     generalCounter3
        lda     generalCounter3
        cmp     #$0A
        bne     @drawCurtainRow
        lda     curtainRow
        sta     vramRow
@incrementCurtainRow:
        inc     curtainRow
        lda     curtainRow
        cmp     #$14
        bne     @ret
@ret:   rts

@curtainFinished:
.if NWC = 1
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jmp     @curtainFinished
.endif
        lda     numberOfPlayers
        cmp     #$02
        beq     @exitGame
        lda     player1_score+2
        cmp     #$03
        bcc     @checkForStartButton
        lda     #ENDING_SLEEP_TIME_1
        jsr     sleep_for_a_vblanks
        jsr     endingAnimation
        jmp     @exitGame

@checkForStartButton:
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        bne     @ret2
@exitGame:
        lda     #$00
        sta     playState
        sta     newlyPressedButtons_player1
@ret2:  rts

playState_checkForCompletedRows:
        lda     vramRow
        cmp     #$20
        bpl     @updatePlayfieldComplete
        jmp     @ret

@updatePlayfieldComplete:
        lda     tetriminoY
        sec
        sbc     #$02
        bpl     @yInRange
        lda     #$00
@yInRange:
        clc
        adc     lineIndex
        sta     generalCounter2
        asl     a
        sta     generalCounter
        asl     a
        asl     a
        clc
        adc     generalCounter
        sta     generalCounter
        tay
        ldx     #$0A
@checkIfRowComplete:
        lda     (playfieldAddr),y
        cmp     #tileEmpty
        beq     @rowNotComplete
        iny
        dex
        bne     @checkIfRowComplete
        lda     #$0A
        sta     soundEffectSlot1Init
        inc     completedLines
        ldx     lineIndex
        lda     generalCounter2
        sta     completedRow,x
        ldy     generalCounter
        dey
@movePlayfieldDownOneRow:
        lda     (playfieldAddr),y
        ldx     #$0A
        stx     playfieldAddr
        sta     (playfieldAddr),y
        lda     #$00
        sta     playfieldAddr
        dey
        cpy     #$FF
        bne     @movePlayfieldDownOneRow
        lda     #tileEmpty
        ldy     #$00
@clearRowTopRow:
        sta     (playfieldAddr),y
        iny
        cpy     #$0A
        bne     @clearRowTopRow
        lda     #hidden
        sta     currentPiece
        jmp     @incrementLineIndex

@rowNotComplete:
        ldx     lineIndex
        lda     #$00
        sta     completedRow,x
@incrementLineIndex:
        inc     lineIndex
        lda     lineIndex
        cmp     #$04
        bmi     @ret
        ldy     completedLines
        lda     garbageLines,y
        clc
        adc     pendingGarbageInactivePlayer
        sta     pendingGarbageInactivePlayer
        lda     #$00
        sta     vramRow
        sta     rowY
        lda     completedLines
        cmp     #$04
        bne     @skipTetrisSoundEffect
        lda     #$04
        sta     soundEffectSlot1Init
@skipTetrisSoundEffect:
        inc     playState
        lda     completedLines
        bne     @ret
        inc     playState
        lda     #$07
        sta     soundEffectSlot1Init
@ret:   rts

playState_receiveGarbage:
        lda     numberOfPlayers
        cmp     #$01
        beq     @ret
        ldy     pendingGarbage
        beq     @ret
        lda     vramRow
        cmp     #$20
        bmi     @delay
        lda     multBy10Table,y
        sta     generalCounter2
        lda     #$00
        sta     generalCounter
@shiftPlayfieldUp:
        ldy     generalCounter2
        lda     (playfieldAddr),y
        ldy     generalCounter
        sta     (playfieldAddr),y
        inc     generalCounter
        inc     generalCounter2
        lda     generalCounter2
        cmp     #$C8
        bne     @shiftPlayfieldUp
        iny
        ldx     #$00
@fillGarbage:
        cpx     garbageHole
        beq     @hole
        lda     #$78
        jmp     @set
@hole:
        lda     #$FF
@set:
        sta     (playfieldAddr),y
        inx
        cpx     #$0A
        bne     @inc
        ldx     #$00
@inc:   iny
        cpy     #$C8
        bne     @fillGarbage
        lda     #$00
        sta     pendingGarbage
        sta     vramRow
@ret:  inc     playState
@delay:  rts

garbageLines:
        .byte   $00,$00,$01,$02,$04
playState_updateLinesAndStatistics:
        jsr     updateMusicSpeed
        lda     completedLines
        bne     @linesCleared
        jmp     addHoldDownPoints

@linesCleared:
        tax
        dex
        lda     lineClearStatsByType,x
        clc
        adc     #$01
        sta     lineClearStatsByType,x
        and     #$0F
        cmp     #$0A
        bmi     @noCarry
        lda     lineClearStatsByType,x
        clc
        adc     #$06
        sta     lineClearStatsByType,x
@noCarry:
        lda     outOfDateRenderFlags
        ora     #RENDER_LINES
        sta     outOfDateRenderFlags
        lda     gameType
        beq     @gameTypeA
        lda     completedLines
        sta     generalCounter
        lda     lines
        sec
        sbc     generalCounter
        sta     lines
        bpl     @checkForBorrow
        lda     #$00
        sta     lines
        jmp     addHoldDownPoints

@checkForBorrow:
        and     #$0F
        cmp     #$0A
        bmi     addHoldDownPoints
        lda     lines
        sec
        sbc     #$06
        sta     lines
        jmp     addHoldDownPoints

@gameTypeA:
        ldx     completedLines
incrementLines:
        inc     lines
        lda     lines
        and     #$0F
        cmp     #$0A
        bmi     L9BC7
        lda     lines
        clc
        adc     #$06
        sta     lines
        and     #$F0
        cmp     #$A0
        bcc     L9BC7
        lda     lines
        and     #$0F
        sta     lines
        inc     lines+1
L9BC7:  lda     lines
        and     #$0F
.if NWC = 1
        beq     @incrementLevel
        cmp     #$05
        bne     L9BFB
        jmp     @incrementLevel
.else
        bne     L9BFB
        jmp     L9BD0

L9BD0:  lda     lines+1
        sta     generalCounter2
        lda     lines
        sta     generalCounter
        lsr     generalCounter2
        ror     generalCounter
        lsr     generalCounter2
        ror     generalCounter
        lsr     generalCounter2
        ror     generalCounter
        lsr     generalCounter2
        ror     generalCounter
        lda     levelNumber
        cmp     generalCounter
        bpl     L9BFB
.endif
@incrementLevel:
        inc     levelNumber
        lda     #$06
        sta     soundEffectSlot1Init
        lda     outOfDateRenderFlags
        ora     #RENDER_LEVEL
        sta     outOfDateRenderFlags
L9BFB:  dex
        bne     incrementLines
addHoldDownPoints:
.if NWC = 1
        sei
.endif
        lda     holdDownPoints
        cmp     #$02
        bmi     addLineClearPoints
        clc
        dec     score
        adc     score
        sta     score
        and     #$0F
        cmp     #$0A
        bcc     L9C18
        lda     score
        clc
        adc     #$06
        sta     score
L9C18:  lda     score
        and     #$F0
        cmp     #$A0
        bcc     L9C27
        clc
        adc     #$60
        sta     score
        inc     score+1
L9C27:  lda     outOfDateRenderFlags
        ora     #RENDER_SCORE
        sta     outOfDateRenderFlags
addLineClearPoints:
        lda     #$00
        sta     holdDownPoints
        lda     levelNumber
        sta     generalCounter
        inc     generalCounter
L9C37:  lda     completedLines
        asl     a
        tax
        lda     pointsTable,x
        clc
        adc     score
        sta     score
        cmp     #$A0
        bcc     L9C4E
        clc
        adc     #$60
        sta     score
        inc     score+1
L9C4E:  inx
        lda     pointsTable,x
        clc
        adc     score+1
        sta     score+1
        and     #$0F
        cmp     #$0A
        bcc     L9C64
        lda     score+1
        clc
        adc     #$06
        sta     score+1
L9C64:  lda     score+1
        and     #$F0
        cmp     #$A0
        bcc     L9C75
        lda     score+1
        clc
        adc     #$60
        sta     score+1
        inc     score+2
L9C75:  lda     score+2
        and     #$0F
        cmp     #$0A
        bcc     L9C84
        lda     score+2
        clc
        adc     #$06
        sta     score+2
L9C84:  lda     score+2
        and     #$F0
        cmp     #$A0
        bcc     L9C94
        lda     #$99
        sta     score
        sta     score+1
        sta     score+2
L9C94:  dec     generalCounter
        bne     L9C37
        lda     outOfDateRenderFlags
        ora     #RENDER_SCORE
        sta     outOfDateRenderFlags
        lda     #$00
        sta     completedLines
        inc     playState
.if NWC = 1
        cli
.endif
        rts

pointsTable:
        .word   $0000,$0040,$0100,$0300
        .word   $1200
updatePlayfield:
        ldx     tetriminoY
        dex
        dex
        txa
        bpl     @rowInRange
        lda     #$00
@rowInRange:
        cmp     vramRow
        bpl     @ret
        sta     vramRow
@ret:   rts

gameModeState_handleGameOver:
        lda     #$05
        sta     generalCounter2
        lda     player1_playState
        cmp     #$00
        beq     @gameOver
        lda     numberOfPlayers
        cmp     #$01
        beq     @ret
        lda     #$04
        sta     generalCounter2
        lda     player2_playState
        cmp     #$00
        bne     @ret
@gameOver:
        lda     numberOfPlayers
        cmp     #$01
        beq     @onePlayerGameOver
        lda     #$09
        sta     gameModeState
        rts

@onePlayerGameOver:
        lda     #$03
        sta     renderMode
        lda     numberOfPlayers
        cmp     #$01
        bne     @resetGameState
        jsr     handleHighScoreIfNecessary
@resetGameState:
        lda     #$01
        sta     player1_playState
        sta     player2_playState
        lda     #tileEmpty
        ldx     #>playfield
        ldy     #>playfieldForSecondPlayer
        jsr     memset_page
        lda     #$00
        sta     player1_vramRow
        sta     player2_vramRow
        lda     #$01
        sta     player1_playState
        sta     player2_playState
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$03
        sta     gameMode
        rts

@ret:   inc     gameModeState
        rts

updateMusicSpeed:
        ldx     #$05
        lda     multBy10Table,x
        tay
        ldx     #$0A
@checkForBlockInRow:
        lda     (playfieldAddr),y
        cmp     #tileEmpty
        bne     @foundBlockInRow
        iny
        dex
        bne     @checkForBlockInRow
        lda     allegro
        beq     @ret
        lda     #$00
        sta     allegro
        ldx     musicType
        lda     musicSelectionTable,x
        jsr     setMusicTrack
        jmp     @ret

@foundBlockInRow:
        lda     allegro
        bne     @ret
        lda     #$FF
        sta     allegro
        lda     musicType
        clc
        adc     #$04
        tax
        lda     musicSelectionTable,x
        jsr     setMusicTrack
@ret:   rts

pollControllerButtons:
        lda     gameMode
        cmp     #$05
        beq     @demoGameMode
        jsr     pollController
        rts

@demoGameMode:
        lda     $D0
        cmp     #$FF
        beq     @recording
        jsr     pollController
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        beq     @startButtonPressed
        lda     demo_repeats
        beq     @finishedMove
        dec     demo_repeats
        jmp     @moveInProgress

@finishedMove:
        ldx     #$00
        lda     (demoButtonsAddr,x)
        sta     generalCounter
        jsr     demoButtonsTable_indexIncr
        lda     demo_heldButtons
        eor     generalCounter
        and     generalCounter
        sta     newlyPressedButtons_player1
        lda     generalCounter
        sta     demo_heldButtons
        ldx     #$00
        lda     (demoButtonsAddr,x)
        sta     demo_repeats
        jsr     demoButtonsTable_indexIncr
        lda     demoButtonsAddr+1
        cmp     #>demoTetriminoTypeTable
        beq     @ret
        jmp     @holdButtons

@moveInProgress:
        lda     #$00
        sta     newlyPressedButtons_player1
@holdButtons:
        lda     demo_heldButtons
        sta     heldButtons_player1
@ret:   rts

@startButtonPressed:
        lda     #>demoButtonsTable
        sta     demoButtonsAddr+1
        lda     #$00
        sta     frameCounter+1
        lda     #$01
        sta     gameMode
        rts

@recording:
        jsr     pollController
.if PAL = 1
        lda     heldButtons_player1
        and     #$DF
        sta     heldButtons_player1
.endif
        lda     gameMode
        cmp     #$05
        bne     @ret2
        lda     $D0
        cmp     #$FF
        bne     @ret2
        lda     heldButtons_player1
        cmp     demo_heldButtons
        beq     @buttonsNotChanged
        ldx     #$00
        lda     demo_heldButtons
        sta     (demoButtonsAddr,x)
        jsr     demoButtonsTable_indexIncr
        lda     demo_repeats
        sta     (demoButtonsAddr,x)
        jsr     demoButtonsTable_indexIncr
        lda     demoButtonsAddr+1
        cmp     #>demoTetriminoTypeTable
        beq     @ret2
        lda     heldButtons_player1
        sta     demo_heldButtons
        lda     #$00
        sta     demo_repeats
        rts

@buttonsNotChanged:
        inc     demo_repeats
        rts

@ret2:  rts

demoButtonsTable_indexIncr:
        lda     demoButtonsAddr
        clc
        adc     #$01
        sta     demoButtonsAddr
        lda     #$00
        adc     demoButtonsAddr+1
        sta     demoButtonsAddr+1
        rts

gameMode_startDemo:
        lda     #$00
        sta     gameType
        sta     player1_startLevel
        sta     gameModeState
        sta     player1_playState
        lda     #$05
        sta     gameMode
        jmp     gameMode_playAndEndingHighScore_jmp

; canon is adjustMusicSpeed
setMusicTrack:
        sta     musicTrack
        lda     gameMode
        cmp     #$05
        bne     @ret
        lda     #$FF
        sta     musicTrack
@ret:   rts

; A+B+Select+Start
gameModeState_checkForResetKeyCombo:
.if NWC <> 1
        lda     heldButtons_player1
        cmp     #BUTTON_A+BUTTON_B+BUTTON_SELECT+BUTTON_START
        beq     @reset
.endif
        inc     gameModeState
        rts

@reset: jsr     updateAudio2
        lda     #$00
        sta     gameMode
        rts

; It looks like the jsr _must_ do nothing, otherwise reg a != gameModeState in mainLoop and there would not be any waiting on vsync
gameModeState_vblankThenRunState2:
        lda     #$02
        sta     gameModeState
        jsr     noop_disabledVramRowIncr
        rts

playState_unassignOrientationId:
        lda     #hidden
        sta     currentPiece
        rts

        inc     gameModeState
        rts

playState_incrementPlayState:
        inc     playState
playState_noop:
        rts

endingAnimation:
        lda     #$02
        sta     spriteIndexInOamContentLookup
        lda     #$04
        sta     renderMode
        lda     gameType
        bne     endingAnimationB
        jmp     endingAnimationA

bTypeLevelBonus := generalCounter4
bTypeHeightBonus := generalCounter5

endingAnimationB:
        ldx     player1_levelNumber
        lda     levelDisplayTable,x
        and     #$0F
        sta     levelNumber
        lda     #$00
        sta     totalScore+2
        sta     totalScore+1
        sta     totalScore
        lda     levelNumber
        asl     a
        asl     a
        asl     a
        asl     a
        sta     bTypeLevelBonus
        lda     player1_startHeight
        asl     a
        asl     a
        asl     a
        asl     a
        sta     bTypeHeightBonus
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        lda     levelNumber
        cmp     #$09
        bne     @checkPenguinOrOstrichEnding
        ; castle ending for level 9/19
        lda     #CHR_TYPEB_ENDING
        jsr     changeCHRBank0
        lda     #CHR_TYPEB_ENDING
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   type_b_lvl9_ending_nametable
        jmp     @startAnimation

@checkPenguinOrOstrichEnding:
        ldx     #CHR_GAME
        lda     levelNumber
        cmp     #$02    ; Penguin ending for level 2/12
        beq     @normalEnding
        cmp     #$06    ; Ostrich for 6/16
        beq     @normalEnding
        ldx     #CHR_TYPEA_ENDING
@normalEnding:
        txa
        jsr     changeCHRBank0
        lda     #CHR_TYPEA_ENDING
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   type_b_ending_nametable
@startAnimation:
        jsr     bulkCopyToPpu
        .addr   ending_palette
        jsr     ending_initTypeBVars
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$04
        sta     renderMode
        lda     #$0A
        jsr     setMusicTrack
        lda     #ENDING_SLEEP_TIME_1
        jsr     render_endingUnskippable
        lda     player1_score
        sta     totalScore
        lda     player1_score+1
        sta     totalScore+1
        lda     player1_score+2
        sta     totalScore+2
        lda     #$02
        sta     soundEffectSlot1Init
        lda     #$00
        sta     player1_score
        sta     player1_score+1
        sta     player1_score+2
        lda     #ENDING_SLEEP_TIME_2
        jsr     render_endingUnskippable
        lda     bTypeLevelBonus
        beq     @checkForHeightBonus
@addLevelBonus:
        dec     bTypeLevelBonus
        lda     bTypeLevelBonus
        and     #$0F
        cmp     #$0F
        bne     @noLevelCarry
        lda     bTypeLevelBonus
        and     #$F0
        ora     #$09
        sta     bTypeLevelBonus
@noLevelCarry:
        lda     bTypeLevelBonus
        jsr     add100Points
        lda     #$01
        sta     soundEffectSlot1Init
        lda     #ENDING_SLEEP_TIME_3
        jsr     render_endingUnskippable
        lda     bTypeLevelBonus
        bne     @addLevelBonus
        lda     #ENDING_SLEEP_TIME_2
        jsr     render_endingUnskippable
@checkForHeightBonus:
        lda     bTypeHeightBonus
        beq     @startNotPressed
@addHeightBonus:
        dec     bTypeHeightBonus
        lda     bTypeHeightBonus
        and     #$0F
        cmp     #$0F
        bne     @noHeightCarry
        lda     bTypeHeightBonus
        and     #$F0
        ora     #$09
        sta     bTypeHeightBonus
@noHeightCarry:
        lda     bTypeHeightBonus
        jsr     add100Points
        lda     #$01
        sta     soundEffectSlot1Init
        lda     #ENDING_SLEEP_TIME_3
        jsr     render_endingUnskippable
        lda     bTypeHeightBonus
        bne     @addHeightBonus
        lda     #$02
        sta     soundEffectSlot1Init
        lda     #ENDING_SLEEP_TIME_2
        jsr     render_endingUnskippable
@startNotPressed:
        jsr     render_ending
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        bne     @startNotPressed
        lda     player1_levelNumber
        sta     levelNumber
        lda     totalScore
        sta     score
        lda     totalScore+1
        sta     score+1
        lda     totalScore+2
        sta     score+2
        rts

add100Points:
        lda     #$01
        clc
        adc     totalScore+1
        sta     totalScore+1
        and     #$0F
        cmp     #$0A
        bcc     L9F76
        lda     totalScore+1
        clc
        adc     #$06
        sta     totalScore+1
L9F76:  and     #$F0
        cmp     #$A0
        bcc     L9F85
        lda     totalScore+1
        clc
        adc     #$60
        sta     totalScore+1
        inc     totalScore+2
L9F85:  lda     totalScore+2
        and     #$0F
        cmp     #$0A
        bcc     L9F94
        lda     totalScore+2
        clc
        adc     #$06
        sta     totalScore+2
L9F94:  rts

render_mode_ending_animation:
        lda     #$20
        sta     PPUADDR
        lda     #$8E
        sta     PPUADDR
        lda     player1_score+2
        jsr     twoDigsToPPU
        lda     player1_score+1
        jsr     twoDigsToPPU
        lda     player1_score
        jsr     twoDigsToPPU
        lda     gameType
        beq     L9FE9
        lda     #$20
        sta     PPUADDR
        lda     #$B0
        sta     PPUADDR
        lda     generalCounter4
        jsr     twoDigsToPPU
        lda     #$20
        sta     PPUADDR
        lda     #$D0
        sta     PPUADDR
        lda     generalCounter5
        jsr     twoDigsToPPU
        lda     #$21
        sta     PPUADDR
        lda     #$2E
        sta     PPUADDR
        lda     totalScore+2
        jsr     twoDigsToPPU
        lda     totalScore+1
        jsr     twoDigsToPPU
        lda     totalScore
        jsr     twoDigsToPPU
L9FE9:  ldy     #$00
        sty     PPUSCROLL
        sty     PPUSCROLL
        rts

showHighScores:
        lda     numberOfPlayers
        cmp     #$01
        beq     showHighScores_real
        jmp     showHighScores_ret

showHighScores_real:
        jsr     bulkCopyToPpu
        .addr   high_scores_nametable
        lda     #$00
        sta     generalCounter2
        lda     gameType
        beq     @copyEntry
        lda     #$04
        sta     generalCounter2
@copyEntry:
        lda     generalCounter2
        and     #$03
        asl     a
        tax
        lda     highScorePpuAddrTable,x
        sta     PPUADDR
        lda     generalCounter2
        and     #$03
        asl     a
        tax
        inx
        lda     highScorePpuAddrTable,x
        sta     PPUADDR
        lda     generalCounter2
        asl     a
        sta     generalCounter
        asl     a
        clc
        adc     generalCounter
        tay
        ldx     #$06
@copyChar:
        lda     highScoreNames,y
        sty     generalCounter
        tay
        lda     highScoreCharToTile,y
        ldy     generalCounter
        sta     PPUDATA
        iny
        dex
        bne     @copyChar
        lda     #$FF
        sta     PPUDATA
        lda     generalCounter2
        sta     generalCounter
        asl     a
        clc
        adc     generalCounter
        tay
        lda     highScoreScoresA,y
        jsr     twoDigsToPPU
        iny
        lda     highScoreScoresA,y
        jsr     twoDigsToPPU
        iny
        lda     highScoreScoresA,y
        jsr     twoDigsToPPU
        lda     #$FF
        sta     PPUDATA
        ldy     generalCounter2
        lda     highScoreLevels,y
        tax
        lda     byteToBcdTable,x
        jsr     twoDigsToPPU
        inc     generalCounter2
        lda     generalCounter2
        cmp     #$03
        beq     showHighScores_ret
        cmp     #$07
        beq     showHighScores_ret
        jmp     @copyEntry

showHighScores_ret:  rts

highScorePpuAddrTable:
        .dbyt   $2289,$22C9,$2309
highScoreCharToTile:
        .byte   $24,$0A,$0B,$0C,$0D,$0E,$0F,$10
        .byte   $11,$12,$13,$14,$15,$16,$17,$18
        .byte   $19,$1A,$1B,$1C,$1D,$1E,$1F,$20
        .byte   $21,$22,$23,$00,$01,$02,$03,$04
        .byte   $05,$06,$07,$08,$09,$25,$4F,$5E
        .byte   $5F,$6E,$6F,$FF
unreferenced_data7:
        .byte   $00,$00,$00,$00
; maxes out at 49
byteToBcdTable:
        .byte   $00,$01,$02,$03,$04,$05,$06,$07
        .byte   $08,$09,$10,$11,$12,$13,$14,$15
        .byte   $16,$17,$18,$19,$20,$21,$22,$23
        .byte   $24,$25,$26,$27,$28,$29,$30,$31
        .byte   $32,$33,$34,$35,$36,$37,$38,$39
        .byte   $40,$41,$42,$43,$44,$45,$46,$47
        .byte   $48,$49
; Adjusts high score table and handles data entry, if necessary
handleHighScoreIfNecessary:
        lda     #$00
        sta     highScoreEntryRawPos
        lda     gameType
        beq     @compareWithPos
        lda     #$04
        sta     highScoreEntryRawPos
@compareWithPos:
        lda     highScoreEntryRawPos
        sta     generalCounter2
        asl     a
        clc
        adc     generalCounter2
        tay
        lda     highScoreScoresA,y
        cmp     player1_score+2
        beq     @checkHundredsByte
        bcs     @tooSmall
        bcc     adjustHighScores
@checkHundredsByte:
        iny
        lda     highScoreScoresA,y
        cmp     player1_score+1
        beq     @checkOnesByte
        bcs     @tooSmall
        bcc     adjustHighScores
; This breaks ties by prefering the new score
@checkOnesByte:
        iny
        lda     highScoreScoresA,y
        cmp     player1_score
        beq     adjustHighScores
        bcc     adjustHighScores
@tooSmall:
        inc     highScoreEntryRawPos
        lda     highScoreEntryRawPos
        cmp     #$03
        beq     @ret
        cmp     #$07
        beq     @ret
        jmp     @compareWithPos

@ret:   rts

adjustHighScores:
        lda     highScoreEntryRawPos
        and     #$03
        cmp     #$02
        bpl     @doneMovingOldScores
        lda     #$06
        jsr     copyHighScoreNameToNextIndex
        lda     #$03
        jsr     copyHighScoreScoreToNextIndex
        lda     #$01
        jsr     copyHighScoreLevelToNextIndex
        lda     highScoreEntryRawPos
        and     #$03
        bne     @doneMovingOldScores
        lda     #$00
        jsr     copyHighScoreNameToNextIndex
        lda     #$00
        jsr     copyHighScoreScoreToNextIndex
        lda     #$00
        jsr     copyHighScoreLevelToNextIndex
@doneMovingOldScores:
        ldx     highScoreEntryRawPos
        lda     highScoreIndexToHighScoreNamesOffset,x
        tax
        ldy     #$06
        lda     #$00
@clearNameLetter:
        sta     highScoreNames,x
        inx
        dey
        bne     @clearNameLetter
        ldx     highScoreEntryRawPos
        lda     highScoreIndexToHighScoreScoresOffset,x
        tax
        lda     player1_score+2
        sta     highScoreScoresA,x
        inx
        lda     player1_score+1
        sta     highScoreScoresA,x
        inx
        lda     player1_score
        sta     highScoreScoresA,x
        ldx     highScoreEntryRawPos
        lda     player1_levelNumber
        sta     highScoreLevels,x
        jmp     highScoreEntryScreen

; reg a: start byte to copy
copyHighScoreNameToNextIndex:
        sta     generalCounter
        lda     gameType
        beq     @offsetAdjustedForGameType
        lda     #$18
        clc
        adc     generalCounter
        sta     generalCounter
@offsetAdjustedForGameType:
        lda     #$05
        sta     generalCounter2
@copyLetter:
        lda     generalCounter
        clc
        adc     generalCounter2
        tax
        lda     highScoreNames,x
        sta     generalCounter3
        txa
        clc
        adc     #$06
        tax
        lda     generalCounter3
        sta     highScoreNames,x
        dec     generalCounter2
        lda     generalCounter2
        cmp     #$FF
        bne     @copyLetter
        rts

; reg a: start byte to copy
copyHighScoreScoreToNextIndex:
        tax
        lda     gameType
        beq     @xAdjustedForGameType
        txa
        clc
        adc     #$0C
        tax
@xAdjustedForGameType:
        lda     highScoreScoresA,x
        sta     highScoreScoresA+3,x
        inx
        lda     highScoreScoresA,x
        sta     highScoreScoresA+3,x
        inx
        lda     highScoreScoresA,x
        sta     highScoreScoresA+3,x
        rts

; reg a: start byte to copy
copyHighScoreLevelToNextIndex:
        tax
        lda     gameType
        beq     @xAdjustedForGameType
        txa
        clc
        adc     #$04
        tax
@xAdjustedForGameType:
        lda     highScoreLevels,x
        sta     highScoreLevels+1,x
        rts

highScoreIndexToHighScoreNamesOffset:
        .byte   $00,$06,$0C,$12,$18,$1E,$24,$2A
highScoreIndexToHighScoreScoresOffset:
        .byte   $00,$03,$06,$09,$0C,$0F,$12,$15
highScoreEntryScreen:
        inc     initRam
.if NWC = 1
        lda     #$00
.else
        lda     #MMC1_4KCHR_32KPRG_H_MIRROR
.endif
        jsr     setMMC1Control
        lda     #$09
        jsr     setMusicTrack
        lda     #$02
        sta     renderMode
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank0
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   menu_palette
        jsr     bulkCopyToPpu
        .addr   enter_high_score_nametable
        lda     #$20
        sta     PPUADDR
        lda     #$6D
        sta     PPUADDR
        lda     #$0A
        clc
        adc     gameType
        sta     PPUDATA
        jsr     showHighScores
        lda     #$02
        sta     renderMode
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     highScoreEntryRawPos
        asl     a
        sta     generalCounter
        asl     a
        clc
        adc     generalCounter
        sta     highScoreEntryNameOffsetForRow
        lda     #$00
        sta     highScoreEntryNameOffsetForLetter
        sta     oamStaging
        lda     highScoreEntryRawPos
        and     #$03
        tax
        lda     highScorePosToY,x
        sta     spriteYOffset
@renderFrame:
        lda     #$00
        sta     oamStaging
        ldx     highScoreEntryNameOffsetForLetter
        lda     highScoreNamePosToX,x
        sta     spriteXOffset
        lda     #$0E
        sta     spriteIndexInOamContentLookup
        lda     frameCounter
        and     #MENU_CURSOR_MASK
        bne     @flickerStateSelected_checkForStartPressed
        lda     #$02
        sta     spriteIndexInOamContentLookup
@flickerStateSelected_checkForStartPressed:
        jsr     loadSpriteIntoOamStaging
        lda     newlyPressedButtons_player1
        and     #BUTTON_START
        beq     @checkForAOrRightPressed
        lda     #$02
        sta     soundEffectSlot1Init
        jmp     @ret

@checkForAOrRightPressed:
        lda     newlyPressedButtons_player1
        and     #BUTTON_A+BUTTON_RIGHT
        beq     @checkForBOrLeftPressed
        lda     #$01
        sta     soundEffectSlot1Init
        inc     highScoreEntryNameOffsetForLetter
        lda     highScoreEntryNameOffsetForLetter
        cmp     #$06
        bmi     @checkForBOrLeftPressed
        lda     #$00
        sta     highScoreEntryNameOffsetForLetter
@checkForBOrLeftPressed:
        lda     newlyPressedButtons_player1
        and     #BUTTON_B+BUTTON_LEFT
        beq     @checkForDownPressed
        lda     #$01
        sta     soundEffectSlot1Init
        dec     highScoreEntryNameOffsetForLetter
        lda     highScoreEntryNameOffsetForLetter
        bpl     @checkForDownPressed
        lda     #$05
        sta     highScoreEntryNameOffsetForLetter
@checkForDownPressed:
        lda     heldButtons_player1
        and     #BUTTON_DOWN
        beq     @checkForUpPressed
        lda     frameCounter
        and     #$07
        bne     @checkForUpPressed
        lda     #$01
        sta     soundEffectSlot1Init
        lda     highScoreEntryNameOffsetForRow
        sta     generalCounter
        clc
        adc     highScoreEntryNameOffsetForLetter
        tax
        lda     highScoreNames,x
        sta     generalCounter
        dec     generalCounter
        lda     generalCounter
        bpl     @letterDoesNotUnderflow
        clc
        adc     #$2C
        sta     generalCounter
@letterDoesNotUnderflow:
        lda     generalCounter
        sta     highScoreNames,x
@checkForUpPressed:
        lda     heldButtons_player1
        and     #BUTTON_UP
        beq     @waitForVBlank
        lda     frameCounter
        and     #$07
        bne     @waitForVBlank
        lda     #$01
        sta     soundEffectSlot1Init
        lda     highScoreEntryNameOffsetForRow
        sta     generalCounter
        clc
        adc     highScoreEntryNameOffsetForLetter
        tax
        lda     highScoreNames,x
        sta     generalCounter
        inc     generalCounter
        lda     generalCounter
        cmp     #$2C
        bmi     @letterDoesNotOverflow
        sec
        sbc     #$2C
        sta     generalCounter
@letterDoesNotOverflow:
        lda     generalCounter
        sta     highScoreNames,x
@waitForVBlank:
        lda     highScoreEntryNameOffsetForRow
        clc
        adc     highScoreEntryNameOffsetForLetter
        tax
        lda     highScoreNames,x
        sta     highScoreEntryCurrentLetter
        lda     #RENDER_HIGH_SCORE_LETTER
        sta     outOfDateRenderFlags
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jmp     @renderFrame

@ret:   jsr     updateAudioWaitForNmiAndResetOamStaging
        rts

highScorePosToY:
        .byte   $9F,$AF,$BF
highScoreNamePosToX:
        .byte   $48,$50,$58,$60,$68,$70
render_mode_congratulations_screen:
        lda     outOfDateRenderFlags
        and     #RENDER_HIGH_SCORE_LETTER
        beq     @ret
        lda     highScoreEntryRawPos
        and     #$03
        asl     a
        tax
        lda     highScorePpuAddrTable,x
        sta     PPUADDR
        lda     highScoreEntryRawPos
        and     #$03
        asl     a
        tax
        inx
        lda     highScorePpuAddrTable,x
        sta     generalCounter
        clc
        adc     highScoreEntryNameOffsetForLetter
        sta     PPUADDR
        ldx     highScoreEntryCurrentLetter
        lda     highScoreCharToTile,x
        sta     PPUDATA
        lda     #$00
        sta     ppuScrollX
        sta     PPUSCROLL
        sta     ppuScrollY
        sta     PPUSCROLL
        sta     outOfDateRenderFlags
@ret:   rts

; Handles pausing and exiting demo
gameModeState_startButtonHandling:
.if NWC = 1
        jmp     @ret
.endif
        lda     gameMode
        cmp     #$05
        bne     @checkIfInGame
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        bne     @checkIfInGame
        lda     #$01
        sta     gameMode
        jmp     @ret

@checkIfInGame:
        lda     renderMode
        cmp     #$03
        bne     @ret
        lda     newlyPressedButtons_player1
        and     #BUTTON_START
        bne     @startPressed
        jmp     @ret

; Do nothing if curtain is being lowered
@startPressed:
        lda     player1_playState
        cmp     #$0A
        bne     @pause
        jmp     @ret

@pause: lda     #$05
        sta     musicStagingNoiseHi
        lda     #$00
        sta     renderMode
        jsr     updateAudioAndWaitForNmi
.if NWC <> 1
        lda     #$16
        sta     PPUMASK
.endif
        lda     #$FF
        ldx     #>oamStaging
        ldy     #>oamStaging
        jsr     memset_page
@pauseLoop:
        lda     #$70
        sta     spriteXOffset
        lda     #$77
        sta     spriteYOffset
        lda     #$05
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        beq     @resume
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jmp     @pauseLoop

@resume:
.if NWC <> 1
        lda     #$1E
        sta     PPUMASK
.endif
        lda     #$00
        sta     musicStagingNoiseHi
        sta     player1_vramRow
        lda     #$03
        sta     renderMode
@ret:   inc     gameModeState
        rts

playState_bTypeGoalCheck:
        lda     gameType
.if PAL = 1
        beq     checkSelectHeldToAddPoints
        lda     heldButtons_player1
        and     #BUTTON_SELECT
        bne     @gameOver
.else
        beq     playState_bTypeGoalCheck_ret
.endif
        lda     lines
        bne     playState_bTypeGoalCheck_ret
@gameOver:
        lda     #$02
        jsr     setMusicTrack
        ldy     #$46
        ldx     #$00
@copySuccessGraphic:
        lda     typebSuccessGraphic,x
        cmp     #$80
        beq     @graphicCopied
        sta     (playfieldAddr),y
        inx
        iny
        jmp     @copySuccessGraphic

@graphicCopied:
        lda     #$00
        sta     player1_vramRow
        jsr     sleep_for_14_vblanks
        lda     #$00
        sta     renderMode
        lda     #$80
        jsr     sleep_for_a_vblanks
        jsr     endingAnimation
        lda     #$00
        sta     playState
        inc     gameModeState
        rts

playState_bTypeGoalCheck_ret:
        inc     playState
        rts

typebSuccessGraphic:
        .byte   $38,$39,$39,$39,$39,$39,$39,$39
        .byte   $39,$3A,$3B,$1C,$1E,$0C,$0C,$0E
        .byte   $1C,$1C,$28,$3C,$3D,$3E,$3E,$3E
        .byte   $3E,$3E,$3E,$3E,$3E,$3F,$80
sleep_for_14_vblanks:
        lda     #$14
        sta     sleepCounter
@loop:  jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     sleepCounter
        bne     @loop
        rts

sleep_for_a_vblanks:
        sta     sleepCounter
@loop:  jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     sleepCounter
        bne     @loop
        rts

.if PAL = 1
checkSelectHeldToAddPoints:
        lda     heldButtons_player1
        and     #BUTTON_SELECT
        beq     playState_bTypeGoalCheck_ret
        inc     score+2
        inc     player1_score+2
        lda     outOfDateRenderFlags
        ora     #RENDER_SCORE
        sta     outOfDateRenderFlags
        jmp     playState_bTypeGoalCheck_ret
.endif


ending_initTypeBVars:
        lda     #$00
        sta     ending
        sta     ending_customVars
        sta     ending_typeBCathedralFrameDelayCounter
        lda     #$02
        sta     spriteIndexInOamContentLookup
        lda     levelNumber
        cmp     #$09
        bne     @notLevel9
        lda     player1_startHeight
        clc
        adc     #$01
        sta     ending
        jsr     ending_typeBConcertPatchToPpuForHeight
        lda     #$00
        sta     ending
        sta     ending_customVars+2
        lda     LA73D
        sta     ending_customVars+3
        lda     LA73E
        sta     ending_customVars+4
        lda     LA73F
        sta     ending_customVars+5
        lda     LA740
        sta     ending_customVars+6
        rts

@notLevel9:
        ldx     levelNumber
        lda     LA767,x
        sta     ending_customVars+2
        sta     ending_customVars+3
        sta     ending_customVars+4
        sta     ending_customVars+5
        sta     ending_customVars+6
        ldx     levelNumber
        lda     LA75D,x
        sta     ending_customVars+1
        rts

ending_typeBConcertPatchToPpuForHeight:
        lda     ending
        jsr     switch_s_plus_2a
        .addr   @heightUnused
        .addr   @height0
        .addr   @height1
        .addr   @height2
        .addr   @height3
        .addr   @height4
        .addr   @height5
@heightUnused:
        lda     #>ending_patchToPpu_typeBConcertHeightUnused
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeBConcertHeightUnused
        sta     patchToPpuAddr
        jsr     patchToPpu
@height0:
        lda     #>ending_patchToPpu_typeBConcertHeight0
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeBConcertHeight0
        sta     patchToPpuAddr
        jsr     patchToPpu
@height1:
        lda     #>ending_patchToPpu_typeBConcertHeight1
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeBConcertHeight1
        sta     patchToPpuAddr
        jsr     patchToPpu
@height2:
        lda     #>ending_patchToPpu_typeBConcertHeight2
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeBConcertHeight2
        sta     patchToPpuAddr
        jsr     patchToPpu
@height3:
        lda     #>ending_patchToPpu_typeBConcertHeight3
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeBConcertHeight3
        sta     patchToPpuAddr
        jsr     patchToPpu
@height4:
        lda     #>ending_patchToPpu_typeBConcertHeight4
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeBConcertHeight4
        sta     patchToPpuAddr
        jsr     patchToPpu
@height5:
        rts

patchToPpu:
        ldy     #$00
@patchAddr:
        lda     (patchToPpuAddr),y
        sta     PPUADDR
        iny
        lda     (patchToPpuAddr),y
        sta     PPUADDR
        iny
@patchValue:
        lda     (patchToPpuAddr),y
        iny
        cmp     #$FE
        beq     @patchAddr
        cmp     #$FD
        beq     @ret
        sta     PPUDATA
        jmp     @patchValue

@ret:   rts

render_ending:
        lda     gameType
        bne     ending_typeB
        jmp     ending_typeA

ending_typeB:
        lda     levelNumber
        cmp     #$09
        beq     @typeBConcert
        jmp     ending_typeBCathedral

@typeBConcert:
        jsr     ending_typeBConcert
        rts

ending_typeBConcert:
        lda     player1_startHeight
        jsr     switch_s_plus_2a
        .addr   @kidIcarus
        .addr   @link
        .addr   @samus
        .addr   @donkeyKong
        .addr   @bowser
        .addr   @marioLuigiPeach
@marioLuigiPeach:
        lda     #$C8
        sta     spriteXOffset
        lda     #$47
        sta     spriteYOffset
        lda     frameCounter
.if PAL = 1
        and     #$04
.else
        and     #$08
        lsr     a
.endif
        lsr     a
        lsr     a
        clc
        adc     #$21
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
        lda     #$A0
        sta     spriteXOffset
        lda     #$27
        sta     spriteIndexInOamContentLookup
        lda     frameCounter
        and     #$18
        lsr     a
        lsr     a
        lsr     a
        tax
        lda     marioFrameToYOffsetTable,x
        sta     spriteYOffset
        cmp     #$97
        beq     @marioFrame1
        lda     #$28
        sta     spriteIndexInOamContentLookup
@marioFrame1:
        jsr     loadSpriteIntoOamStaging
@luigiCalculateFrame:
        lda     #$C0
        sta     spriteXOffset
        lda     ending
        lsr     a
        lsr     a
        lsr     a
        cmp     #$0A
        bne     @luigiFrameCalculated
        lda     #$00
        sta     ending
        inc     ending_customVars
        jmp     @luigiCalculateFrame

@luigiFrameCalculated:
        tax
        lda     luigiFrameToYOffsetTable,x
        sta     spriteYOffset
        lda     luigiFrameToSpriteTable,x
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
        inc     ending
@bowser:lda     #$30
        sta     spriteXOffset
        lda     #$A7
        sta     spriteYOffset
        lda     frameCounter
.if PAL = 1
        and     #$08
.else
        and     #$10
        lsr     a
.endif
        lsr     a
        lsr     a
        lsr     a
        clc
        adc     #$1F
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
@donkeyKong:
        lda     #$40
        sta     spriteXOffset
        lda     #$77
        sta     spriteYOffset
        lda     frameCounter
        and     #$10
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        clc
        adc     #$1D
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
@samus: lda     #$A8
        sta     spriteXOffset
        lda     #$D7
        sta     spriteYOffset
        lda     frameCounter
.if PAL = 1
        and     #$08
.else
        and     #$10
        lsr     a
.endif
        lsr     a
        lsr     a
        lsr     a
        clc
        adc     #$1A
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
@link:  lda     #$C8
        sta     spriteXOffset
        lda     #$D7
        sta     spriteYOffset
        lda     frameCounter
.if PAL = 1
        and     #$08
.else
        and     #$10
        lsr     a
.endif
        lsr     a
        lsr     a
        lsr     a
        clc
        adc     #$18
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
@kidIcarus:
        lda     #$28
        sta     spriteXOffset
        lda     #$77
        sta     spriteYOffset
        lda     frameCounter
.if PAL = 1
        and     #$08
.else
        and     #$10
        lsr     a
.endif
        lsr     a
        lsr     a
        lsr     a
        clc
        adc     #$16
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
        jsr     LA6BC
        rts

ending_typeBCathedral:
        jsr     ending_typeBCathedralSetSprite
        inc     ending_typeBCathedralFrameDelayCounter
        lda     #$00
        sta     ending_currentSprite
@spriteLoop:
        ldx     levelNumber
        lda     LA767,x
        sta     generalCounter
        ldx     ending_currentSprite
        lda     ending_customVars+1,x
        cmp     generalCounter
        beq     @continue
        sta     spriteXOffset
        jsr     ending_computeTypeBCathedralYTableIndex
        lda     ending_typeBCathedralYTable,x
        sta     spriteYOffset
        jsr     loadSpriteIntoOamStaging
        ldx     levelNumber
        lda     ending_typeBCathedralFrameDelayTable,x
        cmp     ending_typeBCathedralFrameDelayCounter
        bne     @continue
        ldx     levelNumber
        lda     ending_typeBCathedralVectorTable,x
        clc
        adc     spriteXOffset
        sta     spriteXOffset
        ldx     ending_currentSprite
        sta     ending_customVars+1,x
        jsr     ending_computeTypeBCathedralYTableIndex
        lda     ending_typeBCathedralXTable,x
        cmp     spriteXOffset
        bne     @continue
        ldx     levelNumber
        lda     LA75D,x
        ldx     ending_currentSprite
        inx
        sta     ending_customVars+1,x
@continue:
        lda     ending_currentSprite
        sta     generalCounter
        cmp     startHeight
        beq     @done
        inc     ending_currentSprite
        jmp     @spriteLoop

@done:  ldx     levelNumber
        lda     ending_typeBCathedralFrameDelayTable,x
        cmp     ending_typeBCathedralFrameDelayCounter
        bne     @ret
        lda     #$00
        sta     ending_typeBCathedralFrameDelayCounter
@ret:   rts

ending_typeBCathedralSetSprite:
        inc     ending
        ldx     levelNumber
        lda     ending_typeBCathedralAnimSpeed,x
        cmp     ending
        bne     @skipAnimSpriteChange
        lda     ending_customVars
        eor     #$01
        sta     ending_customVars
        lda     #$00
        sta     ending
@skipAnimSpriteChange:
        lda     ending_typeBCathedralSpriteTable,x
        clc
        adc     ending_customVars
        sta     spriteIndexInOamContentLookup
        rts

; levelNumber * 6 + currentEndingBSprite
ending_computeTypeBCathedralYTableIndex:
        lda     levelNumber
        asl     a
        sta     generalCounter
        asl     a
        clc
        adc     generalCounter
        clc
        adc     ending_currentSprite
        tax
        rts

LA6BC:  ldx     #$00
LA6BE:  lda     LA735,x
        cmp     ending_customVars
        bne     LA6D0
        lda     ending_customVars+3,x
        beq     LA6D0
        sec
        sbc     #$01
        sta     ending_customVars+3,x
        inc     ending_customVars
LA6D0:  inx
        cpx     #$04
        bne     LA6BE
        lda     #$00
        sta     ending_currentSprite
LA6D9:  ldx     ending_currentSprite
        lda     ending_customVars+3,x
        beq     LA72C
        sta     generalCounter
        lda     LA73D,x
        cmp     generalCounter
        beq     LA6F7
        lda     #$03
        sta     soundEffectSlot0Init
        dec     generalCounter
        lda     generalCounter
        cmp     #$A0
        bcs     LA6F7
        dec     generalCounter
LA6F7:  lda     generalCounter
        sta     ending_customVars+3,x
        sta     spriteYOffset
        lda     domeNumberToXOffsetTable,x
        sta     spriteXOffset
        lda     domeNumberToSpriteTable,x
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
        ldx     ending_currentSprite
        lda     ending_customVars+3,x
        sta     generalCounter
        lda     LA73D,x
        cmp     generalCounter
        beq     LA72C
        lda     LA745,x
        clc
        adc     spriteXOffset
        sta     spriteXOffset
        lda     frameCounter
        and     #$02
        lsr     a
        clc
        adc     #$51
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
LA72C:  inc     ending_currentSprite
        lda     ending_currentSprite
        cmp     #$04
        bne     LA6D9
        rts

LA735:  .byte   $05,$07,$09,$0B
domeNumberToXOffsetTable:
        .byte   $60,$90,$70,$7E
LA73D:  .byte   $BC
LA73E:  .byte   $B8
LA73F:  .byte   $BC
LA740:  .byte   $B3
domeNumberToSpriteTable:
        .byte   $4D,$50,$4E,$4F
LA745:  .byte   $00,$00,$00,$02
; Frames before changing to next frame's sprite
ending_typeBCathedralAnimSpeed:
        .byte   $02,$04,$06,$03,$10,$03,$05,$06
        .byte   $02,$05
; Number of frames to keep sprites in same position (inverse of vector table)
ending_typeBCathedralFrameDelayTable:
        .byte   $03,$01,$01,$01,$02,$05,$01,$02
        .byte   $01,$01
LA75D:  .byte   $02,$02,$FE,$FE,$02,$FE,$02,$02
        .byte   $FE,$02
LA767:  .byte   $00,$00,$00,$02,$F0,$10,$F0,$F0
        .byte   $20,$F0
ending_typeBCathedralVectorTable:
        .byte   $01,$01,$FF,$FC,$01,$FF,$02,$02
        .byte   $FE,$02
ending_typeBCathedralXTable:
        .byte   $3A,$24,$0A,$4A,$3A,$FF,$22,$44
        .byte   $12,$32,$4A,$FF,$AE,$6E,$8E,$6E
        .byte   $1E,$02,$42,$42,$42,$42,$42,$02
        .byte   $22,$0A,$1A,$04,$0A,$FF,$EE,$DE
        .byte   $FC,$FC,$F6,$02,$80,$80,$80,$80
        .byte   $80,$FF,$E8,$E8,$E8,$E8,$48,$FF
        .byte   $80,$AE,$9E,$90,$80,$02,$80,$80
        .byte   $80,$80,$80,$FF
ending_typeBCathedralYTable:
        .byte   $98,$A8,$C0,$A8,$90,$B0,$B0,$B8
        .byte   $A0,$B8,$A8,$A0,$C8,$C8,$C8,$C8
        .byte   $C8,$C8,$30,$20,$40,$28,$A0,$80
        .byte   $A8,$88,$68,$A8,$48,$78,$58,$68
        .byte   $18,$48,$78,$38,$C8,$C8,$C8,$C8
        .byte   $C8,$C8,$90,$58,$70,$A8,$40,$38
        .byte   $68,$88,$78,$18,$48,$A8,$C8,$C8
        .byte   $C8,$C8,$C8,$C8
ending_typeBCathedralSpriteTable:
        .byte   $2C,$2E,$54,$32,$34,$36,$4B,$38
        .byte   $3A,$4B
render_endingUnskippable:
        sta     sleepCounter
@loopUntilEnoughFrames:
        jsr     render_ending
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     sleepCounter
        bne     @loopUntilEnoughFrames
        rts

marioFrameToYOffsetTable:
        .byte   $97,$8F,$87,$8F
luigiFrameToYOffsetTable:
        .byte   $97,$8F,$87,$87,$8F,$97,$8F,$87
        .byte   $87,$8F
luigiFrameToSpriteTable:
        .byte   $29,$29,$29,$2A,$2A,$2A,$2A,$2A
        .byte   $29,$29
; Used by patchToPpu. Address followed by bytes to write. $FE to start next address. $FD to end
ending_patchToPpu_typeBConcertHeightUnused:
        .byte   $21,$A5,$FF,$FF,$FF,$FE,$21,$C5
        .byte   $FF,$FF,$FF,$FE,$21,$E5,$FF,$FF
        .byte   $FF,$FD
ending_patchToPpu_typeBConcertHeight0:
        .byte   $23,$1A,$FF,$FE,$23,$39,$FF,$FF
        .byte   $FF,$FE,$23,$59,$FF,$FF,$FF,$FE
        .byte   $23,$79,$FF,$FF,$FF,$FD
ending_patchToPpu_typeBConcertHeight1:
        .byte   $23,$15,$FF,$FF,$FF,$FE,$23,$35
        .byte   $FF,$FF,$FF,$FE,$23,$55,$FF,$FF
        .byte   $FF,$FE,$23,$75,$FF,$FF,$FF,$FD
ending_patchToPpu_typeBConcertHeight2:
        .byte   $21,$88,$FF,$FF,$FF,$FE,$21,$A8
        .byte   $FF,$FF,$FF,$FE,$21,$C8,$FF,$FF
        .byte   $FF,$FE,$21,$E8,$FF,$FF,$FF,$FD
ending_patchToPpu_typeBConcertHeight3:
        .byte   $22,$46,$FF,$FF,$FF,$FF,$FE,$22
        .byte   $66,$FF,$FF,$FF,$FF,$FE,$22,$86
        .byte   $FF,$FF,$FF,$FF,$FE,$22,$A6,$FF
        .byte   $FF,$FF,$FF,$FD
ending_patchToPpu_typeBConcertHeight4:
        .byte   $20,$F9,$FF,$FF,$FF,$FE,$21,$19
        .byte   $FF,$FF,$FF,$FE,$21,$39,$FF,$FF
        .byte   $FF,$FD
unreferenced_patchToPpu0:
        .byte   $23,$35,$FF,$FF,$FF,$FE,$23,$55
        .byte   $FF,$FF,$FF,$FE,$23,$75,$FF,$FF
        .byte   $FF,$FD
unreferenced_patchToPpu1:
        .byte   $23,$39,$FF,$FF,$FF,$FE,$23,$59
        .byte   $FF,$FF,$FF,$FE,$23,$79,$FF,$FF
        .byte   $FF,$FD
ending_patchToPpu_typeAOver120k:
        .byte   $22,$58,$FF,$FE,$22,$75,$FF,$FF
        .byte   $FF,$FF,$FF,$FF,$FE,$22,$94,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FE
        .byte   $22,$B4,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $FF,$FF,$FE,$22,$D4,$FF,$FF,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FE,$22,$F4
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $FE,$23,$14,$FF,$FF,$FF,$FF,$FF
        .byte   $FF,$FF,$FF,$FE,$23,$34,$FF,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FE,$22
        .byte   $CA,$46,$47,$FE,$22,$EA,$56,$57
        .byte   $FD
unreferenced_data6:
        .byte   $FC

endingAnimationA:
        jsr     updateAudioWaitForNmiAndDisablePpuRendering
        jsr     disableNmi
        lda     #CHR_TYPEA_ENDING
        jsr     changeCHRBank0
        lda     #CHR_TYPEA_ENDING
        jsr     changeCHRBank1
        jsr     bulkCopyToPpu
        .addr   type_a_ending_nametable
        jsr     bulkCopyToPpu
        .addr   ending_palette
        jsr     selectEndingScreen
        jsr     waitForVBlankAndEnableNmi
        jsr     updateAudioWaitForNmiAndResetOamStaging
        jsr     updateAudioWaitForNmiAndEnablePpuRendering
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     #$04
        sta     renderMode
        lda     #$0A
        jsr     setMusicTrack
        lda     #ENDING_SLEEP_TIME_1
        jsr     render_endingUnskippable
@endingSleep:
        jsr     render_ending
        jsr     updateAudioWaitForNmiAndResetOamStaging
        lda     ending_customVars
        bne     @endingSleep
        lda     newlyPressedButtons_player1
        cmp     #BUTTON_START
        bne     @endingSleep
        rts

selectEndingScreen:
; score+2 is compared to $03 in @curtainFinished
        lda     #$00 ; >= 30,000
        sta     ending
        lda     player1_score+2
        cmp     #$05
        bcc     ending_selected
        lda     #$01 ; >= 50,000
        sta     ending
        lda     player1_score+2
        cmp     #$07
        bcc     ending_selected
        lda     #$02 ; >= 70,000
        sta     ending
        lda     player1_score+2
        cmp     #$10
        bcc     ending_selected
        lda     #$03 ; >= 100,000
        sta     ending
        lda     player1_score+2
        cmp     #$12
        bcc     ending_selected
        lda     #$04 ; >= 120,000
        sta     ending
        lda     #>ending_patchToPpu_typeAOver120k
        sta     patchToPpuAddr+1
        lda     #<ending_patchToPpu_typeAOver120k
        sta     patchToPpuAddr
        jsr     patchToPpu
ending_selected:
        ldx     ending
        lda     LAA2A,x
        sta     ending_customVars
        lda     #$00
        sta     ending_customVars+1
        rts

ending_typeA:
        lda     ending_customVars
        cmp     #$00
        beq     LAA10
        sta     spriteYOffset
        lda     #$58
        ldx     ending
        lda     rocketToXOffsetTable,x
        sta     spriteXOffset
        lda     rocketToSpriteTable,x
        sta     spriteIndexInOamContentLookup
        jsr     loadSpriteIntoOamStaging
        lda     ending
        asl     a
        sta     generalCounter
        lda     frameCounter
        and     #$02
        lsr     a
        clc
        adc     generalCounter
        tax
        lda     rocketToJetSpriteTable,x
        sta     spriteIndexInOamContentLookup
        ldx     ending
        lda     rocketToJetXOffsetTable,x
        clc
        adc     spriteXOffset
        sta     spriteXOffset
        jsr     loadSpriteIntoOamStaging
        lda     ending_customVars+1
        cmp     #$F0
        bne     LAA0E
        lda     ending_customVars
        cmp     #$B0
        bcc     LA9FC
        lda     frameCounter
        and     #$01
        bne     LAA0B
LA9FC:  lda     #$03
        sta     soundEffectSlot0Init
        dec     ending_customVars
        lda     ending_customVars
        cmp     #$80
        bcs     LAA0B
        dec     ending_customVars
LAA0B:  jmp     LAA10

LAA0E:  inc     ending_customVars+1
LAA10:  rts

rocketToSpriteTable:
        .byte   $3E,$41,$44,$47,$4A
rocketToJetSpriteTable:
        .byte   $3F,$40,$42,$43,$45,$46,$48,$49
        .byte   $23,$24
rocketToJetXOffsetTable:
        .byte   $00,$00,$00,$00,$00
rocketToXOffsetTable:
        .byte   $54,$54,$50,$48,$A0
LAA2A:  .byte   $BF,$BF,$BF,$BF,$C7
; canon is waitForVerticalBlankingInterval
updateAudioWaitForNmiAndResetOamStaging:
        jsr     updateAudio_jmp
        lda     #$00
        sta     verticalBlankingInterval
        nop
@checkForNmi:
        lda     verticalBlankingInterval
        beq     @checkForNmi
        lda     #$FF
        ldx     #>oamStaging
        ldy     #>oamStaging
        jsr     memset_page
        rts

updateAudioAndWaitForNmi:
        jsr     updateAudio_jmp
        lda     #$00
        sta     verticalBlankingInterval
        nop
@checkForNmi:
        lda     verticalBlankingInterval
        beq     @checkForNmi
        rts

updateAudioWaitForNmiAndDisablePpuRendering:
        jsr     updateAudioAndWaitForNmi
        lda     currentPpuMask
        and     #$E1
_updatePpuMask:
        sta     PPUMASK
        sta     currentPpuMask
        rts

updateAudioWaitForNmiAndEnablePpuRendering:
        jsr     updateAudioAndWaitForNmi
.if NWC <> 1
        jsr     copyCurrentScrollAndCtrlToPPU
.endif
        lda     currentPpuMask
        ora     #$1E
        bne     _updatePpuMask
waitForVBlankAndEnableNmi:
        lda     PPUSTATUS
        and     #$80
        bne     waitForVBlankAndEnableNmi
        lda     currentPpuCtrl
        ora     #$80
        bne     _updatePpuCtrl
disableNmi:
        lda     currentPpuCtrl
        and     #$7F
_updatePpuCtrl:
        sta     PPUCTRL
        sta     currentPpuCtrl
        rts

LAA82:  ldx     #$FF
        ldy     #$00
        jsr     memset_ppu_page_and_more
        rts

copyCurrentScrollAndCtrlToPPU:
        lda     #$00
        sta     PPUSCROLL
        sta     PPUSCROLL
        lda     currentPpuCtrl
        sta     PPUCTRL
        rts

bulkCopyToPpu:
        jsr     copyAddrAtReturnAddressToTmp_incrReturnAddrBy2
        jmp     copyToPpu

LAA9E:  pha
        sta     PPUADDR
        iny
        lda     (tmp1),y
        sta     PPUADDR
        iny
        lda     (tmp1),y
        asl     a
        pha
        lda     currentPpuCtrl
        ora     #$04
        bcs     LAAB5
        and     #$FB
LAAB5:  sta     PPUCTRL
        sta     currentPpuCtrl
        pla
        asl     a
        php
        bcc     LAAC2
        ora     #$02
        iny
LAAC2:  plp
        clc
        bne     LAAC7
        sec
LAAC7:  ror     a
        lsr     a
        tax
LAACA:  bcs     LAACD
        iny
LAACD:  lda     (tmp1),y
        sta     PPUDATA
        dex
        bne     LAACA
        pla
        cmp     #$3F
        bne     LAAE6
        sta     PPUADDR
        stx     PPUADDR
        stx     PPUADDR
        stx     PPUADDR
LAAE6:  sec
        tya
        adc     tmp1
        sta     tmp1
        lda     #$00
        adc     tmp2
        sta     tmp2
; Address to read from stored in tmp1/2
copyToPpu:
        ldx     PPUSTATUS
        ldy     #$00
        lda     (tmp1),y
        bpl     LAAFC
        rts

LAAFC:  cmp     #$60
        bne     LAB0A
        pla
        sta     tmp2
        pla
        sta     tmp1
        ldy     #$02
        bne     LAAE6
LAB0A:  cmp     #$4C
        bne     LAA9E
        lda     tmp1
        pha
        lda     tmp2
        pha
        iny
        lda     (tmp1),y
        tax
        iny
        lda     (tmp1),y
        sta     tmp2
        stx     tmp1
        bcs     copyToPpu
copyAddrAtReturnAddressToTmp_incrReturnAddrBy2:
        tsx
        lda     stack+3,x
        sta     tmpBulkCopyToPpuReturnAddr
        lda     stack+4,x
        sta     tmpBulkCopyToPpuReturnAddr+1
        ldy     #$01
        lda     (tmpBulkCopyToPpuReturnAddr),y
        sta     tmp1
        iny
        lda     (tmpBulkCopyToPpuReturnAddr),y
        sta     tmp2
        clc
        lda     #$02
        adc     tmpBulkCopyToPpuReturnAddr
        sta     stack+3,x
        lda     #$00
        adc     tmpBulkCopyToPpuReturnAddr+1
        sta     stack+4,x
        rts

;reg x: zeropage addr of seed; reg y: size of seed
generateNextPseudorandomNumber:
        lda     tmp1,x
        and     #$02
        sta     tmp1
        lda     tmp2,x
        and     #$02
        eor     tmp1
        clc
        beq     @updateNextByteInSeed
        sec
@updateNextByteInSeed:
        ror     tmp1,x
        inx
        dey
        bne     @updateNextByteInSeed
        rts

; canon is initializeOAM
copyOamStagingToOam:
        lda     #$00
        sta     OAMADDR
        lda     #$02
        sta     OAMDMA
        rts

pollController_actualRead:
        ldx     joy1Location
        inx
        stx     JOY1
        dex
        stx     JOY1
        ldx     #$08
@readNextBit:
        lda     JOY1
        lsr     a
        rol     newlyPressedButtons_player1
        lsr     a
        rol     tmp1
        lda     JOY2_APUFC
        lsr     a
        rol     newlyPressedButtons_player2
        lsr     a
        rol     tmp2
        dex
        bne     @readNextBit
        rts

addExpansionPortInputAsControllerInput:
        lda     tmp1
        ora     newlyPressedButtons_player1
        sta     newlyPressedButtons_player1
        lda     tmp2
        ora     newlyPressedButtons_player2
        sta     newlyPressedButtons_player2
        rts

        jsr     pollController_actualRead
        beq     diffOldAndNewButtons
pollController:
        jsr     pollController_actualRead
        jsr     addExpansionPortInputAsControllerInput
        lda     newlyPressedButtons_player1
        sta     generalCounter2
        lda     newlyPressedButtons_player2
        sta     generalCounter3
        jsr     pollController_actualRead
        jsr     addExpansionPortInputAsControllerInput
        lda     newlyPressedButtons_player1
        and     generalCounter2
        sta     newlyPressedButtons_player1
        lda     newlyPressedButtons_player2
        and     generalCounter3
        sta     newlyPressedButtons_player2
diffOldAndNewButtons:
        ldx     #$01
@diffForPlayer:
        lda     newlyPressedButtons_player1,x
        tay
        eor     heldButtons_player1,x
        and     newlyPressedButtons_player1,x
        sta     newlyPressedButtons_player1,x
        sty     heldButtons_player1,x
        dex
        bpl     @diffForPlayer
        rts

unreferenced_func1:
        jsr     pollController_actualRead
LABD1:  ldy     newlyPressedButtons_player1
        lda     newlyPressedButtons_player2
        pha
        jsr     pollController_actualRead
        pla
        cmp     newlyPressedButtons_player2
        bne     LABD1
        cpy     newlyPressedButtons_player1
        bne     LABD1
        beq     diffOldAndNewButtons
        jsr     pollController_actualRead
        jsr     addExpansionPortInputAsControllerInput
LABEA:  ldy     newlyPressedButtons_player1
        lda     newlyPressedButtons_player2
        pha
        jsr     pollController_actualRead
        jsr     addExpansionPortInputAsControllerInput
        pla
        cmp     newlyPressedButtons_player2
        bne     LABEA
        cpy     newlyPressedButtons_player1
        bne     LABEA
        beq     diffOldAndNewButtons
        jsr     pollController_actualRead
        lda     tmp1
        sta     heldButtons_player1
        lda     tmp2
        sta     heldButtons_player2
        ldx     #$03
LAC0D:  lda     newlyPressedButtons_player1,x
        tay
        eor     $F1,x
        and     newlyPressedButtons_player1,x
        sta     newlyPressedButtons_player1,x
        sty     $F1,x
        dex
        bpl     LAC0D
        rts

memset_ppu_page_and_more:
        sta     tmp1
        stx     tmp2
        sty     tmp3
        lda     PPUSTATUS
        lda     currentPpuCtrl
        and     #$FB
        sta     PPUCTRL
        sta     currentPpuCtrl
        lda     tmp1
        sta     PPUADDR
        ldy     #$00
        sty     PPUADDR
        ldx     #$04
        cmp     #$20
        bcs     LAC40
        ldx     tmp3
LAC40:  ldy     #$00
        lda     tmp2
LAC44:  sta     PPUDATA
        dey
        bne     LAC44
        dex
        bne     LAC44
        ldy     tmp3
        lda     tmp1
        cmp     #$20
        bcc     LAC67
        adc     #$02
        sta     PPUADDR
        lda     #$C0
        sta     PPUADDR
        ldx     #$40
LAC61:  sty     PPUDATA
        dex
        bne     LAC61
LAC67:  ldx     tmp2
        rts

; reg a: value; reg x: start page; reg y: end page (inclusive)
memset_page:
        pha
        txa
        sty     tmp2
        clc
        sbc     tmp2
        tax
        pla
        ldy     #$00
        sty     tmp1
@setByte:
        sta     (tmp1),y
        dey
        bne     @setByte
        dec     tmp2
        inx
        bne     @setByte
        rts

switch_s_plus_2a:
        asl     a
        tay
        iny
        pla
        sta     tmp1
        pla
        sta     tmp2
        lda     (tmp1),y
        tax
        iny
        lda     (tmp1),y
        sta     tmp2
        stx     tmp1
        jmp     (tmp1)

.if NWC <> 1
        sei
.endif
        inc     initRam
.if NWC = 1
        lda     #$00
.else
        lda     #$1A
.endif
        jsr     setMMC1Control
        rts

        rts

setMMC1Control:
        sta     MMC1_Control
        lsr     a
        sta     MMC1_Control
        lsr     a
        sta     MMC1_Control
        lsr     a
        sta     MMC1_Control
        lsr     a
        sta     MMC1_Control
        rts

changeCHRBank0:
.if NWC = 1
        rts
.endif
        sta     MMC1_CHR0
        lsr     a
        sta     MMC1_CHR0
        lsr     a
        sta     MMC1_CHR0
        lsr     a
        sta     MMC1_CHR0
        lsr     a
        sta     MMC1_CHR0
        rts

changeCHRBank1:
.if NWC = 1
        rts
.endif
        sta     MMC1_CHR1
        lsr     a
        sta     MMC1_CHR1
        lsr     a
        sta     MMC1_CHR1
        lsr     a
        sta     MMC1_CHR1
        lsr     a
        sta     MMC1_CHR1
        rts

changePRGBank:
.if NWC = 1
        rts
.endif
        sta     MMC1_PRG
        lsr     a
        sta     MMC1_PRG
        lsr     a
        sta     MMC1_PRG
        lsr     a
        sta     MMC1_PRG
        lsr     a
        sta     MMC1_PRG
        rts

game_palette:
        .byte   $3F,$00,$20,$0F,$30,$12,$16,$0F
        .byte   $20,$12,$18,$0F,$2C,$16,$29,$0F
        .byte   $3C,$00,$30,$0F,$35,$15,$22,$0F
        .byte   $35,$29,$26,$0F,$2C,$16,$29,$0F
        .byte   $3C,$00,$30,$FF
legal_screen_palette:
        .byte   $3F,$00,$10,$0F,$27,$2A,$2B,$0F
        .byte   $3C,$2A,$22,$0F,$27,$2C,$29,$0F
        .byte   $30,$3A,$15,$FF
menu_palette:
        .byte   $3F,$00,$14,$0F,$30,$38,$00,$0F
        .byte   $30,$16,$00,$0F,$30,$21,$00,$0F
        .byte   $16,$2A,$28,$0F,$30,$29,$27,$FF
ending_palette:
        .byte   $3F,$00,$20,$12,$0F,$29,$37,$12
        .byte   $0F,$30,$27,$12,$0F,$17,$27,$12
        .byte   $0F,$15,$37,$12,$0F,$29,$37,$12
        .byte   $0F,$30,$27,$12,$0F,$17,$27,$12
        .byte   $0F,$15,$37,$FF


.include "charmap.asm"
        ;are the following zeros unused entries for each high score table?
defaultHighScoresTable:
        .byte  "HOWARD" ;$08,$0F,$17,$01,$12,$04
        .byte  "OTASAN" ;$0F,$14,$01,$13,$01,$0E
        .byte  "LANCE " ;$0C,$01,$0E,$03,$05,$2B
        .byte  $00,$00,$00,$00,$00,$00 ;unused fourth name
        .byte  "ALEX  " ;$01,$0C,$05,$18,$2B,$2B
        .byte  "TONY  " ;$14,$0F,$0E,$19,$2B,$2B
        .byte  "NINTEN" ;$0E,$09,$0E,$14,$05,$0E
        .byte   $00,$00,$00,$00,$00,$00 ;unused fourth name
        ;High Scores are stored in BCD
        .byte   $01,$00,$00 ;Game A 1st Entry Score, 10000
        .byte   $00,$75,$00 ;Game A 2nd Entry Score, 7500
        .byte   $00,$50,$00 ;Game A 3rd Entry Score, 5000
        .byte   $00,$00,$00 ;unused fourth score
        .byte   $00,$20,$00 ;Game B 1st Entry Score, 2000
        .byte   $00,$10,$00 ;Game B 2nd Entry Score, 1000
        .byte   $00,$05,$00 ;Game B 3rd Entry Score, 500
        .byte   $00,$00,$00 ;unused fourth score
        .byte   $09 ;Game A 1st Entry Level
        .byte   $05 ;Game A 2nd Entry Level
        .byte   $00 ;Game A 3nd Entry Level
        .byte   $00 ;unused fourth level
        .byte   $09 ;Game B 1st Entry Level
        .byte   $05 ;Game B 2nd Entry Level
        .byte   $00 ;Game B 3rd Entry Level
        .byte   $00 ;unused fourth level
        .byte   $FF

;.segment        "legal_screen_nametable": absolute

legal_screen_nametable:
        .incbin "gfx/nametables/legal_screen_nametable.bin"
title_screen_nametable:
        .include "gfx/nametables/title_screen_nametable.asm"
game_type_menu_nametable:
        .incbin "gfx/nametables/game_type_menu_nametable.bin"
level_menu_nametable:
        .incbin "gfx/nametables/level_menu_nametable.bin"
game_nametable:
        .incbin "gfx/nametables/game_nametable.bin"
enter_high_score_nametable:
        .incbin "gfx/nametables/enter_high_score_nametable.bin"
high_scores_nametable:
        .incbin "gfx/nametables/high_scores_nametable.bin"
height_menu_nametablepalette_patch:
        .byte   $3F,$0A,$01,$16,$20,$6D,$01,$0A
        .byte   $20,$F3,$48,$FF,$21,$13,$48,$FF
        .byte   $21,$33,$48,$FF,$21,$53,$47,$FF
        .byte   $21,$73,$47,$FF,$21,$93,$47,$FF
        .byte   $21,$B3,$47,$FF,$21,$D3,$47,$FF
        .byte   $22,$33,$48,$FF,$22,$53,$48,$FF
        .byte   $22,$73,$48,$FF,$22,$93,$47,$FF
        .byte   $22,$B3,$47,$FF,$22,$D3,$47,$FF
        .byte   $22,$F3,$47,$FF,$23,$13,$47,$FF
        .byte   $FF
type_b_lvl9_ending_nametable:
        .incbin "gfx/nametables/type_b_lvl9_ending_nametable.bin"
type_b_ending_nametable:
        .incbin "gfx/nametables/type_b_ending_nametable.bin"
type_a_ending_nametable:
        .incbin "gfx/nametables/type_a_ending_nametable.bin"

; End of "PRG_chunk1" segment
.code


.segment        "unreferenced_data1": absolute

unreferenced_data1:
.if PAL = 1
        .incbin "data/unreferenced_data1_pal.bin"
.elseif NWC = 1
        .include "data/unreferenced_data1_nwc.asm"
.else
        .incbin "data/unreferenced_data1.bin"
.endif

; End of "unreferenced_data1" segment
.code


.segment        "PRG_chunk2": absolute

.include "data/demo_data.asm"

; canon is updateAudio
updateAudio_jmp:
        jmp     updateAudio

; canon is updateAudio
updateAudio2:
        jmp     soundEffectSlot2_makesNoSound

LE006:  jmp     LE1D8

; Referenced via updateSoundEffectSlotShared
soundEffectSlot0Init_table:
        .addr   soundEffectSlot0_makesNoSound
        .addr   soundEffectSlot0_gameOverCurtainInit
        .addr   soundEffectSlot0_endingRocketInit
soundEffectSlot0Playing_table:
        .addr   advanceSoundEffectSlot0WithoutUpdate
        .addr   updateSoundEffectSlot0_apu
        .addr   advanceSoundEffectSlot0WithoutUpdate
soundEffectSlot1Init_table:
        .addr   soundEffectSlot1_menuOptionSelectInit
        .addr   soundEffectSlot1_menuScreenSelectInit
        .addr   soundEffectSlot1_shiftTetriminoInit
        .addr   soundEffectSlot1_tetrisAchievedInit
        .addr   soundEffectSlot1_rotateTetriminoInit
        .addr   soundEffectSlot1_levelUpInit
        .addr   soundEffectSlot1_lockTetriminoInit
        .addr   soundEffectSlot1_chirpChirpInit
        .addr   soundEffectSlot1_lineClearingInit
        .addr   soundEffectSlot1_lineCompletedInit
soundEffectSlot1Playing_table:
        .addr   soundEffectSlot1_menuOptionSelectPlaying
        .addr   soundEffectSlot1_menuScreenSelectPlaying
        .addr   soundEffectSlot1Playing_advance
        .addr   soundEffectSlot1_tetrisAchievedPlaying
        .addr   soundEffectSlot1_rotateTetriminoPlaying
        .addr   soundEffectSlot1_levelUpPlaying
        .addr   soundEffectSlot1Playing_advance
        .addr   soundEffectSlot1_chirpChirpPlaying
        .addr   soundEffectSlot1_lineClearingPlaying
        .addr   soundEffectSlot1_lineCompletedPlaying
soundEffectSlot3Init_table:
        .addr   soundEffectSlot3_fallingAlien
        .addr   soundEffectSlot3_donk
soundEffectSlot3Playing_table:
        .addr   updateSoundEffectSlot3_apu
        .addr   soundEffectSlot3Playing_advance
; Referenced by unused slot 4 as well
soundEffectSlot2Init_table:
        .addr   soundEffectSlot2_makesNoSound
        .addr   soundEffectSlot2_lowBuzz
        .addr   soundEffectSlot2_mediumBuzz
; input y: $E100+y source addr
copyToSq1Channel:
        lda     #$00
        beq     copyToApuChannel
copyToTriChannel:
        lda     #$08
        bne     copyToApuChannel
copyToNoiseChannel:
        lda     #$0C
        bne     copyToApuChannel
copyToSq2Channel:
        lda     #$04
; input a: $4000+a APU addr; input y: $E100+y source; copies 4 bytes
copyToApuChannel:
        sta     AUDIOTMP1
        lda     #$40
        sta     AUDIOTMP2
        sty     AUDIOTMP3
        lda     #>soundEffectSlot0_gameOverCurtainInitData
        sta     AUDIOTMP4
        ldy     #$00
@copyByte:
        lda     (AUDIOTMP3),y
        sta     (AUDIOTMP1),y
        iny
        tya
        cmp     #$04
        bne     @copyByte
        rts

; input a: index-1 into table at $E000+AUDIOTMP1; output AUDIOTMP3/4: address; $EF set to a
computeSoundEffMethod:
        sta     currentAudioSlot
        pha
        ldy     #>soundEffectSlot0Init_table
        sty     AUDIOTMP2
        ldy     #$00
@whileYNot2TimesA:
        dec     currentAudioSlot
        beq     @copyAddr
        iny
        iny
        tya
        cmp     #$22
        bne     @whileYNot2TimesA
        lda     #$91
        sta     AUDIOTMP3
        lda     #>soundEffectSlot0Init_table
        sta     AUDIOTMP4
@ret:   pla
        sta     currentAudioSlot
        rts

@copyAddr:
        lda     (AUDIOTMP1),y
        sta     AUDIOTMP3
        iny
        lda     (AUDIOTMP1),y
        sta     AUDIOTMP4
        jmp     @ret

unreferenced_soundRng:
        lda     $EB
        and     #$02
        sta     $06FF
        lda     $EC
        and     #$02
        eor     $06FF
        clc
        beq     @insertRandomBit
        sec
@insertRandomBit:
        ror     $EB
        ror     $EC
        rts

; Z=0 when returned means disabled
advanceAudioSlotFrame:
        ldx     currentSoundEffectSlot
        inc     soundEffectSlot0FrameCounter,x
        lda     soundEffectSlot0FrameCounter,x
        cmp     soundEffectSlot0FrameCount,x
        bne     @ret
        lda     #$00
        sta     soundEffectSlot0FrameCounter,x
@ret:   rts

unreferenced_data3:
.if NWC = 1
        .byte   $D0,$03,$20,$24,$E1,$20,$4F,$E1
        .byte   $B5,$1E,$29,$80,$D0,$05,$A9,$00
        .byte   $95,$1E,$60,$B5,$1E,$29,$BF,$95
        .byte   $1E,$60,$B5,$16,$C9,$03,$D0,$04
        .byte   $B5,$1E,$F0,$38,$B5,$1E,$A8,$0A
        .byte   $90,$07,$B5,$1E,$09,$40,$4C,$FC
        .byte   $E0,$B9,$B9,$DF,$95,$1E,$B5,$CF
.else
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
.endif
        .byte   $03,$7F,$0F,$C0
; Referenced by initSoundEffectShared
soundEffectSlot0_gameOverCurtainInitData:
        .byte   $1F,$7F,$0F,$C0
soundEffectSlot0_endingRocketInitData:
        .byte   $08,$7F,$0E,$C0
; Referenced at LE20F
music_pause_sq1_even:
        .byte   $9D,$7F,$7A,$28
; Referenced at LE20F
music_pause_sq1_odd:
        .byte   $9D,$7F,$40,$28
soundEffectSlot1_rotateTetriminoInitData:
        .byte   $9E,$7F,$C0,$28
soundEffectSlot1Playing_rotateTetriminoStage3:
        .byte   $B2,$7F,$C0,$08
soundEffectSlot1_levelUpInitData:
        .byte   $DE,$7F,$A8,$18
soundEffectSlot1_lockTetriminoInitData:
        .byte   $9F,$84,$FF,$0B
soundEffectSlot1_menuOptionSelectInitData:
        .byte   $DB,$7F,$40,$28
soundEffectSlot1Playing_menuOptionSelectStage2:
        .byte   $D2,$7F,$40,$28
soundEffectSlot1_menuScreenSelectInitData:
        .byte   $D9,$7F,$84,$28
soundEffectSlot1_tetrisAchievedInitData:
        .byte   $9E,$9D,$C0,$08
soundEffectSlot1_lineCompletedInitData:
        .byte   $9C,$9A,$A0,$09
soundEffectSlot1_lineClearingInitData:
        .byte   $9E,$7F,$69,$08
soundEffectSlot1_chirpChirpInitData:
        .byte   $96,$7F,$36,$20
soundEffectSlot1Playing_chirpChirpStage2:
        .byte   $82,$7F,$30,$F8
soundEffectSlot1_shiftTetriminoInitData:
        .byte   $98,$7F,$80,$38
soundEffectSlot3_fallingAlienInitData:
        .byte   $30,$7F,$70,$08
soundEffectSlot3_donkInitData:
        .byte   $03,$7F,$3D,$18
soundEffectSlot1_chirpChirpSq1Vol_table:
        .byte   $14,$93,$94,$D3
; See getSoundEffectNoiseNibble
noiselo_table:
        .byte   $7A,$DE,$FF,$EF,$FD,$DF,$FE,$EF
        .byte   $EF,$FD,$EF,$FE,$DF,$FF,$EE,$EE
        .byte   $FF,$EF,$FF,$FF,$FF,$EF,$EF,$FF
        .byte   $FD,$DF,$DF,$EF,$FE,$DF,$EF,$FF
; Similar to noiselo_table. Nibble set to NOISE_VOL bits 0-3 with bit 4 set to 1
noisevol_table:
        .byte   $BF,$FF,$EE,$EF,$EF,$EF,$DF,$FB
        .byte   $BB,$AA,$AA,$99,$98,$87,$76,$66
        .byte   $55,$44,$44,$44,$44,$43,$33,$33
        .byte   $22,$22,$22,$22,$21,$11,$11,$11
updateSoundEffectSlot2:
        ldx     #$02
        lda     #<soundEffectSlot2Init_table
        ldy     #<soundEffectSlot2Init_table
        bne     updateSoundEffectSlotShared
updateSoundEffectSlot3:
        ldx     #$03
        lda     #<soundEffectSlot3Init_table
        ldy     #<soundEffectSlot3Playing_table
        bne     updateSoundEffectSlotShared
updateSoundEffectSlot4_unused:
        ldx     #$04
        lda     #<soundEffectSlot2Init_table
        ldy     #<soundEffectSlot2Init_table
        bne     updateSoundEffectSlotShared
updateSoundEffectSlot1:
        lda     soundEffectSlot4Playing
        bne     updateSoundEffectSlotShared_rts
        ldx     #$01
        lda     #<soundEffectSlot1Init_table
        ldy     #<soundEffectSlot1Playing_table
        bne     updateSoundEffectSlotShared
updateSoundEffectSlot0:
        ldx     #$00
        lda     #<soundEffectSlot0Init_table
        ldy     #<soundEffectSlot0Playing_table
; x: sound effect slot; a: low byte addr, for $E0 high byte; y: low byte addr, for $E0 high byte, if slot unused
updateSoundEffectSlotShared:
        sta     AUDIOTMP1
        stx     currentSoundEffectSlot
        lda     soundEffectSlot0Init,x
        beq     @primaryIsEmpty
@computeAndExecute:
        jsr     computeSoundEffMethod
        jmp     (AUDIOTMP3)

@primaryIsEmpty:
        lda     soundEffectSlot0Playing,x
        beq     updateSoundEffectSlotShared_rts
        sty     AUDIOTMP1
        bne     @computeAndExecute
updateSoundEffectSlotShared_rts:
        rts

LE1D8:  lda     #$0F
        sta     SND_CHN
        lda     #$55
        sta     soundRngSeed
        jsr     soundEffectSlot2_makesNoSound
        rts

initAudioAndMarkInited:
        inc     audioInitialized
        jsr     muteAudio
        sta     musicPauseSoundEffectLengthCounter ; a = 0
        rts

updateAudio_pause:
        lda     audioInitialized
        beq     initAudioAndMarkInited
        lda     musicPauseSoundEffectLengthCounter
        cmp     #$12
        beq     @ret
        and     #$03
        cmp     #$03
        bne     @incAndRet
        inc     musicPauseSoundEffectCounter
        ldy     #<music_pause_sq1_odd
        lda     musicPauseSoundEffectCounter
        and     #$01
        bne     @tableChosen
        ldy     #<music_pause_sq1_even
@tableChosen:
        jsr     copyToSq1Channel
@incAndRet:
        inc     musicPauseSoundEffectLengthCounter
@ret:   rts

; Disables APU frame interrupt
updateAudio:
        lda     #$C0
        sta     JOY2_APUFC
        lda     musicStagingNoiseHi
        cmp     #$05
        beq     updateAudio_pause
        lda     #$00
        sta     audioInitialized
        sta     $068B
        jsr     updateSoundEffectSlot2
        jsr     updateSoundEffectSlot0
        jsr     updateSoundEffectSlot3
        jsr     updateSoundEffectSlot1
        jsr     updateMusic
        lda     #$00
        ldx     #$06
@clearSoundEffectSlotsInit:
        sta     $06EF,x
        dex
        bne     @clearSoundEffectSlotsInit
        rts

soundEffectSlot2_makesNoSound:
        jsr     LE253
muteAudioAndClearTriControl:
        jsr     muteAudio
        lda     #$00
        sta     DMC_RAW
        sta     musicChanControl+2
        rts

LE253:  lda     #$00
        sta     musicChanInhibit
        sta     musicChanInhibit+1
        sta     musicChanInhibit+2
        sta     musicStagingNoiseLo
        sta     resetSq12ForMusic
        tay
LE265:  lda     #$00
        sta     soundEffectSlot0Playing,y
        iny
        tya
        cmp     #$06
        bne     LE265
        rts

muteAudio:
        lda     #$00
        sta     DMC_RAW
        lda     #$10
        sta     SQ1_VOL
        sta     SQ2_VOL
        sta     NOISE_VOL
        lda     #$00
        sta     TRI_LINEAR
        rts

; inits currentSoundEffectSlot; input y: $E100+y to init APU channel (leaves alone if 0); input a: number of frames
initSoundEffectShared:
        ldx     currentSoundEffectSlot
        sta     soundEffectSlot0FrameCount,x
        txa
        sta     $06C7,x
        tya
        beq     @continue
        txa
        beq     @slot0
        cmp     #$01
        beq     @slot1
        cmp     #$02
        beq     @slot2
        cmp     #$03
        beq     @slot3
        rts

@slot1: jsr     copyToSq1Channel
        beq     @continue
@slot2: jsr     copyToSq2Channel
        beq     @continue
@slot3: jsr     copyToTriChannel
        beq     @continue
@slot0: jsr     copyToNoiseChannel
@continue:
        lda     currentAudioSlot
        sta     soundEffectSlot0Playing,x
        lda     #$00
        sta     soundEffectSlot0FrameCounter,x
        sta     soundEffectSlot0SecondaryCounter,x
        sta     soundEffectSlot0TertiaryCounter,x
        sta     soundEffectSlot0Tmp,x
        sta     resetSq12ForMusic
        rts

soundEffectSlot0_endingRocketInit:
        lda     #$20
        ldy     #<soundEffectSlot0_endingRocketInitData
        jmp     initSoundEffectShared

setNoiseLo:
        sta     NOISE_LO
        rts

loadNoiseLo:
        jsr     getSoundEffectNoiseNibble
        jmp     setNoiseLo

soundEffectSlot0_makesNoSound:
        lda     #$10
        ldy     #$00
        jmp     initSoundEffectShared

advanceSoundEffectSlot0WithoutUpdate:
        jsr     advanceAudioSlotFrame
        bne     updateSoundEffectSlot0WithoutUpdate_ret
stopSoundEffectSlot0:
        lda     #$00
        sta     soundEffectSlot0Playing
        lda     #$10
        sta     NOISE_VOL
updateSoundEffectSlot0WithoutUpdate_ret:
        rts

unreferenced_code2:
        lda     #$02
        sta     currentAudioSlot
soundEffectSlot0_gameOverCurtainInit:
        lda     #$40
        ldy     #<soundEffectSlot0_gameOverCurtainInitData
        jmp     initSoundEffectShared

updateSoundEffectSlot0_apu:
        jsr     advanceAudioSlotFrame
        bne     updateSoundEffectNoiseAudio
        jmp     stopSoundEffectSlot0

updateSoundEffectNoiseAudio:
        ldx     #<noiselo_table
        jsr     loadNoiseLo
        ldx     #<noisevol_table
        jsr     getSoundEffectNoiseNibble
        ora     #$10
        sta     NOISE_VOL
        inc     soundEffectSlot0SecondaryCounter
        rts

; Loads from noiselo_table(x=$54)/noisevol_table(x=$74)
getSoundEffectNoiseNibble:
        stx     AUDIOTMP1
        ldy     #>noiselo_table
        sty     AUDIOTMP2
        ldx     soundEffectSlot0SecondaryCounter
        txa
        lsr     a
        tay
        lda     (AUDIOTMP1),y
        sta     AUDIOTMP5
        txa
        and     #$01
        beq     @shift4
        lda     AUDIOTMP5
        and     #$0F
        rts

@shift4:lda     AUDIOTMP5
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        rts

LE33B:  lda     soundEffectSlot1Playing
        cmp     #$04
        beq     LE34E
        cmp     #$06
        beq     LE34E
        cmp     #$09
        beq     LE34E
        cmp     #$0A
        beq     LE34E
LE34E:  rts

soundEffectSlot1_chirpChirpPlaying:
        lda     soundEffectSlot1TertiaryCounter
        beq     @stage1
        inc     soundEffectSlot1SecondaryCounter
        lda     soundEffectSlot1SecondaryCounter
        cmp     #$16
        bne     soundEffectSlot1Playing_ret
        jmp     soundEffectSlot1Playing_stop

@stage1:lda     soundEffectSlot1SecondaryCounter
        and     #$03
        tay
        lda     soundEffectSlot1_chirpChirpSq1Vol_table,y
        sta     SQ1_VOL
        inc     soundEffectSlot1SecondaryCounter
        lda     soundEffectSlot1SecondaryCounter
        cmp     #$08
        bne     soundEffectSlot1Playing_ret
        inc     soundEffectSlot1TertiaryCounter
        ldy     #<soundEffectSlot1Playing_chirpChirpStage2
        jmp     copyToSq1Channel

; Unused.
soundEffectSlot1_chirpChirpInit:
        ldy     #<soundEffectSlot1_chirpChirpInitData
        jmp     initSoundEffectShared

soundEffectSlot1_lockTetriminoInit:
        jsr     LE33B
        beq     soundEffectSlot1Playing_ret
        lda     #$0F
        ldy     #<soundEffectSlot1_lockTetriminoInitData
        jmp     initSoundEffectShared

soundEffectSlot1_shiftTetriminoInit:
        jsr     LE33B
        beq     soundEffectSlot1Playing_ret
        lda     #$02
        ldy     #<soundEffectSlot1_shiftTetriminoInitData
        jmp     initSoundEffectShared

soundEffectSlot1Playing_advance:
        jsr     advanceAudioSlotFrame
        bne     soundEffectSlot1Playing_ret
soundEffectSlot1Playing_stop:
        lda     #$10
        sta     SQ1_VOL
        lda     #$00
        sta     musicChanInhibit
        sta     soundEffectSlot1Playing
        inc     resetSq12ForMusic
soundEffectSlot1Playing_ret:
        rts

soundEffectSlot1_menuOptionSelectPlaying_ret:
        rts

soundEffectSlot1_menuOptionSelectPlaying:
        jsr     advanceAudioSlotFrame
        bne     soundEffectSlot1_menuOptionSelectPlaying_ret
        inc     soundEffectSlot1SecondaryCounter
        lda     soundEffectSlot1SecondaryCounter
        cmp     #$02
        bne     @stage2
        jmp     soundEffectSlot1Playing_stop

@stage2:ldy     #<soundEffectSlot1Playing_menuOptionSelectStage2
        jmp     copyToSq1Channel

soundEffectSlot1_menuOptionSelectInit:
        lda     #$03
        ldy     #<soundEffectSlot1_menuOptionSelectInitData
        bne     LE417
soundEffectSlot1_rotateTetrimino_ret:
        rts

soundEffectSlot1_rotateTetriminoInit:
        jsr     LE33B
        beq     soundEffectSlot1_rotateTetrimino_ret
        lda     #$04
        ldy     #<soundEffectSlot1_rotateTetriminoInitData
        jsr     LE417
soundEffectSlot1_rotateTetriminoPlaying:
        jsr     advanceAudioSlotFrame
        bne     soundEffectSlot1_rotateTetrimino_ret
        lda     soundEffectSlot1SecondaryCounter
        inc     soundEffectSlot1SecondaryCounter
        beq     @stage3
        cmp     #$01
        beq     @stage2
        cmp     #$02
        beq     @stage3
        cmp     #$03
        bne     soundEffectSlot1_rotateTetrimino_ret
        jmp     soundEffectSlot1Playing_stop

@stage2:ldy     #<soundEffectSlot1_rotateTetriminoInitData
        jmp     copyToSq1Channel

; On first glance it appears this is used twice, but the first beq does nothing because the inc result will never be 0
@stage3:ldy     #<soundEffectSlot1Playing_rotateTetriminoStage3
        jmp     copyToSq1Channel

soundEffectSlot1_tetrisAchievedInit:
        lda     #SFX_TETRIS_INIT
        ldy     #<soundEffectSlot1_tetrisAchievedInitData
        jsr     LE417
        lda     #$10
        bne     LE437
soundEffectSlot1_tetrisAchievedPlaying:
        jsr     advanceAudioSlotFrame
        bne     LE43A
        ldy     #<soundEffectSlot1_tetrisAchievedInitData
        bne     LE442
LE417:  jmp     initSoundEffectShared

soundEffectSlot1_lineCompletedInit:
        lda     #SFX_LINE_COMPLETE_INIT
        ldy     #<soundEffectSlot1_lineCompletedInitData
        jsr     LE417
        lda     #$08
        bne     LE437
soundEffectSlot1_lineCompletedPlaying:
        jsr     advanceAudioSlotFrame
        bne     LE43A
        ldy     #<soundEffectSlot1_lineCompletedInitData
        bne     LE442
soundEffectSlot1_lineClearingInit:
        lda     #SFX_LINECLEAR_INIT
        ldy     #<soundEffectSlot1_lineClearingInitData
        jsr     LE417
        lda     #$00
LE437:  sta     soundEffectSlot1TertiaryCounter
LE43A:  rts

soundEffectSlot1_lineClearingPlaying:
        jsr     advanceAudioSlotFrame
        bne     LE43A
        ldy     #<soundEffectSlot1_lineClearingInitData
LE442:  jsr     copyToSq1Channel
        clc
        lda     soundEffectSlot1TertiaryCounter
        adc     soundEffectSlot1SecondaryCounter
        tay
        lda     soundEffectSlot1_lineClearing_lo,y
        sta     SQ1_LO
        ldy     soundEffectSlot1SecondaryCounter
        lda     soundEffectSlot1_lineClearing_vol,y
        sta     SQ1_VOL
        bne     LE46F
        lda     soundEffectSlot1Playing
        cmp     #$04
        bne     LE46C
        lda     #$09
        sta     currentAudioSlot
        jmp     soundEffectSlot1_lineClearingInit

LE46C:  jmp     soundEffectSlot1Playing_stop

LE46F:  inc     soundEffectSlot1SecondaryCounter
LE472:  rts

soundEffectSlot1_menuScreenSelectInit:
        lda     #$03
        ldy     #<soundEffectSlot1_menuScreenSelectInitData
        jsr     initSoundEffectShared
        lda     soundEffectSlot1_menuScreenSelectInitData+2
        sta     soundEffectSlot1SecondaryCounter
        rts

soundEffectSlot1_menuScreenSelectPlaying:
        jsr     advanceAudioSlotFrame
        bne     LE472
        inc     soundEffectSlot1TertiaryCounter
        lda     soundEffectSlot1TertiaryCounter
        cmp     #$04
        bne     LE493
        jmp     soundEffectSlot1Playing_stop

LE493:  lda     soundEffectSlot1SecondaryCounter
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        sta     soundEffectSlot1Tmp
        lda     soundEffectSlot1SecondaryCounter
        clc
        sbc     soundEffectSlot1Tmp
        sta     soundEffectSlot1SecondaryCounter
        sta     SQ1_LO
        lda     #$28
LE4AC:  sta     SQ1_HI
LE4AF:  rts

soundEffectSlot1_lineClearing_vol:
        .byte   $9E,$9B,$99,$96,$94,$93,$92,$91
        .byte   $00
soundEffectSlot1_lineClearing_lo:
        .byte   $46,$37,$46,$37,$46,$37,$46,$37
        .byte   $70,$80,$90,$A0,$B0,$C0,$D0,$E0
        .byte   $C0,$89,$B8,$68,$A0,$50,$90,$40
soundEffectSlot1_levelUpPlaying:
        jsr     advanceAudioSlotFrame
        bne     LE4AF
        ldy     soundEffectSlot1SecondaryCounter
        inc     soundEffectSlot1SecondaryCounter
        lda     soundEffectSlot1_levelUp_lo,y
        beq     LE4E9
        sta     SQ1_LO
        lda     #$28
        jmp     LE4AC

LE4E9:  jmp     soundEffectSlot1Playing_stop

soundEffectSlot1_levelUpInit:
        lda     #SFX_LEVELUP_INIT
        ldy     #<soundEffectSlot1_levelUpInitData
        jmp     initSoundEffectShared

soundEffectSlot1_levelUp_lo:
        .byte   $69,$A8,$69,$A8,$8D,$53,$8D,$53
        .byte   $8D,$00,$A9,$10,$8D,$04,$40,$A9
        .byte   $00,$8D,$C9,$06,$8D,$FA,$06,$60
; Unused
soundEffectSlot2_mediumBuzz:
        .byte   $A9,$3F,$A0,$60,$A2,$0F
        bne     LE51B
; Unused
soundEffectSlot2_lowBuzz:
        lda     #$3F
        ldy     #$60
        ldx     #$0E
        bne     LE51B
LE51B:  sta     DMC_LEN
        sty     DMC_START
        stx     DMC_FREQ
        lda     #$0F
        sta     SND_CHN
        lda     #$00
        sta     DMC_RAW
        lda     #$1F
        sta     SND_CHN
        rts

; Unused
soundEffectSlot3_donk:
        lda     #$02
        ldy     #<soundEffectSlot3_donkInitData
        jmp     initSoundEffectShared

soundEffectSlot3Playing_advance:
        jsr     advanceAudioSlotFrame
        bne     soundEffectSlot3Playing_ret
soundEffectSlot3Playing_stop:
        lda     #$00
        sta     TRI_LINEAR
        sta     musicChanInhibit+2
        sta     soundEffectSlot3Playing
        lda     #$18
        sta     TRI_HI
soundEffectSlot3Playing_ret:
        rts

updateSoundEffectSlot3_apu:
        jsr     advanceAudioSlotFrame
        bne     soundEffectSlot3Playing_ret
        ldy     soundEffectSlot3SecondaryCounter
        inc     soundEffectSlot3SecondaryCounter
        lda     trilo_table,y
        beq     soundEffectSlot3Playing_stop
        sta     TRI_LO
        sta     soundEffectSlot3TertiaryCounter
        lda     soundEffectSlot3_fallingAlienInitData+3
        sta     TRI_HI
        rts

; Unused
soundEffectSlot3_fallingAlien:
        lda     #$06
        ldy     #<soundEffectSlot3_fallingAlienInitData
        jsr     initSoundEffectShared
        lda     soundEffectSlot3_fallingAlienInitData+2
        sta     soundEffectSlot3TertiaryCounter
        rts

trilo_table:
        .byte   $72,$74,$77,$00
updateMusic_noSoundJmp:
        jmp     soundEffectSlot2_makesNoSound

updateMusic:
        lda     musicTrack
        tay
        cmp     #$FF
        beq     updateMusic_noSoundJmp
        cmp     #$00
        beq     @checkIfAlreadyPlaying
        sta     currentAudioSlot
        sta     musicTrack_dec
        dec     musicTrack_dec
        lda     #$7F
        sta     musicStagingSq1Sweep
        sta     musicStagingSq1Sweep+1
        jsr     loadMusicTrack
@updateFrame:
        jmp     updateMusicFrame

@checkIfAlreadyPlaying:
        lda     currentlyPlayingMusicTrack
        bne     @updateFrame
        rts

; triples of bytes, one for each MMIO
noises_table:
        .byte   $00,$10,$01,$18,$00,$01,$38,$00
        .byte   $03,$40,$00,$06,$58,$00,$0A,$38
        .byte   $02,$04,$40,$13,$05,$40,$14,$0A
        .byte   $40,$14,$08,$40,$12,$0E,$08,$16
        .byte   $0E,$28,$16,$0B,$18
; input x: channel number (0-3). Does nothing for track 1 and NOISE
updateMusicFrame_setChanLo:
        lda     currentlyPlayingMusicTrack
        cmp     #$01
        beq     @ret
        txa
        cmp     #$03
        beq     @ret
        lda     musicChanControl,x
        and     #$E0
        beq     @ret
        sta     AUDIOTMP1
        lda     musicChanNote,x
        cmp     #$02
        beq     @incAndRet
        ldy     musicChannelOffset
        lda     musicStagingSq1Lo,y
        sta     AUDIOTMP2
        jsr     updateMusicFrame_setChanLoOffset
@incAndRet:
        inc     musicChanLoFrameCounter,x
@ret:   rts

musicLoOffset_8AndC:
        lda     AUDIOTMP3
        cmp     #$31
        bne     @lessThan31
        lda     #$27
@lessThan31:
        tay
        lda     loOff9To0FallTable,y
        pha
        lda     musicChanNote,x
        cmp     #$46
        bne     LE613
        pla
        lda     #$00
        beq     musicLoOffset_setLoAndSaveFrameCounter
LE613:  pla
        jmp     musicLoOffset_setLoAndSaveFrameCounter

; Doesn't loop
musicLoOffset_4:
        lda     AUDIOTMP3
        tay
        cmp     #$10
        bcs     @outOfRange
        lda     loOffDescendToNeg11BounceToNeg9Table,y
        jmp     musicLoOffset_setLo

@outOfRange:
        lda     #$F6
        bne     musicLoOffset_setLo
; Every frame is the same
musicLoOffset_minus2_6:
        lda     musicChanNote,x
        cmp     #$4C
        bcc     @unnecessaryBranch
        lda     #$FE
        bne     musicLoOffset_setLo
@unnecessaryBranch:
        lda     #$FE
        bne     musicLoOffset_setLo
; input x: channel number (0-2). input AUDIOTMP1: musicChanControl masked by #$E0. input AUDIOTMP2: base LO
updateMusicFrame_setChanLoOffset:
        lda     musicChanLoFrameCounter,x
        sta     AUDIOTMP3
        lda     AUDIOTMP1
        cmp     #$20
        beq     @2AndE
        cmp     #$A0
        beq     @A
        cmp     #$60
        beq     musicLoOffset_minus2_6
        cmp     #$40
        beq     musicLoOffset_4
        cmp     #$80
        beq     musicLoOffset_8AndC
        cmp     #$C0
        beq     musicLoOffset_8AndC
; Loops between 0-9
@2AndE: lda     AUDIOTMP3
        cmp     #$0A
        bne     @2AndE_lessThanA
        lda     #$00
@2AndE_lessThanA:
        tay
        lda     loOffTrillNeg2To2Table,y
        jmp     musicLoOffset_setLoAndSaveFrameCounter

; Ends by looping in 2 and E table
@A:     lda     AUDIOTMP3
        cmp     #$2B
        bne     @A_lessThan2B
        lda     #$21
@A_lessThan2B:
        tay
        lda     loOffSlowStartTrillTable,y
musicLoOffset_setLoAndSaveFrameCounter:
        pha
        tya
        sta     musicChanLoFrameCounter,x
        pla
musicLoOffset_setLo:
        pha
        lda     musicChanInhibit,x
        bne     @ret
        pla
        clc
        adc     AUDIOTMP2
        ldy     musicChannelOffset
        sta     SQ1_LO,y
        rts

@ret:   pla
        rts

; Values are signed
loOff9To0FallTable:
        .byte   $09,$08,$07,$06,$05,$04,$03,$02
        .byte   $02,$01,$01,$00
; Includes next table
loOffSlowStartTrillTable:
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$01
        .byte   $00,$00,$00,$00,$FF,$00,$00,$00
        .byte   $00,$01,$01,$00,$00,$00,$FF,$FF
        .byte   $00
loOffTrillNeg2To2Table:
        .byte   $00,$01,$01,$02,$01,$00,$FF,$FF
        .byte   $FE,$FF
loOffDescendToNeg11BounceToNeg9Table:
        .byte   $00,$FF,$FE,$FD,$FC,$FB,$FA,$F9
        .byte   $F8,$F7,$F6,$F5,$F6,$F7,$F6,$F5
copyFFFFToDeref:
        lda     #$FF
        sta     musicDataChanPtrDeref,x
        bne     storeDeref1AndContinue
loadMusicTrack:
        jsr     muteAudioAndClearTriControl
        lda     currentAudioSlot
        sta     currentlyPlayingMusicTrack
        lda     musicTrack_dec
        tay
        lda     musicDataTableIndex,y
        tay
        ldx     #$00
@copyByteToMusicData:
        lda     musicDataTable,y
        sta     musicDataNoteTableOffset,x
        iny
        inx
        txa
        cmp     #$0A ; copies 10-byte header to musicDataNoteTableOffset
        bne     @copyByteToMusicData
        lda     #$01
        sta     musicChanNoteDurationRemaining
        sta     musicChanNoteDurationRemaining+1
        sta     musicChanNoteDurationRemaining+2
        sta     musicChanNoteDurationRemaining+3
        lda     #$00
        sta     music_unused2
        ldy     #$08
@zeroFillDeref:
        sta     musicDataChanPtrDeref+7,y
        dey
        bne     @zeroFillDeref
        tax
derefNextAddr:
        lda     musicDataChanPtr,x
        sta     musicChanTmpAddr
        lda     musicDataChanPtr+1,x
        cmp     #$FF
        beq     copyFFFFToDeref
        sta     musicChanTmpAddr+1
        ldy     musicDataChanPtrOff
        lda     (musicChanTmpAddr),y
        sta     musicDataChanPtrDeref,x
        iny
        lda     (musicChanTmpAddr),y
storeDeref1AndContinue:
        sta     musicDataChanPtrDeref+1,x
        inx
        inx
        txa
        cmp     #$08
        bne     derefNextAddr
        rts

initSq12IfTrashedBySoundEffect:
        lda     resetSq12ForMusic
        beq     initSq12IfTrashedBySoundEffect_ret
        cmp     #$01
        beq     @setSq1
        lda     #$7F
        sta     SQ2_SWEEP
        lda     musicStagingSq2Lo
        sta     SQ2_LO
        lda     musicStagingSq2Hi
        sta     SQ2_HI
@setSq1:lda     #$7F
        sta     SQ1_SWEEP
        lda     musicStagingSq1Lo
        sta     SQ1_LO
        lda     musicStagingSq1Hi
        sta     SQ1_HI
        lda     #$00
        sta     resetSq12ForMusic
initSq12IfTrashedBySoundEffect_ret:
        rts

; input x: channel number (0-3). Does nothing for SQ1/2
updateMusicFrame_setChanVol:
        txa
        cmp     #$02
        bcs     initSq12IfTrashedBySoundEffect_ret
        lda     musicChanControl,x
        and     #$1F
        beq     @ret
        sta     AUDIOTMP2
        lda     musicChanNote,x
        cmp     #$02
        beq     @muteAndAdvanceFrame
        ldy     #$00
@controlMinus1Times2_storeToY:
        dec     AUDIOTMP2
        beq     @loadFromTable
        iny
        iny
        bne     @controlMinus1Times2_storeToY
@loadFromTable:
        lda     musicChanVolControlTable,y
        sta     AUDIOTMP3
        lda     musicChanVolControlTable+1,y
        sta     AUDIOTMP4
        lda     musicChanVolFrameCounter,x
        lsr     a
        tay
        lda     (AUDIOTMP3),y
        sta     AUDIOTMP5
        cmp     #$FF
        beq     @constVolAtEnd
        cmp     #$F0
        beq     @muteAtEnd
        lda     musicChanVolFrameCounter,x
        and     #$01
        bne     @useNibbleFromTable
        lsr     AUDIOTMP5
        lsr     AUDIOTMP5
        lsr     AUDIOTMP5
        lsr     AUDIOTMP5
@useNibbleFromTable:
        lda     AUDIOTMP5
        and     #$0F
        sta     AUDIOTMP1
        lda     musicChanVolume,x
        and     #$F0
        ora     AUDIOTMP1
        tay
@advanceFrameAndSetVol:
        inc     musicChanVolFrameCounter,x
@setVol:lda     musicChanInhibit,x
        bne     @ret
        tya
        ldy     musicChannelOffset
        sta     SQ1_VOL,y
@ret:   rts

@constVolAtEnd:
        ldy     musicChanVolume,x
        bne     @setVol
; Only seems valid for NOISE
@muteAtEnd:
        ldy     #$10
        bne     @setVol
; Only seems valid for NOISE
@muteAndAdvanceFrame:
        ldy     #$10
        bne     @advanceFrameAndSetVol
;
updateMusicFrame_progLoadNextScript:
        iny
        lda     (musicChanTmpAddr),y
        sta     musicDataChanPtr,x
        iny
        lda     (musicChanTmpAddr),y
        sta     musicDataChanPtr+1,x
        lda     musicDataChanPtr,x
        sta     musicChanTmpAddr
        lda     musicDataChanPtr+1,x
        sta     musicChanTmpAddr+1
        txa
        lsr     a
        tax
        lda     #$00
        tay
        sta     musicDataChanPtrOff,x
        jmp     updateMusicFrame_progLoadRoutine

updateMusicFrame_progEnd:
        jsr     soundEffectSlot2_makesNoSound
updateMusicFrame_ret:
        rts

updateMusicFrame_progNextRoutine:
        txa
        asl     a
        tax
        lda     musicDataChanPtr,x
        sta     musicChanTmpAddr
        lda     musicDataChanPtr+1,x
        sta     musicChanTmpAddr+1
        txa
        lsr     a
        tax
        inc     musicDataChanPtrOff,x
        inc     musicDataChanPtrOff,x
        ldy     musicDataChanPtrOff,x
; input musicChanTmpAddr: current channel's musicDataChanPtr. input y: offset. input x: channel number (0-3)
updateMusicFrame_progLoadRoutine:
        txa
        asl     a
        tax
        lda     (musicChanTmpAddr),y
        sta     musicDataChanPtrDeref,x
        iny
        lda     (musicChanTmpAddr),y
        sta     musicDataChanPtrDeref+1,x
        cmp     #$00
        beq     updateMusicFrame_progEnd
        cmp     #$FF
        beq     updateMusicFrame_progLoadNextScript
        txa
        lsr     a
        tax
        lda     #$00
        sta     musicDataChanInstructionOffset,x
        lda     #$01
        sta     musicChanNoteDurationRemaining,x
        bne     updateMusicFrame_updateChannel
;
updateMusicFrame_progNextRoutine_jmp:
        jmp     updateMusicFrame_progNextRoutine

updateMusicFrame:
        jsr     initSq12IfTrashedBySoundEffect
        lda     #$00
        tax
        sta     musicChannelOffset
        beq     updateMusicFrame_updateChannel
; input x: channel number * 2
updateMusicFrame_incSlotFromOffset:
        txa
        lsr     a
        tax
; input x: channel number (0-3)
updateMusicFrame_incSlot:
        inx
        txa
        cmp     #$04
        beq     updateMusicFrame_ret
        lda     musicChannelOffset
        clc
        adc     #$04
        sta     musicChannelOffset
; input x: channel number (0-3)
updateMusicFrame_updateChannel:
        txa
        asl     a
        tax
        lda     musicDataChanPtrDeref,x
        sta     musicChanTmpAddr
        lda     musicDataChanPtrDeref+1,x
        sta     musicChanTmpAddr+1
        lda     musicDataChanPtrDeref+1,x
        cmp     #$FF
        beq     updateMusicFrame_incSlotFromOffset
        txa
        lsr     a
        tax
        dec     musicChanNoteDurationRemaining,x
        bne     @updateChannelFrame
        lda     #$00
        sta     musicChanVolFrameCounter,x
        sta     musicChanLoFrameCounter,x
@processChannelInstruction:
        jsr     musicGetNextInstructionByte
        beq     updateMusicFrame_progNextRoutine_jmp
        cmp     #$9F
        beq     @setControlAndVolume
        cmp     #$9E
        beq     @setDurationOffset
        cmp     #$9C
        beq     @setNoteOffset
        tay
        cmp     #$FF
        beq     @endLoop
        and     #$C0
        cmp     #$C0
        beq     @startForLoop
        jmp     @noteAndMaybeDuration

@endLoop:
        lda     musicChanProgLoopCounter,x
        beq     @processChannelInstruction_jmp
        dec     musicChanProgLoopCounter,x
        lda     musicDataChanInstructionOffsetBackup,x
        sta     musicDataChanInstructionOffset,x
        bne     @processChannelInstruction_jmp
; Low 6 bits are number of times to run loop (1 == run code once)
@startForLoop:
        tya
        and     #$3F
        sta     musicChanProgLoopCounter,x
        dec     musicChanProgLoopCounter,x
        lda     musicDataChanInstructionOffset,x
        sta     musicDataChanInstructionOffsetBackup,x
@processChannelInstruction_jmp:
        jmp     @processChannelInstruction

@updateChannelFrame:
        jsr     updateMusicFrame_setChanVol
        jsr     updateMusicFrame_setChanLo
        jmp     updateMusicFrame_incSlot

@playDmcAndNoise_jmp:
        jmp     @playDmcAndNoise

@applyDurationForTri_jmp:
        jmp     @applyDurationForTri

@setControlAndVolume:
        jsr     musicGetNextInstructionByte
        sta     musicChanControl,x
        jsr     musicGetNextInstructionByte
        sta     musicChanVolume,x
        jmp     @processChannelInstruction

@unreferenced_code3:
        jsr     musicGetNextInstructionByte
        jsr     musicGetNextInstructionByte
        jmp     @processChannelInstruction

@setDurationOffset:
        jsr     musicGetNextInstructionByte
        sta     musicDataDurationTableOffset
        jmp     @processChannelInstruction

@setNoteOffset:
        jsr     musicGetNextInstructionByte
        sta     musicDataNoteTableOffset
        jmp     @processChannelInstruction

; Duration, if present, is first
@noteAndMaybeDuration:
        tya
        and     #$B0
        cmp     #$B0
        bne     @processNote
        tya
        and     #$0F
        clc
        adc     musicDataDurationTableOffset
        tay
        lda     noteDurationTable,y
        sta     musicChanNoteDuration,x
        tay
        txa
        cmp     #$02
        beq     @applyDurationForTri_jmp
@loadNextAsNote:
        jsr     musicGetNextInstructionByte
        tay
@processNote:
        tya
        sta     musicChanNote,x
        txa
        cmp     #$03
        beq     @playDmcAndNoise_jmp
        pha
        ldx     musicChannelOffset
        lda     noteToWaveTable+1,y
        beq     @determineVolume
        lda     musicDataNoteTableOffset
        bpl     @signMagnitudeIsPositive
        and     #$7F
        sta     AUDIOTMP4
        tya
        clc
        sbc     AUDIOTMP4 ; Subtracts an extra 1 because carry is cleared
        jmp     @noteOffsetApplied

@signMagnitudeIsPositive:
        tya
        clc
        adc     musicDataNoteTableOffset
@noteOffsetApplied:
        tay
        lda     noteToWaveTable+1,y
        sta     musicStagingSq1Lo,x
        lda     noteToWaveTable,y
        ora     #$08
        sta     musicStagingSq1Hi,x
; Complicated way to determine if we skipped setting lo/hi, maybe because of the needed pla. If we set lo/hi (by falling through from above), then we'll go to @loadVolume. If we jmp'ed here, then we'll end up muting the volume
@determineVolume:
        tay
        pla
        tax
        tya
        bne     @loadVolume
        lda     #$00
        sta     AUDIOTMP1
        txa
        cmp     #$02
        beq     @checkChanControl
        lda     #$10
        sta     AUDIOTMP1
        bne     @checkChanControl
;
@loadVolume:
        lda     musicChanVolume,x
        sta     AUDIOTMP1
; If any of 5 low bits of control is non-zero, then mute
@checkChanControl:
        txa
        dec     musicChanInhibit,x
        cmp     musicChanInhibit,x
        beq     @channelInhibited
        inc     musicChanInhibit,x
        ldy     musicChannelOffset
        txa
        cmp     #$02
        beq     @useDirectVolume
        lda     musicChanControl,x
        and     #$1F
        beq     @useDirectVolume
        lda     AUDIOTMP1
        cmp     #$10
        beq     @setMmio
        and     #$F0
        ora     #$00
        bne     @setMmio
@useDirectVolume:
        lda     AUDIOTMP1
@setMmio:
        sta     SQ1_VOL,y
        lda     musicStagingSq1Sweep,x
        sta     SQ1_SWEEP,y
        lda     musicStagingSq1Lo,y
        sta     SQ1_LO,y
        lda     musicStagingSq1Hi,y
        sta     SQ1_HI,y
@copyDurationToRemaining:
        lda     musicChanNoteDuration,x
        sta     musicChanNoteDurationRemaining,x
        jmp     updateMusicFrame_incSlot

; Never triggered
@channelInhibited:
        inc     musicChanInhibit,x
        jmp     @copyDurationToRemaining

; input y: duration of 60Hz frames. TRI has no volume control. The volume MMIO for TRI goes to a linear counter. While the length counter can be disabled, that doesn't appear possible for the linear counter.
@applyDurationForTri:
        lda     musicChanControl+2
        and     #$1F
        bne     @setTriVolume
        lda     musicChanControl+2
        and     #$C0
        bne     @highCtrlImpliesOn
@useDuration:
        tya
        bne     @durationToLinearClock
@highCtrlImpliesOn:
        cmp     #$C0
        beq     @useDuration
        lda     #$FF
        bne     @setTriVolume
; Not quite clear what the -1 is for. Times 4 because the linear clock counts quarter frames
@durationToLinearClock:
        clc
        adc     #$FF
        asl     a
        asl     a
        cmp     #$3C
        bcc     @setTriVolume
        lda     #$3C
@setTriVolume:
        sta     musicChanVolume+2
        jmp     @loadNextAsNote

@playDmcAndNoise:
        tya
        pha
        jsr     playDmc
        pla
        and     #$3F
        tay
        jsr     playNoise
        jmp     @copyDurationToRemaining

; Weird that it references slot 0. Slot 3 would make most sense as NOISE channel and slot 1 would make sense if the point was to avoid noise during a sound effect. But slot 0 isn't used very often
playNoise:
        lda     soundEffectSlot0Playing
        bne     @ret
        lda     noises_table,y
        sta     NOISE_VOL
        lda     noises_table+1,y
        sta     NOISE_LO
        lda     noises_table+2,y
        sta     NOISE_HI
@ret:   rts

playDmc:tya
        and     #$C0
        cmp     #$40
        beq     @loadDmc0
        cmp     #$80
        beq     @loadDmc1
        rts

; dmc0
@loadDmc0:
        lda     #$0E
        sta     AUDIOTMP2
        lda     #$07
        ldy     #$00
        beq     @loadIntoDmc
; dmc1
@loadDmc1:
        lda     #$0E
        sta     AUDIOTMP2
        lda     #$0F
        ldy     #$02
; Note that bit 4 in SND_CHN is 0. That disables DMC. It enables all channels but DMC
@loadIntoDmc:
        sta     DMC_LEN
        sty     DMC_START
        lda     $06F7
        bne     @ret
        lda     AUDIOTMP2
        sta     DMC_FREQ
        lda     #$0F
        sta     SND_CHN
        lda     #$00
        sta     DMC_RAW
        lda     #$1F
        sta     SND_CHN
@ret:   rts

; input x: music channel. output a: next value
musicGetNextInstructionByte:
        ldy     musicDataChanInstructionOffset,x
        inc     musicDataChanInstructionOffset,x
        lda     (musicChanTmpAddr),y
        rts

; Instrument envelopes, listed as a series of nibbles corresponding to volume. $FF sustains the last volume, while $F0 releases
musicChanVolControlTable:
        .addr   LEA76
        .addr   LEA82
        .addr   LEA8B
        .addr   LEA91
        .addr   LEA9A
        .addr   LEAA2
        .addr   LEAA5
        .addr   LEAA8
        .addr   LEAAC
        .addr   LEABA
        .addr   LEAC7
        .addr   LEAD4
        .addr   LEADE
        .addr   LEAE8
        .addr   LEAF2
        .addr   LEAF7
        .addr   LEAFC
        .addr   LEB01
        .addr   LEB05
        .addr   LEB0A
        .addr   LEB0D
        .addr   LEB10
LEA76:  .byte   $46,$89,$87,$76,$66,$55,$44,$33
        .byte   $22,$21,$11,$F0
LEA82:  .byte   $86,$55,$44,$44,$31,$11,$11,$11
        .byte   $F0
LEA8B:  .byte   $54,$43,$33,$22,$11,$F0
LEA91:  .byte   $23,$45,$77,$66,$55,$44,$44,$44
        .byte   $FF
LEA9A:  .byte   $32,$22,$22,$22,$22,$22,$22,$FF
LEAA2:  .byte   $99,$81,$FF
LEAA5:  .byte   $58,$71,$FF
LEAA8:  .byte   $E7,$99,$81,$FF
LEAAC:  .byte   $A8,$66,$55,$54,$43,$43,$32,$22
        .byte   $22,$21,$11,$11,$11,$F0
LEABA:  .byte   $97,$65,$44,$33,$33,$33,$22,$22
        .byte   $11,$11,$11,$11,$F0
LEAC7:  .byte   $65,$44,$44,$33,$22,$22,$11,$11
        .byte   $11,$11,$11,$11,$F0
LEAD4:  .byte   $44,$33,$22,$22,$11,$11,$11,$11
        .byte   $11,$F0
LEADE:  .byte   $22,$22,$11,$11,$11,$11,$11,$11
        .byte   $11,$F0
LEAE8:  .byte   $97,$65,$32,$43,$21,$11,$32,$21
        .byte   $11,$FF
LEAF2:  .byte   $D8,$76,$54,$32,$FF
LEAF7:  .byte   $B8,$76,$53,$21,$FF
LEAFC:  .byte   $85,$43,$21,$11,$FF
LEB01:  .byte   $53,$22,$11,$FF
LEB05:  .byte   $EB,$97,$53,$21,$FF
LEB0A:  .byte   $A9,$91,$F0
LEB0D:  .byte   $85,$51,$F0
LEB10:  .byte   $63,$31,$F0
; Rounds slightly differently, but can use for reference: https://web.archive.org/web/20180315161431if_/http://www.freewebs.com:80/the_bott/NotesTableNTSC.txt
noteToWaveTable:
        ; $00: A1, rest, C2, Db2
        .dbyt   $07F0,$0000,$06AE,$064E
        ; $08: D2, Eb2, E2, F2
        .dbyt   $05F3,$059E,$054D,$0501
        ; $10: Gb2, G2, Ab2, A2
        .dbyt   $04B9,$0475,$0435,$03F8
        ; $18: Bb2, B2, C3, Db3
        .dbyt   $03BF,$0389,$0357,$0327
        ; $20: D3, Eb3, E3, F3
        .dbyt   $02F9,$02CF,$02A6,$0280
        ; $28: Gb3, G3, Ab3, A3
        .dbyt   $025C,$023A,$021A,$01FC
        ; $30: Bb3, B4, C4, Db4
        .dbyt   $01DF,$01C4,$01AB,$0193
        ; $38: D4, Eb4, E4, F4
        .dbyt   $017C,$0167,$0152,$013F
        ; $40: Gb4, G4, Ab4, A4
        .dbyt   $012D,$011C,$010C,$00FD
        ; $48: Bb4, B4, C5, Db5
        .dbyt   $00EE,$00E1,$00D4,$00C8
        ; $50: D5, Eb5, E5, F5
        .dbyt   $00BD,$00B2,$00A8,$009F
        ; $58: Gb5, G5, Ab5, A5
        .dbyt   $0096,$008D,$0085,$007E
        ; $60: Bb5, B5, C6, Db6
        .dbyt   $0076,$0070,$0069,$0063
        ; $68: D6, Eb6, E6, F6
        .dbyt   $005E,$0058,$0053,$004F
        ; $70: Gb6, G6, Ab6, A6
        .dbyt   $004A,$0046,$0042,$003E
        ; $78: Bb6, B6, C7, Db7
        .dbyt   $003A,$0037,$0034,$0031
        ; $80: D7, Eb7, E7, F7
        .dbyt   $002E,$002B,$0029,$0027
        ; $88: very high, Gb7, G7, Ab7
        .dbyt   $0001,$0024,$0022,$0020
        ; $90: A7, Bb7, B7, Eb8
        .dbyt   $001E,$001C,$001A,$000A
        ; $98: Ab8, Db8
        .dbyt   $0010,$0019

noteDurationTable:
.if PAL = 1
        .byte   $02,$05,$0A,$14,$28,$0F,$1E,$03
        .byte   $02,$04,$08,$10,$20,$0C,$18,$06
        .byte   $05,$02,$01,$01,$03,$06,$0C,$18
        .byte   $30,$12,$24,$09,$08,$04,$02,$01
        .byte   $04,$08,$10,$20,$40,$18,$30,$0C
        .byte   $0A,$05,$02,$01,$05,$0A,$14,$28
        .byte   $50,$1E,$3C,$0F,$0D,$06,$02,$01
        .byte   $06,$0C,$18,$30,$60,$24,$48,$12
        .byte   $10,$08,$03,$01,$04,$02,$00,$90
.else
; 1/16  note, 1/8 note, 1/4 note, 1/2 note, full note, 3/8 note, 3/4 note, 3/16 note
        ; 300 bpm
        .byte   $03,$06,$0C,$18,$30,$12,$24,$09
        .byte   $08,$04,$02,$01
        ; 225 bpm
        .byte   $04,$08,$10,$20,$40,$18,$30,$0C
        .byte   $0A,$05,$02,$01
        ; 180 bpm
        .byte   $05,$0A,$14,$28,$50,$1E,$3C,$0F
        .byte   $0D,$06,$02,$01
        ; 150 bpm
        .byte   $06,$0C,$18,$30,$60,$24,$48,$12
        .byte   $10,$08,$03,$01,$04,$02,$00,$90
        ; 128 bpm
        .byte   $07,$0E,$1C,$38,$70,$2A,$54,$15
        .byte   $12,$09,$03,$01,$02
        ; 112 bpm
        .byte   $08,$10,$20,$40,$80,$30,$60,$18
        .byte   $15,$0A,$04,$01,$02,$C0
        ; 100 bpm
        .byte   $09,$12,$24,$48,$90,$36,$6C,$1B
        .byte   $18
        ; 90 bpm
        .byte   $0A,$14,$28,$50,$A0,$3C,$78,$1E
        .byte   $1A,$0D,$05,$01,$02,$17
        ; 82 bpm
        .byte   $0B,$16,$2C,$58,$B0,$42,$84,$21
        .byte   $1D,$0E,$05,$01,$02,$17
.endif
musicDataTableIndex:
        .byte   $00,$0A,$14,$1E,$28,$32,$3C,$46
        .byte   $50,$5A

; First byte corresponds to a key offset that applies to all notes for each channel (excluding noise probably)
; Value of %0xxxxxxx adds xxxxxxx to each index, while %1xxxxxxx subtracts (xxxxxxx+1) to each index
; so $0A shifts each note up by 5 half steps and $83 shifts each note down 2 half steps (note table entries are 2 bytes)
; Second byte controls tempo, indexing into noteDurationTable
; Each table entry is written into musicDataNoteTableOffset
musicDataTable:
.if PAL = 1
        .byte   $0A,$2C
.else
        .byte   $0A,$24
.endif
        .addr   music_titleScreen_sq1Script
        .addr   music_titleScreen_sq2Script
        .addr   music_titleScreen_triScript
        .addr   music_titleScreen_noiseScript
        .byte   $83,$00
        .addr   music_bTypeGoalAchieved_sq1Script
        .addr   music_bTypeGoalAchieved_sq2Script
        .addr   music_bTypeGoalAchieved_triScript
        .addr   music_bTypeGoalAchieved_noiseScript
.if PAL = 1
        .byte   $81,$2C
.else
        .byte   $81,$24
.endif
        .addr   music_music1_sq1Script
        .addr   music_music1_sq2Script
        .addr   music_music1_triScript
        .addr   music_music1_noiseScript
.if PAL = 1
        .byte   $83,$2C
.else
        .byte   $83,$24
.endif
        .addr   music_music2_sq1Script
        .addr   music_music2_sq2Script
        .addr   music_music2_triScript
        .addr   music_music2_noiseScript
.if PAL = 1
        .byte   $81,$2C
.else
        .byte   $81,$24
.endif
        .addr   music_music3_sq1Script
        .addr   music_music3_sq2Script
        .addr   music_music3_triScript
        .addr   LFFFF
.if PAL = 1
        .byte   $81,$08
.else
        .byte   $81,$00
.endif
        .addr   music_music1_sq1Script
        .addr   music_music1_sq2Script
        .addr   music_music1_triScript
        .addr   music_music1_noiseScript
.if PAL = 1
        .byte   $83,$14
.else
        .byte   $83,$0C
.endif
        .addr   music_music2_sq1Script
        .addr   music_music2_sq2Script
        .addr   music_music2_triScript
        .addr   music_music2_noiseScript
.if PAL = 1
        .byte   $81,$14
.else
        .byte   $81,$0C
.endif
        .addr   music_music3_sq1Script
        .addr   music_music3_sq2Script
        .addr   music_music3_triScript
        .addr   LFFFF
.if PAL = 1
        .byte   $00,$20
.else
        .byte   $00,$18
.endif
        .addr   music_congratulations_sq1Script
        .addr   music_congratulations_sq2Script
        .addr   music_congratulations_triScript
        .addr   music_congratulations_noiseScript
.if PAL = 1
        .byte   $8F,$2C
.else
        .byte   $8F,$24
.endif
        .addr   music_endings_sq1Script
        .addr   music_endings_sq2Script
        .addr   music_endings_triScript
        .addr   music_endings_noiseScript
music_bTypeGoalAchieved_sq1Script:
        .addr   music_bTypeGoalAchieved_sq1Routine1
        .addr   tmp1
music_bTypeGoalAchieved_sq2Script:
        .addr   music_bTypeGoalAchieved_triRoutine1
music_bTypeGoalAchieved_triScript:
        .addr   music_bTypeGoalAchieved_sq2Routine1
music_bTypeGoalAchieved_noiseScript:
        .addr   music_bTypeGoalAchieved_noiseRoutine1
.include "audio/music/music_bTypeGoalAchieved.asm"
music_titleScreen_sq1Script:
        .addr   music_titleScreen_sq1Routine1
        .addr   tmp1
music_titleScreen_sq2Script:
        .addr   music_titleScreen_sq2Routine1
music_titleScreen_triScript:
        .addr   music_titleScreen_triRoutine1
music_titleScreen_noiseScript:
        .addr   music_titleScreen_noiseRoutine1
        .addr   LFFFF
        .addr   music_titleScreen_noiseScript
.include "audio/music/music_titlescreen.asm"

; Only 256 bytes can be accessed at a time due to relative addressing, so the various routine addresses are like checkpoints in the music.
music_music1_sq1Script:
        .addr   music_music1_sq1Routine1
        .addr   music_music1_sq1Routine2
        .addr   music_music1_sq1Routine3
        .addr   LFFFF
        .addr   music_music1_sq1Script
music_music1_sq2Script:
        .addr   music_music1_sq2Routine1
        .addr   music_music1_sq2Routine2
        .addr   music_music1_sq2Routine3
        .addr   LFFFF
        .addr   music_music1_sq2Script
music_music1_triScript:
        .addr   music_music1_triRoutine1
        .addr   music_music1_triRoutine2
        .addr   music_music1_triRoutine3
        .addr   LFFFF
        .addr   music_music1_triScript
music_music1_noiseScript:
        .addr   music_music1_noiseRoutine1
        .addr   LFFFF
        .addr   music_music1_noiseScript
.include "audio/music/music1.asm"
music_music3_sq1Script:
        .addr   music_music3_sq1Routine1
music_music3_sq1ScriptLoop:
        .addr   music_music3_sq1Routine2
        .addr   LFFFF
        .addr   music_music3_sq1ScriptLoop
music_music3_sq2Script:
        .addr   music_music3_sq2Routine1
        .addr   LFFFF
        .addr   music_music3_sq2Script
music_music3_triScript:
        .addr   music_music3_triRoutine1
        .addr   LFFFF
        .addr   music_music3_triScript
; unreferenced
music_music3_noiseScript:
        .addr   music_music3_noiseRoutine1
        .addr   LFFFF
        .addr   music_music3_noiseScript
.include "audio/music/music3.asm"
music_congratulations_sq1Script:
        .addr   music_congratulations_sq1Routine1
        .addr   LFFFF
        .addr   music_congratulations_sq1Script
music_congratulations_sq2Script:
        .addr   music_congratulations_sq2Routine1
        .addr   LFFFF
        .addr   music_congratulations_sq2Script
music_congratulations_triScript:
        .addr   music_congratulations_triRoutine1
        .addr   LFFFF
        .addr   music_congratulations_triScript
music_congratulations_noiseScript:
        .addr   music_congratulations_noiseRoutine1
        .addr   LFFFF
        .addr   music_congratulations_noiseScript
.include "audio/music/music_congratulations.asm"
music_music2_sq1Script:
        .addr   music_music2_sq1Routine1
        .addr   music_music2_sq1Routine2
        .addr   music_music2_sq1Routine3
        .addr   music_music2_sq1Routine3
        .addr   music_music2_sq1Routine4
        .addr   LFFFF
        .addr   music_music2_sq1Script
music_music2_sq2Script:
        .addr   music_music2_sq2Routine1
        .addr   music_music2_sq2Routine2
        .addr   music_music2_sq2Routine3
        .addr   music_music2_sq2Routine3
        .addr   music_music2_sq2Routine4
        .addr   LFFFF
        .addr   music_music2_sq2Script
music_music2_triScript:
        .addr   music_music2_triRoutine1
        .addr   music_music2_triRoutine2
        .addr   music_music2_triRoutine3
        .addr   music_music2_triRoutine3
        .addr   music_music2_triRoutine4
        .addr   LFFFF
        .addr   music_music2_triScript
music_music2_noiseScript:
        .addr   music_music2_noiseRoutine1
        .addr   LFFFF
        .addr   music_music2_noiseScript
.include "audio/music/music2.asm"
music_endings_sq1Script:
        .addr   music_endings_sq1Routine1
        .addr   music_endings_sq1Routine2
        .addr   music_endings_sq1Routine1
        .addr   music_endings_sq1Routine3
        .addr   LFFFF
        .addr   music_endings_sq1Script
music_endings_sq2Script:
        .addr   music_endings_sq2Routine1
        .addr   music_endings_sq2Routine2
        .addr   music_endings_sq2Routine1
        .addr   music_endings_sq2Routine3
        .addr   LFFFF
        .addr   music_endings_sq2Script
music_endings_triScript:
        .addr   music_endings_triRoutine1
        .addr   music_endings_triRoutine2
        .addr   music_endings_triRoutine1
        .addr   music_endings_triRoutine3
        .addr   LFFFF
        .addr   music_endings_triScript
music_endings_noiseScript:
        .addr   music_endings_noiseRoutine1
        .addr   music_endings_noiseRoutine1
        .addr   music_endings_noiseRoutine1
        .addr   music_endings_noiseRoutine2
        .addr   LFFFF
        .addr   music_endings_noiseScript
.include "audio/music/music_endings.asm"

; End of "PRG_chunk2" segment
.code


.segment        "unreferenced_data4": absolute

.include "data/unreferenced_data4.asm"

; End of "unreferenced_data4" segment
.code


.segment        "PRG_chunk3": absolute

; incremented to reset MMC1 reg
reset:
.if NWC = 1
        nop
        nop
.endif
        cld
.if NWC <> 1
        sei
.endif
        ldx     #$00
.if NWC = 1
        sta     currentPpuCtrl
.endif
        stx     PPUCTRL
        stx     PPUMASK
@vsyncWait1:
        lda     PPUSTATUS
        bpl     @vsyncWait1
@vsyncWait2:
        lda     PPUSTATUS
        bpl     @vsyncWait2
        dex
        txs
.if NWC = 1
        lda     #$00
.else
        inc     reset
        lda     #MMC1_4KCHR_32KPRG_H_MIRROR
.endif
        jsr     setMMC1Control
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank0
        lda     #CHR_TITLE_MENU
        jsr     changeCHRBank1
.if NWC = 1
        lda     #$00
.else
        lda     #PRG_32K_BANK
.endif
        jsr     changePRGBank
        jmp     initRam

.if NWC = 1
        lda     #$10
        jsr     $F1BD
        lda     #$00
        jsr     $F1BD
        jmp     initRam

.include "data/unreferenced_data5_nwc.asm"

.else

.include "data/unreferenced_data5.asm"

; Unreferenced.  Label previously used as MMC1_PRG
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00
        .byte   $00
; End of "PRG_chunk3" segment

.endif

.code


.segment        "VECTORS": absolute

        .addr   nmi
        .addr   reset
.if NWC = 1
        .word   $6010
.else
        .addr   irq
.endif

; End of "VECTORS" segment
.code
