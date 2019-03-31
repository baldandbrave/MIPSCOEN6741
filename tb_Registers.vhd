-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 31.3.2019 20:20:43 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_Registers is
end tb_Registers;

architecture tb of tb_Registers is

    component Registers
        port (Clock          : in std_logic;
              Reg_write      : in std_logic;
              Read_reg_1     : in std_logic_vector (4 downto 0);
              Read_reg_2     : in std_logic_vector (4 downto 0);
              Write_register : in std_logic_vector (4 downto 0);
              Write_data     : in std_logic_vector (31 downto 0);
              Read_data_1    : out std_logic_vector (31 downto 0);
              Read_data_2    : out std_logic_vector (31 downto 0));
    end component;

    signal Clock          : std_logic;
    signal Reg_write      : std_logic;
    signal Read_reg_1     : std_logic_vector (4 downto 0);
    signal Read_reg_2     : std_logic_vector (4 downto 0);
    signal Write_register : std_logic_vector (4 downto 0);
    signal Write_data     : std_logic_vector (31 downto 0);
    signal Read_data_1    : std_logic_vector (31 downto 0);
    signal Read_data_2    : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Registers
    port map (Clock          => Clock,
              Reg_write      => Reg_write,
              Read_reg_1     => Read_reg_1,
              Read_reg_2     => Read_reg_2,
              Write_register => Write_register,
              Write_data     => Write_data,
              Read_data_1    => Read_data_1,
              Read_data_2    => Read_data_2);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Reg_write <= '0';
        Read_reg_1 <= (others => '0');
        Read_reg_2 <= (others => '0');
        Write_register <= (others => '0');
        Write_data <= (others => '0');

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Registers of tb_Registers is
    for tb
    end for;
end cfg_tb_Registers;