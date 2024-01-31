from numpy import binary_repr
import argparse
from grun import run

parser = argparse.ArgumentParser()

parser.add_argument('input', help='File .asm with the assembly code')
parser.add_argument('-o', '--output', help='File to write binary code', type=str)
parser.add_argument('-r', '--run', help="Modify ROM file with the new binary code and run grun.py", type=str)
parser.add_argument('-v', '--verbose', help="Print generated code", action='store_true')
parser.add_argument('-d', '--duration', help="Duration of simulated code, default=100000ns", type=int)

args = parser.parse_args()

def register_map(register):
    return {
        "R0": "000",
        "R1": "001",
        "R2": "010",
        "R3": "011",
        "R4": "100",
        "R5": "101",
        "R6": "110",
        "R7": "111",
    }[register]

def generate_binary(command):
    translate = {
        "ADD": lambda: "0001"
        + register_map(command.split()[1])
        + register_map(command.split()[2])
        + "0000",

        "ADDI": lambda: "0010"
        + register_map(command.split()[1])
        + str(binary_repr(int(command.split()[2]), width=7)),

        "SUB": lambda: "0011"
        + register_map(command.split()[1])
        + register_map(command.split()[2])
        + "0000",

        "MOV": lambda: "0100"
        + register_map(command.split()[1])
        + register_map(command.split()[2])
        + "0000",

        "JMP": lambda: "0101"
        + str(binary_repr(int(command.split()[1]), width=7))
        + "0000",

        "CMP": lambda: "0110"
        + register_map(command.split()[1])
        + register_map(command.split()[2])
        + "0000",
        
        "BLT": lambda: "0111"
        + str(binary_repr(int(command.split()[1]), width=7))
        + "000",

        "LD.W": lambda: "1000"
        + register_map(command.split()[1])
        + register_map(command.split()[2])
        + "0000",

        "ST.W": lambda: "1001"
        + register_map(command.split()[2])
        + register_map(command.split()[1])
        + "0000",
    }
    return str(translate[command.split()[0]]() + '",')

with open(args.input, "r") as code:
    rom_code = []
    for index, command in enumerate(code.read().splitlines()):
        rom_code.append('-- ' + command) # Assembly reference comment in VHDL
        rom_code.append(str(index) + ' => "' + generate_binary(command))
    rom_code.append("others => (others=>'0')")

if args.verbose:
    for line in rom_code:
        print(line)

if args.output:
    with open(args.output, "w") as output:
        for line in rom_code:
            output.write(line + '\n')

if args.run:
    with open(args.run, "r") as rom:
        rom = rom.readlines()
    with open(args.run, "w") as output:
        write = True
        for line in rom:
            if line.strip() == "--=END_AUTOMATION":
                write = True
            if write == True:
                output.write(line)
                if line.strip() == "--=BEGIN_AUTOMATION":
                    write = False
                    output.write('\n')
                    for line in rom_code:
                        output.write('\t\t' + line + '\n')
                    output.write('\n')

    if args.duration:
        run(args.duration)
    else:
        run()

