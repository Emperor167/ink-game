-- 1. 翻译字典表
local Translations = {
    ["Red Light Green Light"] = "红灯绿灯",
    ["Dalgona & Pentathlon"] = "椪糖与五项全能",
    ["Lights Out"] = "熄灯 / 关灯",
    ["TP To End"] = "传送到终点",
    ["TP To Start"] = "传送到起点",
    ["Remove Injury"] = "移除受伤状态",
    ["Anti Crawl"] = "防爬行",
    ["Freeze On Red Light"] = "红灯时冻结",
    ["Auto TP End Last Second"] = "最后时刻自动传送到终点",
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

-- 3. 主动劫持实例的 Text 属性
local oldIndex
oldIndex = hookmetamethod(game, "__newindex", function(self, k, v)
    if not checkcaller() then
        if (self:IsA("TextLabel") or self:IsA("TextButton") or self:IsA("TextBox")) and k == "Text" then
            v = translateText(v)
        end
    end
    return oldIndex(self, k, v)
end)

-- 4. 同时配合一次全量初始化扫描，处理已经加载出来的文字
task.spawn(function()
    print("高级翻译劫持引擎已启动")
    while true do
        pcall(function()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if gui:IsA("TextLabel") or gui:IsA("TextButton") then
                    gui.Text = translateText(gui.Text)
                end
            end
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if gui:IsA("TextLabel") or gui:IsA("TextButton") then
                        gui.Text = translateText(gui.Text)
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)
