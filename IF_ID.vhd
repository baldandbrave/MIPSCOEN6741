library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity IF_ID is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;
    -- stall in data hazard
    IFIDStall       : in std_logic;
    -- flush in control hazard
    IFIDFlush       : in std_logic;
    -- PCIn: PC+4
    PCIn         : in std_logic_vector(31 downto 0) ;
    InstructionIn   : in std_logic_vector(31 downto 0) ;
    
    PCOut        : out std_logic_vector(31 downto 0) ;
    InstructionOut  : out std_logic_vector(31 downto 0)
  ) ;
end IF_ID ; 

architecture Behavior of IF_ID is

begin
    IF_ID : process( Clock, IFIDStall, IFIDFlush, Reset )
    begin
        if Reset = '1' then
            InstructionOut <= x"01080000";
            PCOut <= (others => '0');
        elsif falling_edge(Clock) then
            if IFIDStall = '1' then -- hold output
                NULL;
            elsif IFIDFlush = '1' then -- set output to 0.
                PCOut <= PCIn;
                InstructionOut <= (others => '0');
            else
                PCOut <= PCIn;
                InstructionOut <= InstructionIn;
            end if ;
        end if ;
    end process ; -- IF_ID
end architecture ;