-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 29.3.2019 19:41:54 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_IF_ID is
end tb_IF_ID;

architecture tb of tb_IF_ID is

    component IF_ID
        port (Clock          : in std_logic;
              Reset          : in std_logic;
              IFIDStall      : in std_logic;
              IFIDFlush      : in std_logic;
              PCIn           : in std_logic_vector (31 downto 0);
              InstructionIn  : in std_logic_vector (31 downto 0);
              PCOut          : out std_logic_vector (31 downto 0);
              InstructionOut : out std_logic_vector (31 downto 0));
    end component;

    signal Clock          : std_logic;
    signal Reset          : std_logic;
    signal IFIDStall      : std_logic;
    signal IFIDFlush      : std_logic;
    signal PCIn           : std_logic_vector (31 downto 0);
    signal InstructionIn  : std_logic_vector (31 downto 0);
    signal PCOut          : std_logic_vector (31 downto 0);
    signal InstructionOut : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : IF_ID
    port map (Clock          => Clock,
              Reset          => Reset,
              IFIDStall      => IFIDStall,
              IFIDFlush      => IFIDFlush,
              PCIn           => PCIn,
              InstructionIn  => InstructionIn,
              PCOut          => PCOut,
              InstructionOut => InstructionOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Reset <= '0';
        IFIDStall <= '0';
        IFIDFlush <= '0';
        PCIn <= (others => '0');
        InstructionIn <= (others => '0');

        -- EDIT Add stimuli here
        wait for 2.5 * TbPeriod;

        PCIn <= x"0000ffff";
        InstructionIn <= x"00110011";
        
        wait for 2 * TbPeriod;
	IFIDStall <= '1';
        PCIn <= x"ffff0000";
        InstructionIn <= x"11001100";

        wait for 1 * TbPeriod;

	IFIDStall <= '0';
	IFIDFlush <= '1';

	wait for 1 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_IF_ID of tb_IF_ID is
    for tb
    end for;
end cfg_tb_IF_ID;
