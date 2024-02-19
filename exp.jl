function simHP(n_Asites,h_TFDsites,n_meas,nsim)
    mi_l = Vector{Float64}(undef,nsim)
    ci_l = Vector{Float64}(undef,nsim)
    @showprogress for sim in 1:nsim

        inds_ABL, si_ABL = genBellState()
        inds_BRC, si_BRC = genBellState()
        
        inds_A = inds_ABL[1:1]
        inds_C = inds_BRC[1:1]
        inds_BL = inds_ABL[2:2]
        inds_BR = inds_BRC[2:2]

        si = si_ABL * si_BRC

        for i = 2:n_Asites
            inds_An, s_An = genBellState()
            inds_Cn, s_Cn = genBellState()
            inds_A = vcat(inds_A,inds_An[1:1])
            inds_BL = vcat(inds_BL,inds_An[2:2])
            inds_C = vcat(inds_C,inds_Cn[1:1])
            inds_BR = vcat(inds_BR,inds_Cn[2:2])
            si = si * s_An * s_Cn
        end

        for i = 1:h_TFDsites
            inds, s = genBellState()
            inds_BL = vcat(inds_BL,inds[1:1])
            inds_BR = vcat(inds_BR,inds[2:2])
            si = si * s
        end

        s_haar = applyPairHaarS(si,inds_BL,inds_BR)
        sm, inds_ml, inds_mr = randBellMeas(s_haar,inds_BL,inds_BR,n_meas)
        inds_B_kept = uniqueinds(vcat(inds_BL,inds_BR),vcat(inds_ml,inds_mr))
        # cmi_l[sim] = cmiS(sm,inds_A,inds_B_kept,inds_C)
        # cmi_l[sim] = miS(sm,inds_A,inds_C)
        mi_l[sim] = miS(sm,inds_A,inds_C)
        ci_l[sim] = ciS(sm,inds_A,inds_C)
    end
    return mi_l, ci_l
end

function scanNmeasHP(n_Asites,h_TFDsites,n_meas_start,n_meas_end,n_meas_step,nsim)
    n_meas_l = floor.(Int,collect(range(n_meas_start,stop=n_meas_end,step=n_meas_step)))
    n_meas_length = length(n_meas_l)
    mi_ave = Vector{Float64}(undef,n_meas_length)
    mi_std = Vector{Float64}(undef,n_meas_length)
    ci_ave = Vector{Float64}(undef,n_meas_length)
    ci_std = Vector{Float64}(undef,n_meas_length)

    @printf "simulation started"
    for (i,n_meas) in enumerate(n_meas_l)
        mi_l,ci_l = simHP(n_Asites,h_TFDsites,n_meas,nsim)
        mi_ave[i] = mean(mi_l)
        mi_std[i] = std(mi_l)
        ci_ave[i] = mean(ci_l)
        ci_std[i] = std(ci_l)
        # GC.gc()
    end

    return mi_ave,mi_std,ci_ave,ci_std
end

function save1DData(scan_l,cmi_ave_l,cmi_std_l,file_name)
    df = DataFrame()
    df.scan_l = scan_l
    df.cmi_ave_l = cmi_ave_l
    df.cmi_std_l = cmi_std_l
    CSV.write(file_name, df)
end