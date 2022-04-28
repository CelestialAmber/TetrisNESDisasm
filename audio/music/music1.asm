; There are 3 main types of commands that controls the instrument, duration, and pitch of the note
; Instrument commands start with $9F and are followed by 2 values, stored into musicChanControl,x and musicVolControl,x
; musicChanControl,x selects the type of instrument (1-indexed) using the low 5 bytes (high 3 bytes control something else?)
; High byte of musicVolControl,x is stored in SQ1_VOL, so controls duty cycle and other flags. Low byte unknown
; Duration commands have the form $Bx, where the x an index into a table of note lengths. It dictates the lengths for all notes after it, until another $Bx command comes up
; All other bytes are indices into the note table, but also shifted per the note offset param in the song header
music_music1_sq1Routine1:
        .byte   $9F,$0A,$F1,$B2,$20,$38,$20,$38
        .byte   $9F,$0D,$F1,$B2,$20,$38,$20,$38
        .byte   $9F,$0A,$F1,$B2,$20,$B1,$46,$3E
        .byte   $B2,$46,$42,$3C,$3E,$B1,$40,$40
        .byte   $B2,$40,$B1,$42,$42,$B2,$42,$B1
        .byte   $3C,$3C,$B2,$3C,$B1,$3E,$3E,$42
        .byte   $42,$B2,$3E,$9F,$0A,$F1,$B0,$56
        .byte   $9F,$0B,$F1,$B0,$54,$9F,$0C,$F1
        .byte   $B0,$50,$9F,$0D,$F1,$B0,$4C,$9F
        .byte   $0D,$F1,$B2,$4A,$38,$50,$4E,$4E
        .byte   $50,$9F,$09,$F1,$B1,$50,$50,$B2
        .byte   $50,$B1,$4C,$4C,$B2,$4C,$B1,$4A
        .byte   $4A,$B2,$4A,$B1,$46,$46,$4A,$4A
        .byte   $B2,$46,$9F,$0D,$F1,$B0,$44,$9F
        .byte   $0C,$F1,$B0,$46,$9F,$0B,$F1,$B0
        .byte   $4A,$9F,$0A,$F1,$B0,$4E,$9F,$09
        .byte   $F1,$B2,$50,$B1,$46,$3E,$B2,$46
        .byte   $42,$3C,$3E,$B1,$40,$40,$B2,$40
        .byte   $B1,$42,$42,$B2,$42,$B1,$3C,$3C
        .byte   $B2,$3C,$B1,$3E,$3E,$42,$42,$B2
        .byte   $3E,$B0,$50,$4C,$4A,$46,$B2,$44
        .byte   $B1,$44,$44,$B2,$44,$B0,$46,$4A
        .byte   $46,$42,$B2,$40,$B1,$40,$40,$B2
        .byte   $40,$B0,$42,$46,$42,$3E,$B2,$3C
        .byte   $B1,$3C,$3C,$B2,$3C,$3E,$02,$3C
        .byte   $9F,$09,$F1,$3E,$02,$00
music_music1_sq2Routine1:
        .byte   $9F,$0A,$F1,$B2,$20,$3E,$20,$3E
        .byte   $9F,$0B,$F1,$B2,$20,$3E,$20,$3E
        .byte   $9F,$09,$F1,$B2,$02,$B1,$56,$50
        .byte   $B2,$56,$54,$4E,$50,$B1,$4C,$4C
        .byte   $B2,$4C,$B1,$4A,$4A,$B2,$4A,$B1
        .byte   $48,$48,$B2,$48,$B1,$46,$50,$48
        .byte   $50,$B2,$46,$02,$9F,$0C,$F1,$02
        .byte   $B1,$50,$4A,$B2,$50,$B1,$54,$46
        .byte   $B2,$54,$50,$9F,$09,$F1,$B1,$56
        .byte   $56,$B2,$56,$B1,$54,$54,$B2,$54
        .byte   $B1,$50,$50,$B2,$50,$B1,$4E,$54
        .byte   $50,$54,$B3,$4E,$9F,$09,$F1,$B2
        .byte   $02,$B1,$56,$50,$B2,$56,$54,$4E
        .byte   $50,$B1,$4C,$4C,$B2,$4C,$B1,$4A
        .byte   $4A,$B2,$4A,$B1,$48,$48,$B2,$48
        .byte   $B1,$46,$50,$48,$50,$B2,$46,$02
        .byte   $B2,$02,$B1,$50,$4A,$B2,$50,$4E
        .byte   $02,$B1,$4C,$46,$B2,$4C,$4A,$02
        .byte   $B1,$48,$42,$B2,$48,$46,$02,$46
        .byte   $9F,$09,$F1,$50,$02,$00
music_music1_triRoutine1:
        .byte   $9F,$00,$00,$C4,$B2,$20,$B1,$46
        .byte   $02,$FF,$B2,$38,$B1,$50,$02,$B2
        .byte   $38,$B1,$4A,$02,$B2,$38,$B1,$44
        .byte   $02,$B2,$38,$B1,$50,$02,$B2,$38
        .byte   $B1,$50,$02,$B2,$38,$B1,$50,$02
        .byte   $C3,$38,$02,$FF,$B0,$56,$54,$50
        .byte   $4C,$B2,$44,$B1,$4A,$02,$B2,$42
        .byte   $B1,$5E,$02,$B2,$3E,$B1,$5E,$02
        .byte   $B2,$3C,$B1,$62,$02,$B2,$3C,$B1
        .byte   $5E,$02,$B2,$3C,$B1,$5C,$02,$C3
        .byte   $B1,$46,$02,$FF,$B2,$02,$B2,$38
        .byte   $B1,$50,$02,$B2,$38,$B1,$62,$02
        .byte   $B2,$38,$B1,$5C,$02,$B2,$38,$B1
        .byte   $5E,$02,$B2,$38,$B1,$50,$02,$B2
        .byte   $38,$B1,$60,$02,$C3,$38,$02,$FF
        .byte   $B0,$50,$4C,$4A,$46,$B2,$3C,$B1
        .byte   $62,$02,$B2,$62,$B1,$46,$02,$B2
        .byte   $38,$B1,$5E,$02,$B2,$46,$B1,$2A
        .byte   $02,$B2,$34,$B1,$42,$02,$B2,$42
        .byte   $B1,$46,$02,$B2,$02,$46,$38,$02
        .byte   $00
