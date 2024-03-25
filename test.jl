include("dependencies.jl")
include("sim.jl")

# generate profile
let 
    run(`clear`)
    nAsites = 1
    nBsites = 500
    nsteps = 200
    # stB = BitArray(rand(Bool,nBsites))
    stB = zeros(Bool,nBsites)

    stTraj = simCA(rule110Step,stB,nAsites,nBsites,nsteps)
    stTraj = Int.(stTraj)
    save2DData(collect(1:(nAsites+nBsites)),collect(1:nsteps),stTraj[:,:,1],stTraj[:,:,2],"data/240303/rule110_OTOC2")
    # measInt = zeros(Int,2^nAsites)
    # for i = 1:2^nAsites
    #     measInt[i] = bitarr_to_int(stTraj[1:2,nsteps,i])
    # end
    # # bitarr_to_int.(stTraj[1:2,nsteps,:])
    # @show measInt, stTraj[1:2,nsteps,1],stTraj[1:2,nsteps,2]
end

# scanNoisyMeas
let 
    run(`clear`)
    i=1
    nAsites = i
    nBsites = 1000
    nsteps = 1000
    nstB = 100
    nmeas_start = 1
    nmeas_end = 1000
    nmeas_step = 1
    pertb_start = 0.0
    pertb_end = 0.5
    pertb_step = 0.01
    idx_start = 4

    S_ave_arr = scanMeasNoisyCAME(rule30NoisyStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)

    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))

    save3DData(nstep_l,nmeas_l,pertb_l,S_ave_arr,string("data/240323/240323_",idx_start+i))
end

# scanNoisyMeasOneDepth
let 
    run(`clear`)
    i=1
    nAsites = i
    nBsites = 1000
    nsteps = 1000
    nstB = 1000
    nmeas_start = 1
    nmeas_end = 500
    nmeas_step = 1
    pertb_start = 0.2
    pertb_end = 0.25
    pertb_step = 0.001
    idx_start = 8

    S_ave_arr = scanRndMeasNoisyCAOneDepth(rule30NoisyStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)

    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))

    save2DData(nmeas_l,pertb_l,S_ave_arr,string("data/240323/240323_",idx_start+i))
end

# scanPertbMeasStag
let 
    run(`clear`)
    i=0
    nAsites = 1+i
    nBsites = 100
    nsteps = 1000
    nstB = 100
    nmeas_start = 1
    nmeas_end = 10
    nmeas_step = 1
    pertb_start = 0
    pertb_end = 0.5
    pertb_step = 0.025
    idx_start = 21

    S_ave_arr, S_std_arr = scanMeasNoisyStagCA(ruleF3StagNoisyStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)

    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nstep_l = floor.(Int,collect(range(1,stop=Int(nsteps/2),step=1)))
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))

    save3DData(nstep_l,nmeas_l,pertb_l,S_ave_arr,S_std_arr,string("data/240219/240219_",idx_start+i))
end

# scanMeas
let 
    run(`clear`)
    for i = 0:9
        nAsites = 1+i
        nBsites = 0
        nsteps = 250
        nstB = 100
        nmeas_start = 1
        nmeas_end = nAsites
        nmeas_step = 1
        idx_start = 31

        S_ave_arr, S_std_arr = scanRndMeasCA(rule60Step,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

        nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
        nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
        save2DData(nstep_l,nmeas_l,S_ave_arr,S_std_arr,string("data/240311/240311_",idx_start+i))
    end
end

# scanMeasStag
let 
    run(`clear`)
    for i = 0:0
        nAsites = 8
        nBsites = 100
        nsteps = 50
        nstB = 1
        nmeas_start = nAsites+5
        nmeas_end = nAsites+5
        nmeas_step = 1
        idx_start = 0

        S_ave_arr, S_std_arr = scanMeasStagCA(rule54StagStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

        nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
        nstep_l = floor.(Int,collect(range(1,stop=Int(nsteps/2),step=1)))
        save2DData(nstep_l,nmeas_l,S_ave_arr,S_std_arr,string("data/240226/240226_",idx_start+i))
    end
end

# scanMeasStag
let 
    run(`clear`)
    for i = 8:8
        nAsites = 1+i
        nBsites = 100
        nsteps = 1000
        nstB = 100
        nmeas_start = 1
        nmeas_end = 10
        nmeas_step = 1
        idx_start = 21

        S_ave_arr, S_std_arr = scanMeasStagCA(ruleF1StagStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

        nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
        nstep_l = floor.(Int,collect(range(1,stop=Int(nsteps/2),step=1)))
        save2DData(nstep_l,nmeas_l,S_ave_arr,S_std_arr,string("data/240214/240214_",idx_start+i))
    end
end

# scanRndMeasStagCA
let 
    run(`clear`)
    i = 0
    # nAsites = 4
    # nBsites = 0
    # nsteps = 1000
    # nstB = 1
    # nmeas_start = 1
    # nmeas_end = nAsites+nBsites
    # nmeas_step = 1
    nAsites = 1
    nBsites = 100
    nsteps = 1000
    nstB = 100
    nmeas_start = 1
    nmeas_end = 10
    nmeas_step = 1
    idx_start = 30

    S_ave_arr, S_std_arr = scanRndMeasStagCA(ruleF3StagStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nstep_l = floor.(Int,collect(range(1,stop=Int(nsteps/2),step=1)))
    save2DData(nstep_l,nmeas_l,S_ave_arr,S_std_arr,string("data/240214/240214_",idx_start+i))
end

# scanRndMeasCA
let 
    run(`clear`)
    for j = 1:4
        for i = 1:10
            nAsites = i
            nBsites = 20*i
            nsteps = 250
            nstB = 100
            nmeas_start = 1
            nmeas_end = nAsites+10
            nmeas_step = 1
            idx_start = 30+10*j

            S_ave_arr, S_std_arr = scanMeasCA(rule110Step,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)

            nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
            nstep_l = floor.(Int,collect(range(1,stop=nsteps,step=1)))
            save2DData(nstep_l,nmeas_l,S_ave_arr,S_std_arr,string("data/240303/240303_",idx_start+i))
        end
    end
end

# check steady state
let
    run(`clear`)
    nAsites = 1
    nBsites = 11
    stB = BitArray(rand(Bool,nBsites))
    nsteps = 2^(nAsites+nBsites)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^(nAsites+nBsites))
    @showprogress for st_num = 0:2^(nAsites+nBsites)-1
        st = Bool.(digits(st_num, base=2,pad=nAsites+nBsites))
        for t = 1:nsteps
            stTraj[:,t,st_num+1] = rule110Step(st,nAsites+nBsites)
            st = stTraj[:,t,st_num+1]
        end
    end
    stTraj = Int.(stTraj)
    save3DData(collect(1:(nAsites+nBsites)),collect(1:nsteps),collect(0:2^(nAsites+nBsites)-1),stTraj,"data/240303/rule110_5")
end

let 
    a = rand(2,10)
    Bool.((sign.(a.-0.5)./2).+0.5)
end