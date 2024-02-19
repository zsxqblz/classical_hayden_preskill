function prepInds(nsites)
    inds_l = Vector{Index{Int64}}(undef,nsites)
    for i = 1:nsites
        inds_l[i] = Index(2)
    end
    return inds_l
end

function genProdState(nsites::Int64)
    inds_l = prepInds(nsites)
    state = ITensor(ComplexF64,inds_l)
    state[ones(Int64,nsites)...] = 1
    return inds_l,state
end

function genProdState(inds_l::Vector{Index{Int64}})
    nsites = length(inds_l)
    state = ITensor(ComplexF64,inds_l)
    state[ones(Int64,nsites)...] = 1
    return state
end

function genGHZState(nsites)
    inds_l = prepInds(nsites)
    state = ITensor(ComplexF64,inds_l)
    state[ones(Int64,nsites)...] = 1/sqrt(2)
    state[(ones(Int64,nsites)*2)...] = 1/sqrt(2)
    return inds_l,state
end

function genGHZState(inds_l::Vector{Index{Int64}})
    nsites = length(inds_l)
    state = ITensor(ComplexF64,inds_l)
    state[ones(Int64,nsites)...] = 1/sqrt(2)
    state[(ones(Int64,nsites)*2)...] = 1/sqrt(2)
    return state
end

function genBellState()
    return genGHZState(2)
end

function genBellState(inds_l::Vector{Index{Int64}})
    return genGHZState(inds_l)
end

function applyOneHaarS(state,ind_target)
    haar_mat = rand(Haar(2),2)
    ind_haar_k = Index(2)
    haar = ITensor(haar_mat,ind_target,ind_haar_k)
    state_out = state * haar
    return ind_haar_k,state_out
end

function applyHaarS(state,inds_target)
    combi = combiner(inds_target...)
    ind_ci = combinedind(combi)
    combo = combiner(inds_target...)
    ind_co = combinedind(combo)
    dim_haar = 2^length(inds_target)
    haar_mat = rand(Haar(2),dim_haar)
    haar = ITensor(haar_mat,ind_co,ind_ci)
    state_out = state * combi
    state_out = state_out * haar
    state_out = state_out * combo
    return state_out
end

function applyPairHaarS(state,inds_L,inds_R)
    comb_Li = combiner(inds_L...)
    ind_Li = combinedind(comb_Li)
    comb_Lo = combiner(inds_L...)
    ind_Lo = combinedind(comb_Lo)
    comb_Ri = combiner(inds_R...)
    ind_Ri = combinedind(comb_Ri)
    comb_Ro = combiner(inds_R...)
    ind_Ro = combinedind(comb_Ro)

    dim_haar = 2^length(inds_L)
    haar_mat = rand(Haar(2),dim_haar)
    haar_L = ITensor(haar_mat,ind_Lo,ind_Li)
    haar_R = ITensor(conj.(haar_mat),ind_Ro,ind_Ri)
    state_out = state * comb_Li * comb_Ri
    state_out = state_out * haar_L * haar_R
    state_out = state_out * comb_Lo * comb_Ro
    return state_out
end

function measOneSite(state,ind_meas)
    m0 = ITensor(ind_meas)
    m0[1] = 1
    s0 = state * m0
    p0 = real((s0 * dag(s0))[1])
    if rand() < p0
        return s0 / sqrt(p0)
    else
        m1 = ITensor(ind_meas)
        m1[2] = 1
        s1 = state * m1
        return s1 / sqrt(1-p0)
    end
end

function bellProj(state,ind_l,ind_r,type=0)
    if type == 0
        m0 = ITensor(ind_l,ind_r)
        m0[1,1] = 1/sqrt(2)
        m0[2,2] = 1/sqrt(2)
        so = state * m0
    elseif type == 1
        mx = ITensor(ind_l,ind_r)
        mx[1,2] = 1/sqrt(2)
        mx[2,1] = 1/sqrt(2)
        so = state * mx
    elseif type == 2
        my = ITensor(ind_l,ind_r)
        my[1,2] = -1im/sqrt(2)
        my[2,1] = 1im/sqrt(2)
        so = state * my
    else
        mz = ITensor(ind_l,ind_r)
        mz[1,1] = 1/sqrt(2)
        mz[2,2] = -1/sqrt(2)
        so = state * mz
    end

    po = real((so * dag(so))[1])
    so = so / sqrt(po)
    return so,po
end

function bellMeas(state,ind_l,ind_r)
    m0 = ITensor(ind_l,ind_r)
    m0[1,1] = 1/sqrt(2)
    m0[2,2] = 1/sqrt(2)
    s0 = state * m0
    p0 = real((s0 * dag(s0))[1])
    p = rand()
    if p < p0
        # @show '0'
        return s0 / sqrt(p0)
    end

    mx = ITensor(ind_l,ind_r)
    mx[1,2] = 1/sqrt(2)
    mx[2,1] = 1/sqrt(2)
    sx = state * mx
    px = real((sx * dag(sx))[1])
    if p < p0 + px
        # @show 'x'
        return sx / sqrt(px)
    end

    my = ITensor(ind_l,ind_r)
    my[1,2] = -1im/sqrt(2)
    my[2,1] = 1im/sqrt(2)
    sy = state * my
    py = real((sy * dag(sy))[1])
    if p < p0 + px + py
        # @show 'y'
        return sy / sqrt(py)
    end

    mz = ITensor(ind_l,ind_r)
    mz[1,1] = 1/sqrt(2)
    mz[2,2] = -1/sqrt(2)
    sz = state * mz
    pz = real((sz * dag(sz))[1])
    # @show 'z'
    return sz / sqrt(pz)
