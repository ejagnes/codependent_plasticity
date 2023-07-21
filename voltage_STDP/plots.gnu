working_directory = system('cat plots_folder.txt')."/"

set terminal qt size 1200,500 enhanced font "Arial, 15" persist

set border linewidth 1.5

set key outside top right

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 30

set lmargin at screen 0.12
set logscale x
set xrange [0.1:10]
set yrange [0:250]
set ylabel "{/Symbol D}w (%)" offset 1,0
set xlabel "Depolarisation (mV)"
#set ytics 0.25
#set xtics 1
#set label "excitatory" at screen 0.2,0.32
plot working_directory."data03.dat" u 1:2:3 w filledcu lc rgb "gray" notitle, "" u 1:2 w l lw 3 lc rgb "gray" notitle, "" u 1:3 w l lw 3 lc rgb "gray" notitle, "experimental_data.dat" u 1:2 lc -1 pt 7 title "Experiment"
