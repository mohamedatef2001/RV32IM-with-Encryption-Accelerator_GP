vlib work
vlog -f list.list -mfcu +cover -covercells 
vsim -voptargs=+acc work.ALU_top -cover -classdebug -uvmcontrol=all
add wave /ALU_top/DUT/*
coverage save top.ucdb -onexit -du work.ALU_top
run -all
coverage report -detail -cvg -directive -comments -output fcover_report.txt /ALU_coverage_collector/alu_coverage/cvr_grp
quit -sim
vcover report top.ucdb -details -annotate -all -output alu_rpt.txt