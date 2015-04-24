# mips-assembler
An assembler written in C that parses a subset of the MIPS 32bit ISA assembly language into binary machine code.

This is a work in progress!

Completed:

- Removing superfluous whitespace from source code
- Removing comments from source code
- Parsing all Labels: Calculating addresses and extracting data values
- Printing the Data section in a properly formatted binary form
- Translation of some registers and instructions into binary opcodes


ToDo:
- Translate remaining registers and instructions into opcodes
- Organize a system of data structures and tables to abstractly represent instructions and their properites
- Parse text lines and convert these into organized data structures
- Print the instructions in binary form, with the correct ordering of opcodes, immediates, and label addresses
