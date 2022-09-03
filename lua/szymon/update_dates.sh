function updateDate() {
	FILE=$1
	### dd.mm.yyyy ###
	TODAY=$(date +'%d.%m.%Y' -r $FILE)
	sed -i "1c\-- Version of $TODAY." $FILE
}

for FILE in *.lua; do updateDate $FILE; done








inny test
