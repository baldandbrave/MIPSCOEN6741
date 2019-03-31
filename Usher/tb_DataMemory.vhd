-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 28.2.2019 19:42:34 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_DataMemory is
end tb_DataMemory;

architecture tb of tb_DataMemory is

    component DataMemory
        port (MemRead   : in std_logic;
              MemWrite  : in std_logic;
              Address   : in std_logic_vector (31 downto 0);
              WriteData : in std_logic_vector (31 downto 0);
              ReadData  : out std_logic_vector (31 downto 0));
    end component;

    signal MemRead   : std_logic;
    signal MemWrite  : std_logic;
    signal Address   : std_logic_vector (31 downto 0);
    signal WriteData : std_logic_vector (31 downto 0);
    signal ReadData  : std_logic_vector (31 downto 0);

begin

    dut : DataMemory
    port map (MemRead   => MemRead,
              MemWrite  => MemWrite,
              Address   => Address,
              WriteData => WriteData,
              ReadData  => ReadData);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        
        -- EDIT Add stimuli here
        MemRead <= '0';
        MemWrite <= '1';
        -- Address <= std_logic_vector(to_unsigned(16, 32)) OR std_logic_vector(to_unsigned(I * 4, 32));
        Address <= std_logic_vector(to_unsigned(20, 32)) ;
        WriteData <= x"00001984";
        WAIT FOR 25 ns;
        MemRead <= '1';
        MemWrite <= '0';
        -- Address <= std_logic_vector(to_unsigned(16, 32)) OR std_logic_vector(to_unsigned(I * 4, 32));
        Address <= std_logic_vector(to_unsigned(20, 32)) ;
        WAIT FOR 25 ns;
        ASSERT false
        REPORT "END"
        SEVERITY failure;
        wait for 10 ns;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_DataMemory of tb_DataMemory is
    for tb
    end for;
end cfg_tb_DataMemory;