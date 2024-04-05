#!/bin/zsh
#SBATCH --job-name=2D
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=23:59:59          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --array=0-99
#SBATCH --mail-user=yz4281@princeton.edu

let i=1
let "nAsites=1"
let "nBsites=100*i"
let "nsteps=50*i"
let nstB=1
let nmeas_start=5000
let "nmeas_end=100*i"
let nmeas_step=1
let pertb_start=0.15
let pertb_end=0.25
let pertb_step=0.002

let id=0
let date=240405

echo $nAsites 
echo $nBsites
echo $nsteps
echo $nstB
echo $nmeas_start
echo $nmeas_end
echo $nmeas_step
echo $pertb_start
echo $pertb_end
echo $pertb_step
echo data/${date}/${date}_n${id}_$SLURM_ARRAY_TASK_ID

julia run_scratch1.jl $nAsites $nBsites $nsteps $nstB $nmeas_start $nmeas_end $nmeas_step $pertb_start $pertb_end $pertb_step data/${date}/${date}_n${id}_$SLURM_ARRAY_TASK_ID