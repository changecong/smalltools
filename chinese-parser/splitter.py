# encoding=utf-8
import jieba
import re

import sys, os

filename = sys.argv[1]
# print "processing file " + filename + "... ..."

readfile = open(filename, 'r')
writefile = open(filename + '.stemmed', 'w')
for oneline in readfile:
    seg_list = jieba.cut(oneline)
    # print u" ".join(seg_list)
    newline = u" ".join(seg_list).encode('utf-8')
    newline = re.sub('《|》|，|：|—|－|“|”|‘|’| 、', '', newline)
    newline = re.sub('-|<|>|:|`|\'|\"', '', newline)
    newline = re.sub('　', ' ', newline)
    newline = re.sub(' +', ' ', newline)
    newline = re.sub('。|\.|？|！|……|…|!|\?|；|;', os.linesep, newline)
    writefile.write(newline)

writefile.close()
readfile.close()
