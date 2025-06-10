# Fortune Telling App - 神秘の占い館

Ruby on Railsで作成された占いアプリ「神秘の占い館」です。タロット占い、星座占い、数秘術など、様々な占いを楽しめるWebアプリケーションです。

## 🚀 クイックスタート

### ⚡ セットアップ

```bash
# 1. リポジトリをクローン
git clone <repository-url>
cd fortune-telling-app

# 2. 自動セットアップ実行
make setup

# 3. 環境変数を設定
cp .env.example .env
# .envファイルのRAILS_MASTER_KEYに config/master.key の内容をコピー

# 4. アプリケーション再起動
docker compose restart

# 5. ブラウザでアクセス
open http://localhost:3002
```

## 🛠️ 開発環境

### 技術スタック

* **Ruby**: 3.3.0
* **Rails**: 8.0.2
* **データベース**: PostgreSQL
* **CSS**: Tailwind CSS v4.1
* **ジョブキュー**: Solid Queue
* **コンテナ**: Docker & Docker Compose
* **認証**: Rails標準認証機能

### 🔐 環境変数の設定

#### 初回セットアップ後の手順

1. **環境変数ファイルをコピー**
   ```bash
   cp .env.example .env
   ```

2. **RAILS_MASTER_KEYを設定**
   ```bash
   # config/master.keyの内容を確認
   cat config/master.key
   
   # .envファイルを編集してRAILS_MASTER_KEYに値を設定
   nano .env
   ```

3. **アプリケーションを再起動**
   ```bash
   docker compose restart
   ```

### 🏗️ 手動でのDocker環境セットアップ

自動セットアップを使わない場合：

```bash
# 1. ビルド・起動
docker compose up --build -d

# 2. 環境変数設定
make env-setup
make master-key-setup

# 3. TailwindCSS設定
make tailwind-setup

# 4. データベースセットアップ
make db-setup

# 5. Solid Queueセットアップ
make solid-queue-setup

# 6. テスト環境準備
make test-setup
```

### 🧪 テスト実行

```bash
# テスト実行
make test

# テスト環境リセット（必要に応じて）
make test-reset
```

### 🌐 アクセス情報

- **アプリケーション**: http://localhost:3002
- **データベース**: localhost:5432
- **コンテナ内ポート**: 3000（アプリ）、5432（DB）

## 📋 開発ガイドライン

### コミットメッセージの形式

このプロジェクトでは以下の接頭語を使用してコミットメッセージを統一しています：

- `feat:` - 新機能・機能追加・機能改善
- `fix:` - バグ修正・問題解決  
- `chore:` - その他（環境設定、ドキュメント更新、リファクタリングなど）

#### 例：
```
feat: タロット占い機能の追加
fix: 認証リダイレクトループの修正
chore: TailwindCSS環境のセットアップ
```

### 開発フロー

1. **機能ブランチを作成**
   ```bash
   git checkout -b feature/tarot-reading
   ```

2. **TailwindCSS開発モード起動**
   ```bash
   make tailwind-watch
   ```

3. **開発・テスト**
   ```bash
   make test
   ```

4. **コミット**
   ```bash
   git add .
   git commit -m "feat: タロットカード表示機能の追加"
   ```

5. **プルリクエスト作成**