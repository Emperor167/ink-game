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
    print("原文本: " + str + " => 翻译后: " + translateText(str))
end


-- 加载你的远程翻译链接
local success, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Emperor167/roblox/refs/heads/main/%E8%BF%9C%E7%A8%8B%E7%BF%BB%E8%AF%91%E9%93%BE%E6%8E%A5.lua?token=GHSAT0AAAAAAEI5RAEMYTMQ6PSBLFYNNI6C2WFVN6Q"))()
end)

if not success then
    warn("翻译模块加载失败:", err)
else
    print("翻译模块加载成功！")
end

-- 随后加载目标菜单脚本
task.wait(1)
loadstring(game:HttpGet("https://platinstudio.xyz/loader/UwUInk"))()
