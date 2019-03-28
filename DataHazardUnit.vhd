-- Data hazards: RAW
-- Dependency between 1,2 stage: 2cc
-- Dependency between 1,3 stage: 1cc

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity DataHarzardUnit is
  port (
    
    Clock       : in std_logic;
    IFIDInst    : in std_logic_vector(31 downto 0) ;
    IDEXInst    : in std_logic_vector(31 downto 0) ;
    EXMEMInst   : in std_logic_vector(31 downto 0) ;

    -- stall PC and IF/ID reg, flush ID/EX reg
    PCStall     : out std_logic;
    IFIDStall   : out std_logic;
    IDEXFlush   : out std_logic -- set operand & control signal to 0, insert bubble.
  ) ;
end DataHarzardUnit ; 

architecture Behavior of DataHarzardUnit is
    -- init counter as 0
    signal StallCounter : integer := 0;

    alias IDEXRd    is IDEXInst(18 downto 14);
    alias EXMEMRd   is EXMEMInst(18 downto 14);

    alias IFIDRs    is IDEXInst(28 downto 24);
    alias IFIDRt    is IDEXInst(23 downto 19);

    signal XorResult1   : std_logic_vector(4 downto 0) ;
    signal XorResult2   : std_logic_vector(4 downto 0) ;
begin
    DataHarzard : process( Clock, IFIDInst, IDEXInst, EXMEMInst)
    begin
        -- Dependency in ID/EX and IF/ID
        XorResult1 <= IDEXRd xor IFIDRs;
        XorResult2 <= IDEXRd xor IFIDRt;
        if XorResult1="00000" or XorResult2="00000" then
            -- stall 2
            StallCounter <= 2;
        end if;
        -- Dependency in EX/MEM and IF/ID
        XorResult1 <= EXMEMRd xor IFIDRs;
        XorResult2 <= EXMEMRd xor IFIDRt;
        if XorResult1="00000" or XorResult2="00000" then
            -- stall 1
            StallCounter <= 1;
        end if ;
        
        -- auto-decrement counter, count on rising edge: before pipe reg update
        if rising_edge(Clock) then
            if StallCounter > 0 then
                StallCounter <= StallCounter - 1;
                PCStall = '1';
                IFIDStall = '1';
                IDEXFlush = '1';
            else
                PCStall = '0';
                IFIDStall = '0';
                IDEXFlush = '0';
            end if ;
        end if ;

    end process ; -- DataHarzard
end architecture ;
