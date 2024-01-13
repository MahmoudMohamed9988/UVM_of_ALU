vlog pkg.sv
vlog -cover bcs ALU.v 
#vsim -coverage tb_top

#run -all


#coverage report -detail 

# make a directory to store regressions
set date [clock format [clock seconds] -format %a-%b-%d]
set regressionoutputDir [format  "regression_run_%s" $date]
file mkdir $regressionoutputDir

 set alu_testcases [list my_test]


foreach testcases $alu_testcases {
  #run tests n times
 set tests 3
 puts "running $testcases"
 for { set n 0 } { $n < $tests } { incr n } {
  #build unique names for each simulation
	 
	#start the simulation
	vsim -sv_seed $n -onfinish stop -coverage +UVM_TESTNAME=my_test tb_top
	 
	# the variable sv_seed always hold the value of the seed defined
	 
	#set Base [format "run_%s__%d__%d" $testcases $n $Sv_Seed]
	#set log_file [format "%s.log" $Base]
	#set wlf_file [format "%s.wlf" $Base]
	#set debugdb_file [format "%s.db" $Base]
        set UCDB_file [format "%s.ucdb" $Base]
	# ensure that we generate the needed files in the right place
	#set log_filename [file join $regressionoutputDir $log_file]
        #set wlf_filename [file join $regressionoutputDir $wlf_file]
	#set debugdb_filename [file join $regressionoutputDir $debugdb_file]
	set UCDB_filename [file join $regressionoutputDir $UCDB_file]
 
 }

# run the simulation
run -all

# coverage
coverage report -detail
coverage save $UCDB_filename

}