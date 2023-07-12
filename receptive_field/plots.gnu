working_directory = system('cat plots_folder.txt')."/"

set terminal qt size 1024,1024 enhanced font "Arial, 15" persist

set linetype 1 lc rgb "#d95f02" lw 2
set linetype 2 lc rgb "#7570b3" lw 2
set linetype 3 lc rgb "#666666" lw 2
set linetype 4 lc rgb "#66a61e" lw 2
set linetype 5 lc rgb "#e6ab02" lw 2
set linetype 6 lc rgb "#e7298a" lw 2
set linetype 7 lc rgb "#a6761d" lw 2
set linetype 8 lc rgb "#1b9e77" lw 2
set linetype 9 lc rgb "#de2e26" lw 2
set linetype 10 lc rgb "#3182bd" lw 2


set border linewidth 1.5

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 10

set multiplot

set key at screen 0.5,0.3
set lmargin at screen 0.12
set origin 0,0
set size 0.5,0.3
set xrange [0.5:8.5]
set yrange [0:1]
set ylabel "weight (nS)" offset 1,0
set xlabel "pathway"
set ytics 0.25
set xtics 1
set label "excitatory" at screen 0.2,0.32
p working_directory."data09.dat" every :::4::4 u 1:2 w l lt 9 notitle, "" every :::4::4 u 1:2 pt 7 ps 1.5 lt 9 notitle, working_directory."data09.dat" every :::9::9 u 1:2 w l lt 9 dt 2 notitle, "" every :::9::9 u 1:2 pt 6 ps 1.5 lt 9 notitle, keyentry with lp title "1st RF" lt 9 pt 7 ps 1.5, keyentry with lp title "2nd RF" lt 9 pt 6 ps 1.5 dt 2

unset label
set key at screen 1.0,0.3
set lmargin at screen 0.62
set origin 0.5,0
set size 0.5,0.3
set xrange [0.8:8.5]
set yrange [0:1]
set ylabel "weight (nS)" offset 1,0
set xlabel "pathway"
set ytics 0.25
set xtics 1
set label "inhibitory" at screen 0.7,0.31
p working_directory."data09.dat" every :::4::4 u 1:3 w l lt 10 notitle, "" every :::4::4 u 1:3 pt 7 ps 1.5 lt 10 notitle, working_directory."data09.dat" every :::9::9 u 1:3 w l lt 10 dt 2 notitle, "" every :::9::9 u 1:3 pt 6 ps 1.5 lt 10 notitle, keyentry with lp title "1st RF" lt 10 pt 7 ps 1.5, keyentry with lp title "2nd RF" lt 10 pt 6 ps 1.5 dt 2


unset key

unset label
set lmargin at screen 0.12
set origin 0,0.35
set size 1.0,0.3
set xrange [0:360]
set yrange [0:20]
set ylabel "weight (nS)" offset 0,0
set xlabel "time (mins)"
set ytics 6
set xtics 60
set label "inhibitory" at screen 0.45,0.62
p for [i=10:17] working_directory."data06.dat" u ($1/60000):(10*column(i)) w l

unset label
set lmargin at screen 0.12
set origin 0,0.65
set size 0.5,0.3
set xrange [50:51.2]
set yrange [0:2.8]
set ylabel "weight (nS)" offset -1,0
set xlabel "time (seconds)"
set ytics 1
set xtics 0.4
set label "excitatory" at screen 0.45,0.94
p for [i=2:9] working_directory."data06.dat" every ::500::1700 u ($1/1000):(10*column(i)) w l


unset label
set lmargin at screen 0.62
set origin 0.5,0.65
set size 0.5,0.3
set xrange [180.93:180.95]
set yrange [0:2.8]
set ylabel "weight (nS)" offset -1,0
set xlabel "time (mins)"
set ytics 1
set xtics 0.01
p for [i=2:9] working_directory."data06.dat" every ::7300::8600 u ($1/60000):(10*column(i)) w l
