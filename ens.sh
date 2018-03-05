./dasm space_raid_0.asm -DNTSC=1 -DCOLOR_NTSC=1 -f3 -lspace_raid_0.lst -ospace_raid_0.bin
./dasm space_raid_1.asm -DNTSC=1 -DCOLOR_NTSC=1 -f3 -lspace_raid_1.lst -ospace_raid_1.bin
cat space_raid_0.bin space_raid_1.bin >space_raid_8k.bin
rm space_raid_0.bin
rm space_raid_1.bin
./dasm space_raid.asm -DNTSC=1 -DCOLOR_NTSC=1 -f3 -lspace_raid.lst -ospace_raid_4k.bin
