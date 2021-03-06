#!/bin/bash
# Copyright (c) 2014-2018 ETH Zurich, University of Bologna
#
# Copyright and related rights are licensed under the Solderpad Hardware
# License, Version 0.51 (the "License"); you may not use this file except in
# compliance with the License.  You may obtain a copy of the License at
# http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
# or agreed to in writing, software, hardware and materials distributed under
# this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#
# Fabian Schuiki <fschuiki@iis.ee.ethz.ch>
# Andreas Kurth  <akurth@iis.ee.ethz.ch>

set -e

[ ! -z "$VSIM" ] || VSIM=vsim

bender script vsim -t test \
    --vlog-arg="-svinputport=compat" \
    --vlog-arg="-override_timescale 1ns/1ps" \
    --vlog-arg="-suppress 2583" \
    > compile.tcl
echo 'return 0' >> compile.tcl
$VSIM -c -do 'exit -code [source compile.tcl]'
