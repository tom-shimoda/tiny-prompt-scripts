#!/bin/bash

# 変換対象のディレクトリを指定（引数があればそれを使用、なければカレントディレクトリ）
TARGET_DIR="${1:-.}"

# ImageMagickの `convert` コマンドが利用可能か確認
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick (convert) がインストールされていません。"
    exit 1
fi

# 指定ディレクトリ内の .heic / .HEIC ファイルを検索して変換
for file in "$TARGET_DIR"/*.{heic,HEIC}; do
    # グロブが展開されずそのままの場合はスキップ
    [ -e "$file" ] || continue

    # 変換後のファイル名を設定（拡張子を .png に変更）
    output_file="${file%.*}.png"

    # 変換処理を実行
    convert "$file" "$output_file"

    # 変換成功メッセージを表示
    echo "Converted: $file -> $output_file"
done

echo "All HEIC files in '$TARGET_DIR' have been converted to PNG."

