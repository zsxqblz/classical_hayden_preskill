include("dependencies.jl")
include("sim.jl")

let 
    run(`clear`)
    slurm_id = ARGS[1]
    for nAsites = 1:4
        for i = 1:5
            # nAsites = 1
            nBsites = 100*i
            nsteps = 50*i
            nstB = 100
            nmeas_start = 1
            nmeas_end = nBsites
            nmeas_step = 1
            pertb_start = 0.0
            pertb_end = 0.3
            pertb_step = 0.001
            idx_start = 40+5*(nAsites-1)
            @show nAsites, i

            S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr = scanMeasNoisyCAOneDepth(rule30NoisyStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)

            nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
            pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))

            save2DData(nmeas_l,pertb_l,S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr,string("data/240405/240405_n",slurm_id,"_",idx_start+i))
        end
    end
end