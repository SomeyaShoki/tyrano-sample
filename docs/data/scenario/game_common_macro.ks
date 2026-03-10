; =========================================
; ゲーム共通処理マクロ（ホテル基準）
; =========================================

; タイトルから各ゲームへ入る際の共通準備
[macro name="game_prepare_scene"]
[cm]
; タイトル画面のテキストとウィンドウを消去
[iscript]
$("#title_bg_window").remove();
$("#title_dynamic_panel").remove();
$(".title_menu_item").remove();
// メッセージウィンドウを再表示
$(".message_outer").show();
$(".message_inner").show();
[endscript]
[free name="dummy_mobile" layer="2"]
[free name="dummy_pc" layer="2"]
; メッセージレイヤーを再表示
[layopt layer="message0" visible="true"]
[endmacro]

; タイトルへ戻る処理を統一
[macro name="game_go_title"]
[cm]
[jump target="*hotel_title"]
[endmacro]

[return]
