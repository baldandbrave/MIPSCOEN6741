-- Data hazards: RAW
-- Dependency between 1,2 stage: 2cc
-- Dependency between 1,3 stage: 1cc

-- How to insert bubble into EX ? 
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity DataHarzardUnit is
  port (
    IFIDInst    : in std_logic_vector(31 downto 0) ;
    IDEXInst    : in std_logic_vector(31 downto 0) ;
    EXMEMInst   : in std_logic_vector(31 downto 0) ;

    PCStall     : out std_logic;
    IFIDStall   : out std_logic;
    IDEXFlush   : out std_logic -- set operand & control signal to 0, insert bubble.
  ) ;
end DataHarzardUnit ; 

architecture Behavior of DataHarzardUnit is
    signal StallCounter : integer := 0;

    alias IDEXInstRd    is IDEXInst(18 downto 14);
    alias EXMEMInstRd   is EXMEMInst(18 downto 14);

    alias IFIDInstRs    is IDEXInst(28 downto 24);
    alias IFIDInstRt    is IDEXInst(23 downto 19);

    signal XorResult1   : std_logic_vector(4 downto 0) ;
    signal XorResult2   : std_logic_vector(4 downto 0) ;
begin
    DataHarzard : process( IFIDInst, IDEXInst, EXMEMInst)
    begin
        
        XorResult1 <= IDEXInstRd xor IFIDInstRs;
        XorResult2 <= IDEXInstRd xor IFIDInstRt;
        if XorResult1="00000" or XorResult2="00000" then
            -- stall 2
            StallCounter <= 2;
        end if;

        XorResult1 <= EXMEMInstRd xor IFIDInstRs;
        XorResult2 <= EXMEMInstRd xor IFIDInstRt;
        if XorResult1="00000" or XorResult2="00000" then
            -- stall 1
            StallCounter <= 1;
        end if ;
        
    end process ; -- DataHarzard
end architecture ;
