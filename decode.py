import sys

if __name__ == '__main__':
    file_input = open("RISC_input.txt", 'r')
    file_output = open("RISC_MC.txt", 'w+')
    commands = file_input.readlines()

    command_list = [
        "LDW", "STW", "MOV", "HLT", "RST", "INT", "IN", "OUT", "CH",
        "RET", "ADD", "SUB", "MUL", "DIV", "MVN", "OR", "AND", "ORN", "ANDN",
        "EOR", "EON", "LSL", "LSR", "ASR", "REV", "J", "JZ", "JNZ", "JC",
        "JNC", "JO", "JNO", "JP", "JNP", "JG", "JL", "JNG", "JNL", "CMP",
        "MOD", "PUSH", "POP"
    ]

    regs_list = ["R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7"]
    getbinary = lambda x, n: format(x, 'b').zfill(n)

    jump_instructions = {
        "J": 25, "JZ": 26, "JNZ": 27, "JC": 28,
        "JNC": 29, "JO": 30, "JNO": 31, "JP": 32,
        "JNP": 33, "JG": 34, "JL": 35, "JNG": 36, "JNL": 37
    }

    for command in commands:
        if not command.strip():
            continue

        words = command.split(" ")
        cmd_upper = words[0].strip()

        if cmd_upper == 'IN':
            print("INPUT NOT WORKING D:\nPLEASE USE MOV INSTEAD.")
            sys.exit(1)

        if cmd_upper == 'HLT':
            file_output.write('0000110000000000\n')
            break

        elif cmd_upper in jump_instructions:
            command_number = jump_instructions[cmd_upper]
            file_output.write(getbinary(command_number, 6))
            file_output.write('1')
            if len(words) > 2:
                command_number = int(words[2])
                file_output.write(getbinary(command_number, 9) + '\n')
            else:
                print(f"JUMP MISSING ARG: {command}")
                sys.exit(1)

        else:
            if cmd_upper in command_list:
                command_number = command_list.index(cmd_upper)
                file_output.write(getbinary(command_number, 6))
            else:
                print("OPERATION UNKNOWN: " + str(cmd_upper))
                sys.exit(1)

            if len(words) <= 1:
                print("SYNTAX ERROR: MISSING PREFIX")
                sys.exit(1)

            prefix = words[1].strip()

            if prefix == 'r':
                file_output.write('0')
                if cmd_upper in ["PUSH", "POP"]:
                    if len(words) > 2 and words[2].strip() in regs_list:
                        reg = regs_list.index(words[2].strip())
                        file_output.write(getbinary(reg, 3))
                        file_output.write('000000\n')
                    else:
                        print(f"{cmd_upper} MISSING REGISTER")
                        sys.exit(1)
                else:
                    if len(words) > 3 and words[2].strip() in regs_list and words[3].strip() in regs_list:
                        r1 = regs_list.index(words[2].strip())
                        r2 = regs_list.index(words[3].strip())
                        file_output.write(getbinary(r1, 3))
                        file_output.write(getbinary(r2, 3))
                        file_output.write('000\n')
                    else:
                        print("REGS UNKNOWN OR MISSING: ---" + str(words[2]) + "------" + str(words[3].strip()) + "---")
                        sys.exit(1)

            elif prefix == 'i':
                file_output.write('1')
                if words[2].strip() in regs_list:
                    reg = regs_list.index(words[2].strip())
                    file_output.write(getbinary(reg, 3))
                    val_str = words[3].strip().strip("#")
                    imm = int(val_str, 16) if "0x" in val_str else int(val_str)
                    file_output.write(getbinary(imm, 6) + '\n')
                else:
                    print("IMM REG UNKNOWN: " + str(words[2]))
                    sys.exit(1)

            else:
                print("PREFIX UNKNOWN: " + str(words[1]))
                sys.exit(1)

    file_input.close()
    file_output.close()
    sys.exit(0)
