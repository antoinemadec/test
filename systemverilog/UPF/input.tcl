database -open waves -into waves.shm -default
probe -create -pwr_mode
probe -create -shm apb_subsystem_top -all -depth all
simvision -input lp_debug.svcf
