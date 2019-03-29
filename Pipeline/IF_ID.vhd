library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity IF_ID is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;
    -- stall control signal
    IFIDStall       : in std_logic;
    -- PCIn: PC+4
    PCIn         : in std_logic_vector(31 downto 0) ;
    InstructionIn   : in std_logic_vector(31 downto 0) ;
    
    PCOut        : out std_logic_vector(31 downto 0) ;
    InstructionOut  : out std_logic_vector(31 downto 0)
  ) ;
end IF_ID ; 

architecture Behavior of IF_ID is

begin
    IF_ID : process( Clock, Reset, IFIDStall )
    begin
        if Reset = '1' then
            PCOut <= (others => '0');
            InstructionOut <= (others => '0');
        elsif falling_edge(Clock) then
            -- judge if stall on falling edge
            if IFIDStall != '0' then
                PCOut <= PCIn;
                InstructionOut <= InstructionIn;
            end if ;
        end if ;
    end process ; -- IF_ID
end architecture ;