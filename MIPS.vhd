library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
library work;
    use work.all;
entity MIPS is
end entity ; -- MIPS

architecture Behavior of MIPS is
    -------------------------------IF----------------------------------------
    signal DHU_PC_PCStall   : std_logic ;
    signal CHU_Mux_NextAddress  : std_logic_vector(31 downto 0) ;
    component PC is
        port (
            Clock           : in std_logic;
            PCStall         : in std_logic;
            PrevInstAddress : in std_logic_vector(31 downto 0);
            NextInstAddress : out std_logic_vector(31 downto 0)
        );
    end component PC;
    signal PC_IM_NextInstAddress   : std_logic_vector(31 downto 0);
    component InstructionMemory is
        port (
            InstructionAddress: in std_logic_vector(31 downto 0);
            InstructionOut: out  std_logic_vector(31 downto 0)
        );
    end component InstructionMemory;
    component Adder is
        port (
            Adder_input: in std_logic_vector(31 downto 0);
            Adder_output: out std_logic_vector(31 downto 0)
        );
    end component Adder;
    signal Adder_Mux_PCPlus4  : std_logic_vector(31 downto 0); -- Holds result of PC+4
    signal DHU_IFID_Stall   : std_logic;
    signal CHU_IFID_Flush   : std_logic;
    signal IM_IFID_InstIn   : std_logic_vector(31 downto 0); -- 32 bit address for holding the instruction after fetching from IM
    component IF_ID is
        port (
            Clock           : in std_logic;
            IFIDStall       : in std_logic;
            IFIDFlush       : in std_logic;
            -- PC+4
            PCIn         : in std_logic_vector(31 downto 0) ;
            InstructionIn   : in std_logic_vector(31 downto 0) ;
            PCOut        : out std_logic_vector(31 downto 0) ;
            InstructionOut  : out std_logic_vector(31 downto 0)
        );
    end component IF_ID;

    ------------------------------------------ID---------------------------------------------------
    signal IFID_InstOut     : std_logic_vector(31 downto 0) ; -- connect to multiple components
    signal MEMWB_Reg_RegWrite: std_logic;
    signal WB_Reg_WriteData : std_logic_vector(31 downto 0) ;
    signal MEMWB_Reg_TargetReg : std_logic_vector(4 downto 0);
    component Registers is
        port (
            Reg_write: in std_logic; -- output from controller
            Read_reg_1: in std_logic_vector(4 downto 0); -- output instruction[28-24] from instruction memory
            Read_reg_2: in std_logic_vector(4 downto 0); -- output instruction[23-19] from instruction memory
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
    signal IDEX_InstOut : std_logic_vector(31 downto 0) ;
    signal EXMEM_InstOut: std_logic_vector(31 downto 0) ;
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
    component ControlHazardUnit is
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
    end component ControlHazardUnit;
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
    signal Ctrl_IDEX_ALUSrc   : std_logic ;
    signal Ctrl_IDEX_ALUOp    : std_logic_vector(1 downto 0) ;
    signal Ctrl_IDEX_MemRead  : std_logic ;
    signal Ctrl_IDEX_MemWrite : std_logic ;
    signal Ctrl_IDEX_MemToReg : std_logic ;
    signal Ctrl_Mux_RegDst    : std_logic ;
    signal Ctrl_IDEX_RegWrite : std_logic ;
    signal DHU_IDEX_Flush     : std_logic ;
    signal Mux_IDEX_TargetReg : std_logic_vector(4 downto 0) ;
    component ID_EX is
        port (
            Clock           : in std_logic;
            IDEXFlush       : in std_logic;
            IFIDInstIn      : in std_logic_vector(31 downto 0) ;
            TargetRegIn     : in std_logic_vector(4 downto 0) ;
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
            RegWrite        : in std_logic;            

            IDEXInstOut     : out std_logic_vector(31 downto 0) ;
            TargetRegOut    : out std_logic_vector(4 downto 0) ;
            ReadData1Out    : out std_logic_vector(31 downto 0) ;
            ReadData2Out    : out std_logic_vector(31 downto 0) ;
            SignExtendOut   : out std_logic_vector(31 downto 0) ;
            FuctionCodeOut  : out std_logic_vector(8 downto 0) ;

            ALUSrcOut       : out std_logic;
            ALUOpOut        : out std_logic_vector(1 downto 0) ;
            MemReadOut      : out std_logic;
            MemWriteOut     : out std_logic;
            MemToRegOut     : out std_logic;
            RegWriteOut       : out std_logic
        );
    end component ID_EX;

    --------------------------------------EX---------------------------------------------
    signal IDEX_ALU_LeftOp : std_logic_vector(31 downto 0) ;
    signal IDEX_Mux_ReadData2        : std_logic_vector(31 downto 0) ;
    signal IDEX_Mux_Immediate        : std_logic_vector(31 downto 0) ;
    signal IDEX_Mux_ALUSrc : std_logic ;
    signal IDEX_ALUOpOut: std_logic_vector(1 downto 0) ;
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
    signal IDEX_EXMEM_MemRead : std_logic ;
    signal IDEX_EXMEM_MemWrite : std_logic ;
    signal IDEX_EXMEM_MemToReg : std_logic ;
    signal IDEX_EXMEM_RegWrite : std_logic ;
    signal IDEX_EXMEM_TargetReg : std_logic_vector(4 downto 0) ;
    component EX_MEM is
        port (
            Clock           : in std_logic;

            IDEXInstIn      : in std_logic_vector(31 downto 0) ;
            ALUResultIn     : in std_logic_vector(31 downto 0) ;
            ReadData2In     : in std_logic_vector(31 downto 0) ;
            TargetRegIn     : in std_logic_vector(4 downto 0) ; -- from mux of rt&rd

            -- MEM signals
            MemRead         : in std_logic;
            MemWrite        : in std_logic;
            -- WB signals
            MemToReg        : in std_logic;
            RegWrite        : in std_logic;

            EXMEMInstOut    : out std_logic_vector(31 downto 0) ;
            ALUResultOut    : out std_logic_vector(31 downto 0) ;
            ReadData2Out    : out std_logic_vector(31 downto 0) ; -- to DM WriteData
            TargetRegOut    : out std_logic_vector(4 downto 0) ; -- to Reg
            MemReadOut      : out std_logic;
            MemWriteOut     : out std_logic;
            MemToRegOut     : out std_logic;
            RegWriteOut     : out std_logic
        );
    end component EX_MEM;

    -----------------------------------------MEM----------------------------------------------
    signal EXMEM_DM_MemRead : std_logic ;
    signal EXMEM_DM_MemWrite : std_logic ;
    signal EXMEM_MEMWB_ALUResultOut: std_logic_vector(31 downto 0) ;-- connect to DM and MEM_WB
    signal EXMEM_DM_ReadData2Out: std_logic_vector(31 downto 0) ;
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
    signal EXMEM_MEMWB_MemToReg : std_logic ;
    signal EXMEM_MEMWB_RegDst   : std_logic ;
    signal EXMEM_MEMWB_RegWrite : std_logic ;
    signal DM_MEMWB_ReadData    : std_logic_vector(31 downto 0) ;
    signal EXMEM_MEMWB_TargetReg : std_logic_vector(4 downto 0) ;
    -- ALUResultIn from EXMEM_MEMWB_ALUResultOut; FIXME
    component MEM_WB is
        port (
            Clock           : in std_logic;
            ReadDataIn      : in std_logic_vector(31 downto 0) ;
            ALUResultIn     : in std_logic_vector(31 downto 0) ;
            TargetRegIn     : in std_logic_vector(4 downto 0) ;
            RegWrite        : in std_logic;
            -- WB signals
            MemToReg        : in std_logic;
            ReadDataOut     : out std_logic_vector(31 downto 0) ;
            ALUResultOut    : out std_logic_vector(31 downto 0) ;
            TargetRegOut    : out std_logic_vector(4 downto 0) ;
            MemToRegOut     : out std_logic;
            RegWriteOut       : out std_logic
        );
    end component MEM_WB;
    signal MEMWB_MemToRegOut: std_logic; -- Output Control signal from the MEMWB Pipe Regs
    signal MEMWB_Mux_ReadDataOut: std_logic_vector(31 downto 0) ;
    signal MEMWB_Mux_ALUResultOut: std_logic_vector(31 downto 0) ;
    --------------------------------------------WB-------------------------------------------
    signal MUX_DestWriteRegister: std_logic_vector(4 downto 0) ; -- used in ID stage
    signal EX_MUX_Out_ALURightOperand : std_logic_vector(31 downto 0) ; 
    component MuxNBit is
        generic (
            N : integer := 1
        );
        port (
            MuxControlInput : in std_logic;
            MuxInput_1 : in std_logic_vector ( N - 1 downto 0);
            MuxInput_0 : in std_logic_vector ( N - 1 downto 0);
            MuxOutput : out std_logic_vector ( N - 1 downto 0)
        );
    
    end component MuxNBit;
    signal Clock   : std_logic;
    constant TbPeriod : time := 20 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

    signal Mux_IFIDPC_NextAddress: std_logic_vector(31 downto 0) ;
begin
   ----------------------------------------------PORT MAPS-------------------------------------------
    Program_Counter:
        PC port map(
            Clock           => Clock,
            PCStall         => DHU_PC_PCStall,
            PrevInstAddress => Mux_IFIDPC_NextAddress,
            NextInstAddress => PC_IM_NextInstAddress
        );
    Instruction_Fetch:
        InstructionMemory port map(
            InstructionAddress => PC_IM_NextInstAddress,
            InstructionOut => IM_IFID_InstIn
        );
    Instruction_Fetch_Adder:
        Adder port map(
            Adder_input => PC_IM_NextInstAddress,
            Adder_output => Adder_Mux_PCPlus4  
        );
    Instruction_Fetch_Mux:
        MuxNBit generic map( N => 32) port map (
            MuxControlInput => CHU_IFID_Flush,
            MuxInput_0 => Adder_Mux_PCPlus4,
            MuxInput_1 => CHU_Mux_NextAddress,
            MuxOutput => Mux_IFIDPC_NextAddress
        );
    Instruction_Fetch_IFID:
        IF_ID port map(
            Clock => Clock,
            IFIDStall => DHU_IFID_Stall,
            IFIDFlush => CHU_IFID_Flush,
            PCIn => Mux_IFIDPC_NextAddress,
            InstructionIn => IM_IFID_InstIn,
            PCOut => IFID_CHU_PCPlus4,
            InstructionOut => IFID_InstOut
        );
    --TODO move regdst mux to ID
    Instruction_Decode_MUX:
            MuxNBit generic map( N => 5 ) port map(
                MuxControlInput => Ctrl_Mux_RegDst,
                MuxInput_1      => IFID_InstOut(18 downto 14),
                MuxInput_0      => IFID_InstOut(23 downto 19),
                MuxOutput       => Mux_IDEX_TargetReg
            );
    Instruction_Decode_Registers:
        Registers port map(
            Reg_write => MEMWB_Reg_RegWrite,
            Read_reg_1 => IFID_InstOut(28 downto 24),
            Read_reg_2 => IFID_InstOut(23 downto 19),
            Write_register => MEMWB_Reg_TargetReg,
            Write_data => WB_Reg_WriteData,
            Read_data_1 => Reg_IDEX_ReadData1,
            Read_data_2 =>Reg_IDEX_ReadData2
        );
    Control_Path:
        Controller port map(
            opCode => IFID_InstOut(31 downto 29),
            RegDst => Ctrl_Mux_RegDst,
            --Jump   
            --Branch 
            MemRead => Ctrl_IDEX_MemRead,
            MemToReg => Ctrl_IDEX_MemToReg,
            ALUOp   => Ctrl_IDEX_ALUOp,
            MemWrite => Ctrl_IDEX_MemWrite,
            ALUSrc  => Ctrl_IDEX_ALUSrc,
            RegWrite => Ctrl_IDEX_RegWrite
        );
    --TODO
    DHU:
        DataHazardUnit port map(
            Clock     => Clock,
            IFIDInst  => IFID_InstOut,
            IDEXInst  => IDEX_InstOut,
            EXMEMInst => EXMEM_InstOut,
            PCStall   => DHU_PC_PCStall,
            IFIDStall => DHU_IFID_Stall,
            IDEXFlush => DHU_IDEX_Flush
        );
    CHU:
        ControlHazardUnit port map(
            Clock       => Clock,
            ReadData1   => Reg_IDEX_ReadData1,
            ReadData2   => Reg_IDEX_ReadData2,
            PCPlus4     => IFID_CHU_PCPlus4,
            Immediate   => SignExtend_IDEX,
            OpCode      => IFID_InstOut(31 downto 29),
            Funct       => IFID_InstOut(8 downto 0),
            NewPc       => CHU_Mux_NextAddress,
            IFIDFlush   => CHU_IFID_Flush
        );
    Instruction_Decode_SignExtend:
        SignExtend port map(
            SignExtend_in => IFID_InstOut(18 downto 0),
            SignExtend_out=> SignExtend_IDEX
        );
    Instruction_Execute_ID_EX:
        ID_EX port map(
            Clock          => Clock,
            IDEXFlush      => CHU_IFID_Flush,
            IFIDInstIn     => IFID_InstOut(31 downto 0),
            TargetRegIn    => Mux_IDEX_TargetReg,
            ReadData1In    => Reg_IDEX_ReadData1,  
            ReadData2In    => Reg_IDEX_ReadData2,
            SignExtendIn   => SignExtend_IDEX,
            FunctionCodeIn => IFID_InstOut(8 downto 0),
            -- EX signals
            ALUSrc         =>  Ctrl_IDEX_ALUSrc,
            ALUOp          =>  Ctrl_IDEX_ALUOp,
            -- MEM signals
            MemRead        =>  Ctrl_IDEX_MemRead,
            MemWrite       =>  Ctrl_IDEX_MemWrite,
            -- WB signals
            MemToReg       => Ctrl_IDEX_MemToReg,
            RegWrite       => Ctrl_IDEX_RegWrite,
            IDEXInstOut    => IDEX_InstOut,
            TargetRegOut   => IDEX_EXMEM_TargetReg,
            ReadData1Out   => IDEX_ALU_LeftOp,
            ReadData2Out   => IDEX_Mux_ReadData2,
            SignExtendOut  => IDEX_Mux_Immediate,
            FuctionCodeOut => IDEX_ALUCtrl_Funct,
            ALUSrcOut      => IDEX_Mux_ALUSrc,
            ALUOpOut       => IDEX_ALUOpOut,
            MemReadOut     => IDEX_EXMEM_MemRead,
            MemWriteOut    => IDEX_EXMEM_MemWrite,
            MemToRegOut    => IDEX_EXMEM_MemToReg,
            RegWriteOut    => IDEX_EXMEM_RegWrite
            );
--------------------------------------EX---------------------------------------
    Instruction_Execute_ALUControl:
        ALUControl port map(
            Funct           => IDEX_ALUCtrl_Funct,
            ALU_op          => IDEX_ALUOpOut,
            ALUControlFunct => ALUCtrl_ALU_ALUCtrlFunc
            );
    Instruction_Execute_MUX:
        MuxNBit GENERIC MAP( N => 32 ) port map(
            MuxControlInput => IDEX_Mux_ALUSrc,
            MuxInput_1 => IDEX_Mux_Immediate,
            MuxInput_0 => IDEX_Mux_ReadData2,
            MuxOutput  => EX_MUX_Out_ALURightOperand
        );
    Instruction_Execute_ALU:
        ALU port map(
            LeftOperand  => IDEX_ALU_LeftOp,
            RightOperand => EX_MUX_Out_ALURightOperand,
            ALUControl   => ALUCtrl_ALU_ALUCtrlFunc,
            ALUResult    => ALU_EXMEM_ALUResult
          --  Zero         =>   TODO remove
        );
    MemoryRW_EX_MEM:
        EX_MEM port map(
            Clock      => Clock, 
            IDEXInstIn => IDEX_InstOut,
            TargetRegIn => IDEX_EXMEM_TargetReg,
            ALUResultIn => ALU_EXMEM_ALUResult,
            ReadData2In => IDEX_Mux_ReadData2,
            -- MEM controller signals
            MemRead     => IDEX_EXMEM_MemRead, 
            MemWrite    => IDEX_EXMEM_MemWrite,   
            -- WB controller signal
            MemToReg    => IDEX_EXMEM_MemToReg,
            RegWrite    => IDEX_EXMEM_RegWrite, --FIXME
                
            EXMEMInstOut => EXMEM_InstOut,
            TargetRegOut => EXMEM_MEMWB_TargetReg,
            ALUResultOut => EXMEM_MEMWB_ALUResultOut,
            ReadData2Out => EXMEM_DM_ReadData2Out,
            MemReadOut  => EXMEM_DM_MemRead,
            MemWriteOut => EXMEM_DM_MemWrite,
            MemToRegOut => EXMEM_MEMWB_MemToReg,
            RegWriteOut => EXMEM_MEMWB_RegWrite
        );
    MemoryRW_DataMemory:
        DataMemory port map(
            MemRead  => EXMEM_DM_MemRead,-- controller signals
            MemWrite => EXMEM_DM_MemWrite,-- controller signals
            Address  => EXMEM_MEMWB_ALUResultOut,-- Input from ALU
            WriteData=> EXMEM_DM_ReadData2Out,
            ReadData => DM_MEMWB_ReadData-- Output for Write Back
        );
    WriteBack_MEM_WB:
        MEM_WB port map(
            Clock        => Clock, 
            ReadDataIn   => DM_MEMWB_ReadData,
            ALUResultIn  => EXMEM_MEMWB_ALUResultOut,
            TargetRegIn  => EXMEM_MEMWB_TargetReg,
            RegWrite     => EXMEM_MEMWB_RegWrite,
            -- WB signals
            MemToReg     => EXMEM_MEMWB_MemToReg,  
            TargetRegOut => MEMWB_Reg_TargetReg,
            ReadDataOut  => MEMWB_Mux_ReadDataOut,
            ALUResultOut => MEMWB_Mux_ALUResultOut,
            MemToRegOut  => MEMWB_MemToRegOut,
            RegWriteOut  => MEMWB_Reg_RegWrite
        );
    WB_MUX:
        MuxNBit GENERIC MAP( N => 32 ) port map(
            MuxControlInput => MEMWB_MemToRegOut,
            MuxInput_1      => MEMWB_Mux_ReadDataOut,
            MuxInput_0      => MEMWB_Mux_ALUResultOut,
            MuxOutput       => WB_Reg_WriteData
        );

    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clock is really your main clock signal
    Clock <= TbClock;
----------------------------Stimulation Process------------------------------
    Simu : process
    begin

        -- wait for 2 * TbPeriod;
        -- CHU_Mux_NextAddress <= x"00000000";
        -- IFID_CHU_PCPlus4 <= CHU_Mux_NextAddress + 4;

        wait for 6 * TbPeriod;

        TbSimEnded <= '1';
        wait;
    end process ; -- Simu
end architecture ; -- Behavior