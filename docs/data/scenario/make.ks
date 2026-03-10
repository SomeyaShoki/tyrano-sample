;このファイルは削除しないでください！
;
;make.ks はデータをロードした時に呼ばれる特別なKSファイルです。
;Fixレイヤーの初期化など、ロード時点で再構築したい処理をこちらに記述してください。
;
;

[iscript]
// ロード直後に動的UIが二重化しないように既存要素を掃除
$("#title_dynamic_panel").remove();
$("#trpg_clear_bg").remove();
[endscript]

;=========================================
; [UIレイアウト] 中央配置マクロ
; マクロ名: sys_place_center
; 画面サイズとオブジェクトサイズから中央のXY座標を算出し、画像やボタンを配置する
; 引数:
;   storage : 画像のファイルパス (type=imageの場合)
;   graphic : ボタン画像のファイルパス (type=buttonの場合)
;   enterimg: ボタンホバー画像 (省略可)
;   width   : 画像/ボタンの幅
;   height  : 画像/ボタンの高さ
;   layer   : 配置するレイヤー (デフォルト: 1)
;   zindex  : 重なり順 (デフォルト: 10)
;   type    : 'image' または 'button' (デフォルト: image)
;   target  : button選択時のジャンプ先ラベル
;   offset_x: X座標のオフセット (デフォルト: 0)
;   offset_y: Y座標のオフセット (デフォルト: 0)
;=========================================
[macro name="sys_place_center"]
[iscript]
// 画面サイズを取得
tf.sys_screen_w = TG.config.scWidth;
tf.sys_screen_h = TG.config.scHeight;

// 引数から幅と高さを取得（未指定時は0として扱う）
tf.sys_obj_w = Number(mp.width) || 0;
tf.sys_obj_h = Number(mp.height) || 0;

// オフセット値を取得
tf.sys_offset_x = Number(mp.offset_x) || 0;
tf.sys_offset_y = Number(mp.offset_y) || 0;

// 中央のX, Y座標を計算し、オフセットを適用
tf.sys_pos_x = (tf.sys_screen_w - tf.sys_obj_w) / 2 + tf.sys_offset_x;
tf.sys_pos_y = (tf.sys_screen_h - tf.sys_obj_h) / 2 + tf.sys_offset_y;
[endscript]

; typeがbuttonの場合はクリッカブルボタンとして配置
[if exp="mp.type == 'button'"]
    [if exp="mp.enterimg != undefined"]
        [button graphic="%graphic" enterimg="%enterimg" target="%target" x="&tf.sys_pos_x" y="&tf.sys_pos_y" zindex="%zindex|10"]
    [else]
        [button graphic="%graphic" target="%target" x="&tf.sys_pos_x" y="&tf.sys_pos_y" zindex="%zindex|10"]
    [endif]
[else]
; デフォルトは画像として配置
    [image layer="%layer|1" page="fore" x="&tf.sys_pos_x" y="&tf.sys_pos_y" width="%width" height="%height" storage="%storage" zindex="%zindex|10"]
[endif]
[endmacro]

;make.ks はロード時にcallとして呼ばれるため、return必須です。
[return]

