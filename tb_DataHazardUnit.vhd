-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 28.3.2019 19:07:07 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_DataHarzardUnit is
end tb_DataHarzardUnit;

architecture tb of tb_DataHarzardUnit is

    component DataHarzardUnit
        port (Clock     : in std_logic;
              IFIDInst  : in std_logic_vector (31 downto 0);
              IDEXInst  : in std_logic_vector (31 downto 0);
              EXMEMInst : in std_logic_vector (31 downto 0);
              PCStall   : out std_logic;
              IFIDStall : out std_logic;
              IDEXFlush : out std_logic);
    end component;

    signal Clock     : std_logic;
    signal IFIDInst  : std_logic_vector (31 downto 0);
    signal IDEXInst  : std_logic_vector (31 downto 0);
    signal EXMEMInst : std_logic_vector (31 downto 0);
    signal PCStall   : std_logic;
    signal IFIDStall : std_logic;
    signal IDEXFlush : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : DataHarzardUnit
    port map (Clock     => Clock,
              IFIDInst  => IFIDInst,
              IDEXInst  => IDEXInst,
              EXMEMInst => EXMEMInst,
              PCStall   => PCStall,
              IFIDStall => IFIDStall,
              IDEXFlush => IDEXFlush);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- init with no hazard
        IFIDInst <= "000" & "00010" & "00011" & "00001" & "00000" & "000100000";
        IDEXInst <= "000" & "00101" & "00110" & "00100" & "00000" & "000100000";
        EXMEMInst <= "000" & "01000" & "01001" & "00111" & "00000" & "000100000";

        -- Program:
        -- add r1, r2, r3
        -- add r4, r1, r2
        
        -- Format:
        -- 31-29 opcode => 3 bits
        -- 5 bits each for regs => 15 bits
        -- 13-9 shant, => 5 bits
        -- 8-0 funct,add 0 in front as extension => 9 bits

        wait for 3 * TbPeriod;

        -- assign to if/id & id/ex
        IDEXInst <= "000" & "00010" & "00011" & "00001" & "00000" & "000100000";
        IFIDInst <= "000" & "00010" & "00001" & "00100" & "00000" & "000100000";
        wait for 3 * TbPeriod;

        IDEXInst <= (others => '0');
        -- assign to if/id & ex/mem
        EXMEMInst <= "000" & "00010" & "00011" & "00001" & "00000" & "000100000";
        IFIDInst <= "000" & "00010" & "00001" & "00100" & "00000" & "000100000";
	wait for 2 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_DataHarzardUnit of tb_DataHarzardUnit is
    for tb
    end for;
end cfg_tb_DataHarzardUnit;