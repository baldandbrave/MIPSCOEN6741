-- current offset: 16
-- current data memory size: 16 rows, 16*32
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
    type DataMemory16Row is array (0 to 15) of std_logic_vector(31 downto 0) ;
    signal DataMemorySignal : DataMemory16Row := (
        "00000000000000000000000000000000",
        "00001001010000101000000000100000", -- 1 add 	$t2, 	$t1, 	$t0
        "00001100010110000001101000100101", -- 2 or 	$t5, 	$t4, 	$t3
        "00001001010000110100000000100010", -- 3sub
        "00001001010000101000000000100100", -- 4 and $t2 $t1 $t0
        "00011000110010111000000000100110", -- 5 xor $t6 $t8 $t9
        "00101001010000000000000000000011", -- 6 andi 
        "01001001011010000000000000001011", -- 7 subi --> addi $t5 $t1 -5
        "01101010011011111111111111110011", -- 8 beq
        "10010011011100000000000000000101", -- 9 lw $t6 5($s3)
        "10110010011010000000000000000101", -- 10 sw $t5 5($s2)  
        "10101011100110000000000000001100", -- 11 lw $s3 12($t3)
        "01001101010011111111111111110101", -- 12 subi $t1 $t5 -11
        "00101101010010000000000000000001", -- 14 andi $t1 $t5 1
        "00001101010100101100000000100101", -- 15 or $t3 $t5 $t2
        "00001110000000000000000000001000"  -- 16 jr $t6
    ); -- set to 0, need verify syntax
begin

    DataMemory : process( MemRead, MemWrite )
        variable DataMemoryControlSignal : std_logic_vector(1 downto 0);
        constant DataMemoryOffset : integer := 16;
    begin
        DataMemoryControlSignal := MemRead & MemWrite; -- concat these 2 signals
        case( DataMemoryControlSignal ) is
        
            when "01" => -- write
                DataMemorySignal(to_integer(unsigned(Address) - DataMemoryOffset)/4) <= WriteData;
            when "10" => -- read
                ReadData <= DataMemorySignal(to_integer(unsigned(Address) - DataMemoryOffset)/4);
            when others => 
                ReadData <= (others => '0'); -- handle exceptions
        
        end case ;
    end process ; -- DataMemory
    
end architecture ;