function scanMeasNoisyCAOneMeasDist(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    # nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    # nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)
    
    # S_ave_arr = zeros(nsteps,pertb_length) 
    # S_snd_arr = zeros(nsteps,pertb_length)
    # S_trd_arr = zeros(nsteps,pertb_length)
    # S_fth_arr = zeros(nsteps,pertb_length)
    S_ave_arr = SharedArray{Float64}(nsteps,pertb_length) 
    S_snd_arr = SharedArray{Float64}(nsteps,pertb_length)
    S_trd_arr = SharedArray{Float64}(nsteps,pertb_length)
    S_fth_arr = SharedArray{Float64}(nsteps,pertb_length)
    @sync @distributed for pertb_idx = 1:length(pertb_l)
        pertb = pertb_l[pertb_idx]
        for stB_idx = 1:nstB
            pertbProf = rand(nsteps,nAsites+nBsites)
            pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
            pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
            stB = BitArray(rand(Bool,nBsites))
            stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
            for t = 1:nsteps
                # idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
                # idx_end = idx_start + nmeas - 1
                measInt = Vector{Vector{Bool}}(undef,0)
                for i = 1:2^(nAsites)
                    bitarr = stTraj[:,t,i]
                    push!(measInt,bitarr)
                end
                measOccurance = countOccurance(measInt)
                S_ave_arr[t,pertb_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
                S_snd_arr[t,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^2
                S_trd_arr[t,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^3
                S_fth_arr[t,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^4
            end
        end
    end
    S_ave_arr = S_ave_arr ./ nstB
    S_snd_arr = S_snd_arr ./ nstB
    S_trd_arr = S_trd_arr ./ nstB
    S_fth_arr = S_fth_arr ./ nstB    

    return S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr
end