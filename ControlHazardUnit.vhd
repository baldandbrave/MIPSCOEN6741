-- only solve control hazard by beq and jr
-- beq: branch when 2 operands equal
-- jr:  unconditional branch to M[rs]

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use ieee.std_logic_unsigned.all;


entity ControlHazardUnit is
  port (
    Clock     : in std_logic;
    ReadData1 : in std_logic_vector(31 downto 0) ; -- output of register
    ReadData2 : in std_logic_vector(31 downto 0) ; -- output of register
    PCPlus4   : in std_logic_vector(31 downto 0) ;
    Immediate : in std_logic_vector(31 downto 0) ;
    OpCode    : in std_logic_vector(2 downto 0) ; -- 3bits opcode
    Funct     : in std_logic_vector(8 downto 0) ; -- 9bits funct
    NewPC     : out std_logic_vector(31 downto 0);

    -- Flush IF/ID to all 0, insert bubble, stall pipeline.
    -- all 0: and r0, r0, r0, doesn't change value of $zero.
    IFIDFlush : out std_logic
  ) ;
end ControlHazardUnit ; 

architecture Behavior of ControlHazardUnit is
  signal FlushCounter : integer := 0;
  signal XorResult    : std_logic_vector(31 downto 0) ;
begin
    
  ControlHazardUnit : process(OpCode, Funct, ReadData1, ReadData2, Clock)
    begin
      XorResult <= ReadData1 xor ReadData2;
      if (XorResult= x"00000000") and (Opcode = "011") then -- beq
        NewPC <= PCPlus4 + Immediate ; 
        FlushCounter <= 1;
        IFIDFlush <= '1';
      elsif OpCode = "000" and Funct = "000001000" then -- jr
        NewPC <= ReadData1; -- TODO: which one?
        FlushCounter <= 1;
        IFIDFlush <= '1';
      else
        NewPC <= PCPlus4; -- no branch
      end if ;

      -- same logic as DataHazardUnit, control on rising edge, before update.
      if rising_edge(Clock) then
        if FlushCounter > 0 then
          FlushCounter <= FlushCounter - 1;
          IFIDFlush <= '1';
        else
          IFIDFlush <= '0';
        end if ;
    end if ;
    end process ; -- ControlHazardUnit

end architecture ;