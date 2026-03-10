; ==========================================
; 1. タイトル画面 (first.ks の一番上に配置)
; ==========================================
*hotel_title
[cm]
[clearstack]
[clearsysvar]
; タイトル背景の表示
[bg storage="sleep.jpg" time="1000"]
; メッセージレイヤーを非表示
[layopt layer="message0" visible="false"]

; デバイス判定と画面サイズ確認、レイアウト計算
[iscript]
tf.is_mobile = $.userenv() != "pc";
// 画面サイズを取得
tf.screen_width = TYRANO.kag.config.scWidth || 1280;
tf.screen_height = TYRANO.kag.config.scHeight || 720;

// 黒半透明ウィンドウのサイズと位置を計算
tf.window_width = tf.is_mobile ? 600 : 500;
tf.window_height = tf.is_mobile ? 450 : 380;
tf.window_x = Math.floor((tf.screen_width - tf.window_width) / 2);
tf.window_y = tf.is_mobile ? 90 : Math.floor((tf.screen_height - tf.window_height) / 2);

// デバッグ用：コンソールに出力
console.log("画面サイズ:", tf.screen_width, "x", tf.screen_height);
console.log("ウィンドウ:", tf.window_x, tf.window_y, tf.window_width, tf.window_height);

// 既存のウィンドウを削除（リロード対策）
$("#title_bg_window").remove();
$(".title_menu_item").remove();

// メッセージウィンドウを確実に非表示
$(".message_outer").hide();
$(".message_inner").hide();

// 黒半透明のウィンドウをHTML要素として作成
$("<div>")
    .attr("id", "title_bg_window")
    .css({
        position: "absolute",
        left: tf.window_x + "px",
        top: tf.window_y + "px",
        width: tf.window_width + "px",
        height: tf.window_height + "px",
        backgroundColor: "rgba(0, 0, 0, 0.7)",
        border: "2px solid rgba(255, 255, 255, 0.3)",
        borderRadius: "10px",
        boxShadow: "0 4px 20px rgba(0, 0, 0, 0.5)",
        zIndex: 100
    })
    .appendTo(".tyrano_base");

// タイトルテキスト（ウィンドウ内中央寄せ）
$("<div>")
    .addClass("title_menu_item")
    .text("脱出ゲーム集")
    .css({
        position: "absolute",
        left: tf.window_x + "px",
        top: (tf.window_y + 40) + "px",
        width: tf.window_width + "px",
        fontSize: tf.is_mobile ? "36px" : "48px",
        color: "#FFFFFF",
        fontWeight: "bold",
        textAlign: "center",
        textShadow: "2px 2px 4px rgba(0, 0, 0, 0.8)",
        zIndex: 110
    })
    .appendTo(".tyrano_base");

// サブタイトル（ウィンドウ内中央寄せ）
$("<div>")
    .addClass("title_menu_item")
    .text("どのゲームで遊びますか？")
    .css({
        position: "absolute",
        left: tf.window_x + "px",
        top: (tf.window_y + 110) + "px",
        width: tf.window_width + "px",
        fontSize: tf.is_mobile ? "20px" : "24px",
        color: "#FFFFFF",
        textAlign: "center",
        textShadow: "1px 1px 3px rgba(0, 0, 0, 0.8)",
        zIndex: 110
    })
    .appendTo(".tyrano_base");

console.log("タイトル配置完了:", "ウィンドウ内中央寄せ");
[endscript]

; メニューボタンを中央配置で縦並び（画面サイズに応じて自動調整）
[iscript]
// ボタンの共通設定
tf.title_btn_w = tf.is_mobile ? 490 : 400;
tf.title_btn_h = tf.is_mobile ? 50 : 55;
tf.title_btn_spacing = tf.is_mobile ? 70 : 65;

// 中央X座標を計算
tf.title_btn_x = (tf.screen_width - tf.title_btn_w) / 2;

// 3つのボタンの中央Y座標を基準に計算
tf.title_btn_center_y = tf.screen_height / 2;
tf.title_btn_y1 = tf.title_btn_center_y - tf.title_btn_spacing;
tf.title_btn_y2 = tf.title_btn_center_y;
tf.title_btn_y3 = tf.title_btn_center_y + tf.title_btn_spacing;

console.log("ボタン配置:", tf.title_btn_x, tf.title_btn_y1, tf.title_btn_y2, tf.title_btn_y3);
[endscript]

