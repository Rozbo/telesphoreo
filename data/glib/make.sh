pkg:setup
autoconf
pkg:configure glib_cv_stack_grows=no glib_cv_uscore=yes ac_cv_func_posix_getpwuid_r=yes --with-libiconv=native
make
pkg:install
