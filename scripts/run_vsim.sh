#!/bin/bash
# Copyright (c) 2018 ETH Zurich, University of Bologna
# All rights reserved.
#
# This code is under development and not yet released to the public.
# Until it is released, the code is under the copyright of ETH Zurich and
# the University of Bologna, and may contain confidential and/or unpublished
# work. Any reuse/redistribution is strictly forbidden without written
# permission from ETH Zurich.
#
# Fabian Schuiki <fschuiki@iis.ee.ethz.ch>

set -e
ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

[ ! -z "$VSIM" ] || VSIM=vsim

call_vsim() {
	echo "run -all" | $VSIM "$@" | tee vsim.log 2>&1
	grep "Errors: 0," vsim.log
}

# for DW in 8 16 32 64 128 256 512 1024; do
# 	call_vsim tb_axi_lite_to_axi -GDW=$DW -t 1ps -c
# 	call_vsim tb_axi_to_axi_lite -GDW=$DW -t 1ps -c
# done

test_axi_lite_xbar() {
	call_vsim tb_axi_lite_xbar -GNUM_MASTER=$1 -GNUM_SLAVE=$2 -t 1ps -c
}

# regression test cases
test_axi_lite_xbar 1 1
# test_axi_lite_xbar 4 9 # This seems to be a bug in ModelSim!

for NM in 1 2 3 4 8; do
	test_axi_lite_xbar $NM 4
done

for NS in 1 2 3 4 8; do
	test_axi_lite_xbar 4 $NS
done
