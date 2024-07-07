vlib work
vlog -f list.list -mfcu +cover -covercells 
vsim -voptargs=+acc work.DIV_top -cover -classdebug -uvmcontrol=all
add wave /DIV_top/DUT/*
coverage save top.ucdb -onexit -du work.DIV_top
run -all
coverage report -detail -cvg -directive -comments -output fcover_report.txt /DIV_coverage_collector/div_coverage/cvr_grp
quit -sim
vcover report top.ucdb -details -annotate -all -output div_rpt.txt