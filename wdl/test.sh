a=$(wc -l < workflow.wdl)
echo $a
if test $a -gt 1000
then
	echo "a"
fi
