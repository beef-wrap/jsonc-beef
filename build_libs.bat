clang -c -g -gcodeview -o jsonc-windows.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall jsonc\jsonc.c

mkdir libs
move jsonc-windows.lib libs
