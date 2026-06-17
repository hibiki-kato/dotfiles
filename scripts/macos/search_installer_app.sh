#!/bin/zsh

# 1. 除外するデフォルトアプリのリスト
exclude_apps=("safari" "mail" "calendar" "contacts" "messages" "reminders" "photos" "maps" "siri"  "imovie" "pages" "numbers" "keynote" "notes" "itunes" "facetime" "iwallpaper" "zoom.us" "utilities" "karabiner-eventviewer" "globalprotect")

# 2. `Applications` フォルダ内のアプリ名を取得し、フォーマットを統一（小文字化 & スペースをハイフンに置換）
ls /Applications | sed 's/\.app$//' | awk '{print tolower($0)}' | sed 's/ /-/g' > installed_apps.txt

# 3. 除外リストに載っているアプリを削除
for app in "${exclude_apps[@]}"; do
    sed -i '' "/$app/d" installed_apps.txt
done

# 4. Brewfile から `brew cask` のアプリ一覧を取得（ダブルクォーテーション削除）
grep 'cask ' ~/.Brewfile | awk '{print $2}' | sed 's/"//g' > brew_cask_apps.txt

# 5. Brewfile から `mas` のアプリ名を取得（idの部分は削除）
grep 'mas ' ~/.Brewfile | sed 's/mas "\([^"]*\)".*/\1/' | awk '{print tolower($0)}' | sed 's/ /-/g' > brew_mas_apps.txt

# 6. Mac にインストールされている `mas` アプリのID一覧を取得
mas list | awk '{print $2}' | sed 's/ /-/g' > installed_mas_apps.txt

# 7. Brewfile に載っている `brew cask` + `mas` のリストを統合
cat brew_cask_apps.txt brew_mas_apps.txt | sort > all_brew_apps.txt

# 8. `Applications` にあるけど `.Brewfile` に載っていないアプリを抽出して保存
comm -23 <(sort installed_apps.txt) <(sort all_brew_apps.txt) > "$HOME/dotfiles/asset/App_list.txt"

# 9. ファイルを削除
rm installed_apps.txt brew_cask_apps.txt installed_mas_apps.txt all_brew_apps.txt brew_mas_apps.txt

