--- Module Instruction Memory: holds the instructions to be execute.
--- address of the instruction will be passed from the program counter
--- of 32 bit. Output will be 32 bit instruction.

-- No info about SUBI: check comment in git

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  


entity InstructionMemory is
port (
 InstructionAddress: in std_logic_vector(31 downto 0);
 InstructionOut: out  std_logic_vector(31 downto 0)
);
end InstructionMemory;
architecture Behavioral of InstructionMemory is
	type RAM_16_x_32 is array(0 to 15) of std_logic_vector(31 downto 0);
	signal IM : RAM_16_x_32 := (
                                x"01285024", -- 0x0040 0000: and 	$t2, 	$t1, 	$t0
                                x"018b6825", -- 0x0040 0004: or 	$t5, 	$t4, 	$t3
                                x"01285020", -- 0x0040 0008: add 	$t2, 	$t1, 	$t0
                                x"01285022", -- 0x0040 0004: sub 	$t5, 	$t1, 	$t0
                                x"03197026", -- xor $t6, $t8, $t9
                                x"8e6e0005", -- andi $t0, $t1, 3
                                x"8d4b0005", -- [lw $t6 5($s3) => I(op:35(lw) rs:19(s3) rt:14(t6) immed:0x00000005)]
                                             -- [ 100011 10011 01110 0000000000000101 ] for lw instruction
                                x"ae4d0005", -- [sw $t5 5($s2) => I(op:43(sw) rs:18(s2) rt:13(t5) immed:0x00000005)]

                                x"1211fffb", -- 0x0040 0014: branchequal 	$s0, 	$s1
                                x"08100000", -- 0x0040 002C: j 0x00400000 => 0000 1000 0001 0000 0000 0000 0000 (jump to address 0x00400000 (begining))
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000",
                                x"00000000"
                                );
begin
	
	-- Reset Address: 003FFFFC 
	InstructionOut <= x"00000000" when InstructionAddress = x"003FFFFC" else 
		IM(( to_integer(unsigned(InstructionAddress)) - 4194304) /4);
end Behavioral;