-- TODO: add other logic and other ports.
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ID_EX is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

    ReadData1In     : in std_logic_vector(31 downto 0) ;
    ReadData2In     : in std_logic_vector(31 downto 0) ;
    SignExtendIn    : in std_logic_vector(31 downto 0) ;
    FunctionCodeIn  : in std_logic_vector(8 downto 0) ;
    
    ReadData1Out    : out std_logic_vector(31 downto 0) ;
    ReadData2Out    : out std_logic_vector(31 downto 0) ;
    SignExtendOut   : out std_logic_vector(31 downto 0) ;
    FuctioinCodeOut : out std_logic_vector(8 downto 0)
    -- NextPCIn        : in std_logic_vector(31 downto 0) ;
  ) ;
end ID_EX ; 

architecture Behavior of ID_EX is

begin
    ID_EX : process( Clock, Reset )
    begin
        if Reset = '1' then
            ReadData1Out <= (others => '0');
            ReadData2Out <= (others => '0');
            SignExtendOut <= (others => '0');
            FuctioinCodeOut <= (others => '0');
        elsif falling_edge(Clock) then
            ReadData1Out <= ReadData1In;
            ReadData2Out <= ReadData2In;
            SignExtendOut <= SignExtendIn;
            FuctionCodeOut <= FunctionCodeIn;
        end if;
    end process ; -- ID_EX
end architecture ;