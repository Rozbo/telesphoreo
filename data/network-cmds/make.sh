shopt -s extglob
tar -zxvf "${PKG_DATA}/network_cmds-306.tar.gz"
cd network_cmds-306
for tproj in !(natd|ping|spray).tproj; do
    tproj=$(basename "${tproj}" .tproj)
    arm-apple-darwin-gcc -o "${tproj}" "${tproj}.tproj"/*.c -DPRIVATE -Dether_ntohost=_old_ether_ntohost
    pkg:usrbin "${tproj}"
done
arm-apple-darwin-gcc -Ialias -o natd natd.tproj/*.c alias/*.c -DPRIVATE
pkg:usrbin natd