[if exp="tf.is_mobile"]
[ptext layer="2" page="fore" text="" size="1" x="0" y="0" name="dummy_mobile"]
[glink text="TRPG風脱出ゲーム" target="*trpg_game_start" x="&tf.title_btn_x" y="&tf.title_btn_y1" width="&tf.title_btn_w" height="&tf.title_btn_h" size="26" color="0x0099CC" opacity="220" font_color="0xFFFFFF"]
[glink text="高層ホテルからの脱出" target="*start" x="&tf.title_btn_x" y="&tf.title_btn_y2" width="&tf.title_btn_w" height="&tf.title_btn_h" size="26" color="0x66BB66" opacity="220" font_color="0xFFFFFF"]
[glink text="続きから" target="*hotel_show_load" x="&tf.title_btn_x" y="&tf.title_btn_y3" width="&tf.title_btn_w" height="&tf.title_btn_h" size="26" color="0x999999" opacity="220" font_color="0xFFFFFF"]
[else]
[ptext layer="2" page="fore" text="" size="1" x="0" y="0" name="dummy_pc"]
; PC版：画面中央に自動配置
[glink text="TRPG風脱出ゲーム" target="*trpg_game_start" x="&tf.title_btn_x" y="&tf.title_btn_y1" width="&tf.title_btn_w" height="&tf.title_btn_h" size="30" color="0x0099CC" opacity="220" font_color="0xFFFFFF"]
[glink text="高層ホテルからの脱出" target="*start" x="&tf.title_btn_x" y="&tf.title_btn_y2" width="&tf.title_btn_w" height="&tf.title_btn_h" size="30" color="0x66BB66" opacity="220" font_color="0xFFFFFF"]
[glink text="続きから" target="*hotel_show_load" x="&tf.title_btn_x" y="&tf.title_btn_y3" width="&tf.title_btn_w" height="&tf.title_btn_h" size="30" color="0x999999" opacity="220" font_color="0xFFFFFF"]
[endif]
[s]

*hotel_show_load
[cm]
[showload]
[jump target="*hotel_title"]

; ==========================================
; TRPGゲーム開始処理
; ==========================================
*trpg_game_start
[cm]
; タイトル画面のテキストとボタンとウィンドウを消去
[iscript]
$("#title_bg_window").remove();
$(".title_menu_item").remove();
// メッセージウィンドウを再表示
$(".message_outer").show();
$(".message_inner").show();
[endscript]
[free name="dummy_mobile" layer="2"]
[free name="dummy_pc" layer="2"]
; メッセージレイヤーを再表示
[layopt layer="message0" visible="true"]

;=========================================
; TRPG風脱出ゲーム 基本システム＆マクロ定義
;=========================================

; 1. 変数とフラグの初期化
[iscript]
// 技能値の初期設定（本来はUIで選択させますが、仮置きします）
f.trpg_skill_search = 2; // 探索
f.trpg_skill_know   = 1; // 知識
f.trpg_skill_move   = 0; // 運動
f.trpg_skill_it     = -1; // IT

// ターン管理
f.trpg_current_stage = 1;
f.trpg_st1_turn_limit = 7;
f.trpg_st1_turn_count = 0;

// ステージ1の進行フラグ
f.trpg_st1_has_ruler = false;    // 定規所持
f.trpg_st1_has_cable = false;    // ケーブル所持
f.trpg_st1_pc_unlocked = false;  // PCロック解除
f.trpg_st1_phone_charged = false;// スマホ充電完了
f.trpg_st1_penalty = false;      // ペナルティ状態（監視AI警戒）
[endscript]

; 2. 2D6ダイスロール判定マクロ
[macro name="trpg_dice_roll"]
    [iscript]
    // 2D6のロール
    tf.dice1 = Math.floor(Math.random() * 6) + 1;
    tf.dice2 = Math.floor(Math.random() * 6) + 1;
    tf.dice_total = tf.dice1 + tf.dice2;
    
    // 指定された技能値を取得
    tf.skill_val = 0;
    if(mp.skill == "search") tf.skill_val = f.trpg_skill_search;
    else if(mp.skill == "know") tf.skill_val = f.trpg_skill_know;
    else if(mp.skill == "move") tf.skill_val = f.trpg_skill_move;
    else if(mp.skill == "it") tf.skill_val = f.trpg_skill_it;
    
    // ペナルティの適用 (ステージ1用)
    if(f.trpg_st1_penalty) tf.skill_val -= 1;
    
    // 最終達成値の計算と成功判定
    tf.final_score = tf.dice_total + tf.skill_val;
    tf.is_success = (tf.final_score >= parseInt(mp.target));
    [endscript]
    
    ; 画面への結果出力
    ダイスロール！ [emb exp="tf.dice1"] ＋ [emb exp="tf.dice2"] ＝ [emb exp="tf.dice_total"][p]
    技能値([emb exp="tf.skill_val"])を加算し、達成値は【 [emb exp="tf.final_score"] 】です。[p]
    
    [if exp="tf.is_success == true"]
        [font color="0x00ff00"]判定に成功しました！[resetfont][p]
    [else]
        [font color="0xff0000"]判定に失敗しました……。[resetfont][p]
    [endif]
[endmacro]

; TRPGゲームのステージ1へ移動
[jump target="*trpg_st1_start"]


; ==========================================
; 2. ゲーム初期化 (タイトルから「最初から」を選んだ場合の処理)
; ==========================================
*start
[cm]
; タイトル画面のテキストとウィンドウを消去
[iscript]
$("#title_bg_window").remove();
$(".title_menu_item").remove();
// メッセージウィンドウを再表示
$(".message_outer").show();
$(".message_inner").show();
[endscript]
[free name="dummy_mobile" layer="2"]
[free name="dummy_pc" layer="2"]
; メッセージレイヤーを再表示
[layopt layer="message0" visible="true"]

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

