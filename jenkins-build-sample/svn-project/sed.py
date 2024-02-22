import sys

def replaceWordsInFile(fileName, before, after):
    with open(fileName, encoding="utf-8") as f:
        data_lines = f.read()

    # 指定したファイルの文字列を置換する
    data_lines = data_lines.replace(before, after)

    # 置換後に同じファイル名で保存する
    with open(fileName, mode="w", encoding="utf-8") as f:
        f.write(data_lines)

args = sys.argv
replaceWordsInFile(args[1], args[2], args[3])
