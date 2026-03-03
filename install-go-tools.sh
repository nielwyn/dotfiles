#!/usr/bin/env bash
set -euo pipefail

# Check that 'go' is available
if ! command -v go >/dev/null 2>&1; then
  echo "Error: 'go' is not installed or not on PATH. Install Go first: https://go.dev/dl"
  exit 1
fi

# Determine install directory
GOBIN=$(go env GOBIN 2>/dev/null || true)
if [ -z "$GOBIN" ] || [ "$GOBIN" = "<no value>" ]; then
  GOPATH=$(go env GOPATH)
  INSTALL_DIR="${GOPATH}/bin"
else
  INSTALL_DIR="$GOBIN"
fi

mkdir -p "$INSTALL_DIR"
echo "Installing tools into: $INSTALL_DIR"
echo

TOOLS=(
  "golang.org/x/tools/gopls@latest"
  "golang.org/x/tools/cmd/goimports@latest"
  "github.com/golangci/golangci-lint/cmd/golangci-lint@latest"
)

for pkg in "${TOOLS[@]}"; do
  echo "-> Installing $pkg"
  go install "$pkg"
done

echo
echo "Install complete."

# Show verification commands / quick checks
echo
echo "Verify installed binaries:"
echo "  command -v gopls && gopls version"
echo "  command -v goimports && echo 'goimports OK'"
echo "  command -v golangci-lint && golangci-lint --version"
echo

# Recommend adding to PATH if not already
case ":$PATH:" in
  *":$INSTALL_DIR:"*) 
    echo "Good: $INSTALL_DIR is already in your PATH"
    ;;
  *)
    SHELL_NAME=$(basename "${SHELL:-}")
    echo "Note: $INSTALL_DIR is not in your PATH."
    echo "Add the following line to your shell profile (~/.${SHELL_NAME}rc or ~/.profile):"
    echo
    echo "  export PATH=\"${INSTALL_DIR}:\$PATH\""
    echo
    echo "Then run: source ~/.${SHELL_NAME}rc  (or restart your terminal)"
    ;;
esac