; 探索UI（中央配置マクロで横並びに配置）
[iscript]
// 3つのボタンを横並びで中央配置するための計算
tf.hotel_btn_w = 100;      // 各ボタンの幅
tf.hotel_btn_spacing = 100; // ボタン間の余白
tf.hotel_btn_y = 380;      // Y座標（共通）
// 中央のボタン位置を基準に、左右にオフセット
tf.hotel_btn_center_x = (TG.config.scWidth - tf.hotel_btn_w) / 2;
tf.hotel_btn_left_x = tf.hotel_btn_center_x - tf.hotel_btn_w - tf.hotel_btn_spacing;
tf.hotel_btn_right_x = tf.hotel_btn_center_x + tf.hotel_btn_w + tf.hotel_btn_spacing;
[endscript]

[button x="&tf.hotel_btn_left_x" y="&tf.hotel_btn_y" text="🚪\nドアを調べる" target="*hotel_check_door" width="100" height="80"]

[button x="&tf.hotel_btn_center_x" y="&tf.hotel_btn_y" text="💼\n机を調べる" target="*hotel_check_desk" width="100" height="80"]

[button x="&tf.hotel_btn_right_x" y="&tf.hotel_btn_y" text="🪟\n窓の外を見る" target="*hotel_check_window" width="100" height="80"]

; --- [追加] ポーズ画面へのボタン (右上固定) ---
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

; タイトルテキストを中央配置
[iscript]
tf.pause_title_w = 300;
tf.pause_title_x = (TG.config.scWidth - tf.pause_title_w) / 2;
[endscript]
[ptext layer="1" page="fore" text="-- PAUSE --" size="30" x="&tf.pause_title_x" y="100" color="0xFFFFFF" name="hotel_pause_txt"]

; ポーズメニュー（中央配置マクロ使用）
[sys_place_center type="button" graphic="button/close.png" enterimg="button/close2.png" target="*hotel_return_game" width="200" height="60" offset_y="-120"]

; ボタンラベルも中央配置
[iscript]
tf.pause_label_w = 200;
tf.pause_label_x = (TG.config.scWidth - tf.pause_label_w) / 2;
[endscript]
[ptext layer="1" page="fore" text="ゲームに戻る" size="20" x="&tf.pause_label_x" y="313" color="0x333333" name="hotel_pause_btn1"]

[sys_place_center type="button" graphic="button/save.png" enterimg="button/save2.png" target="*hotel_show_save" width="200" height="60" offset_y="-20"]
[ptext layer="1" page="fore" text="セーブする" size="20" x="&tf.pause_label_x" y="413" color="0x333333" name="hotel_pause_btn2"]

[sys_place_center type="button" graphic="button/title.png" enterimg="button/title2.png" target="*hotel_return_title_confirm" width="200" height="60" offset_y="80"]
[ptext layer="1" page="fore" text="タイトルへ戻る" size="20" x="&tf.pause_label_x" y="513" color="0x333333" name="hotel_pause_btn3"]
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
; 誤操作防止の確認（中央配置）
[iscript]
tf.confirm_text_w = 600;
tf.confirm_text_x = (TG.config.scWidth - tf.confirm_text_w) / 2;

// 2つのボタンを中央に横並びで配置
tf.confirm_btn_w = 80;
tf.confirm_btn_spacing = 100;
tf.confirm_btn_y = 320;
tf.confirm_btn_center_x = (TG.config.scWidth - tf.confirm_btn_w) / 2;
tf.confirm_btn_left_x = tf.confirm_btn_center_x - tf.confirm_btn_w - tf.confirm_btn_spacing / 2;
tf.confirm_btn_right_x = tf.confirm_btn_center_x + tf.confirm_btn_spacing / 2;
[endscript]

[ptext layer="1" page="fore" text="保存していない進捗は失われます。タイトルに戻りますか？" size="20" x="&tf.confirm_text_x" y="250" color="0xFFFFFF" name="hotel_confirm_txt"]

[button x="&tf.confirm_btn_left_x" y="&tf.confirm_btn_y" text="✅ はい" target="*hotel_do_return_title" width="80" height="60"]

[button x="&tf.confirm_btn_right_x" y="&tf.confirm_btn_y" text="❌ いいえ" target="*hotel_pause" width="80" height="60"]
[s]

*hotel_do_return_title
[cm]
[free name="hotel_confirm_txt" layer="1"]
[jump target="*hotel_title"]


;=========================================
; ステージ1：第3会議室（講習ルーム）
;=========================================
*trpg_st1_start
[cm]
; 背景画像の設定（リポジトリの docs/bgimage/ を想定）
; [bg storage="../docs/bgimage/room3.jpg" time="1000"]
【GM】目を覚ますと、見慣れない「第3会議室」のパイプ椅子の上でした。[p]
隣の「大会議室」へ続く扉は電子ロックで固く閉ざされています。[p]

*trpg_st1_main
[cm]
; 1. タイムリミット（ターン数）のチェック
[if exp="f.trpg_st1_turn_count >= f.trpg_st1_turn_limit"]
    [jump target="*trpg_st1_bad_end"]
[endif]

; 現在の状態表示
[font color="0x00ffff"]
【現在：ステージ1】残り行動回数：[emb exp="f.trpg_st1_turn_limit - f.trpg_st1_turn_count"] 回[resetfont][p]

; 2. 探索箇所の選択肢
どこを調べますか？[p]

