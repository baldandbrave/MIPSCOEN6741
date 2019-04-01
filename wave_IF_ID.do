onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_if_id/dut/PCOut
add wave -noupdate -radix hexadecimal /tb_if_id/dut/InstructionOut
add wave -noupdate -radix hexadecimal /tb_if_id/dut/PCIn
add wave -noupdate -radix hexadecimal /tb_if_id/dut/InstructionIn
add wave -noupdate /tb_if_id/dut/IFIDStall
add wave -noupdate /tb_if_id/dut/IFIDFlush
add wave -noupdate /tb_if_id/dut/Clock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6922347 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {13556809 ps}
