library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
library work;
    use work.all;
entity MIPS is
  port (
    Clock   : in std_logic
  ) ;
end entity ; -- MIPS

architecture Behavior of MIPS is
    -------------------------------IF----------------------------------------
    signal DHU_PC_PCStall   : std_logic;
    signal CHU_PC_PrevInstAddress  : std_logic_vector(31 downto 0) ;
    component PC is
        port (
            Clock           : in std_logic;
            PCStall         : in std_logic;
            PrevInstAddress : in std_logic_vector(31 downto 0);
            NextInstAddress : out std_logic_vector(31 downto 0)
        );
    end component PC;
    signal PC_IM_NextInstAddress   : std_logic_vector(31 downto 0) ;
    component InstructionMemory is
        port (
            InstructionAddress: in std_logic_vector(31 downto 0);
            InstructionOut: out  std_logic_vector(31 downto 0)
        );
    end component InstructionMemory;
    signal PC_Adder         : std_logic_vector(31 downto 0) ;
    component Adder is
        port (
            Adder_input: in std_logic_vector(31 downto 0);
            Adder_output: out std_logic_vector(31 downto 0)
        );
    end component Adder;
    signal Adder_IFID_PCIn  : std_logic_vector(31 downto 0) ;
    signal DHU_IFID_Stall   : std_logic;
    signal CHU_IFID_Flush   : std_logic;
    signal IM_IFID_InstIn   : std_logic_vector(31 downto 0) ;
    component IF_ID is
        port (
            Clock           : in std_logic;
            Reset           : in std_logic;
            IFIDStall       : in std_logic;
            IFIDFlush       : in std_logic;
            -- PC+4
            PCIn         : in std_logic_vector(31 downto 0) ;
            InstructionIn   : in std_logic_vector(31 downto 0) ;
            PCOut        : out std_logic_vector(31 downto 0) ;
            InstructionOut  : out std_logic_vector(31 downto 0)
        );
    end component IF_ID;

