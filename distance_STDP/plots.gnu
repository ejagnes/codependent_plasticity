working_directory = system('cat plots_folder.txt')."/"

set terminal qt size 1024,256 enhanced font "Arial, 15" persist

set size 2.5,1

set linetype 1 lc -1 lw 2
set linetype 2 lc rgb "gray" lw 2

set border linewidth 1.5

set border 1+2
set ytics nomirror out
set xtics nomirror out
unset key

set rmargin 10

set multiplot

set lmargin at screen 0.12
set origin 0,0
set size 0.4,0.95
set xrange [0:50]
set yrange [100:200]
set ylabel "{/Symbol D}w" offset 1,0
set xlabel "{/Symbol D}t"
set ytics 20
set xtics 10
set label "Single synapse" at screen 0.13,0.95
p working_directory."data01.dat" u 1:2 w l lt 1

unset label
set lmargin at screen 0.37
set origin 0.25,0
set size 0.4,0.95
set xrange [0:18]
unset ylabel# "weight (nS)" offset 1,0
set xlabel "Time (mins)"
set format y ''
set xtics 3
set label "Neighbouring synapse" at screen 0.36,0.95
p working_directory."data02.dat" u ($1/60):2 w l lt 1, "" u ($1/60):3 w l lt 2


unset label
set lmargin at screen 0.62
set origin 0.5,0
set size 0.4,0.95
set xrange [0:18]
unset ylabel# "weight (nS)" offset 1,0
set xlabel "Distance ({/Symbol m}m)"
set xtics 3
set label "Neighbouring synapse" at screen 0.61,0.95
p working_directory."data03.dat" u 1:2 w l lt 1, "" u 1:3 w l lt 2

