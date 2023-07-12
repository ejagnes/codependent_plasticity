# Code for simulations with receptive field plasticity -> figure 4

## How to run

On the terminal, execute the file run.sh -> $bash run.sh

Or change the file to executable -> $chmod +x run.sh

and then run it directly -> $./run.sh

It will take approximately 25 mins to run 360 mins of simulation time (more or less depending on your processor). 
The figure will be generated automatically once simulation is over.

You can plot the figure from data already simulated. For that, make sure that the file plots_folder.txt has a single line written (without the quotes): "data01". Then run the gnuplot script for this simulated dataset -> $gnuplot plots.gnu

## Parameters

Parameters for models are in "config.f90" file, in the vector "pr" and other specific variable names. 

## Initial conditions.

Initial conditions are in "initial_conditions.f90" file.

## Questions

Feel free to contact me if you have any questions about the code.
