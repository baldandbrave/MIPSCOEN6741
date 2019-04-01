-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 28.3.2019 17:54:38 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_ControlHarzardUnit is
end tb_ControlHarzardUnit;

architecture tb of tb_ControlHarzardUnit is

    component ControlHarzardUnit
        port (Clock     : in std_logic;
              ReadData1 : in std_logic_vector (31 downto 0);
              ReadData2 : in std_logic_vector (31 downto 0);
              PCPlus4   : in std_logic_vector (31 downto 0);
              Immediate : in std_logic_vector (31 downto 0);
              OpCode    : in std_logic_vector (2 downto 0);
              Funct     : in std_logic_vector (8 downto 0);
              NewPC     : out std_logic_vector (31 downto 0);
              IFIDFlush : out std_logic);
    end component;

    signal Clock     : std_logic;
    signal ReadData1 : std_logic_vector (31 downto 0);
    signal ReadData2 : std_logic_vector (31 downto 0);
    signal PCPlus4   : std_logic_vector (31 downto 0);
    signal Immediate : std_logic_vector (31 downto 0);
    signal OpCode    : std_logic_vector (2 downto 0);
    signal Funct     : std_logic_vector (8 downto 0);
    signal NewPC     : std_logic_vector (31 downto 0);
    signal IFIDFlush : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ControlHarzardUnit
    port map (Clock     => Clock,
              ReadData1 => ReadData1,
              ReadData2 => ReadData2,
              PCPlus4   => PCPlus4,
              Immediate => Immediate,
              OpCode    => OpCode,
              Funct     => Funct,
              NewPC     => NewPC,
              IFIDFlush => IFIDFlush);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ReadData1 <= (others => '0');
        ReadData2 <= (others => '0');
        PCPlus4 <= (others => '0');
        Immediate <= (others => '0');
        OpCode <= (others => '0');
        Funct <= (others => '0');

        -- -- Reset generation
        -- --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        -- YOURRESETSIGNAL <= '1';
        -- wait for 100 ns;
        -- YOURRESETSIGNAL <= '0';
        -- wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 3 * TbPeriod;
        
        -- beq
        ReadData1 <= x"00000001";
        ReadData2 <= x"00000001";
        OpCode <= "011";
        PCPlus4 <= x"00000001";
        Immediate <= x"00000001";
	
	wait for 1 * TbPeriod;
	-- bubble
        ReadData1 <= x"00000000";
        ReadData2 <= x"00000000";
        OpCode <= "000";
        PCPlus4 <= x"00000001";
        Immediate <= x"00000000";

	-- no hazard
        ReadData1 <= x"00000003";
        ReadData2 <= x"00000002";

        wait for 1 * TbPeriod;

        -- jr
        OpCode <= "000";
        Funct <= "000001000";
        ReadData1 <= x"0000ffff";
        ReadData2 <= (others => '0');
        Immediate <= x"00000001";

	wait for 1 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ControlHarzardUnit of tb_ControlHarzardUnit is
    for tb
    end for;
end cfg_tb_ControlHarzardUnit;