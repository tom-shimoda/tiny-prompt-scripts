::================================================================
:: Jenkinsからsvn管理下のプロジェクトをビルドするサンプル
::================================================================

:: SVNログを英語で出したい
chcp 437

:: 出力フォルダ削除
if exist 出力フォルダ (
    powershell Remove-Item 出力フォルダ -Recurse -Force
)

:: svn更新
svn cleanup リポジトリパス
svn revert -R リポジトリパス

if "%~1"=="0" (
    echo "Check out the latest revision."
    svn up リポジトリパス
) else (
    echo "Check out revision %~1."
    svn up -r%~1 リポジトリパス
)

:: リビジョン番号取得
svn info リポジトリパス | findstr Revision >svn_revision_info.txt
python sed.py "svn_revision_info.txt" "Revision: " ""
SET /P revision=<svn_revision_info.txt
if exist svn_revision_info.txt rm svn_revision_info.txt

:: 元に戻す (文字列置換等を扱わないなら戻す必要ないかも？)
chcp 932

:: バージョン管理してない設定書き換え
python sed.py "書き換えたいファイル" "ファイル内の書き換え元文字列" "ファイル内の書き換え先文字列"
:: (ex.) python sed.py "target.cpp" "HogeHogeSrc" "FooFooDst"


:: *** ビルド処理 ***


:: 出力フォルダへ
cd 出力フォルダ
:: 出力フォルダを圧縮する
set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time2=%time: =0%
set hh=%time2:~0,2%
set mn=%time2:~3,2%
set ss=%time2:~6,2%
set filename=r%revision%_%yyyy%%mm%%dd%-%hh%%mn%
:: zipに固める
:: powershell compress-archive Export %filename%
:: 7zに固める
7z a %filename%.7z 出力フォルダ

:: apacheへ移動
mv %filename%.zip C:\Users\ユーザー名\AppData\Roaming\Apache24\htdocs\rom

