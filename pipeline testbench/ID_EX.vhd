library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ID_EX is
  port (
    Clock           : in std_logic;
    IDEXFlush           : in std_logic;

    ReadData1In     : in std_logic_vector(31 downto 0) ;
    ReadData2In     : in std_logic_vector(31 downto 0) ;
    SignExtendIn    : in std_logic_vector(31 downto 0) ;
    FunctionCodeIn  : in std_logic_vector(8 downto 0) ;
    
    -- EX signals
    ALUSrc          : out std_logic;
    ALUOp           : out std_logic_vector(1 downto 0) ;
    -- MEM signals
    MemRead         : out std_logic;
    MemWrite        : out std_logic;
    -- WB signals
    MemToReg        : out std_logic;
    RegDst          : out std_logic;

    ReadData1Out    : out std_logic_vector(31 downto 0) ;
    ReadData2Out    : out std_logic_vector(31 downto 0) ;
    SignExtendOut   : out std_logic_vector(31 downto 0) ;
    FunctionCodeOut : out std_logic_vector(8 downto 0) ;

    ALUSrcOut       : out std_logic;
    ALUOpOut        : out std_logic_vector(1 downto 0) ;
    MemReadOut      : out std_logic;
    MemWriteOut     : out std_logic;
    MemToRegOut     : out std_logic;
    RegDstOut       : out std_logic
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
                FunctionCodeOut <= (others => '0');
            else
                ReadData1Out <= ReadData1In;
                ReadData2Out <= ReadData2In;
                SignExtendOut <= SignExtendIn;
                FunctionCodeOut <= FunctionCodeIn;
            end if;
        end if;
    end process ; -- ID_EX
end architecture ;