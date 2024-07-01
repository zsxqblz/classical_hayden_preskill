include("dependencies.jl")
include("sim.jl")

const nAsites = parse(Int64,ARGS[1])
const nBsites = parse(Int64,ARGS[2])
const nsteps = parse(Int64,ARGS[3])
const nstB = parse(Int64,ARGS[4])
const nmeas_start = parse(Int64,ARGS[5])
const nmeas_end = parse(Int64,ARGS[6])
const nmeas_step = parse(Int64,ARGS[7])
const pertb_start = parse(Float64,ARGS[8])
const pertb_end = parse(Float64,ARGS[9])
const pertb_step = parse(Float64,ARGS[10])
const file_name = ARGS[11]

S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr = scanMeasNoisyCAOneDepth(rule30NoisyStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)

nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
# nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))

# save3DData(nstep_l,nmeas_l,pertb_l,S_ave_arr,file_name)
save2DData(nmeas_l,pertb_l,S_ave_arr,S_snd_arr,S_trd_arr,S_fth_arr,file_name)