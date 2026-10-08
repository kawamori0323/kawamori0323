#!/usr/bin/env bash
set -euo pipefail

echo "===  ==="

echo "=== 環境変数をセット (~/.bashrc.local) ==="
# ~/.bashrc に source 設定を追加（なければ）
LOAD_LOCAL_CMD='[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"'
if ! grep -Fq "$HOME/.bashrc.local" "$HOME/.bashrc" 2>/dev/null; then
    echo "" >> "$HOME/.bashrc"
    echo "# Load local-only environment variables (Ignored by Git)" >> "$HOME/.bashrc"
    echo "$LOAD_LOCAL_CMD" >> "$HOME/.bashrc"
fi

echo "=== 3. 環境変数の設定 (~/.bashrc.local) ==="

LOCAL_RC="$HOME/.bashrc.local"

# 1. 対話形式で入力を受け取る
read -p "GITHUB_TOKEN を入力してください (スキップはEnter): " input_github_token
# トークンなど画面に文字を出したくない場合は -s フラグを使う
read -s -p "SECRET_KEY を入力してください (非表示 / スキップはEnter): " input_secret_key
echo "" # -s の後は改行が入らないため改行を出力

# 2. 入力があった場合のみ ~/.bashrc.local に追記
if [ -n "$input_github_token" ]; then
    echo "export GITHUB_TOKEN=\"$input_github_token\"" >> "$LOCAL_RC"
fi

if [ -n "$input_secret_key" ]; then
    echo "export SECRET_KEY=\"$input_secret_key\"" >> "$LOCAL_RC"
fi

# パーミッションを自分専用（600）にしておくと安全
[ -f "$LOCAL_RC" ] && chmod 600 "$LOCAL_RC"

# 3. ~/.bashrc から ~/.bashrc.local を読み込む記述がなければ追加
if ! grep -q '\.bashrc\.local' "$HOME/.bashrc"; then
    echo '[ -f ~/.bashrc.local ] && source ~/.bashrc.local' >> "$HOME/.bashrc"
    echo "~/.bashrc に ~/.bashrc.local の読み込み設定を追加しました。"
fi

# --- 1. 機密情報（入力文字を隠す: -s） ---
read -rsp "1. OPENAI_API_KEY: " OPENAI_API_KEY
echo ""

read -rsp "2. GITHUB_TOKEN (Personal Access Token): " GITHUB_TOKEN
echo ""

# --- 2. 一般的な設定値（入力文字を表示: -sなし） ---
read -rp "3. DATABASE_URL (例: postgres://...): " DATABASE_URL

# --- ファイルへの書き出し ---
cat <<EOF > "$ENV_FILE"
# ==========================================
# ローカル環境変数（手動セットアップ）
# ==========================================
export OPENAI_API_KEY="${OPENAI_API_KEY}"
export GITHUB_TOKEN="${GITHUB_TOKEN}"
export DATABASE_URL="${DATABASE_URL}"
EOF

# 自分以外は読み書きできない権限（-rw-------）に変更
chmod 600 "$ENV_FILE"

# --- シェル起動時に自動読み込みされるよう設定 ---
SHELL_RC="$HOME/.bashrc" # zshを使っているなら "$HOME/.zshrc" に変更
LOAD_CMD="[ -f \"$ENV_FILE\" ] && source \"$ENV_FILE\""

if ! grep -Fq "$ENV_FILE" "$SHELL_RC" 2>/dev/null; then
    echo "" >> "$SHELL_RC"
    echo "# Load local environment variables" >> "$SHELL_RC"
    echo "$LOAD_CMD" >> "$SHELL_RC"
fi

echo "------------------------------------------"
echo "✅ $ENV_FILE に環境変数を保存しました（権限: 600）。"
echo "✅ $SHELL_RC に自動読み込み設定を追記しました。"
echo ""
echo "今のターミナルに反映するには、以下を実行してください："
echo "source $ENV_FILE"
echo "=========================================="




# miseのPATHを通す
export PATH="$HOME/.local/bin:$PATH"

WORKSPACE_DIR="$HOME/project" # または $HOME/dev などお好みの作業場所
mkdir -p "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"

echo "=== リポジトリのクローン ==="
# gh repo clone を使えば SSHキー等の登録前でもghログイン経由で認証が通る
if [ ! -d "Memo-z-base" ]; then
    gh repo clone kawamori0323/Memo-z-base
fi
cd Memo-z-base


#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="$HOME/.env.local"


echo "=== mise の依存ツールをインストール ==="
mise install




echo "ワークスペースの準備が完了しました！"

