module Individual
# individualの設計がわからない.

genes = []
function setGene(_genes)
    global genes = _genes
end

# 制約条件を確認する
function check(genes)
    return true
end

end
