local function curryRepX(src)
    return function(from)
        if (from == nil) then
            return src
        end
        return function(target)
            return string.gsub(string.gsub(src, from .. "x", target), from .. "X", target)
        end
    end
end

local function concatF(f1, args, f2)
    return f2(f1(args[1])(args[2]))
end

local function translator(input, seg)
    local alphabetTable = {
        { "c", "ĉ" },
        { "C", "Ĉ" },
        { "g", "ĝ" },
        { "G", "Ĝ" },
        { "h", "ĥ" },
        { "H", "Ĥ" },
        { "j", "ĵ" },
        { "J", "Ĵ" },
        { "s", "ŝ" },
        { "S", "Ŝ" },
        { "u", "ŭ" },
        { "U", "Ŭ" },
    }
    local fn = curryRepX(input)

    for _, i in ipairs(alphabetTable) do
        fn = concatF(fn, i, curryRepX)
    end

    local word = fn(nil)
    local lastChar = string.sub(word, -1)
    if(lastChar == "," or lastChar == "." or lastChar == "!") then
        epoEnv.engine:commit_text(word .. " ")
        epoEnv.engine.context:clear()
    else
        local cand = Candidate(word, seg.start, seg._end, word .. " " , " ")
        cand.quality = 1
        yield(cand)
    end

end

local function init(env)
    epoEnv = env
end

return { init = init, func = translator }
