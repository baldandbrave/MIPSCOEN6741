library ieee;
use ieee.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

entity MIPS is
  port (
    clock : in std_logic;
    reset : in std_logic
  ) ;
end MIPS ;

architecture Behavior of MIPS is

  -- setting the default address as 0
  -- input signal from PC to instruction memory to read the instruction from the address provided by PC
  signal CurrentInstructionAddress : std_logic_vector(31 downto 0) := (others => 0);

  -- ouput signal from instruction memory [ 32 bit ]
  signal Instruction : std_logic_vector(31 downto 0) := (others => 0); 

begin
  process(clk,reset)
  begin
      U1 : ENTITY work.InstructionMemory(Behavioral)
      PORT MAP(
        InstructionAddress => CurrentInstructionAddress,
        Instruction => Instruction
  );


end architecture ; -- Behavior