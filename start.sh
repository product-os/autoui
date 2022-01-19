#!/usr/bin/env bash

showHelp() {
# `cat << EOF` This means that cat should stop reading when EOF is detected
cat << EOF  

--help,                  Display help

--title                  Project title

--openapi                Open API JSON path

--logo,                  Project logo path

--apihost,               API host

EOF
# EOF is found above and hence cat command stops reading. This is equivalent to echo but much neater when printing out.
}

for i in "$@"; do
  case $i in
    -h|--help)
      showHelp
      shift
      exit 0
      ;;
    --title=*)
      echo "title:" ${i#*=}
      TITLE=${i#*=}
      shift
      ;;
    --openapi=*)
      echo "Open API JSON path or url:" ${i#*=}
      OPEN_API_ODATA_JSON_PATH=${i#*=}
      shift
      ;;
    --logo=*)
      echo "Logo path or url:" ${i#*=}
      LOGO_PATH=${i#*=}
      shift
      ;;
    --apihost=*)
      echo "API HOST:" ${i#*=}
      API_HOST=${i#*=}
      shift
      ;;
    --default)
      DEFAULT=YES
      shift
      ;;
    *)
      echo "${i#*=} uknwon option"
      ;;
  esac
done

while [ -z "$API_HOST" ]
do
  sleep 2s 
done

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $OPEN_API_ODATA_JSON_PATH =~ $regex ]]
then
    OPEN_API_JSON=$(curl $OPEN_API_ODATA_JSON_PATH);
else
    OPEN_API_JSON=$(cat $OPEN_API_ODATA_JSON_PATH);
fi

if [[ $LOGO_PATH =~ $regex ]]
then
    LOGO=$(curl $LOGO_PATH);
else
    LOGO=$(cat $LOGO_PATH);
fi

rm -rf ./autoui-project && npm run create-app && cd autoui-project \
&& npm uninstall react react-dom --silent && npm i --save @types/react@^16.14.5 @types/react-dom@^16.9.11 react@^16.14.0 react-dom@^16.14.0 --silent \
&& echo $LOGO > ./src/logo.svg \
&& echo $OPEN_API_JSON > ./src/open-api.json \
&& echo REACT_APP_API_HOST=$API_HOST >> ./.env \
&& echo REACT_APP_TITLE=$TITLE >> ./.env \
&& npm run build \
&& cd ..