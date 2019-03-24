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

begin
    DataHarzard : process( )
    begin
        -- TODO: need fix condition syntax
        if (IDEXInst[18-14] xor IFIDInst[28-24] = (others=>'0')) or (IDEXInst[18-14] xor IFIDInst[23-19] = (others=>'0')) then
            -- stall 2
        elsif (EXMEMInst[18-14] xor IFIDInst[28-24] = (others=>'0')) or (EXMEMInst[18-14] xor IFIDInst[23-19] = (others=>'0')) then
            -- stall 1
        end if ;

        -- if IDEXInst[31-29] = "000" then
        --     if IDEXInst[18-14] xor IFIDInst[28-24] = '0' then
        --         -- stall 2
        --     elsif IDEXInst[18-14] xor IFIDInst[23-19] = '0'then
        --         -- stall 2
        --     end if ;
        -- end if ;
        
    end process ; -- DataHarzard
end architecture ;