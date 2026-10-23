#!/usr/bin/env bash
###############################################################################
# scripts/verificar-latex.sh
# 5 checks de decisiones-fase2.md (§10). Bloquea el merge si alguno falla.
# Uso: ./scripts/verificar-latex.sh   (desde la raíz del repositorio)
###############################################################################
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

STATUS=0

check() { echo "[check] $1"; }
fail()  { echo "[FAIL] $1" >&2; STATUS=1; }

echo "============================================================"
echo "verificar-latex.sh — 5 checks de decisiones-fase2.md §10"
echo "============================================================"

# (a) Toda clave usada en \cite / \citep / \citet / \fuente de cada .tex
#     existe en core.bib o en el .bib de su carpeta.
check "(a) claves de citación definidas"
DEFINED_FILE="$(mktemp)"
grep -rhoE '@[a-zA-Z]+\{[^,]+,' core.bib *.bib preguntas/*/*.bib investigacion/*/*.bib 2>/dev/null \
  | sed -E 's/.*\{([^,]+).*/\1/' | sort -u > "$DEFINED_FILE" || true
clave_definida() { grep -qxF "$1" "$DEFINED_FILE"; }
while IFS= read -r -d '' f; do
  keys="$(grep -v '^[[:space:]]*%' "$f" | grep -hoE '\\(cite|citep|citet)\{([^}]*)\}' \
    | sed -E 's/.*\{([^}]*)\}/\1/' | tr ',' '\n' \
    | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | grep -v '^$' || true)"
  keys_fuente="$(grep -v '^[[:space:]]*%' "$f" | grep -hoE '\\fuente\{([^}]*)\}' \
    | sed -E 's/.*\{([^}]*)\}/\1/' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | grep -v '^$' || true)"
  for k in $keys $keys_fuente; do
    case "$k" in \#*) continue ;; esac   # parámetro de macro (p. ej. \fuente{#1}), no una clave
    if ! clave_definida "$k"; then
      fail "$f: clave de cita no definida: $k"
    fi
  done
done < <(find . -name '*.tex' -not -path './.git/*' -print0 | sort -z)
rm -f "$DEFINED_FILE"

# (b) .tex/.bib UTF-8 válidos
check "(b) codificación UTF-8 de .tex y .bib"
while IFS= read -r -d '' f; do
  if ! iconv -f UTF-8 -t UTF-8 "$f" -o /dev/null 2>/dev/null; then
    fail "$f: no es UTF-8 válido"
  fi
done < <(find . \( -name '*.tex' -o -name '*.bib' \) -not -path './.git/*' -print0 | sort -z)

# (c) portada.tex no debe contener TODO
check "(c) portada.tex sin placeholders TODO"
if [ -f portada.tex ] && grep -q 'TODO' portada.tex; then
  fail "portada.tex contiene placeholders TODO (rellenar antes del merge)"
fi

# (d) fragmentos sin \documentclass / \begin{document} / \usepackage
check "(d) fragmentos libres de preámbulo"
while IFS= read -r -d '' f; do
  # El documento principal y el preámbulo compartido son los únicos que cargan paquetes.
  [ "$f" = "./SemArq1_TeamBales.tex" ] && continue
  [ "$f" = "./preamble.tex" ] && continue
  if grep -v '^[[:space:]]*%' "$f" | grep -qE '\\(documentclass|begin\{document\}|usepackage)'; then
    fail "$f: fragmento contiene preámbulo (prohibido en fragmentos)"
  fi
done < <(find . -name '*.tex' -not -path './.git/*' -print0 | sort -z)

# (e) listar \chapter y \section para revisión humana
check "(e) jerarquía de capítulos y secciones encontrada"
echo "--- \chapter / \section detectados ---"
grep -rhoE '\\(chapter|section)\*?\{[^}]*\}' --exclude-dir=.git . | sort || true
echo "----------------------------------------"

if [ "$STATUS" -ne 0 ]; then
  echo "============================================================"
  echo "verificar-latex.sh: FALLÓ (merge bloqueado)"
  echo "============================================================"
  exit 1
fi

echo "============================================================"
echo "verificar-latex.sh: OK — los 5 checks pasaron"
echo "============================================================"
exit 0
