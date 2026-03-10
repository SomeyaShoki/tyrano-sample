; =========================================
; タイトル画面表示マクロ
; =========================================
[macro name="hotel_title_layout"]
; -----------------------------------------
; スマホ用レイアウト
; -----------------------------------------
[if exp="sf.sys_is_mobile == true"]

    ; タイトルテキスト
    [ptext layer="1" page="fore" text="脱出ゲーム集" size="70" x="0" y="120" width="1280" align="center" color="0xffffff" bold="true" zindex="20"]
    [ptext layer="1" page="fore" text="どのゲームで遊びますか？" size="36" x="0" y="220" width="1280" align="center" color="0xdddddd" zindex="20"]
    [ptext layer="1" page="fore" text="〇〇からの脱出" size="34" x="0" y="272" width="1280" align="center" color="0xfff1b8" zindex="20"]

    [if exp="f.hotel_is_cleared == true"]
        [ptext layer="1" page="fore" text="高層ホテルからの脱出：クリア済み" size="24" x="0" y="312" width="1280" align="center" color="0x9ef7a9" zindex="20"]
    [endif]

    ; 選択肢ボタン
    [glink target="*trpg_game_start" text="会議室からの脱出" size="40" x="240" y="320" width="800" align="center" color="black" zindex="30"]
    [glink target="*start" text="高層ホテルからの脱出" size="40" x="240" y="420" width="800" align="center" color="black" zindex="30"]
    [glink target="*hotel_show_load" text="続きから" size="40" x="240" y="520" width="800" align="center" color="black" zindex="30"]

; -----------------------------------------
; PC用レイアウト
; -----------------------------------------
[else]

    ; 1280x720向け中央揃え
    [ptext layer="1" page="fore" text="脱出ゲーム集" size="50" x="0" y="160" width="1280" align="center" color="0xffffff" bold="true" zindex="20"]
    [ptext layer="1" page="fore" text="どのゲームで遊びますか？" size="24" x="0" y="240" width="1280" align="center" color="0xdddddd" zindex="20"]
    [ptext layer="1" page="fore" text="〇〇からの脱出" size="24" x="0" y="276" width="1280" align="center" color="0xfff1b8" zindex="20"]

    [if exp="f.hotel_is_cleared == true"]
        [ptext layer="1" page="fore" text="高層ホテルからの脱出：クリア済み" size="20" x="0" y="306" width="1280" align="center" color="0x9ef7a9" zindex="20"]
    [endif]

    [glink target="*trpg_game_start" text="会議室からの脱出" size="28" x="390" y="330" width="500" align="center" color="black" zindex="30"]
    [glink target="*start" text="高層ホテルからの脱出" size="28" x="390" y="410" width="500" align="center" color="black" zindex="30"]
    [glink target="*hotel_show_load" text="続きから" size="28" x="390" y="490" width="500" align="center" color="black" zindex="30"]

[endif]
[endmacro]

[return]
