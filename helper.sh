#!/bin/bash

export PKG_TARG=arm-apple-darwin

export PKG_ROOT=$("${PKG_TARG}-gcc" -dumpspecs | grep '%{isysroot' | sed -e 's/.*%{isysroot\*:\([^}]*\)}.*/\1/; s/;:/\n/g' | sed -e 's/^-syslibroot //' | tail -n 1)
export PKG_PFIX=$("${PKG_TARG}-gcc" -v 2>&1 | grep -- --prefix | sed -e 's/.*--prefix=\([^ ]*\).*/\1/')

source "${PKG_BASE}/folders.sh"

export PKG_DATA=$(PKG_DATA_ "${PKG_NAME}")
export PKG_WORK=$(PKG_WORK_ "${PKG_NAME}")
export PKG_DEST=$(PKG_DEST_ "${PKG_NAME}")

export PKG_STAT=${PKG_BASE}/stat/${PKG_TARG}/${PKG_NAME}
export PKG_DATA=$(echo "${PKG_BASE}"/data/"${PKG_NAME}"?(_))
export PKG_VRSN=$(cat "${PKG_DATA}/_metadata/version")
export PKG_PRIO=$(cat "${PKG_DATA}/_metadata/priority")
export PKG_RVSN=$(cat "${PKG_STAT}/dest-ver" 2>/dev/null)

if [[ ! -e ${PKG_DATA} ]]; then
    echo "unknown package: ${PKG_NAME}" 1>&2
    exit 1
fi

declare -a PKG_DEPS
for dep in "${PKG_DATA}"/_metadata/*.dep; do
    PKG_DEPS[${#PKG_DEPS[@]}]=$(basename "${dep}" .dep)
done
