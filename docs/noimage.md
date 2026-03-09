# 対応する画像ファイルが存在しないもの

## 📌 概要
以下は `first.ks` に記述されているが、実際の画像ファイルが存在しないものです。

---

## ❌ 存在しない画像ファイル

### 背景画像（bgimage フォルダ）

| ファイル名 | 用途 | 状態 | 備考 |
|-----------|------|------|------|
| `hotel_pause_bg.jpg` | ポーズ画面用背景 | ❌ 未存在 | コメント内で言及されているが実装されていない |

---

## ✅ 確認済み（存在する画像）

### 背景画像（docs/data/bgimage/）
- ✓ sleep.jpg
- ✓ hotel_room.jpg
- ✓ hotel_window.jpg
- ✓ hotel_corridor.jpg
- ✓ run.jpg

### ボタン画像（docs/data/image/button/）
- ✓ menu.png / menu2.png
- ✓ load.png / load2.png
- ✓ close.png / close2.png
- ✓ save.png / save2.png
- ✓ title.png / title2.png

---

## 📋 Material Icons 実装状況

### ✅ 実装済み
- index.html に Google Material Icons CDN を追加
- CSS スタイルシート `.material-icons` クラスを定義
- 以下のボタンに Material Icons を適用：
  - **探索UI**: ドア（door_front）、机（draw）、窓（window）
  - **確認ダイアログ**: はい（done, 緑）、いいえ（close, 赤）

### ⚠️ 注意点・今後の改善案

TyranoScript の `[ptext]` タグは className をサポートしていないため、以下のような対応が考えられます：

#### **オプション A: 実装済み（現在）**
Font 属性で直接 Material Icons を指定
```tyrano
[ptext layer="1" page="fore" text="door_front" size="40" x="100" y="100" 
        color="0x666666" name="hotel_icon_door" font="Material Icons"]
```

#### **オプション B: Unicode 絵文字に変更（推奨）**
Google Fonts 不要で、より確実に表示できます。
```tyrano
[ptext layer="1" page="fore" text="🚪" size="40" x="100" y="100" 
        color="0x666666" name="hotel_icon_door"]
```

対応する絵文字：
- 🚪 ドア
- 🚪 机 / 💼
- 🪟 窓
- ✅ はい
- ❌ いいえ

#### **オプション C: カスタム CSS の埋め込み**
HTML を直接編集して、より高度なスタイリングを実装可能。

---

## 🎯 推奨アクション

1. **Material Icons が正常に表示されるか確認**
   - ゲームを実行し、アイコンが表示されるか検証
   
2. **表示されない場合は Unicode 絵文字に切り替え**
   ```bash
   grep -r "font=\"Material Icons\"" docs/data/scenario/
   # 各行で font 属性を削除し、テキストを絵文字に置き換える
   ```

3. **背景画像 `hotel_pause_bg.jpg` を用意する**
   - ポーズ画面を暗くするため、推奨サイズ: 1280x720px

---

## 💡 Material Icons 参考リンク
- [Google Fonts - Material Icons](https://fonts.google.com/icons)
- [Material Icons Cheat Sheet](http://google.github.io/material-design-icons/)

## 📝 修正履歴
- index.html にクイックリンク追加（Google Fonts CDN）
- first.ks に Material Icons アイコン統合
- CSSスタイル定義を index.html に追加
