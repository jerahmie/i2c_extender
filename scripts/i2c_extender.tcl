# Assemble the design source files
#
read_verilog ./src/hdl/i2c_extender.v
# read_verilog [ glob ./src/hdl/*.v ]
# read_xdc ./src/top_full.xdc

# Run synthesis and implementation

set outputDir ./output
file mkdir $outputDir 

# synth_design -top top -part xc7s25csga225-1
# opt_design
# route_design
#
# Generate reports
# report_timing_summary -file $outputDir/post_route_timing_summary.rpt
#write_checkpoint -force $outputDir/post_synth
# report_utilizaton -file $outputDir/post_route_util.rpt
# opt_design
# power_opt_design
# place_design
# write_checkpoint -force $outputDir/post_place
# pys_opt_design
# route_design
# write_checkpoint -force $outputDir/post_route
#wite_xdc -no_fixed_only -force $outputDir/top_save.xdc
# Generate Bit File
# write_bitstream ./$outputDir/design.bit
