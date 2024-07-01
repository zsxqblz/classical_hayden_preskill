using Distributed
addprocs(10)
@everywhere using SharedArrays
using Dates

@everywhere include("dependencies.jl")
@everywhere include("sim.jl")
@everywhere include("sim_dist.jl")

@sync @distributed for i = 1:254
    nAsites = 4
    nBsites = 100
    nsteps = 350
    nstB = 1000
    nmeas_start = 1
    nmeas_end = nBsites-5
    nmeas_step = 1
    idx_start = 1000

    S_ave_arr = scanMeasCAME(ruleStep,i,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
    save2DData(nstep_l,nmeas_l,S_ave_arr,S_ave_arr,string("data/240611/240611_",idx_start+i))
end