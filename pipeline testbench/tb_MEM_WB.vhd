-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 30.3.2019 01:44:04 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_MEM_WB is
end tb_MEM_WB;

architecture tb of tb_MEM_WB is

    component MEM_WB
        port (Clock        : in std_logic;
              Reset        : in std_logic;
              ReadDataIn   : in std_logic_vector (31 downto 0);
              ALUResultIn  : in std_logic_vector (31 downto 0);
              MemToReg     : in std_logic;
              RegDst       : in std_logic;
              ReadDataOut  : out std_logic_vector (31 downto 0);
              ALUResultOut : out std_logic_vector (31 downto 0);
              MemToRegOut  : out std_logic;
              RegDstOut    : out std_logic);
    end component;

    signal Clock        : std_logic;
    signal Reset        : std_logic;
    signal ReadDataIn   : std_logic_vector (31 downto 0);
    signal ALUResultIn  : std_logic_vector (31 downto 0);
    signal MemToReg     : std_logic;
    signal RegDst       : std_logic;
    signal ReadDataOut  : std_logic_vector (31 downto 0);
    signal ALUResultOut : std_logic_vector (31 downto 0);
    signal MemToRegOut  : std_logic;
    signal RegDstOut    : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : MEM_WB
    port map (Clock        => Clock,
              Reset        => Reset,
              ReadDataIn   => ReadDataIn,
              ALUResultIn  => ALUResultIn,
              MemToReg     => MemToReg,
              RegDst       => RegDst,
              ReadDataOut  => ReadDataOut,
              ALUResultOut => ALUResultOut,
              MemToRegOut  => MemToRegOut,
              RegDstOut    => RegDstOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ReadDataIn <= (others => '0');
        ALUResultIn <= (others => '0');
        MemToReg <= '0';
        RegDst <= '0';

        -- Reset generation
        -- EDIT: Check that Reset is really your reset signal
        Reset <= '1';
        wait for 100 ns;
        Reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_MEM_WB of tb_MEM_WB is
    for tb
    end for;
end cfg_tb_MEM_WB;