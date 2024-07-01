function bitarr_to_int(arr,s=0)
    v = 1
    for i in view(arr,length(arr):-1:1)
        s += v*i
        v <<= 1
    end 
    s
end

function countOccurance(A)
    return [count(==(i), A) for i in unique(A)]
end

function ruleStep(ruleID,st,len)
    ruleBit = reverse(digits(ruleID, base=2, pad=8))
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = (ruleBit[1] == 1)
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = (ruleBit[2] == 1)
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = (ruleBit[3] == 1)
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = (ruleBit[4] == 1)
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = (ruleBit[5] == 1)
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = (ruleBit[6] == 1)
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = (ruleBit[7] == 1)
        else
            new_st[i] = (ruleBit[8] == 1)
        end
    end
    return new_st
end

function rule54Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = false
        end
    end
    return new_st
end

function rule19Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = true
        end
    end
    return new_st
end

function rule14Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        else
            new_st[i] = true
        end
    end
    return new_st
end


function rule54StagStep(stTraj,t,len)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    else
        for i in 1:len
            if stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    end
    return new_st
end

function rule30StagStep(stTraj,t,len)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    else
        for i in 1:len
            if stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    end
    return new_st
end

function rule30StagNoisyStep(stTraj,t,len,pertb)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if pertb[i] != 0
                new_st[i] = sign(pertb[i])==+1
            elseif stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    else
        for i in 1:len
            if pertb[i] != 0
                new_st[i] = sign(pertb[i])==+1
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    end
    return new_st
end

function ruleF1StagStep(stTraj,t,len)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[i,t-1] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif !stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = stTraj[i,t-2]
            else
                new_st[i] = stTraj[i,t-2]
            end
        end
    else
        for i in 1:len
            if stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = stTraj[i,t-2]
            else
                new_st[i] = stTraj[i,t-2]
            end
        end
    end
    return new_st
end

function ruleF2StagStep(stTraj,t,len)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[i,t-1] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = stTraj[i,t-2]
            elseif !stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = stTraj[i,t-2]
            else
                new_st[i] = !stTraj[i,t-2]
            end
        end
    else
        for i in 1:len
            if stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-1]
                new_st[i] = stTraj[i,t-2]
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = stTraj[i,t-2]
            else
                new_st[i] = !stTraj[i,t-2]
            end
        end
    end
    return new_st
end

function ruleF3StagStep(stTraj,t,len)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[i,t-1] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = stTraj[i,t-2]
            elseif !stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            else
                new_st[i] = !stTraj[i,t-2]
            end
        end
    else
        for i in 1:len
            if stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-1]
                new_st[i] = stTraj[i,t-2]
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            else
                new_st[i] = !stTraj[i,t-2]
            end
        end
    end
    return new_st
end

function ruleF3StagNoisyStep(stTraj,t,len,pertb)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if pertb[i] != 0
                new_st[i] = sign(pertb[i])==+1
            elseif stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[i,t-1] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = stTraj[i,t-2]
            elseif !stTraj[i,t-1] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = !stTraj[i,t-2]
            else
                new_st[i] = !stTraj[i,t-2]
            end
        end
    else
        for i in 1:len
            if pertb[i] != 0
                new_st[i] = sign(pertb[i])==+1
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-1]
                new_st[i] = stTraj[i,t-2]
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-1]
                new_st[i] = !stTraj[i,t-2]
            else
                new_st[i] = !stTraj[i,t-2]
            end
        end
    end
    return new_st
end

function rule54StagPertbStep(stTraj,t,len,pertb)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
            new_st[i] = new_st[i] ⊻ pertb[i]
        end
    else
        for i in 1:len
            if stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
            new_st[i] = new_st[i] ⊻ pertb[i]
        end
    end
    return new_st
end

