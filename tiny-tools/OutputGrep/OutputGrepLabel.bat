:: 指定XMLファイルから該当ラベルの値を抜き出し、その値でのgrep結果をファイル出力します

:: ◆使い方
:: このバッチはプロジェクトルートフォルダに配置した上で実行してください
:: また、OutputGrepLabel.pyを同階層に配置してください
:: 処理対象ファイルパスは適当なものに変えて使用してください
:: ※ pythonと、grepにripgrepを使用していますのでそれぞれインストールしてください。

:: 第1引数: 処理対象ファイル
:: 第2引数: ラベル名
:: 第3引数: 出力ファイル名
:: 第4引数: 検索結果の除外ファイル名


python ./OutputGrep.py ^
            処理対象ファイル ^
            LABEL ^
            output.txt ^
            ignore.txt

