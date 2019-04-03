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

    signal ALUResultSignal : std_logic_vector(31 downto 0) ;

begin

    ALU : process( LeftOperand, RightOperand, ALUControl )
    begin
        case( ALUControl ) is
        
            when "000" => -- and
                ALUResultSignal <= LeftOperand and RightOperand;
            when "001" => -- xor
                ALUResultSignal <= LeftOperand xor RightOperand;
            when "010" => -- add
                ALUResultSignal <= std_logic_vector(unsigned(LeftOperand) + unsigned(RightOperand));
            when "110" => -- sub
                ALUResultSignal <= std_logic_vector(unsigned(LeftOperand) - unsigned(RightOperand));
            when "111" => -- slt, set less than
                -- ALUResultSignal <= std_logic_vector(unsigned(LeftOperand < RightOperand));
                if (signed(LeftOperand) < signed(RightOperand)) then
                    ALUResultSignal <= x"00000001";
                else
                    ALUResultSignal <= x"00000000";
                end if ;
            when others => -- TODO: nop?
                ALUResultSignal <= (others => '0'); -- set all bits to 0
        end case ;
    end process ; -- ALU
    
    -- after process, set output concurrently
    ALUResult <= ALUResultSignal;
    Zero <= '1' when ALUResultSignal = x"00000000"
            else '0';
    
end architecture ; -- Behavior