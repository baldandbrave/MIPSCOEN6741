onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_pc/dut/Clock
add wave -noupdate -radix decimal /tb_pc/dut/PrevInstAddress
add wave -noupdate -radix decimal /tb_pc/dut/PCAddressSignal
add wave -noupdate -radix decimal /tb_pc/dut/NextInstAddress
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {64 ns}
