# Redmine Tokyo Theme 🗼

[Redmine Tokyo](https://redmine.tokyo/) コミュニティで愛用されているテーマです。Redmine のクラシックな使い勝手はそのままに、より洗練された見た目で快適にプロジェクト管理できます！

## 使い方(3 ステップで完了!) 🚀

1. このリポジトリをクローンまたはダウンロードします
2. Redmine インストールディレクトリの `public/themes/redmine_tokyo_theme` にコピーします
3. Redmine を再起動後、**管理 → 設定 → 表示** から「Redmine Tokyo Theme」を選択

💡 **Tip**: アセットがキャッシュされて変更が反映されない場合は、`bundle exec rails tmp:cache:clear` でキャッシュをクリアしてください。

## 開発に参加したい方へ 🛠️

Redmine Tokyo Theme はコミュニティみんなで育てているテーマです。改善案や新機能のアイデアがあれば、ぜひ PR を送ってください！

## ファイル構成 📁

- `stylesheets/application.css` – メインのスタイルシートとカスタムアセット
- `javascripts/theme.js` – 軽量な動作改善スクリプト
- `favicon/` – テーマに含まれるファビコン素材

## コントリビューションガイド 🤝

プルリクエストを送る際は、以下を心がけていただけると助かります:

- **コミットメッセージ**: 簡潔に(例: `ガントチャートの色を更新`)。チケット参照は `refs #ID` で
- **コーディングスタイル**: CSS は小文字ハイフン区切り、インデントは 2 スペースで
- **PR の内容**: UI 変更の概要、スクリーンショット、動作確認方法を記載してください
- **パッケージング確認**: ZIP 作成が正常に動くか確認してからレビュー依頼をお願いします

みんなで作るテーマなので、気軽に参加してください！質問があれば Issue を立てていただければ対応します 😊

## English Summary 🌏

Redmine Tokyo Theme is the official theme used by the [Redmine Tokyo](https://redmine.tokyo/) user community. It modernizes the default Redmine look while maintaining a familiar interface. The theme is built with plain static files (no build process required), making it easy to install and compatible with multiple Redmine versions. Simply copy to `public/themes/redmine_tokyo_theme` in your Redmine installation and select it from the administration settings.

## ライセンス 📄

このプロジェクトは MIT ライセンスの下で公開されています。Redmine Tokyo コミュニティによってメンテナンスされており、自由に使用・改変・再配布が可能です。

MIT License - 詳細は [LICENSE](LICENSE) ファイルをご覧ください。
