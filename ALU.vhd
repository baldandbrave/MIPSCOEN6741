-- http://personal.denison.edu/~bressoud/cs281-s08/homework/MIPSALU.html
-- Reference of mapping of ALU function and ALUControl input
-- Only implement Zero Flag defined in the datapath.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port (
    LeftOperand  : in std_logic_vector(31 downto 0);
    RightOperand : in std_logic_vector(31 downto 0);
    ALUControl   : in std_logic_vector(2 downto 0);
    ALUResult    : out std_logic_vector(31 downto 0) ;
    Zero: out std_logic
  ) ;
end ALU ;

architecture Behavior of ALU is

    -- signal ALUResult : std_logic_vector(31 downto 0) ;

begin

    ALU : process( ALUControl, LeftOperand, RightOperand )
    begin
        case( ALUControl ) is
        
            when "000" => -- and
                ALUResult <= LeftOperand and RightOperand;
            when "001" => -- xor
                ALUResult <= LeftOperand xor RightOperand;
            when "010" => -- add
                ALUResult <= std_logic_vector(unsigned(LeftOperand) + unsigned(RightOperand));
            when "110" => -- sub
                ALUResult <= std_logic_vector(unsigned(LeftOperand) - unsigned(RightOperand));
            when "111" => -- slt, set less than
                -- ALUResult <= std_logic_vector(unsigned(LeftOperand < RightOperand));
                if (signed(LeftOperand) < signed(RightOperand)) then
                    ALUResult <= x"00000001";
                else
                    ALUResult <= x"00000000";
                end if ;
            when others => -- TODO: nop?
                ALUResult <= (others => '0'); -- set all bits to 0
        end case ;
    end process ; -- ALU
    
    -- after process, set output concurrently
    -- ALUResult <= ALUResult;
    -- Zero <= '1' when ALUResult = x"00000000"
    --         else '0';
    
end architecture ; -- Behavior