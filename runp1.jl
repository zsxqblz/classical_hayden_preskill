using Distributed
addprocs(11)
@everywhere using SharedArrays
using Dates

@everywhere include("dependencies.jl")
@everywhere include("sim.jl")
@everywhere include("sim_dist.jl")

# run(`clear`)
for i = 4:4
    @show i
    println("Current date and time: ", now())
    nAsites = i
    nBsites = 100*i
    nsteps = 350*i
    nstB = 100000
    nmeas_start = 1
    nmeas_end = nBsites
    nmeas_step = 1
    pertb_start = 0.20
    pertb_end = 0.21
    pertb_step = 0.001
    idx_start = 1000

    S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr = scanMeasNoisyCAOneMeasDist(rule30NoisyStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)

    nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))

    save2DData(nstep_l,pertb_l,S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr,string("data/240414/240414_",idx_start+i))
end
println("Current date and time: ", now())