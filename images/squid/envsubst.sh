#!/bin/sh

DIR_TEMPLATES="${DIR_TEMPLATES:-$(pwd)/templates}";
DIR_OUTPUT="${DIR_OUTPUT:-$(pwd)/conf}";
FILE_SUFFIX="${FILE_SUFFIX:-.template}";

printf "Factoring templates in $DIR_TEMPLATES to $DIR_OUTPUT\n";

DEFINED_ENVS=$(printf '${%s} ' $(env | cut -d= -f1));

if [ ! -d "$DIR_TEMPLATES" ];
then
    exit 0;
fi

find "$DIR_TEMPLATES" -follow -type f -name "*$FILE_SUFFIX" -print | while read -r TEMPLATE;
do
    RELATIVE_PATH="${TEMPLATE#$DIR_TEMPLATES/}";

    OUTPUT_PATH="$DIR_OUTPUT/${RELATIVE_PATH%$FILE_SUFFIX}";
    SUBDIR=$(dirname "$RELATIVE_PATH");
    mkdir -p "$DIR_OUTPUT/$SUBDIR";
    printf "Running envsubst on $TEMPLATE to $OUTPUT_PATH\n";
    envsubst "$DEFINED_ENVS" < "$TEMPLATE" > "$OUTPUT_PATH";
done
