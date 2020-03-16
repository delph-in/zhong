################################################################################
# 
# This script is addapted from FCB's, and is able to transform Mandarin text 
# into its respective pinyin variants.
#
# It currently is used in conjunction with lexicon_splut.py
# Maybe these two should be merged.
################################################################################

##
## get a word and return its pronunciation
##
##  confidence case
##  in cedict with one pronunciation 1.0
##  in cedict with multiple pronunciation 0.9
##  all characters have one pronunciation 0.8
##  at least one character has multiple pronunciation 0.7
import gzip, re, os, requests
from collections import defaultdict as dd
import itertools
import unicodedata



# Download/Update CEDICT 
url = 'https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz'
r = requests.get(url, allow_redirects=True)
open('cedict_1_0_ts_utf-8_mdbg.txt.gz', 'wb').write(r.content)


tonemarks = ["", "̄", "́", "̌", "̀", ""]

def readcepy():
    lines = gzip.open(
        os.path.join(os.path.dirname(__file__),
        "cedict_1_0_ts_utf-8_mdbg.txt.gz"),
        mode='rt',
        encoding='utf-8')
    exp = re.compile("^([^ ]+) ([^ ]+) \[(.*)\] /(.+)/")
    parsed_lines = (exp.match(line).groups()
                    for line in lines
                if line[0] != '#')

    zhs2pys = dd(set)
    zhs2py = dd(list)
    chr2pyd=dd(lambda: dd(int))
    chr2py = dd(list)
    for traditional, simplified, pinyin, meaning in parsed_lines:
        #print(simplified, pinyin)
        pinyin = pinyin.replace('u:', 'ü')
        zhs2pys[simplified].add(pinyin.lower())
        ss = list(simplified)
        ps = pinyin.split()
        if len(ss) == len(ps):
            for (s,p) in zip(ss,ps):
                #print(s,p)
                chr2pyd[s][p.lower()] +=1
        # else:
        #     print("Different length: ", ss, ps)
    for c in chr2pyd:
        for (f,p) in sorted([(f,p) for (p,f) in chr2pyd[c].items()],
                            reverse=True):
            chr2py[c].append((p,f))
    for w in zhs2pys:
        zhs2py[w]=list(zhs2pys[w])
    return zhs2py, chr2py

zhs2py, chr2py = readcepy()



def pinyin(w):
    """
    This function takes a string a returns a tuple with the form ("pin1 yin1", 0.99)
    The second is a confidence score based on how the pinyin was determined.
    """
    if len(zhs2py[w]) == 1: ### unique match!
        return (zhs2py[w][0], 1.0) 
    elif len(zhs2py[w]) > 1 and len(w) > 1: ### multiple match!
        return (zhs2py[w][0], 0.85)
    elif len(zhs2py[w]) > 1 and len(w) == 1: ### multiple match chr!
        return (chr2py[w][0][0], 0.8) 
    elif len(zhs2py[w]) < 1:
        conf = 0.8
        p = []
        for c in list(w):
            if c in chr2py:
                p.append(chr2py[c][0][0])
                if len(chr2py[c]) > 1:
                    conf += -0.01
            elif c == ' ' or '␣':
                p.append(c)
            else:
                return None
        return (" ".join(p), conf)


def py2dia(w):
    d = []
    for pinyin in w.split():
        if pinyin[-1] in "012345":
            tone=int(pinyin[-1])
            pinyin=pinyin[:-1]
        else:
            tone=0
        if pinyin.isalpha() and tone in [1,2,3,4]:
            vowels = itertools.chain((c for c in pinyin if c in "aeo"),
                                     (c for c in pinyin if c in "iuvü"))
            vowel = pinyin.index(next(vowels)) + 1
            pinyin = pinyin[:vowel] + tonemarks[tone] + pinyin[vowel:]
        d.append(unicodedata.normalize('NFC', pinyin))
    return " ".join(d)

def py2plain(w):
    d = []
    for pinyin in w.split():
        if pinyin[-1] in "12345":
            pinyin=pinyin[:-1]
        d.append(pinyin)
    return " ".join(d)


# for w in """我 七点半 就 起床 ， 晚上 十二点半 以后 才 睡觉 。请 问 欢欢 在 吗 ？ 我的 宿舍 是 四一三 号 ， 房间 很 小 ， 有 一 个 电话 ， 我 的 电话 号码 是 （ 一四二 ） 九三二六五八七 。 严以律己 如果 你们 不 认识 他 ， 也 没关系 ， 我 来给 你们 介绍 一下 ， 他 是 我 的 室友 。
# 他 叫 学友 ， 他 是 韩国人 ， 他 学 英国 文学 。
# 我们 常常 一起 上课 ， 下课 。 女人
# 下课 以后 我们 常 一起 回 宿舍 。
# 我们 是 好 室友 ， 好 同学 ， 也是 好 朋友 。
# 今天 我们 想 去 吃 日本 菜 ， 下次 吃 中国 菜 。
# 下课 以后 你们 有 事儿 吗 ？
# 你们 想 不 想 吃 日本 菜 ？
# 跟 我␣们 一起 去 吃 日本 菜 ， 怎么样 ？
# 好 ，␣ 再见 ！
# """.split() + ['宿 舍']:
#     print('\n', w)
#     # p =  pinyin(w,zhs2py, chr2py)
#     p =  pinyin(w)
#     if p:
#         print (w, p[0], p[1], py2dia(p[0]), py2plain(p[0]), sep='; ')
#         if 'ü' in p[0]:
#             print (w, p[0].replace('ü', 'v'), py2plain(p[0]).replace('ü', 'v'), sep='; ')
#     else:
#         print (w, "???")
 

    
