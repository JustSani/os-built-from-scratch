echo "size ---------------------------------"
touch src/main.c
make size

echo "size2 ---------------------------------"
touch boot/startup.c
make size

echo "size3 ---------------------------------"
touch scripts/mps2_m3.ld
make size


echo "disasm -------------------------------"
touch src/main.c
make disasm


echo "disasm2 -------------------------------"
touch boot/startup.c
make disasm

echo "disasm3 -------------------------------"
touch scripts/mps2_m3.ld
make disasm
