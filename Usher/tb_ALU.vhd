-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 28.2.2019 21:35:56 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_ALU is
end tb_ALU;

architecture tb of tb_ALU is

    component ALU
        port (LeftOperand  : in std_logic_vector (31 downto 0);
              RightOperand : in std_logic_vector (31                                                                                                                                                                                                                                                                              downto 0);
              ALUControl   : in std_logic_vector (2 downto 0);
              ALUResult    : out std_logic_vector (31 downto 0);
              Zero         : out std_logic);
    end component;

    signal LeftOperand  : std_logic_vector (31 downto 0);
    signal RightOperand : std_logic_vector (31                                                                                                                                                                                                                                                                              downto 0);
    signal ALUControl   : std_logic_vector (2 downto 0);
    signal ALUResult    : std_logic_vector (31 downto 0);
    signal Zero         : std_logic;

begin

    dut : ALU
    port map (LeftOperand  => LeftOperand,
              RightOperand => RightOperand,
              ALUControl   => ALUControl,
              ALUResult    => ALUResult,
              Zero         => Zero);

    stimuli : process
    begin
        -- init with 1 and 16
        LeftOperand <= x"00000001";
        RightOperand <= x"00000010";
        -- test every op
        ALUControl <= "000";
        wait for 10 ns;
        ALUControl <= "001";
        wait for 10 ns;
        ALUControl <= "010";
        wait for 10 ns;
        ALUControl <= "110";
        wait for 10 ns;
        ALUControl <= "111";
        wait for 10 ns;
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ALU of tb_ALU is
    for tb
    end for;
end cfg_tb_ALU;