import sys
import os
import xml.etree.ElementTree as ET
import subprocess

def ExtractLabelValue(filename, label):
    # XMLファイルをパース
    tree = ET.parse(filename)
    root = tree.getroot()

    # ラベル名と合致するものを探す
    elements = root.findall(".//{}".format(label))

    values = []
    for element in elements:
        values.append(element.text)

    return values


def IsUsed(labelValue, ignoreFiles) -> bool:
    # その値でgrepする
    usages = subprocess.check_output(["rg", "--no-ignore", "--count", labelValue]) \
                        .decode('utf-8') \
                        .splitlines()
    # 無視対象を除外
    usages = [
        line for line in usages 
        if all (ignoreFiles not in os.path.basename(line) 
                for ignoreFiles in ignoreFiles)
    ]

    return len(usages) > 0


args = sys.argv
ans = []
ignoreFiles = []

# ignore.txtから除外対象のファイル名を読み込む
with open(args[4], 'r') as f:
    ignoreFiles = f.read().splitlines()

# 指定されたラベルの値を抽出
labelValues = ExtractLabelValue(args[1], args[2])

# 使用されているかチェック
for v in labelValues:
    if IsUsed(v, ignoreFiles):
        print(v + ' is used.')
    else:
        ans.append(v)
        print(v + ' is not used.')

# 未使用のものを書き出し
with open(args[3], 'w', encoding='utf-8') as f:
    for v in ans:
        f.write(v + '\n')

