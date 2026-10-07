-- 1. 翻译字典表（支持全称与关键词模糊匹配）
local Translations = {
    ["Red Light Green Light"] = "红灯绿灯",
    ["Dalgona & Pentathlon"] = "椪糖与五项全能",
    ["Lights Out"] = "熄灯 / 关灯",
    ["Hide And Seek & Tug Of War"] = "捉迷藏与拔河",
    ["Jump Rope & Glass Bridge"] = "跳绳与玻璃桥",
    ["TP To End"] = "传送到终点",
    ["TP To Start"] = "传送到起点",
    ["Remove Injury"] = "移除受伤状态",
    ["Anti Crawl"] = "防爬行",
    ["Freeze On Red Light"] = "红灯时冻结",
    ["Auto TP End Last Second"] = "最后时刻自动传送到终点"
}

-- 2. 文本翻译匹配函数
local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    -- 精准匹配
    if Translations[text] then
        return Translations[text]
    end
    -- 模糊包含匹配（防止菜单自带空格或富文本标签干扰）
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    return text
end

-- 3. 安全的单节点刷新函数（仅修改 Text 属性，绝对不碰底层内存）
local function safeApply(obj)
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        local currentText = obj.Text
        local newText = translateText(currentText)
        if currentText ~= newText then
            obj.Text = newText
        end
    end
end

-- 4. 采用低频率、高效率的局部扫描（保护性能，防止卡顿）
task.spawn(function()
    print("安全版中文辅助引擎已启动")
    while true do
        task.wait(1.5) -- 降低扫描频率，每1.5秒检查一次，完全不卡顿、不占用 CPU
        
        pcall(function()
            -- 仅扫描玩家自己的 PlayerGui（最安全的范围）
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    safeApply(gui)
                end
            end
            
            -- 如果菜单挂载在 CoreGui，进行受保护的定向扫描
            local coreGui = game:GetService("CoreGui")
            for _, gui in ipairs(coreGui:GetDescendants()) do
                -- 过滤条件：只对包含 UwU 关键词或菜单特征的容器进行扫描，避免全盘遍历
                if gui.Name:lower():find("uwu") or gui.Name:lower():find("hub") or gui.Name:lower():find("platinstudio") then
                    for _, subGui in ipairs(gui:GetDescendants()) do
                        safeApply(subGui)
                    end
                end
            end
        end)
    end
end)