<<<<<<< HEAD:Pipeline/MIPS.vhd
  Constant N : natural := 5;
  signal sigOpCode : std_logic_vector( 2 downto 0 ) := (others => '0') ;
  signal sigFunctn : std_logic_vector( 8 downto 0 ) := (others => '0') ;
  signal sigRs : std_logic_vector( 4 downto 0 ) := (others => '0') ;
  signal sigRt : std_logic_vector( 4 downto 0 ) := (others => '0') ;
  signal sigRd : std_logic_vector( 4 downto 0 ) := (others => '0') ;
  signal sigImmediate : std_logic_vector( 18 downto 0 ) := (others => '0') ;
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
=======
    ------------------------------------------ID---------------------------------------------------
    signal IFID_InstOut     : std_logic_vector(31 downto 0) ; -- connect to multiple components
    signal MEMWB_Reg_RegWrite: std_logic; --TODO: add this signal to all pipe regs
    component Registers is
        port (
            Reg_write: in std_logic; -- output from controller
            Read_reg_1: in std_logic_vector(4 downto 0); -- output instruction[25-21] from instruction memory
            Read_reg_2: in std_logic_vector(4 downto 0); -- output instruction[20-16] from instruction memory
            Write_register: in std_logic_vector(4 downto 0); 
            Write_data: in std_logic_vector(31 downto 0);
            Read_data_1: out std_logic_vector(31 downto 0);
            Read_data_2: out std_logic_vector(31 downto 0)
        );
    end component Registers;
    component Controller is
        port (
            opCode  : in std_logic_vector(2 downto 0);
            RegDst  : out std_logic;
            Jump    : out std_logic;
            Branch  : out std_logic;
            MemRead : out std_logic;
            MemToReg: out std_logic;
            ALUOp   : out std_logic_vector(1 downto 0) ;
            MemWrite: out std_logic;
            ALUSrc  : out std_logic;
            RegWrite: out std_logic
        );
    end component Controller;
    signal IDEX_InstOut : std_logic_vector(31 downto 0) ; -- multiple use
    signal EXMEM_InstOut: std_logic_vector(31 downto 0) ; -- multiple use?
    component DataHazardUnit is
        port (
            Clock       : in std_logic;
            IFIDInst    : in std_logic_vector(31 downto 0) ;
            IDEXInst    : in std_logic_vector(31 downto 0) ;
            EXMEMInst   : in std_logic_vector(31 downto 0) ;
            -- stall PC and IF/ID reg, flush ID/EX reg
            PCStall     : out std_logic;
            IFIDStall   : out std_logic;
            IDEXFlush   : out std_logic -- set operand & control signal to 0, insert bubble.
        );
    end component DataHazardUnit;
    signal IFID_CHU_PCPlus4   : std_logic_vector(31 downto 0) ;
    component ControlHazrdUnit is
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
        );
    end component ControlHazrdUnit;
    component SignExtend is
        port (
            SignExtend_in: in std_logic_vector(18 downto 0);
            SignExtend_out: out std_logic_vector(31 downto 0)
        );
    end component SignExtend;
    signal Reg_IDEX_ReadData1: std_logic_vector(31 downto 0) ;
    signal Reg_IDEX_ReadData2: std_logic_vector(31 downto 0) ;
    signal SignExtend_IDEX   : std_logic_vector(31 downto 0) ;
    -- func from IFIDOut
    signal Ctrl_IDEX_ALUSrc   : std_logic;
    signal Ctrl_IDEX_ALUOp    : std_logic_vector(1 downto 0) ;
    signal Ctrl_IDEX_MemRead  : std_logic;
    signal Ctrl_IDEX_MemWrite : std_logic;
    signal Ctrl_IDEX_MemToReg : std_logic;
    signal Ctrl_IDEX_RegDst   : std_logic;
    component ID_EX is
        port (
            Clock           : in std_logic;
            IDEXFlush       : in std_logic;
            ReadData1In     : in std_logic_vector(31 downto 0) ;
            ReadData2In     : in std_logic_vector(31 downto 0) ;
            SignExtendIn    : in std_logic_vector(31 downto 0) ;
            FunctionCodeIn  : in std_logic_vector(8 downto 0) ;
            -- EX signals
            ALUSrc          : in std_logic;
            ALUOp           : in std_logic_vector(1 downto 0) ;
            -- MEM signals
            MemRead         : in std_logic;
            MemWrite        : in std_logic;
            -- WB signals
            MemToReg        : in std_logic;
            RegDst          : in std_logic;
>>>>>>> 4bf62585c89b45a32d6f849237f3a233e9be0575:MIPS.vhd

            ReadData1Out    : out std_logic_vector(31 downto 0) ;
            ReadData2Out    : out std_logic_vector(31 downto 0) ;
            SignExtendOut   : out std_logic_vector(31 downto 0) ;
            FuctionCodeOut : out std_logic_vector(8 downto 0) ;

            ALUSrcOut       : out std_logic;
            ALUOpOut        : out std_logic_vector(1 downto 0) ;
            MemReadOut      : out std_logic;
            MemWriteOut     : out std_logic;
            MemToRegOut     : out std_logic;
            RegDstOut       : out std_logic
        );
    end component ID_EX;

    --------------------------------------EX---------------------------------------------
    signal IDEX_ALU_LeftOp : std_logic_vector(31 downto 0) ;
    signal IDEX_Mux_ReadData2        : std_logic_vector(31 downto 0) ;
    signal IDEX_Mux_Immediate        : std_logic_vector(31 downto 0) ;
    signal IDEX_Mux_ALUSrc : std_logic;
    signal IDEX_ALUCtrl_Funct : std_logic_vector(8 downto 0) ;
    component ALUControl is
        port (
            Funct: in std_logic_vector(8 downto 0);
            ALU_op: in std_logic_vector(1 downto 0);
            ALUControlFunct: out std_logic_vector(2 downto 0)
        );
    end component ALUControl;
    signal ALUCtrl_ALU_ALUCtrlFunc : std_logic_vector(2 downto 0) ;
    component ALU is
        port (
            LeftOperand  : in std_logic_vector(31 downto 0);
            RightOperand : in std_logic_vector(31 downto 0);
            ALUControl   : in std_logic_vector(2 downto 0);
            ALUResult    : out std_logic_vector(31 downto 0) ;
            Zero: out std_logic
        );
    end component ALU;
    signal ALU_EXMEM_ALUResult : std_logic_vector(31 downto 0) ;
    signal IDEX_EXMEM_MemRead : std_logic;
    signal IDEX_EXMEM_MemWrite : std_logic;
    signal IDEX_EXMEM_MemToReg : std_logic;
    signal IDEX_EXMEM_MemRegDst : std_logic;
    component EX_MEM is
        port (
            Clock           : in std_logic;
            Reset           : in std_logic;
            ALUResultIn     : in std_logic_vector(31 downto 0) ;
            MemWriteIn      : in std_logic;
            -- MEM signals
            MemRead         : in std_logic;
            MemWrite        : in std_logic;
            -- WB signals
            MemToReg        : in std_logic;
            RegDst          : in std_logic;
            ALUResultOut    : out std_logic_vector(31 downto 0) ;
            MemReadOut      : out std_logic;
            MemWriteOut     : out std_logic;
            MemToRegOut     : out std_logic;
            RegDstOut       : out std_logic
        );
    end component EX_MEM;

