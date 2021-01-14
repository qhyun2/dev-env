#!/bin/bash
if [ $# -lt 3 ]; then
	echo "Usage: marmoset_submit course project file [...]"
	exit 1
fi
if [ $# -eq 3 ]; then
	zip "$3" >& /dev/null
	if [ $? -eq 12 ]; then
		~/dev-env/scripts/marmoset.py "$@"
		exit 0;
	fi
fi
COURSE="$1"
ASSIGN="$2"
shift
shift
TEMP=`tempfile --suffix=.zip`
rm $TEMP
zip -j $TEMP "$@"

RTEMP=`ssh uw "tempfile --suffix=.zip"`
ssh uw rm $RTEMP
scp $TEMP uw:$RTEMP

~/dev-env/scripts/marmoset.py "$COURSE" "$ASSIGN" $RTEMP
rm $TEMP
