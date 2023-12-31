#!/bin/bash
echo ""
echo "======================================="
echo "=------------- compiling -------------="
echo "=                                     ="
echo "=------------ messages: --------------="
ifx balance_firing_rate.f90 -fast -o exec_sim_balance_firing_rate
echo "======================================="
echo ""
echo "======================================="
echo "=-------------  running  -------------="
echo "=                                     ="
echo "=------------ messages: --------------="
./exec_sim_balance_firing_rate
echo "======================================="
echo ""
echo "======================================="
echo "=------------- plotting  -------------="
echo "=                                     ="
echo "=------------ messages: --------------="
gnuplot plots.gnu
echo "======================================="
echo ""
echo "======================================="
echo "=-------------    done   -------------="
echo "======================================="
echo ""
echo "======================================="
echo "=-------------    bye    -------------="
echo "======================================="