<<<<<<< HEAD:Pipeline/MIPS.vhd
  signal sigMuxInp0 : std_logic_vector( N - 1 downto 0 ):= (others => '0');
  signal sigMuxInp1 : std_logic_vector( N - 1 downto 0 ):= (others => '0');
  signal sigMuxOut : std_logic_vector( N - 1 downto 0 ):= (others => '0');

begin
  -- process( clock, reset )
	-- begin
  -- end process;
-- Wire some stuff
      sigOpCode <= sigInstruction(31 downto 29); -- 3 bits
      sigRs <= sigInstruction(28 downto 24); -- 5 bits
      sigRt <= sigInstruction(23 downto 19); -- 5 bits
      sigRd <= sigInstruction(18 downto 14); -- 5 bits
      sigImmediate <= sigInstruction(18 downto 0); -- 19 bits
      sigFunctn <= sigInstruction(8 downto 0); -- 9 bits
      sigShamt <= sigInstruction(13 downto 9); -- 5 bits

	-- Mapping for IM Component -------------------------------------
      IM : entity work.InstructionMemory(Behavioral)   port map(
	 InstructionAddress => sigCurrentInstructionAddress,
        InstructionOut => sigInstruction
);
  --------------------  MUX mapping ---------------------------------
  -- For R and I type operation: destination register is of 5 bit
  -- MUX_RegFile : ENTITY work.MuxNBit(Behavioral)
  --     Generic map (5)
  --     PORT MAP(
  --         MuxControlInput => sigRegDstCntrl,
  --         MuxInput_0 => sigRt,
  --         MuxInput_1 => sigRd,
  --         MuxOutput => sigRegWriteData
  -- );
  -- MUX_ALU : ENTITY work.MuxNBit(Behavioral)
  --     Generic map (32)
  --     PORT MAP(
  --         MuxControlInput => sigALUSrcCntrl,
  --         MuxInput_0 => sigRegData2,
  --         MuxInput_1 => sigExtendedImmediate,
  --         MuxOutput => sigRegData2
	--   );

  -- MUX_Mem2Reg : ENTITY work.MuxNBit(Behavioral)
  --     Generic map ( 32)
  --     PORT MAP(
  --         MuxControlInput => sigMem2RegCntrl,
  --         MuxInput_0 => sigALUResult,
  --         MuxInput_1 => sigDMReadData,
  --         MuxOutput => sigRegWriteAddress
  -- );
  
  
 
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

=======
    -----------------------------------------MEM----------------------------------------------
    signal EXMEM_DM_MemRead : std_logic;
    signal EXMEM_DM_MemWrite : std_logic;
    signal EXMEM_ALUResultOut: std_logic_vector(31 downto 0) ;-- connect to DM and MEM_WB
    -- TODO: add ReadData2 to IDEX and EXMEM
    signal EXMEM_DM_WriteData: std_logic_vector(31 downto 0) ;
    component DataMemory is
        port (
            MemRead   : in std_logic;
            MemWrite  : in std_logic;
            Address   : in std_logic_vector(31 downto 0);
            WriteData : in std_logic_vector(31 downto 0);
            ReadData  : out std_logic_vector(31 downto 0)
        );
    end component DataMemory;
    signal EXMEM_MEMWB_MemToReg : std_logic;
    signal EXMEM_MEMWB_RegDst : std_logic;
    -- TODO: RegWrite
    signal DM_MEMWB_ReadData : std_logic_vector(31 downto 0) ;
    -- ALUResultIn from EXMEM_ALUResultOut;
    component MEM_WB is
        port (
            Clock           : in std_logic;
            Reset           : in std_logic;
            ReadDataIn      : in std_logic_vector(31 downto 0) ;
            ALUResultIn     : in std_logic_vector(31 downto 0) ;
            -- WB signals
            MemToReg        : in std_logic;
            RegDst          : in std_logic;
            ReadDataOut     : out std_logic_vector(31 downto 0) ;
            ALUResultOut    : out std_logic_vector(31 downto 0) ;
            MemToRegOut     : out std_logic;
            RegDstOut       : out std_logic
        );
    end component MEM_WB;
    signal MEMWB_Mux_ReadDataOut: std_logic_vector(31 downto 0) ;
    signal MEMWB_Mux_ALUResultOut: std_logic_vector(31 downto 0) ;
    --------------------------------------------WB-------------------------------------------
    component Mux32 is
        generic (
            N : integer := 32
        );
        port (
            MuxControlInput : in std_logic;
            MuxInput_1 : in std_logic_vector ( N - 1 downto 0);
            MuxInput_0 : in std_logic_vector ( N - 1 downto 0);
            MuxOutput : out std_logic_vector ( N - 1 downto 0)
        );
    end component Mux32;
begin
    
>>>>>>> 4bf62585c89b45a32d6f849237f3a233e9be0575:MIPS.vhd
end architecture ; -- Behavior