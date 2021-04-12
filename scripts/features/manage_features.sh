PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' 

appVersion=$1

echo -e "${PURPLE}CONFIGURING API URLS${NC}"

apibaseVar=$(cat ../../versions/${appVersion}/feature_list.txt | grep -m 1 api_base)
apibaseFile=$(echo $apibaseVar | cut -d'=' -f 2)


hostUrlVar=$(cat ../../versions/${appVersion}/feature_list.txt | grep -m 1 host_url)
hostUrlFile=$(echo $hostUrlVar | cut -d'=' -f 2)


echo -e "api base -> ${GREEN}${apibaseFile}${NC}"
apibaseFileLine=$(cat ../../src/services/api.js | grep -m 1 baseUrl)
sed -i -e "s#${apibaseFileLine}#export var baseUrl = ${apibaseFile}#g" ../../src/services/api.js

echo -e "host url -> ${GREEN}${hostUrlFile}${NC}"
hostUrlFileLine=$(cat ../../src/services/api.js | grep -m 1 hostUrl)
sed -i -e "s#${hostUrlFileLine}#export var hostUrl = ${hostUrlFile}#g" ../../src/services/api.js


echo -e "${PURPLE}MANAGING OPTIONAL FEATURES FOR THIS VERSION${NC}"

declare -a featureArr=("reverse_prospect")

for j in "${featureArr[@]}"
do
    featureLine=$(cat ../../versions/${appVersion}/feature_list.txt | grep -m 1 $j)
    feature=$(echo $featureLine | cut -d'=' -f 2)
    ./$j.sh $feature
done