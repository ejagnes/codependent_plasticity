working_directory = system('cat folder_plots.txt')."/"

set terminal qt size 1024,1024 enhanced font "Arial, 15" persist

set linetype 1 lc rgb "#555555" lw 2
set linetype 2 lc rgb "#de2e26" lw 2
set linetype 3 lc rgb "#3182bd" lw 2


set border linewidth 1.5

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 10

set multiplot

set lmargin at screen 0.12
set origin 0,0
set size 0.5,0.3
set xrange [0:40]
set yrange [0:3]
set ylabel "Normalised weight" offset 1,0
set xlabel "Time (hours)"
set ytics 1.0
set xtics 10
p working_directory."data03.dat" u ($1/3600000):2 w l lt 2 notitle, "" u ($1/3600000):3 w l lt 3 notitle

set lmargin at screen 0.62
set origin 0.5,0
set size 0.5,0.3
set xrange [0:40]
set yrange [0:3]
set ylabel "Normalised weight" offset 1,0
set xlabel "Time (hours)"
set ytics 1.0
set xtics 10
p working_directory."data06.dat" u ($1/3600000):2 w l lt 2 notitle, "" u ($1/3600000):3 w l lt 3 notitle


unset key

set lmargin at screen 0.12
set origin 0,0.35
set size 0.5,0.3
set xrange [0:40]
set yrange [0:20]
set ylabel "E/I" offset 0,0
set xlabel "Time (hours)"
set ytics 10
set xtics 10
p working_directory."data02.dat" u ($1/3600000):($9/$10) w l lt 1 notitle

set lmargin at screen 0.62
set origin 0.5,0.35
set size 0.5,0.3
set xrange [0:40]
set yrange [0:1.5]
set ylabel "E/I" offset 0,0
set xlabel "Time (hours)"
set ytics 0.5
set xtics 10
p working_directory."data05.dat" u ($1/3600000):($9/$10) w l lt 1 notitle, 0.855 lt 3



set lmargin at screen 0.12
set origin 0,0.65
set size 0.5,0.3
set xrange [0:40]
set yrange [0:12]
set ylabel "Firing-rate (Hz)" offset -1,0
set xlabel "Time (hours)"
set ytics 4
set xtics 10
set label "Spike-based E and I" at 8,14
p 7 lt 3, "exc_fixed_point.dat" w l lt 2 dt 2, working_directory."data02.dat" u ($1/3600000):2 w l lt 1 notitle


unset label
set lmargin at screen 0.62
set origin 0.5,0.65
set size 0.5,0.3
set xrange [0:40]
set yrange [0:12]
set ylabel "Firing-rate (Hz)" offset -1,0
set xlabel "Time (hours)"
set ytics 4
set xtics 10
set label "Spike-based E and codependent I" at -1,14
p working_directory."data05.dat" u ($1/3600000):2 w l lt 1 notitle, "exc_fixed_point.dat" w l lt 2 dt 2
