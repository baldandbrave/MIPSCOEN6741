-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 30.3.2019 00:17:33 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_ID_EX is
end tb_ID_EX;

architecture tb of tb_ID_EX is

    component ID_EX
        port (Clock           : in std_logic;
              IDEXFlush       : in std_logic;
              ReadData1In     : in std_logic_vector (31 downto 0);
              ReadData2In     : in std_logic_vector (31 downto 0);
              SignExtendIn    : in std_logic_vector (31 downto 0);
              FunctionCodeIn  : in std_logic_vector (8 downto 0);
              ALUSrc          : out std_logic;
              ALUOp           : out std_logic_vector (1 downto 0);
              MemRead         : out std_logic;
              MemWrite        : out std_logic;
              MemToReg        : out std_logic;
              RegDst          : out std_logic;
              ReadData1Out    : out std_logic_vector (31 downto 0);
              ReadData2Out    : out std_logic_vector (31 downto 0);
              SignExtendOut   : out std_logic_vector (31 downto 0);
              FunctionCodeOut : out std_logic_vector (8 downto 0);
              ALUSrcOut       : out std_logic;
              ALUOpOut        : out std_logic_vector (1 downto 0);
              MemReadOut      : out std_logic;
              MemWriteOut     : out std_logic;
              MemToRegOut     : out std_logic;
              RegDstOut       : out std_logic);
    end component;

    signal Clock           : std_logic;
    signal IDEXFlush       : std_logic;
    signal ReadData1In     : std_logic_vector (31 downto 0);
    signal ReadData2In     : std_logic_vector (31 downto 0);
    signal SignExtendIn    : std_logic_vector (31 downto 0);
    signal FunctionCodeIn  : std_logic_vector (8 downto 0);
    signal ALUSrc          : std_logic;
    signal ALUOp           : std_logic_vector (1 downto 0);
    signal MemRead         : std_logic;
    signal MemWrite        : std_logic;
    signal MemToReg        : std_logic;
    signal RegDst          : std_logic;
    signal ReadData1Out    : std_logic_vector (31 downto 0);
    signal ReadData2Out    : std_logic_vector (31 downto 0);
    signal SignExtendOut   : std_logic_vector (31 downto 0);
    signal FunctionCodeOut : std_logic_vector (8 downto 0);
    signal ALUSrcOut       : std_logic;
    signal ALUOpOut        : std_logic_vector (1 downto 0);
    signal MemReadOut      : std_logic;
    signal MemWriteOut     : std_logic;
    signal MemToRegOut     : std_logic;
    signal RegDstOut       : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ID_EX
    port map (Clock           => Clock,
              IDEXFlush       => IDEXFlush,
              ReadData1In     => ReadData1In,
              ReadData2In     => ReadData2In,
              SignExtendIn    => SignExtendIn,
              FunctionCodeIn  => FunctionCodeIn,
              ALUSrc          => ALUSrc,
              ALUOp           => ALUOp,
              MemRead         => MemRead,
              MemWrite        => MemWrite,
              MemToReg        => MemToReg,
              RegDst          => RegDst,
              ReadData1Out    => ReadData1Out,
              ReadData2Out    => ReadData2Out,
              SignExtendOut   => SignExtendOut,
              FunctionCodeOut => FunctionCodeOut,
              ALUSrcOut       => ALUSrcOut,
              ALUOpOut        => ALUOpOut,
              MemReadOut      => MemReadOut,
              MemWriteOut     => MemWriteOut,
              MemToRegOut     => MemToRegOut,
              RegDstOut       => RegDstOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        IDEXFlush <= '0';
        ReadData1In <= (others => '0');
        ReadData2In <= (others => '0');
        SignExtendIn <= (others => '0');
        FunctionCodeIn <= (others => '0');

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ID_EX of tb_ID_EX is
    for tb
    end for;
end cfg_tb_ID_EX;