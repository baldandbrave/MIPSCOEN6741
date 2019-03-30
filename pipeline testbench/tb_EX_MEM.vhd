-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 30.3.2019 01:42:45 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_EX_MEM is
end tb_EX_MEM;

architecture tb of tb_EX_MEM is

    component EX_MEM
        port (Clock        : in std_logic;
              Reset        : in std_logic;
              ALUResultIn  : in std_logic_vector (31 downto 0);
              MemWriteIn   : in std_logic;
              MemRead      : in std_logic;
              MemWrite     : in std_logic;
              MemToReg     : in std_logic;
              RegDst       : in std_logic;
              ALUResultOut : out std_logic_vector (31 downto 0);
              MemWriteOut  : out std_logic;
              MemReadOut   : out std_logic;
              MemWriteOut  : out std_logic;
              MemToRegOut  : out std_logic;
              RegDstOut    : out std_logic);
    end component;

    signal Clock        : std_logic;
    signal Reset        : std_logic;
    signal ALUResultIn  : std_logic_vector (31 downto 0);
    signal MemWriteIn   : std_logic;
    signal MemRead      : std_logic;
    signal MemWrite     : std_logic;
    signal MemToReg     : std_logic;
    signal RegDst       : std_logic;
    signal ALUResultOut : std_logic_vector (31 downto 0);
    signal MemWriteOut  : std_logic;
    signal MemReadOut   : std_logic;
    signal MemWriteOut  : std_logic;
    signal MemToRegOut  : std_logic;
    signal RegDstOut    : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : EX_MEM
    port map (Clock        => Clock,
              Reset        => Reset,
              ALUResultIn  => ALUResultIn,
              MemWriteIn   => MemWriteIn,
              MemRead      => MemRead,
              MemWrite     => MemWrite,
              MemToReg     => MemToReg,
              RegDst       => RegDst,
              ALUResultOut => ALUResultOut,
              MemWriteOut  => MemWriteOut,
              MemReadOut   => MemReadOut,
              MemWriteOut  => MemWriteOut,
              MemToRegOut  => MemToRegOut,
              RegDstOut    => RegDstOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ALUResultIn <= (others => '0');
        MemWriteIn <= '0';
        MemRead <= '0';
        MemWrite <= '0';
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

configuration cfg_tb_EX_MEM of tb_EX_MEM is
    for tb
    end for;
end cfg_tb_EX_MEM;