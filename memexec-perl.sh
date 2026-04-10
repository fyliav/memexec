#! /bin/bash

# printf SYS_memfd_create | gcc -include sys/syscall.h -E -
#  319 - x86_64
#  279 - aarch64
#  385 - armv6l
# 4314 - mipsel n64
# 4354 - mipsel o32
# $^F=255; will disable perl's default O_CLOEXEC.
memexec(){ LANG="${LANG:-C}" exec perl '-e$^F=255;for(319,279,385,4314,4354){($f=syscall$_,$",16)>0&&last};open($o,">&=".$f);print$o(<STDIN>);exec{"/proc/$$/fd/$f"}"'"${NAME:-/usr/bin/python3}"'",@ARGV;exit 255' -- "$@";}
# Example: cat /usr/bin/id | memexec -u

