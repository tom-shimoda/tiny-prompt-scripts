### 使い方
1. スクリプトに実行権限を付与  
   ```sh
   chmod +x convert_heic_to_png.sh
   ```
2. カレントディレクトリ内の `.heic` を変換  
   ```sh
   ./convert_heic_to_png.sh
   ```
3. 特定のディレクトリ内の `.heic` を変換  
   ```sh
   ./convert_heic_to_png.sh /path/to/directory
   ```

### 事前準備
- `imagemagick` がインストールされていることを確認してください。  
  インストールされていない場合は、以下のコマンドでインストールできます：
  - **Ubuntu/Debian**  
    ```sh
    sudo apt update && sudo apt install imagemagick -y
    ```
  - **macOS (Homebrew)**  
    ```sh
    brew install imagemagick
    ```
  - **Windows (WSL)**  
    ```sh
    sudo apt install imagemagick -y
    ```

[参考元](https://blog.k-bushi.com/post/tech/tips/convert-heic-to-png-with-imagemagick/)
