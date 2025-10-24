# dotfiles
## Set up guide before `chezmoi init --apply`
### MacOS
```sh
export HOMEBREW_NO_INSTALL_FROM_API=1
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git chezmoi
```
### Ubuntu
```sh
sudo apt update && sudo apt install -y git
snap install chezmoi --classic
```
### Windows
```ps1
winget install --id Git.Git -e --source winget
winget install --id=twpayne.chezmoi  -e
```

## Chezmoi init
```sh
chezmoi init --apply hibiki-kato/dotfiles
```

## TODO
```mermaid
flowchart TD
  A0["Lv0 ブートストラップ chezmoi 導入・設定(JSON)・git 初期化"] --> A1
  A1["Lv1 最小 dotfiles 追加\n.zshrc .gitconfig .vimrc / .chezmoiignore"] --> A2
  A2["Lv2 ルート整理\n.home をソースルート化 (.chezmoiroot)"] --> A3

  A3["Lv3 スクリプト導入\nrun_once_/run_onchange_/run_ を配置\nhome/.chezmoiscripts にテンプレ"] --> A4
  A4["Lv4 設定ディレクトリ投入\nnvim/karabiner は自作のみ管理・生成物は ignore"] --> A5
  A5["Lv5 SSH 対応\nA: age 暗号化 + 鍵は BW テキスト\nB: Premium なら attachment + テンプレ"] --> A6
  A6["Lv6 テンプレ化\n.data と .chezmoi.* で OS/ホスト分岐"] --> A7
  A7["Lv7 ライブ反映\nwatchman / watchexec で変更→自動 apply"] --> A8
  A8["Lv8 Docker テスト\n初期 Ubuntu で chezmoi init --apply 検証"] --> A9
  A9["Lv9 CI テスト強化\nGitHub Actions (macOS/Ubuntu) + Bats + Codecov"] --> A10
  A10["Lv10 配布・保守\nワンライナー / Makefile / watch タスク / ドライラン運用"]

  %% （必要ならクラス定義は後置で明示的に）
  %% class A10 final;
  %% classDef final fill:#1f2937,stroke:#0ea5e9,stroke-width:2px,color:#fff;
```

# Bellow are deprecated instructions. 
## MacOS

### Install command line tools
Install command line tools for Xcode. This is required for installing git and other packages.
```sh
xcode-select --install
```
Set user name and email for git. 
```sh
git config --global user.name "Your Name"
git config --global user.email "example.com"
```

## Clone this repository
```sh
cd ~
git clone https://github.com/hibiki-kato/dotfiles.git
cd dotfiles
```

## Run startup.sh
```sh
zsh ./scripts/setup.sh
```

## System settings
Open settings and set as same as previous device.

Additionally, run
```sh
zsh ./scripts/system_settings.sh
``` 

## Raycast
Open System Settings > General > Keyboard > Keyboard Shortcuts > Spotlight >

## Music
Set equalizer

## Zotero
Install Zotmoov, Better BibTeX, and Zotero Better Notes.

Follow this [link](https://plaza.umin.ac.jp/shoei05/index.php/2025/01/03/2706/#2_クラウドストレージにはメタ情報のみ、pdfは外部ストレージへ設定する_Zotmoov)




