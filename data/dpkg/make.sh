pkg:setup
autoconf
cp -a libcompat/obstack.[ch] lib
pkg:configure --with-admindir=/var/lib/dpkg --without-start-stop-daemon --disable-nls --sysconfdir=/etc --disable-linker-optimisations dpkg_cv_va_copy=yes
pkg:make
pkg:install
pkg: rm -rf /usr/share/perl5
pkg: grep -Erl '#! ?/usr/bin/perl' / | while read -r line; do
    rm -f "${line}"
done
pkg: rm -rf /{usr,var}/lib/dpkg/methods
pkg: rm -rf /usr/lib/dpkg/parsechangelog
