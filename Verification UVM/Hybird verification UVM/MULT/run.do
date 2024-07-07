vlib work
vlog -f list.list -mfcu +cover -covercells 
vsim -voptargs=+acc work.MULT_top -cover -classdebug -uvmcontrol=all
add wave /MULT_top/DUT/*
coverage save top.ucdb -onexit -du work.MULT_top
run -all
coverage report -detail -cvg -directive -comments -output fcover_report.txt /MULT_coverage_collector/mult_coverage/cvr_grp
quit -sim
vcover report top.ucdb -details -annotate -all -output mult_rpt.txt