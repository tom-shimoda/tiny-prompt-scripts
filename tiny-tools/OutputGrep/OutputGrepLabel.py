import sys
import xml.etree.ElementTree as ET
import subprocess

def ExtractLabelValue(filename, label):
    tree = ET.parse(filename)
    root = tree.getroot()

    elements = root.findall(".//{}".format(label))

    values = []
    for element in elements:
        values.append(element.text)

    return values




args = sys.argv
ans = []
ignoreFiles = []

# ignore.txtから除外対象のファイル名を読み込む
with open(args[4], 'r') as f:
    ignoreFiles = f.read().splitlines()

labelValues = ExtractLabelValue(args[1], args[2])

for v in labelValues:
    print(v)

    ans.append(v)
    command = ['rg', '--no-ignore', '--column', '--heading', v]
    for file in ignoreFiles:
        command.extend(['--glob', '!' + file])

    try:
        output = subprocess.check_output(command, shell=True)
    except subprocess.CalledProcessError as e:
        print("\tNot used.")
    else:
        output_utf8 = output.decode('utf-8').splitlines()
        for w in output_utf8:
            ans.append('\t'+w)

    ans.append('\n')


with open(args[3], 'w', encoding='utf-8') as f:
    for v in ans:
        f.write(v + '\n')

