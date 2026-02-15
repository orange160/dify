#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-}"
TARGET_DIR="${2:-$(pwd)}"

if [[ -z "$REPO_NAME" ]]; then
  echo "Usage: $0 <repo-name> [target-directory]"
  exit 1
fi

REPO_PATH="$TARGET_DIR/$REPO_NAME"

if [[ -e "$REPO_PATH" ]]; then
  echo "Error: '$REPO_PATH' already exists"
  exit 1
fi

mkdir -p "$REPO_PATH"
cd "$REPO_PATH"

git init -b main >/dev/null

cat > README.md <<README
# $REPO_NAME

A new repository scaffolded from /workspace/dify/scripts/create-repo.sh.
README

cat > .gitignore <<'GITIGNORE'
.DS_Store
node_modules/
.env
__pycache__/
*.pyc
GITIGNORE

git add README.md .gitignore
git commit -m "chore: initialize repository" >/dev/null

echo "Repository created at: $REPO_PATH"
