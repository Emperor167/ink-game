-- 1. 翻译字典表
local Translations = {
    ["Red Light Green Light"] = "红灯绿灯",
    ["Dalgona & Pentathlon"] = "椪糖与五项全能",
    ["Lights Out"] = "熄灯 / 关灯",
    ["TP To End"] = "传送到终点",
    ["Auto Complete Dalgona"] = "自动完成椪糖"
}

-- 2. 翻译匹配函数
local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    if Translations[text] then
        return Translations[text]
    end
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    return text
end

-- 3. 简单的本地模拟测试
local testStrings = {
    "Red Light Green Light",
    "TP To End",
    "Unknown Menu Item"
}

for _, str in ipairs(testStrings) do
    -- 注意这里：把原来的加号 + 全部改成了连接符 ..
    print("原文本: " .. str .. " => 翻译后: " .. translateText(str))
end
