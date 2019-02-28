-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 28.2.2019 21:02:38 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_PC is
end tb_PC;

architecture tb of tb_PC is

    component PC
        port (Clock           : in std_logic;
              PrevInstAddress : in std_logic_vector (31 downto 0);
              NextInstAddress : out std_logic_vector (31 downto 0));
    end component;

    signal Clock           : std_logic;
    signal PrevInstAddress : std_logic_vector (31 downto 0);
    signal NextInstAddress : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PC
    port map (Clock           => Clock,
              PrevInstAddress => PrevInstAddress,
              NextInstAddress => NextInstAddress);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        PrevInstAddress <= (others => '0');

        -- EDIT Add stimuli here
        PCForLoop : for i in 0 to 10 loop
            PrevInstAddress <= std_logic_vector(to_unsigned(i, 32)) ;
            wait for TbPeriod;
        end loop ; -- PCForLoop

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PC of tb_PC is
    for tb
    end for;
end cfg_tb_PC;