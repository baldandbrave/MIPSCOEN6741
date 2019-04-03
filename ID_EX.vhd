library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ID_EX is
  port (
    Clock           : in std_logic;
    IDEXFlush       : in std_logic;

    IFIDInstIn      : in std_logic_vector(31 downto 0) ;
    TargetRegIn     : in std_logic_vector(4 downto 0) ;
    ReadData1In     : in std_logic_vector(31 downto 0) ;
    ReadData2In     : in std_logic_vector(31 downto 0) ;
    SignExtendIn    : in std_logic_vector(31 downto 0) ;
    FunctionCodeIn  : in std_logic_vector(8 downto 0) ;
    -- EX signals
    ALUSrc          : in std_logic;
    ALUOp           : in std_logic_vector(1 downto 0) ;
    -- MEM signals
    MemRead         : in std_logic;
    MemWrite        : in std_logic;
    -- WB signals
    MemToReg        : in std_logic;
    RegWrite        : in std_logic;

    IDEXInstOut     : out std_logic_vector(31 downto 0) ;
    TargetRegOut    : out std_logic_vector(4 downto 0) ;
    ReadData1Out    : out std_logic_vector(31 downto 0) ;
    ReadData2Out    : out std_logic_vector(31 downto 0) ;
    SignExtendOut   : out std_logic_vector(31 downto 0) ;
    FuctionCodeOut  : out std_logic_vector(8 downto 0) ;

    ALUSrcOut       : out std_logic;
    ALUOpOut        : out std_logic_vector(1 downto 0) ;
    MemReadOut      : out std_logic;
    MemWriteOut     : out std_logic;
    MemToRegOut     : out std_logic;
    RegWriteOut     : out std_logic
  ) ;
end ID_EX ; 

architecture Behavior of ID_EX is

begin
    ID_EX : process( Clock, IDEXFlush )
    begin
        if falling_edge(Clock) then
            if IDEXFlush = '1' then
                ReadData1Out <= (others => '0');
                ReadData2Out <= (others => '0');
                SignExtendOut <= (others => '0');
                FuctionCodeOut <= (others => '0');
                IDEXInstOut <= (others => '0');
                TargetRegOut <= (others => '0');
            else
                IDEXInstOut <= IFIDInstIn;
                TargetRegOut <= TargetRegIn;
                ReadData1Out <= ReadData1In;
                ReadData2Out <= ReadData2In;
                SignExtendOut <= SignExtendIn;
                FuctionCodeOut <= FunctionCodeIn;
                ALUSrcOut <= ALUSrc;
                ALUOpOut <= ALUOp;
                MemReadOut <= MemRead;
                MemWriteOut <= MemWrite;
                MemToRegOut <= MemToReg;
                RegWriteOut <= RegWrite;
            end if;
        end if;
    end process ; -- ID_EX
end architecture ;