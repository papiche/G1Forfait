#!/bin/bash
################################################################################
# Author: Fred (support@qo-op.com)
# Version: 0.1
# License: AGPL-3.0 (https://choosealicense.com/licenses/agpl-3.0/)
################################################################################
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized

############################################################### ipfs
##  __  __ ___ ____ ____   ___    _     _____ ____   ____ _____ ____
## |  \/  |_ _/ ___|  _ \ / _ \  | |   | ____|  _ \ / ___| ____|  _ \
## | |\/| || | |   | |_) | | | | | |   |  _| | | | | |  _|  _| | |_) |
## | |  | || | |___|  _ <| |_| | | |___| |___| |_| | |_| | |___|  _ <
## |_|  |_|___\____|_| \_\\___/  |_____|_____|____/ \____|_____|_| \_\  me


MOATS=$(date -u +"%Y%m%d%H%M%S%4N")

OLD=$(cat ${MY_PATH}/.chain)
cp ${MY_PATH}/.chain \
        ${MY_PATH}/.chain.$(cat ${MY_PATH}/.moats)

TW=$(ipfs add -rwHq ${MY_PATH}/*.* | tail -n 1)

[[ ${TW} == ${OLD} ]] && echo "No change." && exit 1

echo ${TW} > ${MY_PATH}/.chain
echo ${MOATS} > ${MY_PATH}/.moats

sed -i "s~${OLD}~${TW}~g" ${MY_PATH}/README.md
sed -i "s~${OLD}~${TW}~g" ${MY_PATH}/index.html

echo '# MAKE YOUR GIT IPFS LINKING
git add .
git commit -m "Try ME https://ipfs.copylaradio.com/ipfs/'${TW}'"
git push
'
