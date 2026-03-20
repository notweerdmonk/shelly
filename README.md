# shelly

###### Shellcode extraction utility

---

## Overview

The `bash` script can extract shellcode from object or ELF files or standard
input. Optionally it can create a new file and write assembly instructions from
standard input to the file, then assemble them.

---

## Dependencies

- `bash` *duh*
- `as`
- `ld
- `objdump`

---

## Command line options

These options can be passed to the script after the target file path.

```console
  -a, --array           output as a C array named "shellcode"
  -w, --write           write to file "shellcode" or "shellcode.c"
  -q, --quite           do not print to stdout, implies write to file
  -i, --input           write assembly instructions to a file
  -s, --assemble        assemble instructions from a file
  -h, --help            show this message
```

## Example usage

Write assembly instructions to a file.

```console
bash-5.1$ ./shelly file -i
(*) Enter contents of file.S (CTRL-D to end)
        .global _start
_start:
        movl $0xcafe, %eax
        push %rdi
(*) Written file.S
```

Write assembly instructions to a file and assemble them.

```console
bash-5.1$ ./shelly file -i -s
(*) Enter contents of file.S (CTRL-D to end)
        .global _start
_start:
        movl $0xcafe, %eax
        push %rdi
(*) Written file.S
(*) Assembling file.S...
(*) Written file.o
(*) Linking file.o...
(*) Written file
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Attempt to assemble incorrect instructions shall fail and the assembler output
shall be printed to terminal.

```console
bash-5.1$ ./shelly file -i -s
(*) Enter contents of file.S (CTRL-D to end)
rubbish
(*) Written file.S
(*) Assembling file.S...
(x) Assembly failed
(x) file.S: Assembler messages:
(x) file.S:1: Error: no such instruction: `rubbish'
```

Write assembly instructions to a file and assemble them. Redirect `stderr` to
bit bucker to avoid printing logs in terminal.

```console
bash-5.1$ ./shelly file -i -s 2>/dev/null
        .global _start
_start:
        movl $0xcafe, %eax
        push %rdi
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Attempt to extract shellcode from a file that is not an object or ELF file shall
fail.

```console
bash-5.1$ ./shelly file.S
(!) File file.S not ELF
```

Extract shellcode from standard input.

```console
bash-5.1$ ./shelly < file
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Extract shellcode from piped input.

```console
bash-5.1$ cat file | ./shelly
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Extract shellcode from an object file.

```console
bash-5.1$ ./shelly file.o
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Extract shellcode from an ELF file.

```console
bash-5.1$ ./shelly file
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Extract shellcode from an ELF file as a C array.

```console
bash-5.1$ ./shelly file -a
unsigned char shellcode[] = {
    0xb8, 0xfe, 0xca, 0x00, 0x00, 0x57
};
```

Extract shellcode from an ELF file but do not print to terminal. Quite operation
implies shellode is written to a file on disk.

```console
bash-5.1$ ./shelly file -q
Shellcode extracted to shellcode

bash-5.1$ cat shellcode
0xb8,0xfe,0xca,0x00,0x00,0x57
```

Extract shellcode from an ELF file and write them to a file on disk.

```console
bash-5.1$ ./shelly file -a -w
Shellcode extracted to shellcode.c

unsigned char shellcode[] = {
    0xb8, 0xfe, 0xca, 0x00, 0x00, 0x57
};
bash-5.1$ cat shellcode.c
unsigned char shellcode[] = {
    0xb8, 0xfe, 0xca, 0x00, 0x00, 0x57
};
```

---

## License

Please! Just... Don't!

---

## Contributing

If you know git and bash who is stopping you!

---

## Note

Run the script after making sure the dependencies are installed and available in
system path. What is even the point otherwise?!