music_music1_sq1Routine2:
        .byte   $C2,$B1,$46,$46,$4A,$4A,$4E,$4E
        .byte   $50,$50,$50,$50,$4A,$4A,$B2,$4E
        .byte   $76,$B9,$38,$3E,$46,$38,$3E,$46
        .byte   $38,$3E,$46,$38,$3E,$46,$34,$3C
        .byte   $42,$34,$3C,$42,$B1,$42,$02,$64
        .byte   $02,$FF,$9F,$0C,$F1,$B1,$5E,$5E
        .byte   $62,$62,$B2,$66,$B1,$46,$02,$9F
        .byte   $0B,$F1,$B1,$68,$68,$6C,$6C,$B2
        .byte   $6E,$B1,$46,$02,$9F,$09,$F1,$B1
        .byte   $6C,$6C,$6E,$6E,$B2,$72,$B1,$46
        .byte   $02,$B1,$6E,$6E,$72,$72,$00
music_music1_sq2Routine2:
        .byte   $C2,$B1,$4E,$4E,$50,$50,$54,$54
        .byte   $56,$56,$5A,$5A,$50,$50,$B2,$54
        .byte   $02,$9F,$09,$F1,$02,$B1,$4E,$02
        .byte   $B3,$50,$B2,$02,$B1,$4A,$02,$B3
        .byte   $4C,$FF,$9F,$0C,$F1,$B1,$66,$66
        .byte   $68,$68,$B2,$6C,$B1,$46,$02,$9F
        .byte   $0B,$F1,$B1,$5E,$62,$66,$66,$B2
        .byte   $68,$B1,$46,$02,$9F,$09,$F1,$B1
        .byte   $5E,$66,$68,$68,$B2,$6C,$B1,$46
        .byte   $02,$B1,$5E,$68,$6C,$6C,$00
music_music1_triRoutine2:
        .byte   $C2,$B1,$46,$46,$46,$46,$5E,$5E
        .byte   $5E,$5E,$62,$62,$62,$62,$5E,$02
        .byte   $46,$02,$B2,$38,$38,$B1,$38,$02
        .byte   $38,$02,$B3,$34,$B1,$34,$02,$4C
        .byte   $02,$FF,$C4,$B1,$46,$FF,$B2,$46
        .byte   $B0,$5C,$5E,$02,$02,$C4,$B1,$5E
        .byte   $FF,$B2,$5E,$B0,$5C,$5E,$02,$02
        .byte   $C4,$B1,$5E,$FF,$B2,$5E,$B0,$5C
        .byte   $5E,$02,$02,$C4,$B1,$76,$FF,$00
music_music1_sq1Routine3:
        .byte   $9F,$0E,$F1,$B2,$6E,$4E,$4C,$4E
        .byte   $4C,$56,$54,$56,$54,$62,$5E,$62
        .byte   $5E,$62,$5A,$62,$5A,$76,$B2,$2E
        .byte   $00
music_music1_sq2Routine3:
        .byte   $9F,$0F,$F1,$B2,$76,$B0,$02,$54
        .byte   $5A,$60,$02,$54,$5A,$5E,$02,$54
        .byte   $5A,$60,$02,$54,$5A,$5E,$02,$5A
        .byte   $62,$68,$02,$5A,$62,$66,$02,$66
        .byte   $72,$78,$02,$5A,$62,$66,$02,$5A
        .byte   $62,$66,$02,$66,$72,$76,$02,$66
        .byte   $72,$78,$02,$66,$72,$76,$02,$6C
        .byte   $72,$80,$02,$6C,$72,$7E,$02,$6C
        .byte   $72,$80,$02,$6C,$72,$7E,$B2,$76
        .byte   $B2,$2E,$00
music_music1_triRoutine3:
        .byte   $B2,$76,$02,$02,$02,$02,$02,$02
        .byte   $02,$02,$6C,$66,$6C,$66,$6C,$5E
        .byte   $6C,$5E,$76,$B2,$02,$00
music_music1_noiseRoutine1:
        .byte   $C4,$B2,$01,$04,$FF,$C6,$01,$04
        .byte   $FF,$01,$07,$07,$01,$C6,$01,$04
        .byte   $FF,$01,$07,$07,$01,$C6,$01,$04
        .byte   $FF,$01,$07,$07,$01,$C2,$01,$07
        .byte   $07,$01,$FF,$01,$04,$01,$04,$01
        .byte   $07,$07,$01,$C2,$B4,$04,$FF,$C2
        .byte   $B2,$01,$04,$04,$04,$FF,$C2,$B4
        .byte   $04,$FF,$C2,$B2,$01,$04,$04,$04
        .byte   $FF,$C3,$B1,$04,$04,$04,$04,$B2
        .byte   $04,$01,$FF,$B1,$04,$04,$04,$04
        .byte   $B2,$04,$C4,$B4,$01,$FF,$B3,$01
        .byte   $00