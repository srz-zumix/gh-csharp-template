#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" &>/dev/null && pwd -P)
ROOT_DIR=$(cd "${SCRIPT_DIR}/../" &>/dev/null && pwd -P)

cd "${ROOT_DIR}"

OUTPUTDIR="${RUNNER_TEMP:-${ROOT_DIR}/temp}"
COMMAND_NAME=GhCSharpExtension
SLN=GhCSharpExtension.sln

dotnet restore "${SLN}"

dotnet build "${SLN}"

function publish() {
    dotnet publish "${SLN}" -c Release -r "$1" --property:PublishDir="${OUTPUTDIR}/$1" \
        --no-restore --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true
    if [ -f "${OUTPUTDIR}/$1/${COMMAND_NAME}.exe" ]; then
        cp "${OUTPUTDIR}/$1/${COMMAND_NAME}.exe" "dist/${COMMAND_NAME}-$2.exe"
    else
        cp "${OUTPUTDIR}/$1/${COMMAND_NAME}" "dist/${COMMAND_NAME}-$2"
    fi
}

[ ! -d dist ] && mkdir dist

publish osx-x64   darwin-amd64
publish osx-arm64 darwin-arm64
publish linux-x64 linux-amd64
publish win-x64 windows-amd64
