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
                                "00000000000000000000000000000000",
                                "00001001010000101000000000100000", -- 1 add 	$t2, 	$t1, 	$t0
                                "00001100010110000001101000100101", -- 2 or 	$t5, 	$t4, 	$t3
                                "00001001010000110100000000100010", -- 3sub
                                "00001001010000101000000000100100", -- 4 and $t2 $t1 $t0
                                "00011000110010111000000000100110", -- 5 xor $t6 $t8 $t9
                                "00101001010000000000000000000011", -- 6 andi 
                                "01001001011010000000000000001011", -- 7 subi --> addi $t5 $t1 -5
                                "01101010011011111111111111110011", -- 8 beq
                                "10010011011100000000000000000101", -- 9 lw $t6 5($s3)
                                "10110010011010000000000000000101", -- 10 sw $t5 5($s2)  
                                "10101011100110000000000000001100", -- 11 lw $s3 12($t3)
                                "01001101010011111111111111110101", -- 12 subi $t1 $t5 -11
                                "00101101010010000000000000000001", -- 14 andi $t1 $t5 1
                                "00001101010100101100000000100101", -- 15 or $t3 $t5 $t2
                                "00001110000000000000000000001000"  -- 16 jr $t6                                
                                );
begin
process (InstructionAddress)
	begin

		case InstructionAddress is
			when "00000000000000000000000000000000" => 
                InstructionOut <= IM(0);
			when "00000000000000000000000000000100" => 
                InstructionOut <= IM(1);
			when "00000000000000000000000000001000" => 
                InstructionOut <= IM(2);
			when "00000000000000000000000000001100" => 
                InstructionOut <= IM(3);
			when "00000000000000000000000000010000" => 
                InstructionOut <= IM(4);
			when "00000000000000000000000000010100" => 
                InstructionOut <= IM(5);
			when "00000000000000000000000000011000" => 
                InstructionOut <= IM(6);
			when "00000000000000000000000000011100" => 
                InstructionOut <= IM(7);
			when "00000000000000000000000000100000" => 
                InstructionOut <= IM(8);
			when "00000000000000000000000000100100" => 
                InstructionOut <= IM(9);
			when "00000000000000000000000000101000" => 
                InstructionOut <= IM(10);
			when "00000000000000000000000000101100" => 
                InstructionOut <= IM(11);
			when "00000000000000000000000000110000" => 
                InstructionOut <= IM(12);
			when "00000000000000000000000000110100" => 
                InstructionOut <= IM(13);
			when "00000000000000000000000000111000" => 
                InstructionOut <= IM(14);
			when "00000000000000000000000000111100" => 
                InstructionOut <= IM(15);
			when others => 
		InstructionOut <= x"00000000";
		end case;

	end process;

	
--end InstructionMemory;
	
end architecture ;