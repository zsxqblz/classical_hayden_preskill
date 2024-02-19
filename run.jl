using Revise
include("dependencies.jl")
include("functions.jl")
include("exp.jl")
ITensors.disable_warn_order()

let
    run(`clear`)
    for i = 1:3
        n_Asites = 3
        h_TFDsites = 2+i
        nsim = 100
        n_meas_start = 1
        n_meas_end = 2+i+n_Asites
        n_meas_step = 1

        start_idx = 20

        n_meas_l = floor.(Int,collect(range(n_meas_start,stop=n_meas_end,step=n_meas_step)))
        n_meas_length = length(n_meas_l)
        mi_ave,mi_std,ci_ave,ci_std = scanNmeasHP(n_Asites,h_TFDsites,n_meas_start,n_meas_end,n_meas_step,nsim)
        save1DData(n_meas_l,mi_ave,mi_std,string("data/230419/230419_",(start_idx+i),"_mi.csv"))
        save1DData(n_meas_l,ci_ave,ci_std,string("data/230419/230419_",(start_idx+i),"_ci.csv"))
        # @profile scanNmeasHP(h_TFDsites,n_meas_start,n_meas_end,n_meas_step,nsim)
        # Profile.print()
    end
end

let
    h_TFDsites = 7
    nsim = 1000
    n_meas_start = 0
    n_meas_end = h_TFDsites
    n_meas_step = 1

    save_idx = 5

    n_meas_l = floor.(Int,collect(range(n_meas_start,stop=n_meas_end,step=n_meas_step)))
    n_meas_length = length(n_meas_l)
    cmi_ave,cmi_std = scanNmeasHP(h_TFDsites,n_meas_start,n_meas_end,n_meas_step,nsim)
    save1DData(n_meas_l,cmi_ave,cmi_std,string("data/230410/230410_",save_idx))
end

let 
    inds_ABL, si_ABL = genProdState(2)
    so = applyPairHaarS(si_ABL,inds_ABL[1:1],inds_ABL[2:2])
    @show svd(so,inds_ABL[1])
end

let
    run(`clear`)
    is,s = genBellState()
    ik,in,d = partialTraceS(s,is[1:1])
    @show d
    @show ik
    @show in
    U,S,V = svd(d, ik...)
    @show vnEntropy(d,ik)
end

let 
    ones(Int,3)
end