[link target="*trpg_st1_whiteboard"] ① ホワイトボード [endlink][r]
[link target="*trpg_st1_binder"] ② 備品入れと書類バインダー [endlink][r]
[link target="*trpg_st1_pc"] ③ 講師が置き忘れた社用ノートPC [endlink][r]

; スマホ充電は、ケーブル所持＆PCロック解除済みの時のみ出現
[if exp="f.trpg_st1_has_cable == true && f.trpg_st1_pc_unlocked == true && f.trpg_st1_phone_charged == false"]
    [link target="*trpg_st1_phone"] 📱 スマホを充電する [endlink][r]
[endif]

[link target="*trpg_st1_door"] 🚪 大会議室への扉（電子ロック） [endlink][r]
[r]
[link target="*trpg_pause_menu"] ⏸️ メニュー（ポーズ） [endlink][r]
[s]

;-----------------------------------------
; ① ホワイトボード
;-----------------------------------------
*trpg_st1_whiteboard
[cm]
[eval exp="f.trpg_st1_turn_count = f.trpg_st1_turn_count + 1"]
ホワイトボードには熱血講師の字でこう書かれている。[p]
「本日の議題：我らが偉大なるCEOの軌跡を辿れ！ 最初のコミットメッセージは『CEOが初めて海外進出した年のパスポート番号下4桁』とせよ！」[p]
[eval exp="f.trpg_st1_penalty = false"] ; 行動完了によりペナルティ解除
[jump target="*trpg_st1_main"]

;-----------------------------------------
; ② 備品入れと書類バインダー (探索判定)
;-----------------------------------------
*trpg_st1_binder
[cm]
[eval exp="f.trpg_st1_turn_count = f.trpg_st1_turn_count + 1"]

[if exp="f.trpg_st1_has_cable == true"]
    すでにめぼしい物は見つけている。これ以上探す必要はないだろう。[p]
    [eval exp="f.trpg_st1_penalty = false"]
    [jump target="*trpg_st1_main"]
[endif]

