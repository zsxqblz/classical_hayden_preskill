include("dependencies.jl")
include("sim.jl")

const nAsites = parse(Int64,ARGS[1])
const nBsites = parse(Int64,ARGS[2])
const nsteps = parse(Int64,ARGS[3])
const nstB = parse(Int64,ARGS[4])
const nmeas_start = parse(Int64,ARGS[5])
const nmeas_end = parse(Int64,ARGS[6])
const nmeas_step = parse(Int64,ARGS[7])
const file_name = ARGS[8]

S_ave_arr, S_std_arr = scanMeasStagCA(rule54StagStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
nstep_l = floor.(Int,collect(range(1,stop=Int(nsteps/2),step=1)))

save2DData(nstep_l,nmeas_l,S_ave_arr,S_std_arr,file_name)