function rule54StagNoisyStep(stTraj,t,len,pertb)
    new_st = zeros(Bool,len)
    if mod(t,2)==1
        for i in 1:len
            if pertb[i] != 0
                new_st[i] = sign(pertb[i])==+1
            elseif stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif stTraj[i,t-1] && !stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = false
            elseif !stTraj[i,t-1] && stTraj[i,t-2] && !stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            elseif !stTraj[i,t-1] && !stTraj[i,t-2] && stTraj[mod1(i+1,len),t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    else
        for i in 1:len
            if pertb[i] != 0
                new_st[i] = sign(pertb[i])==+1
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = false
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            elseif stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = false
            elseif !stTraj[mod1(i-1,len),t-1] && stTraj[i,t-2] && !stTraj[i,t-1]
                new_st[i] = true
            elseif !stTraj[mod1(i-1,len),t-1] && !stTraj[i,t-2] && stTraj[i,t-1]
                new_st[i] = true
            else
                new_st[i] = false
            end
        end
    end
    return new_st
end

function rule30Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = false
        end
    end
    return new_st
end

function rule30OBCStep(st,len)
    new_st = zeros(Bool,len)
    # left zero boundary
    i = 1
    if st[i] && st[mod1(i+1,len)]
        new_st[i] = true
    elseif st[i] && !st[mod1(i+1,len)]
        new_st[i] = true
    elseif !st[i] && st[mod1(i+1,len)]
        new_st[i] = true
    elseif !st[i] && !st[mod1(i+1,len)]
        new_st[i] = false
    end

    for i in 2:len-1
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = false
        end
    end
    # right zero boundary
    i = len-1
    if st[i] && st[mod1(i+1,len)]
        new_st[i] = false
    elseif st[i] && !st[mod1(i+1,len)]
        new_st[i] = false
    elseif !st[i] && st[mod1(i+1,len)]
        new_st[i] = true
    elseif !st[i] && !st[mod1(i+1,len)]
        new_st[i] = false
    end

    return new_st
end

function rule45Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        else
            new_st[i] = true
        end
    end
    return new_st
end

function rule60Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        else
            new_st[i] = false
        end
    end
    return new_st
end

function rule60NoisyStep(st,len,pertb)
    new_st = zeros(Bool,len)
    for i in 1:len
        if pertb[i] != 0
            new_st[i] = sign(pertb[i])==+1
        elseif st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        else
            new_st[i] = false
        end
    end
    return new_st
end

function rule30NoisyStep(st,len,pertb)
    new_st = zeros(Bool,len)
    for i in 1:len
        if pertb[i] != 0
            new_st[i] = sign(pertb[i])==+1
        elseif st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = false
        end
    end
    return new_st
end

function rule110Step(st,len)
    new_st = zeros(Bool,len)
    for i in 1:len
        if st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = false
        end
    end
    return new_st
end

function rule110NoisyStep(st,len,pertb)
    new_st = zeros(Bool,len)
    for i in 1:len
        if pertb[i] != 0
            new_st[i] = sign(pertb[i])==+1
        elseif st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = false
        elseif st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif st[mod1(i-1,len)] && !st[i] && !st[mod1(i+1,len)]
            new_st[i] = false
        elseif !st[mod1(i-1,len)] && st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && st[i] && !st[mod1(i+1,len)]
            new_st[i] = true
        elseif !st[mod1(i-1,len)] && !st[i] && st[mod1(i+1,len)]
            new_st[i] = true
        else
            new_st[i] = false
        end
    end
    return new_st
end

function simCA(ruleStep,stB,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^nAsites)
    for stA_num = 0:2^nAsites-1
        stA = Bool.(digits(stA_num, base=2,pad=nAsites))
        st = vcat(stA, stB)
        for t = 1:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(st,nAsites+nBsites)
            st = stTraj[:,t,stA_num+1]
        end
    end
    return stTraj
end

function simCA(ruleStep,ruleID,stB,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^nAsites)
    for stA_num = 0:2^nAsites-1
        stA = Bool.(digits(stA_num, base=2,pad=nAsites))
        st = vcat(stA, stB)
        for t = 1:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(ruleID,st,nAsites+nBsites)
            st = stTraj[:,t,stA_num+1]
        end
    end
    return stTraj
end

function simPertbCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^nAsites)
    for stA_num = 0:2^nAsites-1
        stA = Bool.(digits(stA_num, base=2,pad=nAsites))
        st = vcat(stA, stB)
        for t = 1:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(st,nAsites+nBsites,pertbProf[t,:])
            st = stTraj[:,t,stA_num+1]
        end
    end
    return stTraj
end

function simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^nAsites)
    for stA_num = 0:2^nAsites-1
        stA = Bool.(digits(stA_num, base=2,pad=nAsites))
        st = vcat(stA, stB)
        for t = 1:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(st,nAsites+nBsites,pertbProf[t,:])
            st = stTraj[:,t,stA_num+1]
        end
    end
    return stTraj
end

function simStagCA(ruleStep,stB1,stB2,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^(2*nAsites))
    for stA_num1 = 0:2^nAsites-1, stA_num2 = 0:2^nAsites-1
        stA_num = stA_num1 + 2^nAsites*stA_num2
        stA1 = Bool.(digits(stA_num1, base=2,pad=nAsites))
        stA2 = Bool.(digits(stA_num2, base=2,pad=nAsites))
        stTraj[:,1,stA_num+1] = vcat(stA1, stB1)
        stTraj[:,2,stA_num+1] = vcat(stA2, stB2)
        for t = 3:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(stTraj[:,:,stA_num+1],t,nAsites+nBsites)
            # if sum(stTraj[:,t,stA_num+1]) == 0
            #     @show stTraj[:,t,stA_num+1]
            #     throw(error())
            # end
        end
    end
    return stTraj
