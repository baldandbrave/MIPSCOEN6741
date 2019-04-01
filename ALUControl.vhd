------------------------------------------------------
-- ALU Control component
-- 
-- Used for deciding which operation the alu shoud perform.
--
-- and: 0000
-- or: 0001
-- add: 0010
-- subtract-not-equal: 0011 # For bne. Not sure if these are the right alu_control bits, but this one was available.
-- subtract: 0110
-- set-on-less-than: 0111
-------------------------
-- Instruction format: 8-0 funct, 9 bits,  add 0 ext, ALUOp=11 => and
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl is
  port (
    Funct: in std_logic_vector(8 downto 0);
    ALU_op: in std_logic_vector(1 downto 0);
    ALUControlFunct: out std_logic_vector(2 downto 0)
  ) ;
end ALUControl ;

architecture Behavior of ALUControl is

    begin
        ALUControl_Process : process(Funct, ALU_op)
        begin
            -- add
            if (ALU_op="00" or (ALU_op = "10" and Funct = "000100000")) then
                 ALUControlFunct <= "010";
	    
            -- sub
            elsif (ALU_op="01" or (ALU_op = "10" and Funct = "000100010")) then
                 ALUControlFunct <= "110";
	    
            -- and
            elsif (ALU_op="11" or (ALU_op = "10" and Funct = "000100100")) then
                 ALUControlFunct <= "000";
	    
            -- xor
            elsif (ALU_op="10" and Funct="000100110") then
                 ALUControlFunct <= "001";

            -- slt, set less than
            elsif (ALU_op="10" and Funct="000101010") then
                 ALUControlFunct <= "111";

            else
                 ALUControlFunct <= "000";
	    end if;
	
        end process;


end architecture ; -- Behavior
