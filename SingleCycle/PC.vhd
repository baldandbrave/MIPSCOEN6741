-- PC: Program Counter
-- Added a memory-like signal to store current addr, maybe useful for pipeline
-- Added clock port input, maybe remove it for simulation
-- set output from the memory, then load to mem from input.
-- Reference code: https://github.com/PiJoules/MIPS-processor/blob/master/pc.vhd
-- Reference code without clock: https://github.com/dugagjin/MIPS/blob/master/MIPS/programCounter.vhd
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity PC is
  port (
    Clock : in std_logic;
    PrevInstAddress : in std_logic_vector(31 downto 0);
    NextInstAddress: out std_logic_vector(31 downto 0)
  ) ;
end PC ; 

architecture Behavior of PC is
    signal PCAddressSignal : std_logic_vector(31 downto 0) := (others =>0);
begin
    PC : process( Clock )
    begin
        NextInstAddress <= PCAddressSignal;
        if rising_edge(Clock) then -- TODO: if meet error in simulating use Clock'event
            PCAddressSignal <= PrevInstAddress;
        end if ;
    end process ; -- PC
end architecture ;