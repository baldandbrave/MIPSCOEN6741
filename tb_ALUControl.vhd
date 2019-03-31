-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 31.3.2019 22:11:17 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_ALUControl is
end tb_ALUControl;

architecture tb of tb_ALUControl is

    component ALUControl
        port (Funct           : in std_logic_vector (8 downto 0);
              ALU_op          : in std_logic_vector (1 downto 0);
              ALUControlFunct : out std_logic_vector (2 downto 0));
    end component;

    signal Funct           : std_logic_vector (8 downto 0);
    signal ALU_op          : std_logic_vector (1 downto 0);
    signal ALUControlFunct : std_logic_vector (2 downto 0);

begin

    dut : ALUControl
    port map (Funct           => Funct,
              ALU_op          => ALU_op,
              ALUControlFunct => ALUControlFunct);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Funct <= (others => '0');
        ALU_op <= (others => '0');

        -- EDIT Add stimuli here
        ALU_op <= "00";
        wait for 10 ns;
        -- ALUControlFunct <= "010 
        
        ALU_op <= "10";  
        Funct <= "000100000";
        wait for 10 ns;
        -- ALUControlFunct <= "010

        ALU_op <= "01";
        wait for 10 ns;
        -- ALUControlFunct <= "110

        ALU_op <= "10";  
        Funct <= "000100010";
        wait for 10 ns;
        -- ALUControlFunct <= "110

        ALU_op <= "11";
        wait for 10 ns;
        -- ALUControlFunct <= "000

        ALU_op <= "10";  
        Funct <= "000100100";
        wait for 10 ns;
        -- ALUControlFunct <= "001"

        ALU_op <= "10";  
        Funct <= "000101010";
        wait for 10 ns;
        -- ALUControlFunct <= "111"

        ALU_op <= "10";  
        Funct <= "111111010";
        wait for 10 ns;
        -- ALUControlFunct <= "000"
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ALUControl of tb_ALUControl is
    for tb
    end for;
end cfg_tb_ALUControl;
