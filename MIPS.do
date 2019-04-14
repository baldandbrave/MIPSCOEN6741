onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips/Clock
add wave -noupdate /mips/CHU_PC_PrevInstAddress
add wave -noupdate /mips/IM_IFID_InstIn
add wave -noupdate /mips/IFID_InstOut
add wave -noupdate /mips/Reg_IDEX_ReadData1
add wave -noupdate /mips/Reg_IDEX_ReadData2
add wave -noupdate /mips/SignExtend_IDEX
add wave -noupdate /mips/ALUCtrl_ALU_ALUCtrlFunc
add wave -noupdate /mips/IDEX_ALU_LeftOp
add wave -noupdate /mips/EX_MUX_Out_ALURightOperand
add wave -noupdate /mips/ALU_EXMEM_ALUResult
add wave -noupdate /mips/EXMEM_MEMWB_ALUResultOut
add wave -noupdate /mips/WB_Reg_WriteData
add wave -noupdate /mips/MEMWB_Reg_TargetReg
add wave -noupdate /mips/MEMWB_Reg_RegWrite
add wave -noupdate /mips/WB_Reg_WriteData
add wave -noupdate /mips/Instruction_Decode_Registers/Reg_mem(10)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4 ns} {136 ns}
