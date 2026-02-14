# Sutradhar

Orchestrator for macOS that automates the transition from a fresh install to a fully configured state. It uses **Homebrew**, **Oh-My-Zsh**, and **Chezmoi**.

## Quick Start

### Option 1: Remote Bootstrap (fresh machine)

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jigarjain/sutradhar/HEAD/bootstrap.sh)"
```

### Option 2: Local Run

```bash
git clone https://github.com/jigarjain/sutradhar
cd sutradhar
./run_scripts.sh
```

Each script is idempotent and can be run independently.

## Scripts

| Step | Script                   | Description                                                        |
| ---- | ------------------------ | ------------------------------------------------------------------ |
| 0    | `00_prerequisites.sh`    | Checks/installs git, curl, python3, clang                          |
| 1    | `01_setup_omz.sh`        | Installs Oh-My-Zsh + Powerlevel10k theme + zsh-syntax-highlighting |
| 2    | `02_install_packages.sh` | Installs Homebrew + packages (prompts for Personal/Work/Both)      |
| 3    | `03_configure.sh`        | Applies dotfiles via chezmoi                                       |
| 4    | `04_finish.sh`           | Creates folders & shows manual setup todos                         |

### Running a Single Script

```bash
# Example: Setup OMZ with plugins & themes
./scripts/01_setup_omz.sh

# Example: Install packages based for specific profile
./scripts/02_install_packages.sh

# Example: Apply dot files config via chezmoi
export REMOTE_REPO="https://github.com/jigarjain/sutradhar"
export LOCAL_REPO="$HOME/Code/sutradhar"
./scripts/03_configure.sh
```

## .dotfiles managed by Chezmoi

- `configs/dot_zshrc` - Zsh configuration
- `configs/dot_zprofile` - Login shell config
- `configs/dot_gitconfig.tmpl` - Git config template
- `configs/dot_config/iterm2/com.googlecode.iterm2.plist` - iTerm2 settings
- `configs/dot_config/zed/` - Zed editor config
