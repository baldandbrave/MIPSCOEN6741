-- TODO: need to define offset and memory size
-- current offset: 16
-- current memory size: 16 rows, 16*32
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity DataMemory is
  port (
    MemRead   : in std_logic;
    MemWrite  : in std_logic;
    Address   : in std_logic_vector(31 downto 0);
    WriteData : in std_logic_vector(31 downto 0);
    ReadData  : out std_logic_vector(31 downto 0)
  ) ;
end DataMemory ; 

architecture Behavior of DataMemory is
    type 16RowDataMemory is array (0 to 16) of std_logic_vector(31 downto 0) ;
    signal DataMemorySignal : 16RowDataMemory := (others => 0); -- set to 0, need verify syntax
begin

    DataMemory : process( MemRead, MemWrite )
        variable DataMemoryControlSignal : std_logic_vector(1 downto 0);
        constant DataMemoryOffset : unsigned := 16;
    begin
        DataMemoryControlSignal := MemRead & MemWrite; -- concat these 2 signals
        case( DataMemoryControlSignal ) is
        
            when "01" => -- write
                16RowDataMemory(to_integer(unsigned(Address) - DataMemoryOffset)/4) <= WriteData;
            when "10" => -- read
                ReadData <= 16RowDataMemory(to_integer(unsigned(Address) - DataMemoryOffset)/4);
            when others => NULL; -- handle exceptions
        
        end case ;
    end process ; -- DataMemory
    
end architecture ;