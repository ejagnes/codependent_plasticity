working_directory = system('cat plots_folder.txt')."/"

set terminal qt size 800,500 enhanced font "Arial, 15" persist

set border linewidth 1.5
unset key

set border 1+2
set ytics nomirror out
set xtics nomirror out

#set rmargin 30

set lmargin at screen 0.12
set xrange [0:1]
set yrange [-1:1]
set ylabel "Clustering index" offset 1,0
set xlabel "Co-active group (%)"
set ytics 0.5
set xtics 0.5
plot working_directory."data01.dat" u ($1/32):2 w l lw 2 lc -1