備品入れを調べる。【探索】判定を行います。[p]
[trpg_dice_roll skill="search" target="7"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st1_has_ruler = true"]
    [eval exp="f.trpg_st1_has_cable = true"]
    透明な「アクリル定規」と、「海外製のスマホ充電ケーブル」を発見した！[p]
    さらに「CEOの海外出張記録（パスポート番号：TG982008）」を見つけた。[p]
    [eval exp="f.trpg_st1_penalty = false"]
[else]
    バインダーを床に派手にぶちまけてしまった！[p]
    [font color="0xff0000"]大きな音で監視AIが警戒レベルを上げた！ 次のターン、全判定に -1 のペナルティ。[resetfont][p]
    [eval exp="f.trpg_st1_penalty = true"]
[endif]
[jump target="*trpg_st1_main"]

;-----------------------------------------
; ③ 講師のノートPC (IT判定)
;-----------------------------------------
*trpg_st1_pc
[cm]
[eval exp="f.trpg_st1_turn_count = f.trpg_st1_turn_count + 1"]

[if exp="f.trpg_st1_pc_unlocked == true"]
    PCはすでにロック解除されており、USBポートが使用可能だ。[p]
    [eval exp="f.trpg_st1_penalty = false"]
    [jump target="*trpg_st1_main"]
[endif]

社用ノートPCのロック解除を試みる。【IT】判定を行います。[p]
[trpg_dice_roll skill="it" target="7"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st1_pc_unlocked = true"]
    見事起動に成功し、PCのUSBポートが使えるようになった！[p]
    [eval exp="f.trpg_st1_penalty = false"]
[else]
    パスワードのタイピングをミスして一時的にロックアウトされた……。[p]
    [eval exp="f.trpg_st1_penalty = false"]
[endif]
[jump target="*trpg_st1_main"]

;-----------------------------------------
; 📱 スマホの充電 (知識判定)
;-----------------------------------------
*trpg_st1_phone
[cm]
[eval exp="f.trpg_st1_turn_count = f.trpg_st1_turn_count + 1"]
特殊な電圧の海外製ケーブルをPCに繋ぎ、スマホの充電を試みる。【知識】判定を行います。[p]
[trpg_dice_roll skill="know" target="7"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st1_phone_charged = true"]
    安全に接続完了！ スマホが起動し、時刻が【 02:00（午前2時） 】であることを示した。[p]
    同時に『扉のパスワードを入力せよ』というメッセージが届いた！[p]
    [eval exp="f.trpg_st1_penalty = false"]
[else]
    電圧計算を間違えて火花が散った！ 調整に手間取ってしまった……。[p]
    [eval exp="f.trpg_st1_penalty = false"]
[endif]
[jump target="*trpg_st1_main"]

;-----------------------------------------
; 🚪 扉のパスワード入力
;-----------------------------------------
*trpg_st1_door
[cm]
電子ロックのキーパッドがある。4桁の数字を入力できそうだ。[p]
; ターンは消費しない（プレイヤーの思考フェーズとする）

; テキスト入力UIの生成
[if exp="tf.is_mobile"]
[edit name="f.trpg_st1_input_pass" left="255" top="200" width="250" height="44" maxchars="4"]
[glink text="決定" target="*trpg_st1_door_check" x="255" y="262" width="120" height="46" size="24" cm="false"]
[glink text="戻る" target="*trpg_st1_main" x="385" y="262" width="120" height="46" size="24" cm="false"]
[else]
[edit name="f.trpg_st1_input_pass" left="460" top="200" width="220" height="44" maxchars="4"]
[glink text="決定" target="*trpg_st1_door_check" x="460" y="270" width="120" height="46" size="24" cm="false"]
[glink text="戻る" target="*trpg_st1_main" x="590" y="270" width="120" height="46" size="24" cm="false"]
[endif]
[s]

*trpg_st1_door_check
[commit]
[cm]
[if exp="f.trpg_st1_input_pass == '2008'"]
    電子音と共に、重い扉が開いた！[p]
    [jump target="*trpg_st2_start"] ; ステージ2へ遷移（後で実装）
[else]
    『パスワードが間違っています』[p]
    [jump target="*trpg_st1_main"]
[endif]

;-----------------------------------------
; BAD END処理
;-----------------------------------------
*trpg_st1_bad_end
[cm]
[font color="0xff0000"]
タイムリミット！[r]
プシュー……という音と共に、白い催涙ガスが大量に噴射された！[resetfont][p]
激しく咳き込み、あなたは意識を失った……。[p]
【 BAD END 】[s]


;=========================================
; ステージ2：大会議室（プレゼンルーム）
;=========================================
*trpg_st2_start
[cm]
; ステージ2専用変数の初期化
[iscript]
f.trpg_st2_turn_limit = 6;
f.trpg_st2_turn_count = 0;
f.trpg_st2_gas_active = true;    // ガス充満状態（ペナルティあり）
f.trpg_st2_cant_search = false;  // 探索不能ペナルティフラグ
f.trpg_st2_proj_on = false;      // プロジェクター起動フラグ
f.trpg_st2_found_note = false;   // 付箋発見フラグ
[endscript]

【GM】重い扉を開けると、広々とした大会議室です。しかし安堵したのも束の間、無機質な音声が流れます。[p]
『第3会議室の汚染完了。続いて大会議室へ、防犯用催涙ガスの充填を開始します』[p]
シューッ！という音と共に、白く濁ったガスが足元を這うように広がってきました。[p]
目がチカチカし、咳き込んでしまいます。急いでガスを止めなければ！[p]

*trpg_st2_main
[cm]
; 1. タイムリミットのチェック
[if exp="f.trpg_st2_turn_count >= f.trpg_st2_turn_limit"]
    [jump target="*trpg_st2_bad_end"]
[endif]

; 2. 現在の状態と目標値の動的計算
; ガス充満中は実質-1ペナルティのため、判定の目標値(target)を8に上げる
[eval exp="tf.st2_target = f.trpg_st2_gas_active ? 8 : 7"]

[font color="0x00ffff"]
【現在：ステージ2】残り行動回数：[emb exp="f.trpg_st2_turn_limit - f.trpg_st2_turn_count"] 回[resetfont][p]
[if exp="f.trpg_st2_gas_active == true"]
    [font color="0xff0000"]※催涙ガス充満中：全判定の目標値が【 8 】に上昇（実質-1ペナルティ）※[resetfont][p]
[endif]

; 3. 探索箇所の選択肢
どこを調べますか？[p]

[link target="*trpg_st2_vent"] ① 空調の吹き出し口 [endlink][r]
[link target="*trpg_st2_podium"] ② 演台と天井のプロジェクター [endlink][r]
[link target="*trpg_st2_screen"] ③ 巻き上げ式のスクリーン [endlink][r]
[link target="*trpg_st2_door"] 🚪 特別役員会議室への扉（ダイヤル錠） [endlink][r]
[r]
[link target="*trpg_pause_menu"] ⏸️ メニュー（ポーズ） [endlink][r]
[s]

;-----------------------------------------
; ① 空調の吹き出し口 (運動判定)
;-----------------------------------------
*trpg_st2_vent
[cm]
[eval exp="f.trpg_st2_turn_count = f.trpg_st2_turn_count + 1"]

[if exp="f.trpg_st2_gas_active == false"]
    空調はすでに塞がれている。これ以上ガスは出てこない。[p]
    [jump target="*trpg_st2_main"]
[endif]

空調を塞ぐため、【運動】判定を行います。[p]
[trpg_dice_roll skill="move" target="&tf.st2_target"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st2_gas_active = false"]
    部屋の隅の「飛沫防止用アクリルパーテーション」を力いっぱい外し、ガムテープで空調を塞ぐことに成功！[p]
    ガスの流入が止まり、以降の判定ペナルティが解除された！[p]
[else]
    届かない……！ ガスを深く吸い込んで激しく咳き込み、涙で視界が滲む。[p]
    [font color="0xff0000"]※次のターン、【探索】行動ができないペナルティを受けます。[resetfont][p]
    [eval exp="f.trpg_st2_cant_search = true"]
[endif]
[jump target="*trpg_st2_main"]

;-----------------------------------------
; ② 演台と天井のプロジェクター (IT判定)
;-----------------------------------------
*trpg_st2_podium
[cm]
[eval exp="f.trpg_st2_turn_count = f.trpg_st2_turn_count + 1"]

[if exp="f.trpg_st2_proj_on == true"]
    プロジェクターからはすでに「絶対に儲かるブランチ戦略」のグラフ（赤・青・黄）が投影されている。[p]
    [jump target="*trpg_st2_main"]
[endif]

演台のパネルを操作し、プロジェクターの起動を試みます。【IT】判定を行います。[p]
[trpg_dice_roll skill="it" target="&tf.st2_target"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st2_proj_on = true"]
    強制起動に成功！ 壁のスクリーンに「絶対に儲かるブランチ戦略」と題されたネットワークグラフが投影された。[p]
    赤・青・黄の3本の直線のグラフだが、長さを表す目盛りが書かれていないようだ。[p]
[else]
    入力切替の操作を間違え、エラー画面が表示されてしまった。[p]
[endif]
[jump target="*trpg_st2_main"]

;-----------------------------------------
; ③ 巻き上げ式のスクリーン (探索判定)
;-----------------------------------------
*trpg_st2_screen
[cm]
; 探索不能ペナルティのチェック
[if exp="f.trpg_st2_cant_search == true"]
    ガスで涙が止まらず、今はとても探索などできそうにない……！[p]
    [eval exp="f.trpg_st2_cant_search = false"] ; 1ターン経過で回復
    [jump target="*trpg_st2_main"]
[endif]

[eval exp="f.trpg_st2_turn_count = f.trpg_st2_turn_count + 1"]

[if exp="f.trpg_st2_found_note == true"]
    スクリーンの裏側はすでに調べた。役員室のパスワードに関する付箋があった。[p]
    [jump target="*trpg_st2_main"]
[endif]

スクリーンの裏側を調べます。【探索】判定を行います。[p]
[trpg_dice_roll skill="search" target="&tf.st2_target"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st2_found_note = true"]
    前の会議で誰かが残した付箋を発見した！[p]
    「役員室のパスワードは『赤・青・黄のブランチの物理的な長さ（cm）』の順。定規でしっかり測ること」[p]
[else]
    特に怪しいところは見当たらない。見落としがあるだろうか？[p]
[endif]
[jump target="*trpg_st2_main"]

;-----------------------------------------
; 🚪 特別役員会議室への扉
;-----------------------------------------
*trpg_st2_door
[cm]
3桁のダイヤル錠がかかっている。[p]
; ターンは消費しない

[if exp="tf.is_mobile"]
[edit name="f.trpg_st2_input_pass" left="280" top="200" width="200" height="44" maxchars="3"]
[glink text="決定" target="*trpg_st2_door_check" x="255" y="262" width="120" height="46" size="24" cm="false"]
[glink text="戻る" target="*trpg_st2_main" x="385" y="262" width="120" height="46" size="24" cm="false"]
[else]
[edit name="f.trpg_st2_input_pass" left="510" top="200" width="170" height="44" maxchars="3"]
[glink text="決定" target="*trpg_st2_door_check" x="460" y="270" width="120" height="46" size="24" cm="false"]
[glink text="戻る" target="*trpg_st2_main" x="590" y="270" width="120" height="46" size="24" cm="false"]
[endif]
[s]

*trpg_st2_door_check
[commit]
[cm]
; ステージ1のアクリル定規(f.trpg_st1_has_ruler)を持っていることが前提の謎ですが、
; ここでは正解(315)を入力できれば通過とします。
[if exp="f.trpg_st2_input_pass == '315'"]
    カチャッ！ ダイヤル錠が外れ、扉が開いた！[p]
    [jump target="*trpg_st3_start"] ; ステージ3へ
[else]
    ダイヤルは開かない。暗証番号が違うようだ。[p]
    [jump target="*trpg_st2_main"]
[endif]

;-----------------------------------------
; BAD END処理
;-----------------------------------------
*trpg_st2_bad_end
[cm]
[font color="0xff0000"]
タイムリミット！[r]
部屋中に白い催涙ガスが完全に充満してしまった！[resetfont][p]
激しく咳き込み、あなたは床に倒れ伏した……。[p]
【 BAD END 】[s]


;=========================================
; ステージ3：特別役員会議室
;=========================================
*trpg_st3_start
[cm]
; ステージ3専用変数の初期化
[iscript]
f.trpg_st3_turn_limit = 7;
f.trpg_st3_turn_count = 0;
f.trpg_st3_found_seatmap = false; // 座席表発見フラグ
f.trpg_st3_found_rule = false;    // 暗証番号ルール発見フラグ
f.trpg_st3_found_ext = false;     // 内線番号発見フラグ
[endscript]

【GM】最後の部屋は、重厚なマホガニーの円卓が置かれた特別役員会議室です。[p]
奥に外へ通じる非常口がありますが、分厚い鉄板が下りており、横にはカードリーダーと指紋認証の装置があります。[p]
スピーカーから音声が流れます。[p]
『最終防衛ライン。管理者権限（Admin）を持つ者のみ、通過を許可します』[p]

*trpg_st3_main
[cm]
; 1. タイムリミットのチェック
[if exp="f.trpg_st3_turn_count >= f.trpg_st3_turn_limit"]
    [jump target="*trpg_st3_bad_end"]
[endif]

; 2. 現在の状態表示
[font color="0x00ffff"]
【現在：ステージ3】残り行動回数：[emb exp="f.trpg_st3_turn_limit - f.trpg_st3_turn_count"] 回[resetfont][p]

; 3. 探索箇所の選択肢
どこを調べますか？[p]

[link target="*trpg_st3_table"] ① マホガニーの円卓 [endlink][r]
[link target="*trpg_st3_shredder"] ② 業務用シュレッダー [endlink][r]
[link target="*trpg_st3_cabinet"] ③ 役員用キャビネット [endlink][r]
[link target="*trpg_st3_safe"] 🚪 隠し金庫（非常口の横） [endlink][r]
[r]
[link target="*trpg_pause_menu"] ⏸️ メニュー（ポーズ） [endlink][r]
[s]

;-----------------------------------------
; ① マホガニーの円卓 (探索判定)
;-----------------------------------------
*trpg_st3_table
[cm]
[eval exp="f.trpg_st3_turn_count = f.trpg_st3_turn_count + 1"]

[if exp="f.trpg_st3_found_seatmap == true"]
    テーブルの上にはすでに「悪徳スクール運営陣の座席表」がある。これ以上調べる必要はない。[p]
    [jump target="*trpg_st3_main"]
[endif]

円卓を調べます。【探索】判定を行います。[p]
[trpg_dice_roll skill="search" target="7"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st3_found_seatmap = true"]
    テーブルの上の「悪徳スクール運営陣の座席表」を発見した！[p]
    そこには「CEO、CTO、CFO、CMO」の4名の席が指定されている。[p]
[else]
    暗くてよく見えない……。何かを見落としている気がする。[p]
[endif]
[jump target="*trpg_st3_main"]

;-----------------------------------------
; ② 業務用シュレッダー (知識判定)
;-----------------------------------------
*trpg_st3_shredder
[cm]
[eval exp="f.trpg_st3_turn_count = f.trpg_st3_turn_count + 1"]

[if exp="f.trpg_st3_found_rule == true"]
    機密文書はすでに復元済みだ。『非常口金庫の暗証番号は、本日の会議に出席した【CEO・CTO・CFO・CMO】の順に、それぞれの内線番号の下1桁を並べたものとする』[p]
    [jump target="*trpg_st3_main"]
[endif]

裁断された機密文書の復元を試みます。【知識】判定を行います。[p]
[trpg_dice_roll skill="know" target="7"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st3_found_rule = true"]
    シュレッダーのくず受けから紙片を拾い集め、パズルのように復元した！[p]
    復元した文書：『非常口金庫の暗証番号は、本日の会議に出席した【CEO・CTO・CFO・CMO】の順に、それぞれの内線番号の下1桁を並べたものとする』[p]
[else]
    紙くずが細かすぎて手間取ってしまった……。[p]
[endif]
[jump target="*trpg_st3_main"]

;-----------------------------------------
; ③ 役員用キャビネット (運動判定)
;-----------------------------------------
*trpg_st3_cabinet
[cm]
[eval exp="f.trpg_st3_turn_count = f.trpg_st3_turn_count + 1"]

[if exp="f.trpg_st3_found_ext == true"]
    キャビネットの中からはすでに「緊急連絡網」を入手済みだ。[p]
    連絡網：CEO(8005)、CTO(8007)、CFO(8001)、CMO(8002)[p]
    [jump target="*trpg_st3_main"]
[endif]

鍵のかかったキャビネットを力ずくでこじ開けます。【運動】判定を行います。[p]
[trpg_dice_roll skill="move" target="7"]

[if exp="tf.is_success == true"]
    [eval exp="f.trpg_st3_found_ext = true"]
    近くの消火器を使って強引にこじ開けた！[p]
    中から「運営陣の緊急連絡網（内線版）」を発見した！[p]
    連絡網の内容：CEO（内線：8005）、CTO（内線：8005）、CFO（内線：8000）、CMO（内線：8000）[p]
[else]
    キャビネットがびくともせず、腕が痺れた……！[p]
[endif]
[jump target="*trpg_st3_main"]

;-----------------------------------------
; 🚪 隠し金庫 (最終パスワード入力)
;-----------------------------------------
*trpg_st3_safe
[cm]
4桁の数字を入力するテンキー錠がある。[p]

[if exp="tf.is_mobile"]
[edit name="f.trpg_st3_input_pass" left="255" top="200" width="250" height="44" maxchars="4"]
[glink text="決定" target="*trpg_st3_safe_check" x="255" y="262" width="120" height="46" size="24" cm="false"]
[glink text="戻る" target="*trpg_st3_main" x="385" y="262" width="120" height="46" size="24" cm="false"]
[else]
[edit name="f.trpg_st3_input_pass" left="460" top="200" width="220" height="44" maxchars="4"]
[glink text="決定" target="*trpg_st3_safe_check" x="460" y="270" width="120" height="46" size="24" cm="false"]
[glink text="戻る" target="*trpg_st3_main" x="590" y="270" width="120" height="46" size="24" cm="false"]
[endif]
[s]

*trpg_st3_safe_check
[commit]
[cm]
; CEO(5), CTO(5), CFO(0), CMO(0) -> 5500
[if exp="f.trpg_st3_input_pass == '5500'"]
    ピピッ！ 金庫が開いた！[p]
    中から「CEOの指紋が付いた決裁用シリコン指サック」と「マスターカードキー」を手に入れた！[p]
    [jump target="*trpg_st3_true_end"]
[else]
    『エラー。パスワードが違います』[p]
    [jump target="*trpg_st3_main"]
[endif]

;-----------------------------------------
; エンディング分岐
;-----------------------------------------
*trpg_st3_true_end
[cm]
【GM】あなたはCEOの指紋サックを指にはめ、マスターカードキーを非常口のリーダーにスキャンさせました。[p]
『管理者権限を確認。ロックダウンを解除します』[p]
重々しい音と共に鉄の扉が上がり、外の新鮮な夜風があなたの頬を撫でました。[p]
スマホの画面を見ると、時刻は「午前2時45分」。[p]
暴走したシステムと、胡散臭いIT詐欺集団の牢獄から見事に脱出したあなたは、静まり返った深夜のオフィス街へと足を踏み出しました。[p]
「楽して稼げる魔法なんてない」。明日からは大学の研究室で、地道にコードを書こうと心に固く誓って。[p]
[font color="0xffff00"]【 TRUE END：脱出成功！ 】[resetfont][p]
[jump target="*trpg_game_clear"]

*trpg_game_clear
[cm]
[bg storage="black.jpg" time="1000"]
[if exp="tf.is_mobile"]
[font color="0xffff00" size="38"]GAME CLEAR[resetfont][p]
[p]
[font color="0xffffff" size="22"]thank you for your playing![resetfont][p]
[p]
[glink text="タイトル画面へ" target="*hotel_title" x="220" y="460" width="320" height="52" size="28" color="black" font_color="0xFFFFFF"]
[else]
[font color="0xffff00" size="48"]GAME CLEAR[resetfont][p]
[p]
[font color="0xffffff" size="28"]thank you for your playing![resetfont][p]
[p]
[glink text="タイトル画面へ" target="*hotel_title" x="460" y="500" width="360" height="60" size="30" color="black" font_color="0xFFFFFF"]
[endif]
[s] ; ゲーム終了

*trpg_st3_bad_end
[cm]
[font color="0xff0000"]
タイムリミット！[r]
プシュー……という音と共に、部屋の四隅から白い催涙ガスが大量に噴射されました。[resetfont][p]
密室の中で喉が焼け付くように痛み、あなたは激しく咳き込んで床に倒れ伏します。[p]
薄れゆく意識の中で、重武装の警備部隊が突入してくる足音を聞きました。[p]
翌日、「深夜のオフィスビルに侵入し、機密情報を漁っていた不審な大学生を逮捕」というニュースが流れることになるでしょう……。[p]
[font color="0xff0000"]【 BAD END：タイムアップ 】[resetfont][p]
[s] ; ゲーム終了


;=========================================
; TRPGゲーム共通：ポーズメニュー
;=========================================
*trpg_pause_menu
[cm]
; 現在のステージを保存（戻る際に使用）
[iscript]
// 現在どのステージにいるか判定
if(typeof f.trpg_st3_turn_count !== 'undefined' && f.trpg_st3_turn_count >= 0) {
    tf.current_stage = 3;
    tf.return_label = "*trpg_st3_main";
} else if(typeof f.trpg_st2_turn_count !== 'undefined' && f.trpg_st2_turn_count >= 0) {
    tf.current_stage = 2;
    tf.return_label = "*trpg_st2_main";
} else {
    tf.current_stage = 1;
    tf.return_label = "*trpg_st1_main";
}
[endscript]

[font color="0xffff00" size="30"]⏸️ ポーズメニュー[resetfont][p]
[font color="0xaaaaaa"]※ポーズ中はターンが進行しません[resetfont][p]
[r]

[link target="*trpg_pause_return"] 🎮 ゲームに戻る [endlink][r]
[link target="*trpg_pause_backlog"] 📜 ログを確認する [endlink][r]
[link target="*trpg_pause_save"] 💾 セーブする [endlink][r]
[link target="*trpg_pause_title_confirm"] 🏠 タイトルに戻る [endlink][r]
[s]

;-----------------------------------------
; ゲームに戻る
;-----------------------------------------
*trpg_pause_return
[cm]
[jump target="&tf.return_label"]

;-----------------------------------------
; ログを確認する（バックログ）
;-----------------------------------------
*trpg_pause_backlog
[cm]
[showlog]
[jump target="*trpg_pause_menu"]

;-----------------------------------------
; セーブする
;-----------------------------------------
*trpg_pause_save
[cm]
[showsave]
[jump target="*trpg_pause_menu"]

;-----------------------------------------
; タイトルに戻る確認
;-----------------------------------------
*trpg_pause_title_confirm
[cm]
[font color="0xff8800"]保存していない進捗は失われます。[r]
本当にタイトルに戻りますか？[resetfont][p]
[r]

[link target="*trpg_pause_do_return_title"] ✅ はい、タイトルに戻る [endlink][r]
[link target="*trpg_pause_menu"] ❌ いいえ、ポーズメニューに戻る [endlink][r]
[s]

*trpg_pause_do_return_title
[cm]
[jump target="*hotel_title"]
