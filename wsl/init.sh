#!/usr/bin/env bash
set -euo pipefail

echo "=== 1. システムパッケージの更新と必須ツールの導入 ==="
sudo apt-get update
sudo apt-get install -y curl git build-essential


echo "=== 2. mise のインストール ==="
if ! grep -q 'mise activate' "$HOME/.bashrc"; then
    curl https://mise.run | sh
    echo 'eval "$($HOME/.local/bin/mise activate bash)"' >> "$HOME/.bashrc"
    echo "mise をインストールし、~/.bashrc に設定を追加しました。"
fi

echo "=== 基本セットアップが完了しました！ ==="
echo "シェルを再起動してください。 または source ~/.bashrc "
echo "Memo-zアプリを初期化する場合は memo-z.sh を"
echo "AUtoGoアプリを初期化する場合は autogo.sh を実行してください。"


