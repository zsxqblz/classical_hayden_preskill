include("dependencies.jl")
include("sim.jl")

run(`clear`)
for i = 1:10
    nAsites = i
    nBsites = 100
    nsteps = 100
    nstB = 100
    nmeas_start = 1
    nmeas_end = nBsites-5
    nmeas_step = 1
    idx_start = 0

    S_ave_arr = scanMeasCAME(rule30Step,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
    save2DData(nstep_l,nmeas_l,S_ave_arr,string("data/240329/240329_",idx_start+i))
end