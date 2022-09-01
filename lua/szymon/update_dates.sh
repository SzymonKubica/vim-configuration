

function updateDate() {
	### dd.mm.yyyy ###
	TODAY=$(date +'%d.%m.%Y')
	FILE=$1
	sed -i "1c\-- Version of $TODAY" $FILE
}

for FILE in *.lua; do updateDate $FILE; done
