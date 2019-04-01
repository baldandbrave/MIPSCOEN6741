onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_controlharzardunit/Clock
add wave -noupdate -radix hexadecimal /tb_controlharzardunit/ReadData1
add wave -noupdate -radix hexadecimal /tb_controlharzardunit/ReadData2
add wave -noupdate -radix hexadecimal /tb_controlharzardunit/PCPlus4
add wave -noupdate -radix hexadecimal /tb_controlharzardunit/Immediate
add wave -noupdate /tb_controlharzardunit/OpCode
add wave -noupdate /tb_controlharzardunit/Funct
add wave -noupdate -radix hexadecimal /tb_controlharzardunit/NewPC
add wave -noupdate /tb_controlharzardunit/IFIDFlush
add wave -noupdate /tb_controlharzardunit/dut/FlushCounter
add wave -noupdate /tb_controlharzardunit/dut/XorResult
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2532020 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 242
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
WaveRestoreZoom {0 ps} {6385664 ps}
