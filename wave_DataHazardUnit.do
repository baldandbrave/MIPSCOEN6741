onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dataharzardunit/Clock
add wave -noupdate /tb_dataharzardunit/IFIDInst
add wave -noupdate /tb_dataharzardunit/IDEXInst
add wave -noupdate /tb_dataharzardunit/EXMEMInst
add wave -noupdate /tb_dataharzardunit/PCStall
add wave -noupdate /tb_dataharzardunit/IFIDStall
add wave -noupdate /tb_dataharzardunit/IDEXFlush
add wave -noupdate /tb_dataharzardunit/dut/IDEXRd
add wave -noupdate /tb_dataharzardunit/dut/EXMEMRd
add wave -noupdate /tb_dataharzardunit/dut/IFIDRs
add wave -noupdate /tb_dataharzardunit/dut/IFIDRt
add wave -noupdate /tb_dataharzardunit/dut/XorResult1
add wave -noupdate /tb_dataharzardunit/dut/XorResult2
add wave -noupdate /tb_dataharzardunit/dut/XorResult3
add wave -noupdate /tb_dataharzardunit/dut/XorResult4
add wave -noupdate /tb_dataharzardunit/dut/StallCounter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3601686 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
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
WaveRestoreZoom {1043427 ps} {7527403 ps}
