working_directory = system('cat plots_folder.txt')."/"

set terminal qt size 1200,500 enhanced font "Arial, 15" persist

set style line 1 lc -1 lw 4 dt 3
set style line 2 lc rgb "#e7e1ef" lw 2 dt 3
set style line 3 lc rgb "#d4b9da" lw 2 dt 3
set style line 4 lc rgb "#df65b0" lw 2 dt 3
set style line 5 lc rgb "#ce1256" lw 2 dt 3
set style line 6 lc rgb "#67001f" lw 2 dt 3

set style line 11 lc -1 lw 4
set style line 12 lc rgb "#e7e1ef" lw 2
set style line 13 lc rgb "#d4b9da" lw 2
set style line 14 lc rgb "#df65b0" lw 2
set style line 15 lc rgb "#ce1256" lw 2
set style line 16 lc rgb "#67001f" lw 2

set border linewidth 1.5

set key outside top right

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 30

set lmargin at screen 0.12
set xrange [-0.5:50]
#set yrange [0:500]
set ylabel "{/Symbol D}w (%)" offset 1,0
set xlabel "Frequency (Hz)"
#set ytics 0.25
#set xtics 1
#set label "excitatory" at screen 0.2,0.32
plot working_directory."data01.dat" every :::::0 u 1:2 w l ls 1 title "{/Symbol D}t = -10 ms; 0 Hz", "" every :::1::1 u 1:2 w l ls 2 title "10 Hz", "" every :::2::2 u 1:2 w l ls 3 title "20 Hz", "" every :::3::3 u 1:2 w l ls 4 title "40 Hz", "" every :::4::4 u 1:2 w l ls 5 title "80 Hz", "" every :::5::5 u 1:2 w l ls 6 title "160 Hz", working_directory."data01.dat" every :::::0 u 1:3 w l ls 11 title "{/Symbol D}t = +10 ms; 0 Hz", "" every :::1::1 u 1:3 w l ls 12 title "10 Hz", "" every :::2::2 u 1:3 w l ls 13 title "20 Hz", "" every :::3::3 u 1:3 w l ls 14 title "40 Hz", "" every :::4::4 u 1:3 w l ls 15 title "80 Hz", "" every :::5::5 u 1:3 w l ls 16 title "160 Hz", "experimental_data.dat" u 3:1:4 w errorbar lc -1 pt 7 ps 2 lw 4 title "Experiment ({/Symbol D}t = +10 ms)", "experimental_data.dat" u 3:2:5 w errorbar pt 6 ps 2 lw 4 lc rgb "#135ecd" title "Experiment ({/Symbol D}t = -10 ms)"


