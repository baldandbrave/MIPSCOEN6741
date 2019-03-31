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
    -- signal "000": std_logic_vector(2 downto 0) := "000";
    -- signal "001": std_logic_vector(2 downto 0) := "001";
    -- signal "010": std_logic_vector(2 downto 0) := "010";
    -- -- signal "110"NotEqual: std_logic_vector(2 downto 0) := "0011";
    -- signal "110": std_logic_vector(2 downto 0) := "110";
    -- signal "111": std_logic_vector(2 downto 0) := "111";

    begin
        ALUControl_Process : process(Funct, ALU_op)
        begin
            ALUControlFunct <= "010" when (ALU_op="00" or (ALU_op="10" and Funct="000100000")) else
                                "110" when(ALU_op="01" or (ALU_op="10" and Funct="000100010")) else
                                -- "110"NotEqual when(ALU_op="11") else
                                "000" when(ALU_op="11" or (ALU_op="10" and Funct="000100100")) else
                                "001" when(ALU_op="10" and Funct="000100110") else
                                "111" when(ALU_op="10" and Funct="000101010") else
                                "000";
        end process;


end architecture ; -- Behavior