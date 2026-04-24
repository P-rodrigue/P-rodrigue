#!/usr/bin/env bash
set -euo pipefail

# Bootstrap local pour repartir proprement sur OpenNos
# Usage:
#   ./scripts/bootstrap_opennos.sh [target_dir]

TARGET_DIR="${1:-vendor/OpenNos}"
REPO_URL="https://github.com/OpenNos/OpenNos.git"

mkdir -p "$(dirname "$TARGET_DIR")"

if [ -d "$TARGET_DIR/.git" ]; then
  echo "[INFO] Dépôt déjà présent: $TARGET_DIR"
else
  echo "[INFO] Clonage de $REPO_URL vers $TARGET_DIR"
  git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"

echo "[INFO] Branche courante: $(git rev-parse --abbrev-ref HEAD || true)"
echo "[INFO] Dernier commit: $(git log -1 --oneline || true)"

echo "[INFO] Vérification structure..."
for d in src docker scripts; do
  if [ -d "$d" ]; then
    echo "  - trouvé: $d/"
  fi
done

echo "\n[PROCHAINE ETAPE]"
echo "1) Lire le README du projet cloné"
echo "2) Restaurer les dépendances (nuget/dotnet restore)"
echo "3) Configurer DB/ports"
echo "4) Lancer les services login/world"