```console
%%%%%%%%%%%%%%%%%#######%%%%#**#%%###*++*****++++*****++*###*###****##*++++
%%%%%%%%%%%%%%%%%%####%%%%%%#+**#####++***#*************#####**###**#%#*++*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%#*#*####***###************#######**#********##%
##%%%%%%%%%%%%%%%%%%%%%%%%####**#*#*++###****##*******##%##***##****##%%%%%
***#%%%%%%%%%%%%%%%%%%%%%##*##****#*++*##*****#*#*******%##**#*#*##*#%%%%%%
#*++**#%%%%%%%%%%%%%%%##**#**#+*+***=++##*++*##*#*******##**##***#**#%%%%%%
%#*+==+**##%%%%%%%######++****++=***+++##*+=*##****##**###*###**#******#***
%%#*+====++**#######**##*++***+==+#**+**##+=*#*++**##########**##**#*******
%%%#**+==----=+**##***##*==***+==+#***#*##*+*#*+**##*##*####***#*****##*###
%%%%##***+===+**#*****###++****=-+****++*#*+*#***#####*####*##**#****##*###
%%%%##**********#**++*###*****+=-+***++=+**+*#**########*##****************
%%%%%####******#***+=+*##**+**+==++**++=++==**##****#####*##*********++++++
%%%%%##%#**+******#*+=*#**+++++===+++++++=-+++++++=++*****###********++++++
%%%%%%%%##***#*+++**+=+*++==++==+=+++****+-:-:..   :---===*##*********++++*
%%%%%%%%%##****+++*#+=-=====++=++==++**##=.       .-=---=-=*#*********+++**
%%%%%%%%%%####*+*+*#*=--=+++++=+==++*#*##=  .     .+#***+==+##*********+***
%%%%%%%%%%##****#****+=-=+*+=++==+++*#*#%*  .    .:*%#*+**++*##************
%%%%%%%%%##***###***++---+##++++++++*####*. ..   .=##+=++*+=+%##******+****
%%%%%%%%####**##**++-:. .:#%++*++=+****#**-.....:+*+=+++***++########***#*#
%%%%%%%%%%#**##**=:.      #%#+**+==*****++*#*=-+**++++++*#*++#%%####**+*#*#
%%%%%%%%%##****+-  ..     #%#**#+==******=++####*+++++**#**==*%%%%###*+*#*#
%%%%%%%%%#***+-::  :.     *#*****++***+==+*++*#*+*****#****++*%%%%###*+*###
%%%%%%%%%#*+-:-==. ..   ..=*+*+**+***++=*++*****#***#**#*##*++#%%%###*+*##%
%%%%%%%%%*=--=*##=......-=-=++=*++***++++**#*****##****###**++*%%%###**###%
%%%%%%%%%*=-=+##**+-:.:=**=-==+++*****+*+#*###############***+*%%%###*+*##%
###%%%%%%*-:=++++++*###%#*=-===+***##***+*##########%%#**#####*%%%###*+####
****####%*--====*++++****+====+*##*##***+#%%#***%%%%%%####*###*%%%###**####
#########*==++++++++++***+++*++**#**++=++*##*#%%#%%%%%%#+==+**+%%%###***###
#########*==++++++++++**++*##*++++++++-=*#%%%%#####%%%%%*+=+*+*%%%###***###
######%%#*=++*************####+=+=+==-.-#%%%##*+#%%%%%%%#*++++*%%%###**##%%
%####*###*==++**********##*#%%*+:.--:-:*%%##*#%%%%##%%%%##*****%%%###**##%%
###*+-=*#*====+++++****#**+*#%%#+-:-:==#%%%###%%####%%%%#******%%%*+#**###%
%##+:.-*#*=++++****#########%%%%%*--:-+#%%%%%%####%%%%%%#******#%#+-***##%%
###+::+##*+****#***##%%######%%%%#*=:-+#%%%#####%%%##%%#####***###+:=*#%#%%
%#**++*##*****++++*#%%###**+*#%%%%#*=+*##############%%#*=+++*%*#*-:=*#%%%%
###*+-=+##****=-=+#%%#########%%%%%*++*****#####***##%%#**+=+*#%%%+**++#%%%
%##*+--=###**+=-=+#%%%%%#%%%%%%####*+++****###****#####*+=+**#%%%%**#**#%##
###*=--+#%#*++=--+#%%############***+==+++***++***#####*#=-+*##*+==+*+*%%%#
%#**+===###*+=--+*####**#########**+=-===++++==+**###***=******%+--*#+*%%%%
*##*+=++##%#+--=++*#############**++++******++=+**##***+**#*++*##=-=+=*%%%%
%%%%%%%%%%%%*==+=+*#######***#**+++**########***###*+++++*###++##%#=..+%%%%
%%%%%%%%%%%%%*+++*++#%###*****++=+########%%%#####***+=**##*+**#*%#*-:+%%%%
%%%%%%%%%%%%%#**+==+*##******++=+*#############%%*++**+*##*++**#####+-+#%%%
%%%%########***+==++++*#*****+++*################*==+*#***++****##*#*+*#%%%
####**#########*++===++********#################*+++*##*=+++#*##******#%%%%
*#########%%%%%##+=+==+=++****####**###**##*****++*####++*#*#*+++****#%%%%%
###########%%%%%##*+===++++****###**##***#*****+++#%#**++****++++**#####%%%
#######%%%%%%%%%%%*=+*++*++**********#******+++++*##+=++**+++++****###*****
```

