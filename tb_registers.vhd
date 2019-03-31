-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 31.3.2019 18:56:10 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_registers is
end tb_registers;

architecture tb of tb_registers is

    component registers
        port (Clock       : in std_logic;
              reg_write   : in std_logic;
              read_reg_1  : in std_logic_vector (4 downto 0);
              read_reg_2  : in std_logic_vector (4 downto 0);
              write_reg   : in std_logic_vector (4 downto 0);
              write_data  : in std_logic_vector (31 downto 0);
              read_data_1 : out std_logic_vector (31 downto 0);
              read_data_2 : out std_logic_vector (31 downto 0);
              R0          : out std_logic_vector (31 downto 0);
              R1          : out std_logic_vector (31 downto 0);
              R2          : out std_logic_vector (31 downto 0);
              R3          : out std_logic_vector (31 downto 0));
    end component;

    signal Clock       : std_logic;
    signal reg_write   : std_logic;
    signal read_reg_1  : std_logic_vector (4 downto 0);
    signal read_reg_2  : std_logic_vector (4 downto 0);
    signal write_reg   : std_logic_vector (4 downto 0);
    signal write_data  : std_logic_vector (31 downto 0);
    signal read_data_1 : std_logic_vector (31 downto 0);
    signal read_data_2 : std_logic_vector (31 downto 0);
    signal R0          : std_logic_vector (31 downto 0);
    signal R1          : std_logic_vector (31 downto 0);
    signal R2          : std_logic_vector (31 downto 0);
    signal R3          : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : registers
    port map (Clock       => Clock,
              reg_write   => reg_write,
              read_reg_1  => read_reg_1,
              read_reg_2  => read_reg_2,
              write_reg   => write_reg,
              write_data  => write_data,
              read_data_1 => read_data_1,
              read_data_2 => read_data_2,
              R0          => R0,
              R1          => R1,
              R2          => R2,
              R3          => R3);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        reg_write <= '0';
        read_reg_1 <= (others => '0');
        read_reg_2 <= (others => '0');
        write_reg <= (others => '0');
        write_data <= (others => '0');

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_registers of tb_registers is
    for tb
    end for;
end cfg_tb_registers;