end

function simStagPertbCA(ruleStep,stB1,stB2,pertbProf,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^(2*nAsites))
    for stA_num1 = 0:2^nAsites-1, stA_num2 = 0:2^nAsites-1
        stA_num = stA_num1 + 2^nAsites*stA_num2
        stA1 = Bool.(digits(stA_num1, base=2,pad=nAsites))
        stA2 = Bool.(digits(stA_num2, base=2,pad=nAsites))
        stTraj[:,1,stA_num+1] = vcat(stA1, stB1)
        stTraj[:,2,stA_num+1] = vcat(stA2, stB2)
        for t = 3:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(stTraj[:,:,stA_num+1],t,nAsites+nBsites,pertbProf[t,:])
            # if sum(stTraj[:,t,stA_num+1]) == 0
            #     @show stTraj[:,t,stA_num+1]
            #     throw(error())
            # end
        end
    end
    return stTraj
end

function simStagNoisyCA(ruleStep,stB1,stB2,pertbProf,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^(2*nAsites))
    for stA_num1 = 0:2^nAsites-1, stA_num2 = 0:2^nAsites-1
        stA_num = stA_num1 + 2^nAsites*stA_num2
        stA1 = Bool.(digits(stA_num1, base=2,pad=nAsites))
        stA2 = Bool.(digits(stA_num2, base=2,pad=nAsites))
        stTraj[:,1,stA_num+1] = vcat(stA1, stB1)
        stTraj[:,2,stA_num+1] = vcat(stA2, stB2)
        for t = 3:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(stTraj[:,:,stA_num+1],t,nAsites+nBsites,pertbProf[t,:])
            # if sum(stTraj[:,t,stA_num+1]) == 0
            #     @show stTraj[:,t,stA_num+1]
            #     throw(error())
            # end
        end
    end
    return stTraj
end

function simStagProbCA(ruleStep,stB,nAsites,nBsites,nsteps)
    stTraj = zeros(Bool,nAsites+nBsites,nsteps,2^nAsites)
    for stA_num = 0:2^nAsites-1
        stA = Bool.(digits(stA_num, base=2,pad=nAsites))
        # stTraj[:,1,stA_num+1] = vcat(stA, stB)
        stTraj[:,2,stA_num+1] = vcat(stA, stB)
        for t = 3:nsteps
            stTraj[:,t,stA_num+1] = ruleStep(stTraj[:,:,stA_num+1],t,nAsites+nBsites)
            # if sum(stTraj[:,t,stA_num+1]) == 0
            #     @show stTraj[:,t,stA_num+1]
            #     throw(error())
            # end
        end
    end
    return stTraj
end

function scanMeasCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(nsteps,nmeas_length,nstB)
    @showprogress for stB_idx = 1:nstB
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simCA(ruleStep,stB,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            # measInt = zeros(Int,2^nAsites)
            # for i = 1:2^nAsites
            #     measInt[i] = bitarr_to_int(stTraj[idx_start:idx_end,t,i])
            # end
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,end,i]
                push!(measInt,bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx,stB_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = zeros(nsteps,nmeas_length)
    S_std_arr = zeros(nsteps,nmeas_length)
    for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
        S_ave_arr[t,meas_idx] = mean(S_arr[t,meas_idx,:])
        S_std_arr[t,meas_idx] = std(S_arr[t,meas_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanMeasCA(ruleStep,ruleID,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(nsteps,nmeas_length,nstB)
    @showprogress for stB_idx = 1:nstB
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simCA(ruleStep,ruleID,stB,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            # measInt = zeros(Int,2^nAsites)
            # for i = 1:2^nAsites
            #     measInt[i] = bitarr_to_int(stTraj[idx_start:idx_end,t,i])
            # end
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,end,i]
                push!(measInt,bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx,stB_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = zeros(nsteps,nmeas_length)
    S_std_arr = zeros(nsteps,nmeas_length)
    for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
        S_ave_arr[t,meas_idx] = mean(S_arr[t,meas_idx,:])
        S_std_arr[t,meas_idx] = std(S_arr[t,meas_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanMeasCAME(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(nsteps,nmeas_length)
    @showprogress for stB_idx = 1:nstB
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simCA(ruleStep,stB,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            # measInt = zeros(Int,2^nAsites)
            # for i = 1:2^nAsites
            #     measInt[i] = bitarr_to_int(stTraj[idx_start:idx_end,t,i])
            # end
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,t,i]
                push!(measInt,bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = S_arr / nstB

    return S_ave_arr
end

function scanMeasCAME(ruleStep,ruleID,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(nsteps,nmeas_length)
    @showprogress for stB_idx = 1:nstB
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simCA(ruleStep,ruleID,stB,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            # measInt = zeros(Int,2^nAsites)
            # for i = 1:2^nAsites
            #     measInt[i] = bitarr_to_int(stTraj[idx_start:idx_end,t,i])
            # end
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,t,i]
                push!(measInt,bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = S_arr / nstB

    return S_ave_arr
end

function scanMeasStagCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length,nstB)
    @showprogress for stB_idx = 1:nstB
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagCA(ruleStep,stB1,stB2,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            # measInt = zeros(Int,2^(2*nAsites))
            # for i = 1:2^(2*nAsites)
            #     bitarr1 = stTraj[idx_start:idx_end,t-1,i]
            #     bitarr2 = stTraj[idx_start:idx_end,t,i]
            #     measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            # end
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[idx_start:idx_end,t-1,i]
                bitarr2 = stTraj[idx_start:idx_end,t,i]
                push!(measInt,vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx,stB_idx] += -dot(measOccurance./2^(2*nAsites), log2.(measOccurance)) + 2*nAsites
        end
    end

    S_ave_arr = zeros(Int(nsteps/2),nmeas_length)
    S_std_arr = zeros(Int(nsteps/2),nmeas_length)
    for  t = 1:Int(nsteps/2), (meas_idx, nmeas) in enumerate(nmeas_l)
        S_ave_arr[t,meas_idx] = mean(S_arr[t,meas_idx,:])
        S_std_arr[t,meas_idx] = std(S_arr[t,meas_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanMeasStagCAME(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length)
    @showprogress for stB_idx = 1:nstB
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagCA(ruleStep,stB1,stB2,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            measInt = zeros(Int,2^(2*nAsites))
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[idx_start:idx_end,t-1,i]
                bitarr2 = stTraj[idx_start:idx_end,t,i]
                measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx] += -dot(measOccurance./2^(2*nAsites), log2.(measOccurance)) + 2*nAsites
        end
        GC.gc()
    end

    return S_arr / nstB
end

function scanMeasPertbStagCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length,nstB)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Bool.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagPertbCA(ruleStep,stB1,stB2,pertbProf,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            measInt = zeros(Int,2^(2*nAsites))
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[idx_start:idx_end,t-1,i]
                bitarr2 = stTraj[idx_start:idx_end,t,i]
                measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx,pertb_idx,stB_idx] += -dot(measOccurance./2^(2*nAsites), log2.(measOccurance)) + 2*nAsites
        end
    end

    S_ave_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    S_std_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    for  (pertb_idx,pertb) in enumerate(pertb_l), (meas_idx, nmeas) in enumerate(nmeas_l), t = 1:Int(nsteps/2)
        S_ave_arr[t,meas_idx,pertb_idx] = mean(S_arr[t,meas_idx,pertb_idx,:])
        S_std_arr[t,meas_idx,pertb_idx] = std(S_arr[t,meas_idx,pertb_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanRndMeasPertbStagCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length,nstB)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Bool.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagPertbCA(ruleStep,stB1,stB2,pertbProf,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            meas_site_idx = sample(collect(1:(nAsites+nBsites)),nmeas,replace=false)
            measInt = zeros(Int,2^(2*nAsites))
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[meas_site_idx,t-1,i]
                bitarr2 = stTraj[meas_site_idx,t,i]
                measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx,pertb_idx,stB_idx] += -mean(log2.(measOccurance)) + 2*nAsites
        end
    end

    S_ave_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    S_std_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    for  (pertb_idx,pertb) in enumerate(pertb_l), (meas_idx, nmeas) in enumerate(nmeas_l), t = 1:Int(nsteps/2)
        S_ave_arr[t,meas_idx,pertb_idx] = mean(S_arr[t,meas_idx,pertb_idx,:])
        S_std_arr[t,meas_idx,pertb_idx] = std(S_arr[t,meas_idx,pertb_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanMeasNoisyStagCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length,nstB)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagNoisyCA(ruleStep,stB1,stB2,pertbProf,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            measInt = zeros(Int,2^(2*nAsites))
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[idx_start:idx_end,t-1,i]
                bitarr2 = stTraj[idx_start:idx_end,t,i]
                measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx,pertb_idx,stB_idx] += -dot(measOccurance./2^(2*nAsites), log2.(measOccurance)) + 2*nAsites
        end
    end

    S_ave_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    S_std_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    for  (pertb_idx,pertb) in enumerate(pertb_l), (meas_idx, nmeas) in enumerate(nmeas_l), t = 1:Int(nsteps/2)
        S_ave_arr[t,meas_idx,pertb_idx] = mean(S_arr[t,meas_idx,pertb_idx,:])
        S_std_arr[t,meas_idx,pertb_idx] = std(S_arr[t,meas_idx,pertb_idx,:])
    end

    return S_ave_arr, S_std_arr
end


function scanRndMeasNoisyStagCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length,nstB)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagPertbCA(ruleStep,stB1,stB2,pertbProf,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            meas_site_idx = sample(collect(1:(nAsites+nBsites)),nmeas,replace=false)
            measInt = zeros(Int,2^(2*nAsites))
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[meas_site_idx,t-1,i]
                bitarr2 = stTraj[meas_site_idx,t,i]
                measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx,pertb_idx,stB_idx] += -mean(log2.(measOccurance)) + 2*nAsites
        end
    end

    S_ave_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    S_std_arr = zeros(Int(nsteps/2),nmeas_length,pertb_length)
    for  (pertb_idx,pertb) in enumerate(pertb_l), (meas_idx, nmeas) in enumerate(nmeas_l), t = 1:Int(nsteps/2)
        S_ave_arr[t,meas_idx,pertb_idx] = mean(S_arr[t,meas_idx,pertb_idx,:])
        S_std_arr[t,meas_idx,pertb_idx] = std(S_arr[t,meas_idx,pertb_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanMeasNoisyCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(nsteps,nmeas_length,pertb_length,nstB)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            idx_end = idx_start + nmeas - 1
            measInt = zeros(Int,2^(nAsites))
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,t,i]
                measInt[i] = bitarr_to_int(bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx,pertb_idx,stB_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = zeros(nsteps,nmeas_length,pertb_length)
    S_std_arr = zeros(nsteps,nmeas_length,pertb_length)
    for  (pertb_idx,pertb) in enumerate(pertb_l), (meas_idx, nmeas) in enumerate(nmeas_l), t = 1:nsteps
        S_ave_arr[t,meas_idx,pertb_idx] = mean(S_arr[t,meas_idx,pertb_idx,:])
        S_std_arr[t,meas_idx,pertb_idx] = std(S_arr[t,meas_idx,pertb_idx,:])
    end

    return S_ave_arr, S_std_arr
end

# function scanMeasNoisyCAME(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
#     nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
#     nmeas_length = length(nmeas_l)
#     pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
#     pertb_length = length(pertb_l)

#     S_arr = zeros(nsteps,nmeas_length,pertb_length)
#     @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
#         pertbProf = rand(nsteps,nAsites+nBsites)
#         pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
#         pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
#         stB = BitArray(rand(Bool,nBsites))
#         stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
#         for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
#             idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
#             idx_end = idx_start + nmeas - 1
#             measInt = zeros(Int,2^(nAsites))
#             for i = 1:2^(nAsites)
#                 bitarr = stTraj[idx_start:idx_end,t,i]
#                 measInt[i] = bitarr_to_int(bitarr)
#             end
#             measOccurance = countOccurance(measInt)
#             S_arr[t,meas_idx,pertb_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
#         end
#     end

#     S_arr = S_arr ./ nstB

#     return S_arr
# end

function scanMeasNoisyCAME(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_ave_arr = zeros(nsteps,nmeas_length,pertb_length)
    S_snd_arr = zeros(nsteps,nmeas_length,pertb_length)
    S_trd_arr = zeros(nsteps,nmeas_length,pertb_length)
    S_fth_arr = zeros(nsteps,nmeas_length,pertb_length)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
        for t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            # idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            # idx_end = idx_start + nmeas - 1
            idx_start = 1
            idx_end = nmeas-1
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,t,i]
                push!(measInt,bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_ave_arr[t,meas_idx,pertb_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
            S_snd_arr[t,meas_idx,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^2
            S_trd_arr[t,meas_idx,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^3
            S_fth_arr[t,meas_idx,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^4
        end
    end
    S_ave_arr = S_ave_arr ./ nstB
    S_snd_arr = S_snd_arr ./ nstB
    S_trd_arr = S_trd_arr ./ nstB
    S_fth_arr = S_fth_arr ./ nstB    

    return S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr
end

function scanMeasNoisyCAOneDepth(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_ave_arr = zeros(nmeas_length,pertb_length)
    S_snd_arr = zeros(nmeas_length,pertb_length)
    S_trd_arr = zeros(nmeas_length,pertb_length)
    S_fth_arr = zeros(nmeas_length,pertb_length)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
        for (meas_idx, nmeas) in enumerate(nmeas_l)
            # idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
            # idx_end = idx_start + nmeas - 1
            idx_start = 1
            idx_end = nmeas-1
            measInt = Vector{Vector{Bool}}(undef,0)
            for i = 1:2^(nAsites)
                bitarr = stTraj[idx_start:idx_end,end,i]
                push!(measInt,bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_ave_arr[meas_idx,pertb_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
            S_snd_arr[meas_idx,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^2
            S_trd_arr[meas_idx,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^3
            S_fth_arr[meas_idx,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^4
        end
    end
    S_ave_arr = S_ave_arr ./ nstB
    S_snd_arr = S_snd_arr ./ nstB
    S_trd_arr = S_trd_arr ./ nstB
    S_fth_arr = S_fth_arr ./ nstB    

    return S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr
end

function scanMeasNoisyCAOneMeas(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    # nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    # nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_ave_arr = zeros(nsteps,pertb_length)
    S_snd_arr = zeros(nsteps,pertb_length)
    S_trd_arr = zeros(nsteps,pertb_length)
    S_fth_arr = zeros(nsteps,pertb_length)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
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
    S_ave_arr = S_ave_arr ./ nstB
    S_snd_arr = S_snd_arr ./ nstB
    S_trd_arr = S_trd_arr ./ nstB
    S_fth_arr = S_fth_arr ./ nstB    

    return S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr
end

# function scanMeasNoisyCAOneMeasDist(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
#     # nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
#     # nmeas_length = length(nmeas_l)
#     pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
#     pertb_length = length(pertb_l)
    
#     # S_ave_arr = zeros(nsteps,pertb_length) 
#     # S_snd_arr = zeros(nsteps,pertb_length)
#     # S_trd_arr = zeros(nsteps,pertb_length)
#     # S_fth_arr = zeros(nsteps,pertb_length)
#     S_ave_arr = SharedArray{Float64}(nsteps,pertb_length) 
#     S_snd_arr = SharedArray{Float64}(nsteps,pertb_length)
#     S_trd_arr = SharedArray{Float64}(nsteps,pertb_length)
#     S_fth_arr = SharedArray{Float64}(nsteps,pertb_length)
#     @sync @distributed for pertb_idx = 1:length(pertb_l)
#         pertb = pertb_l[pertb_idx]
#         for stB_idx = 1:nstB
#             pertbProf = rand(nsteps,nAsites+nBsites)
#             pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
#             pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
#             stB = BitArray(rand(Bool,nBsites))
#             stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
#             for t = 1:nsteps
#                 # idx_start = nAsites + Int(floor(nBsites/2 - nmeas/2))
#                 # idx_end = idx_start + nmeas - 1
#                 measInt = Vector{Vector{Bool}}(undef,0)
#                 for i = 1:2^(nAsites)
#                     bitarr = stTraj[:,t,i]
#                     push!(measInt,bitarr)
#                 end
#                 measOccurance = countOccurance(measInt)
#                 S_ave_arr[t,pertb_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
#                 S_snd_arr[t,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^2
#                 S_trd_arr[t,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^3
#                 S_fth_arr[t,pertb_idx] += (-dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites)^4
#             end
#         end
#     end
#     S_ave_arr = S_ave_arr ./ nstB
#     S_snd_arr = S_snd_arr ./ nstB
#     S_trd_arr = S_trd_arr ./ nstB
#     S_fth_arr = S_fth_arr ./ nstB    

#     return S_ave_arr, S_snd_arr, S_trd_arr, S_fth_arr
# end

function scanRndMeasNoisyCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(nsteps,nmeas_length,pertb_length,nstB)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            meas_site_idx = sample(collect(1:(nAsites+nBsites)),nmeas,replace=false)
            measInt = zeros(Int,2^(nAsites))
            for i = 1:2^(nAsites)
                bitarr = stTraj[meas_site_idx,t,i]
                measInt[i] = bitarr_to_int(bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx,pertb_idx,stB_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = zeros(nsteps,nmeas_length,pertb_length)
    S_std_arr = zeros(nsteps,nmeas_length,pertb_length)
    for  (pertb_idx,pertb) in enumerate(pertb_l), (meas_idx, nmeas) in enumerate(nmeas_l), t = 1:nsteps
        S_ave_arr[t,meas_idx,pertb_idx] = mean(S_arr[t,meas_idx,pertb_idx,:])
        S_std_arr[t,meas_idx,pertb_idx] = std(S_arr[t,meas_idx,pertb_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanRndMeasNoisyCAOneDepth(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,pertb_start,pertb_end,pertb_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)
    pertb_l = collect(range(pertb_start,stop=pertb_end,step=pertb_step))
    pertb_length = length(pertb_l)

    S_arr = zeros(nmeas_length,pertb_length)
    @showprogress for (pertb_idx,pertb) in enumerate(pertb_l), stB_idx = 1:nstB
        pertbProf = rand(nsteps,nAsites+nBsites)
        pertbProf = Int.((sign.(pertbProf.-(1-pertb))./2).+0.5)
        pertbProf = rand([-1,1],nsteps,nAsites+nBsites).*pertbProf
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simNoisyCA(ruleStep,stB,pertbProf,nAsites,nBsites,nsteps)
        for (meas_idx, nmeas) in enumerate(nmeas_l)
            meas_site_idx = sample(collect(1:(nAsites+nBsites)),nmeas,replace=false)
            measInt = zeros(Int,2^(nAsites))
            for i = 1:2^(nAsites)
                bitarr = stTraj[meas_site_idx,end,i]
                measInt[i] = bitarr_to_int(bitarr)
            end
            measOccurance = countOccurance(measInt)
            S_arr[meas_idx,pertb_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_arr = S_arr ./ nstB

    return S_arr
end

function scanRndMeasCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(nsteps,nmeas_length,nstB)
    @showprogress for stB_idx = 1:nstB
        stB = BitArray(rand(Bool,nBsites))
        stTraj = simCA(ruleStep,stB,nAsites,nBsites,nsteps)
        for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            meas_site_idx = sample(collect(1:(nAsites+nBsites)),nmeas,replace=false)
            measInt = zeros(Int,2^nAsites)
            for i = 1:2^nAsites
                measInt[i] = bitarr_to_int(stTraj[meas_site_idx,t,i])
            end
            measOccurance = countOccurance(measInt)
            S_arr[t,meas_idx,stB_idx] += -dot(measOccurance./2^nAsites, log2.(measOccurance)) + nAsites
        end
    end

    S_ave_arr = zeros(nsteps,nmeas_length)
    S_std_arr = zeros(nsteps,nmeas_length)
    for  t = 1:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
        S_ave_arr[t,meas_idx] = mean(S_arr[t,meas_idx,:])
        S_std_arr[t,meas_idx] = std(S_arr[t,meas_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function scanRndMeasStagCA(ruleStep,nAsites,nBsites,nmeas_start,nmeas_end,nmeas_step,nsteps,nstB)
    nmeas_l = floor.(Int,collect(range(nmeas_start,stop=nmeas_end,step=nmeas_step)))
    nmeas_length = length(nmeas_l)

    S_arr = zeros(Int(nsteps/2),nmeas_length,nstB)
    @showprogress for stB_idx = 1:nstB
        stB1 = BitArray(rand(Bool,nBsites))
        stB2 = BitArray(rand(Bool,nBsites))
        stTraj = simStagCA(ruleStep,stB1,stB2,nAsites,nBsites,nsteps)
        for  t = 2:2:nsteps, (meas_idx, nmeas) in enumerate(nmeas_l)
            meas_site_idx = sample(collect(1:(nAsites+nBsites)),nmeas,replace=false)
            measInt = zeros(Int,2^(2*nAsites))
            for i = 1:2^(2*nAsites)
                bitarr1 = stTraj[meas_site_idx,t-1,i]
                bitarr2 = stTraj[meas_site_idx,t,i]
                measInt[i] = bitarr_to_int(vcat(bitarr1,bitarr2))
            end
            measOccurance = countOccurance(measInt)
            S_arr[Int(t/2),meas_idx,stB_idx] += -dot(measOccurance./2^(2*nAsites), log2.(measOccurance)) + 2*nAsites
        end
    end

    S_ave_arr = zeros(Int(nsteps/2),nmeas_length)
    S_std_arr = zeros(Int(nsteps/2),nmeas_length)
    for  t = 1:Int(nsteps/2), (meas_idx, nmeas) in enumerate(nmeas_l)
        S_ave_arr[t,meas_idx] = mean(S_arr[t,meas_idx,:])
        S_std_arr[t,meas_idx] = std(S_arr[t,meas_idx,:])
    end

    return S_ave_arr, S_std_arr
end

function save2DData(scanx_l,scany_l,data_ave_arr,data_snd_arr,data_trd_arr,data_fth_arr,file_name)
    df_scanx = DataFrame()
    df_scany = DataFrame()
    df_data = DataFrame()
    df_scanx.scanx_l = scanx_l
    df_scany.scany_l = scany_l
    df_data.data_ave_l = collect(Iterators.flatten(data_ave_arr)) 
    df_data.data_snd_l = collect(Iterators.flatten(data_snd_arr))
    df_data.data_trd_l = collect(Iterators.flatten(data_trd_arr)) 
    df_data.data_fth_l = collect(Iterators.flatten(data_fth_arr)) 

    CSV.write(file_name*"_scanx.csv", df_scanx)
    CSV.write(file_name*"_scany.csv", df_scany)
    CSV.write(file_name*"_data.csv", df_data)
end

function save2DData(scanx_l,scany_l,cmi_ave_arr,cmi_std_arr,file_name)
    df_scanx = DataFrame()
    df_scany = DataFrame()
    df_data = DataFrame()
    df_scanx.scanx_l = scanx_l
    df_scany.scany_l = scany_l
    df_data.cmi_ave_l = collect(Iterators.flatten(cmi_ave_arr)) 
    df_data.cmi_std_l = collect(Iterators.flatten(cmi_std_arr))

    CSV.write(file_name*"_scanx.csv", df_scanx)
    CSV.write(file_name*"_scany.csv", df_scany)
    CSV.write(file_name*"_data.csv", df_data)
end

function save2DData(scanx_l,scany_l,data_ave_arr,file_name)
    df_scanx = DataFrame()
    df_scany = DataFrame()
    df_data = DataFrame()
    df_scanx.scanx_l = scanx_l
    df_scany.scany_l = scany_l
    df_data.data_ave_l = collect(Iterators.flatten(data_ave_arr)) 

    CSV.write(file_name*"_scanx.csv", df_scanx)
    CSV.write(file_name*"_scany.csv", df_scany)
    CSV.write(file_name*"_data.csv", df_data)
end

function save3DData(scanx_l,scany_l,scanz_l,data_arr,file_name)
    df_scanx = DataFrame()
    df_scany = DataFrame()
    df_scanz = DataFrame()
    df_data = DataFrame()
    df_scanx.scanx_l = scanx_l
    df_scany.scany_l = scany_l
    df_scanz.scanz_l = scanz_l
    df_data.data_arr = collect(Iterators.flatten(data_arr)) 

    CSV.write(file_name*"_scanx.csv", df_scanx)
    CSV.write(file_name*"_scany.csv", df_scany)
    CSV.write(file_name*"_scanz.csv", df_scanz)
    CSV.write(file_name*"_data.csv", df_data)
end

function save3DData(scanx_l,scany_l,scanz_l,ave_arr,std_arr,file_name)
    df_scanx = DataFrame()
    df_scany = DataFrame()
    df_scanz = DataFrame()
    df_data = DataFrame()
    df_scanx.scanx_l = scanx_l
    df_scany.scany_l = scany_l
    df_scanz.scanz_l = scanz_l
    df_data.ave_arr = collect(Iterators.flatten(ave_arr)) 
    df_data.std_arr = collect(Iterators.flatten(std_arr)) 

    CSV.write(file_name*"_scanx.csv", df_scanx)
    CSV.write(file_name*"_scany.csv", df_scany)
    CSV.write(file_name*"_scanz.csv", df_scanz)
    CSV.write(file_name*"_data.csv", df_data)
end

function save3DData(scanx_l,scany_l,scanz_l,data_ave_arr,data_snd_arr,data_trd_arr,data_fth_arr,file_name)
    df_scanx = DataFrame()
    df_scany = DataFrame()
    df_scanz = DataFrame()
    df_data = DataFrame()
    df_scanx.scanx_l = scanx_l
    df_scany.scany_l = scany_l
    df_scanz.scanz_l = scanz_l
    df_data.data_ave_l = collect(Iterators.flatten(data_ave_arr)) 
    df_data.data_snd_l = collect(Iterators.flatten(data_snd_arr))
    df_data.data_trd_l = collect(Iterators.flatten(data_trd_arr)) 
    df_data.data_fth_l = collect(Iterators.flatten(data_fth_arr)) 

    CSV.write(file_name*"_scanx.csv", df_scanx)
    CSV.write(file_name*"_scany.csv", df_scany)
    CSV.write(file_name*"_scanz.csv", df_scanz)
    CSV.write(file_name*"_data.csv", df_data)
end