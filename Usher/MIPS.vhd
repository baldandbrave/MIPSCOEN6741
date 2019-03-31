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

  Constant N : natural := 5;
  signal sigOpCode : std_logic_vector( 5 downto 0 ) := (others => '0') ;
  signal sigFunctn : std_logic_vector( 5 downto 0 ) := (others => '0') ;
  signal sigRs : std_logic_vector( 4 downto 0 ) := (others => '0') ;
  signal sigRt : std_logic_vector( 4 downto 0 ) := (others => '0') ;
  signal sigRd : std_logic_vector( 4 downto 0 ) := (others => '0') ;
  signal sigImmediate : std_logic_vector( 15 downto 0 ) := (others => '0') ;
  signal sigExtendedImmediate : std_logic_vector( 31 downto 0 ) := (others => '0') ;
  signal sigShamt : std_logic_vector( 4 downto 0 ) := (others => '0') ;

  ---------------5 MUX Control Signals-------------------------------------------
  signal sigRegDstCntrl : std_logic;
  signal sigALUSrcCntrl : std_logic;
  signal sigJMPCntrl : std_logic;
  signal sigMem2RegCntrl : std_logic;
  signal sigANDGateOutCntrl : std_logic;
--------------------------------------------------------------------------------------
  signal sigRegWriteAddress : std_logic_vector( 31 downto 0 ) := (others => '0') ;
  signal sigRegData2 : std_logic_vector( 31 downto 0 ) := ( others => '0' );
  signal sigRegData1 : std_logic_vector( 31 downto 0 ) := ( others => '0' );
  signal sigALUResult : std_logic_vector( 31 downto 0 ) := ( others => '0' );
  signal sigDMReadData : std_logic_vector( 31 downto 0 ) := ( others => '0' );
  signal sigRegWriteData : std_logic_vector( 4 downto 0 ) := (others => '0') ;

---------------Instruction Memory-------------------------------------------
  -- setting the default address as 0
  -- input signal from PC to instruction memory to read the instruction from the address provided by PC
  signal sigCurrentInstructionAddress : std_logic_vector(31 downto 0) := (others => '0');

  -- ouput signal from instruction memory [ 32 bit ]
  signal sigInstruction : std_logic_vector(31 downto 0) := (others => '0'); 

---------------32 and 5 bit MUX 2-to-1-------------------------------------------

  signal sigMuxInp0 : std_logic_vector( N - 1 downto 0 ):= (others => '0');
  signal sigMuxInp1 : std_logic_vector( N - 1 downto 0 ):= (others => '0');
  signal sigMuxOut : std_logic_vector( N - 1 downto 0 ):= (others => '0');

begin
  process( clock, reset )
begin
 end process;

-- Wire some stuff
      sigOpCode <= sigInstruction(31 downto 26);
      sigRs <= sigInstruction(25 downto 21);
      sigRt <= sigInstruction(20 downto 16);
      sigRd <= sigInstruction(15 downto 11);
      sigImmediate <= sigInstruction(15 downto 0);
      sigFunctn <= sigInstruction(5 downto 0);
      sigShamt <= sigInstruction(10 downto 6);
      
	-- Mapping for IM Component -------------------------------------
      IM : entity work.InstructionMemory(Behavioral)
      port map( InstructionAddress => sigCurrentInstructionAddress,
        InstructionOut => sigInstruction
);
  --------------------  MUX mapping ---------------------------------
  -- For R and I type operation: destination register is of 5 bit
  MUX_RegFile : ENTITY work.MuxNBit(Behavioral)
      Generic map (5)
      PORT MAP(
          MuxControlInput => sigRegDstCntrl,
          MuxInput_0 => sigRt,
          MuxInput_1 => sigRd,
          MuxOutput => sigRegWriteData
  );
  MUX_ALU : ENTITY work.MuxNBit(Behavioral)
      Generic map (32)
      PORT MAP(
          MuxControlInput => sigALUSrcCntrl,
          MuxInput_0 => sigRegData2,
          MuxInput_1 => sigExtendedImmediate,
          MuxOutput => sigRegData2
	  );

  MUX_Mem2Reg : ENTITY work.MuxNBit(Behavioral)
      Generic map ( 32)
      PORT MAP(
          MuxControlInput => sigMem2RegCntrl,
          MuxInput_0 => sigALUResult,
          MuxInput_1 => sigDMReadData,
          MuxOutput => sigRegWriteAddress
  );

--- Not clear about the control signals for MUX connected with AND gate. 
--  MUX_AND : ENTITY work.MuxNBit(Behavioral)
--  Generic map ( N => 32)
--  PORT MAP(
--  );
--- This control signal from controlller is connected to the same MUX that is also connected with AND gate output. Not sure what to do
 -- MUX_JMP : ENTITY work.InstructionMemory(Behavioral)
--  Generic map ( N => 32)
--  PORT MAP(
--  );
--------------------  MUX mapping ENDS ---------------------------------

end architecture ; -- Behavior