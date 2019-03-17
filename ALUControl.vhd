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
------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl is
  port (
    Funct: in std_logic_vector(5 down to 0);
    ALU_op: in std_logic_vector(1 down to 0);
    ALUControlFunct: out std_logic_vector(2 downto 0)
  ) ;
end ALUControl ;

architecture Behavior of ALUControl is
    signal And_op: std_logic_vector(2 downto 0) := "000";
    signal Or_op: std_logic_vector(2 downto 0) := "001";
    signal Add: std_logic_vector(2 downto 0) := "010";
    -- signal SubstractNotEqual: std_logic_vector(2 downto 0) := "0011";
    signal Substract: std_logic_vector(2 downto 0) := "110";
    signal SetOnLessThan: std_logic_vector(2 downto 0) := "111";

    begin
        ALUControl_Process : process(Funct, ALU_op)
        begin
            ALUControlFunct <= Add when (ALU_op="00" or (ALU_op="10" and Funct="100000")) else
                                Substract when(ALU_op="01" or (ALU_op="10" and Funct="100010")) else
                                -- SubstractNotEqual when(ALU_op="11") else
                                And_op when(ALU_op="10" and Funct="100100") else
                                Or_op when(ALU_op="10" and Funct="100101") else
                                SetOnLessThan when(ALU_op="10" and Funct="101010") else
                                "0000";
        end process;


end architecture ; -- Behavior