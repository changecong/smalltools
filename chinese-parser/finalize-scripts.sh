`rm -r finalized-scripts *.stemmed`

IAlternative="[俺|额|老臣|奴才|奴婢|卑职|微臣|朕]"
youAlternative="[您]"

txtFileList=`ls *.txt`
for filename in $txtFileList; do
  if [ -f $filename ]; then
    echo 'Filename: ' $filename
    `sed 's/俺|额|老臣|奴才|奴婢|卑职|微臣|朕/我/g' $filename | sed 's/臣/我/g' | sed 's/您/你/g' > temp-$filename`
    `python splitter.py temp-$filename`
    `mv temp-$filename.stemmed $filename.stemmed`
  fi
done
echo "************************************"
echo "* DONE! Scripts have been stemmed! *"
echo "************************************"
echo "Finalizing scripts: "
`mkdir finalized-scripts`
stemmedFileList=`ls *.stemmed`
for filename in $stemmedFileList; do
  if [ -f $filename ]; then
    echo "Finalizing: " $filename
    `sed 's/^[[:space:]]*//g' $filename | sed 's/\r//g' | sed '/^[[:space:]]*$/d' > finalized-scripts/'finalized-'$filename`
  fi
done
`rm *.stemmed temp-*`
echo "**************************************"
echo "* DONE! Scripts have been finalized! *"
echo "**************************************"
