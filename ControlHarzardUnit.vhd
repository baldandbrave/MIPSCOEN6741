-- only solve control hazard by beq and jr
-- beq: branch when 2 operands equal
-- jr:  unconditional branch to M[rs]

library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ControlHarzardUnit is
  port (
    ReadData1 : in std_logic_vector(31 downto 0) ; -- output of register
    ReadData2 : in std_logic_vector(31 downto 0) ; -- output of register
    PCPlus4   : in std_logic_vector(31 downto 0) ;
    Immediate : in std_logic_vector(31 downto 0) ;
    OpCode    : in std_logic_vector(2 downto 0) ; -- 3bits opcode
    Funct     : in std_logic_vector(8 downto 0) ; -- 9bits funct
    NewPC     : out std_logic_vector(31 downto 0;

    -- Flush IF/ID to all 0, insert bubble, stall pipeline.
    -- all 0: and r0, r0, r0, doesn't change value of $zero.
    IFIDFlush : out std_logic
  ) ;
end ControlHarzardUnit ; 

architecture Behavior of ControlHarzardUnit is

begin
    
  ControlHarzardUnit : process(OpCode, Funct, ReadData1, ReadData2)
    begin
      if (ReadData1 xor ReadData2 = x"00000000") and (Opcode = "011") then -- beq
        NewPC <= PCPlus4 + Immediate;
        IFIDFlush <= '1';
      elsif OpCode = "000" and Funct = "000001000" then -- jr
        NewPC <= ReadData1/2; -- TODO: which one?
        IFIDFlush <= '1';
      else
        NewPC <= PCPlus4; -- no branch
        IFIDFlush <= '0';
      end if ;
    end process ; -- ControlHarzardUnit

end architecture ;