end

function randMeas(state,inds_target,nmeas)
    inds_meas = sample(inds_target,nmeas,replace=false)
    state_out = copy(state)
    for ind_meas in inds_meas
        state_out = measOneSite(state_out,ind_meas)
    end
    return state_out
end

function randBellMeas(state,inds_l,inds_r,nmeas)
    idx_inds_meas = sample(collect(1:length(inds_l)),nmeas,replace=false)
    state_out = copy(state)
    inds_l_meas = Vector{Index{Int64}}(undef,length(idx_inds_meas))
    inds_r_meas = Vector{Index{Int64}}(undef,length(idx_inds_meas))
    for (i,idx) in enumerate(idx_inds_meas)
        state_out = bellMeas(state_out,inds_l[idx],inds_r[idx])
        inds_l_meas[i] = inds_l[idx]
        inds_r_meas[i] = inds_r[idx]
    end
    return state_out, inds_l_meas, inds_r_meas
end

function partialTraceS(state,inds_kept)
    kstate = copy(state)
    bstate = dag(kstate)
    inds_new = Vector{Index{Int64}}(undef,length(inds_kept))
    for (i,ind) in enumerate(inds_kept)
        n = Index(2)
        inds_new[i] = n
        del = delta(ind,n)
        kstate = kstate * del
    end

    rdmat = bstate * kstate
    return inds_kept, inds_new, rdmat
end

# function partialTraceD(dmat,inds_k,inds_b,inds_target)
#     inds_newb = Vector{Index{Int64}}(undef,length(inds_target))
#     inds_newk = Vector{Index{Int64}}(undef,length(inds_target))
#     for (i,ind) in enumerate(inds_target)
#         n = Index(2)
#         inds_new[i] = n
#         del = delta(ind,n)
#         kstate = kstate * del
#     end

#     rdmat = bstate * kstate
#     return inds_target, inds_new, rdmat
# end

function vnEntropy(dmat,inds_l)
    # U, S, V = svd(dmat,inds_l...,cutoff=0.1/(2^length(inds_l)))
    U, S, V = svd(dmat,inds_l...)
    # dmat_arr = Array()

    entropy = 0
    for idx in eachindval(inds(S))
        if abs(S[idx...]) < 1e-10
            # @show idx
            continue
        else
            entropy = entropy - S[idx...]*log2(S[idx...])
        end
        # @show entropy
    end
    return entropy

    # return -log((dmat * dag(dmat))[1])
end

function cmiS(state,inds_A,inds_B,inds_C)
    inds_AB, inds_ABd, dmatAB = partialTraceS(state,vcat(inds_A,inds_B))
    SAB = vnEntropy(dmatAB,inds_AB)
    inds_BC, inds_BCd, dmatBC = partialTraceS(state,vcat(inds_B,inds_C))
    SBC = vnEntropy(dmatBC,inds_BC)
    inds_B, inds_Bd, dmatB = partialTraceS(state,vcat(inds_B))
    SB = vnEntropy(dmatB,inds_B)
    # inds_ABC, inds_ABCd, dmatABC = partialTraceS(state,vcat(inds_A,inds_B,inds_C))
    # SABC = vnEntropy(dmatABC,inds_ABC)
    # return SAB + SBC - SB - SABC
    return SAB + SBC - SB
end

function miS(state,inds_A,inds_C)
    inds_rA, inds_rAd, dmatA = partialTraceS(state,vcat(inds_A))
    SA = vnEntropy(dmatA,inds_rA)
    inds_rC, inds_rCd, dmatC = partialTraceS(state,vcat(inds_C))
    SC = vnEntropy(dmatC,inds_rC)
    inds_rAC, inds_rACd, dmatAC = partialTraceS(state,vcat(inds_A,inds_C))
    SAC = vnEntropy(dmatAC,inds_rAC)
    return SA + SC - SAC
end

function ciS(state,inds_A,inds_C)
    inds_rC, inds_rCd, dmatC = partialTraceS(state,vcat(inds_C))
    SC = vnEntropy(dmatC,inds_rC)
    inds_rAC, inds_rACd, dmatAC = partialTraceS(state,vcat(inds_A,inds_C))
    SAC = vnEntropy(dmatAC,inds_rAC)
    return SC - SAC
end

function bellFidelityS(state,inds_A,inds_C)
    inds_rAC, inds_rACd, dmatAC = partialTraceS(state,vcat(inds_A,inds_C))
    for i = 1:length(inds_A)
        dmatAC = dmatAC * delta(inds_rAC[i],inds_rAC[i+length(inds_A)])
        dmatAC = dmatAC * delta(inds_rACd[i],inds_rACd[i+length(inds_A)])
    end

    return dmatAC[1] / (2^length(inds_A))
end