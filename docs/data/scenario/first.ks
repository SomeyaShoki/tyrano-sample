; ==========================================
; 1. タイトル画面 (first.ks の一番上に配置)
; ==========================================
*hotel_title
[cm]
[clearstack]
[clearsysvar]
; タイトル背景の表示
[bg storage="sleep.jpg" time="1000"]

; タイトルテキスト (※レイヤー1に表示。画像でタイトルロゴを作る場合は不要です)
[ptext layer="1" page="fore" text="高層ホテルからの脱出" size="40" x="400" y="200" color="0xFFFFFF" name="hotel_title_txt"]

; メニューボタン（画像ボタン使用）
[button graphic="button/menu.png" enterimg="button/menu2.png" target="*start" x="500" y="400"]
[ptext layer="1" page="fore" text="最初から" size="24" x="530" y="415" color="0x333333" name="hotel_btn_start_txt"]

[button graphic="button/load.png" enterimg="button/load2.png" target="*hotel_show_load" x="500" y="500"]
[ptext layer="1" page="fore" text="続きから" size="24" x="530" y="515" color="0x333333" name="hotel_btn_load_txt"]
[s]

*hotel_show_load
[cm]
[showload]
[jump target="*hotel_title"]


; ==========================================
; 2. ゲーム初期化 (タイトルから「最初から」を選んだ場合の処理)
; ==========================================
*start
[cm]
; タイトル画面のテキストを消去
[free name="hotel_title_txt" layer="1"]
[free name="hotel_btn_start_txt" layer="1"]
[free name="hotel_btn_load_txt" layer="1"]

; --- 変数初期化 ---
[eval exp="f.hotel_door_locked = true"]
[eval exp="f.hotel_has_key = false"]


; ==========================================
; 3. メインルーム（探索の起点）
; ==========================================
[bg storage="hotel_room.jpg" time="1000"]

*hotel_main_room
[cm]
; --- 現在の背景を保存（ポーズ画面から戻る際に復元するため） ---
[eval exp="tf.hotel_current_bg = 'hotel_room.jpg'"]

高層ホテルの豪華な一室だ。[l][r]
どうにかしてここから脱出しなければ。[l][cm]

; 探索UI（Unicode 絵文字使用 + テキストボタン）
[button x="150" y="380" text="🚪\nドアを調べる" target="*hotel_check_door" width="100" height="80"]

[button x="350" y="380" text="💼\n机を調べる" target="*hotel_check_desk" width="100" height="80"]

[button x="550" y="380" text="🪟\n窓の外を見る" target="*hotel_check_window" width="100" height="80"]

; --- [追加] ポーズ画面へのボタン (画像ボタン使用) ---
[button graphic="button/menu.png" enterimg="button/menu2.png" target="*hotel_pause" x="1200" y="20"]
[s]

; --- 3. ギミック：机（アイテム取得） ---
*hotel_check_desk
[cm]
立派な書斎机がある。引き出しを開けてみた。[l][cm]
[if exp="f.hotel_has_key == false"]
    中にカードキーが入っていた！[l][r]
    カードキーを手に入れた。[l][cm]
    [eval exp="f.hotel_has_key = true"]
[else]
    引き出しの中には、もう何もない。[l][cm]
[endif]
[jump target="*hotel_main_room"]

; --- 4. ギミック：窓（フレーバーテキスト） ---
*hotel_check_window
[cm]
; 窓シーンの背景を保存
[eval exp="tf.hotel_current_bg = 'hotel_window.jpg'"]
[bg storage="hotel_window.jpg" time="500"]
窓の下には美しい夜景が広がっている。[l][r]
しかし、高すぎてここから脱出するのは不可能だ。[l][cm]
[eval exp="tf.hotel_current_bg = 'hotel_room.jpg'"]
[bg storage="hotel_room.jpg" time="500"]
[jump target="*hotel_main_room"]

; --- 5. ギミック：ドア（クリア判定） ---
*hotel_check_door
[cm]
[if exp="f.hotel_has_key == true"]
    手に入れたカードキーを電子ロックにかざした。[l][r]
    「ピピッ」という音と共に、ロックが解除された！[l][cm]
    [eval exp="f.hotel_door_locked = false"]
    [jump target="*hotel_ending"]
[else]
    頑丈なドアだ。電子ロックがかかっている。[l][r]
    カードキーがないと開かないようだ。[l][cm]
[endif]
[jump target="*hotel_main_room"]

; --- 6. エンディング ---
*hotel_ending
[cm]
[bg storage="hotel_corridor.jpg" time="1000"]
部屋から脱出することに成功した！[l][cm]
; ※ここからタイトル画面へ戻る、またはクレジットを表示するなどの処理へ繋げます
ゲームクリア！[l][cm]
[s]


; --- 4. ポーズ画面 (背景情報の保存と復元機能付き) ---
*hotel_pause
[cm]
; 背景はそのままか、ポーズ用の暗い画像（hotel_pause_bg.jpg等）に切り替えることも可能
[bg storage="hotel_pause_bg.jpg" time="500"]
[ptext layer="1" page="fore" text="-- PAUSE --" size="30" x="550" y="100" color="0xFFFFFF" name="hotel_pause_txt"]

; ポーズメニュー（画像ボタン使用）
[button graphic="button/close.png" enterimg="button/close2.png" target="*hotel_return_game" x="500" y="300"]
[ptext layer="1" page="fore" text="ゲームに戻る" size="20" x="530" y="313" color="0x333333" name="hotel_pause_btn1"]

[button graphic="button/save.png" enterimg="button/save2.png" target="*hotel_show_save" x="500" y="400"]
[ptext layer="1" page="fore" text="セーブする" size="20" x="530" y="413" color="0x333333" name="hotel_pause_btn2"]

[button graphic="button/title.png" enterimg="button/title2.png" target="*hotel_return_title_confirm" x="500" y="500"]
[ptext layer="1" page="fore" text="タイトルへ戻る" size="20" x="530" y="513" color="0x333333" name="hotel_pause_btn3"]
[s]

*hotel_return_game
[cm]
; ポーズ画面のテキストを消去
[free name="hotel_pause_txt" layer="1"]
[free name="hotel_pause_btn1" layer="1"]
[free name="hotel_pause_btn2" layer="1"]
[free name="hotel_pause_btn3" layer="1"]


; --- 背景を復元（ポーズ前の状態に戻す） ---
[bg storage="&tf.hotel_current_bg" time="500"]

[jump target="*hotel_main_room"]

*hotel_show_save
[cm]
[showsave]
[jump target="*hotel_pause"]

*hotel_return_title_confirm
[cm]
; 誤操作防止の確認（Unicode 絵文字使用）
[ptext layer="1" page="fore" text="保存していない進捗は失われます。タイトルに戻りますか？" size="20" x="350" y="250" color="0xFFFFFF" name="hotel_confirm_txt"]

[button x="400" y="320" text="✅ はい" target="*hotel_do_return_title" width="80" height="60"]

[button x="600" y="320" text="❌ いいえ" target="*hotel_pause" width="80" height="60"]
[s]

*hotel_do_return_title
[cm]
[free name="hotel_confirm_txt" layer="1"]
[jump target="*hotel_title"]
