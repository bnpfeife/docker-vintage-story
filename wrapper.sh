#!/bin/bash
set -eEuo pipefail

STAMP="$(dirname -- "$(realpath -- "${BASH_SOURCE[0]}")")/.vs-stamp"

if [[ -e "${STAMP}" ]]
then
    echo "It appears that Vintage Story is already running!"
    exit 1
fi

touch "${STAMP}" ; trap 'rm -f "'"${STAMP}"'"' EXIT ERR

"${@}"
