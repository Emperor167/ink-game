-- 1. 翻译字典表
local Translations = {
    ["Red Light Green Light"] = "红灯绿灯",
    ["Dalgona & Pentathlon"] = "椪糖与五项全能",
    ["Lights Out"] = "熄灯 / 关灯",
    ["Hide And Seek & Tug Of War"] = "捉迷藏与拔河",
    ["Jump Rope & Glass Bridge"] = "跳绳与玻璃桥",
    ["Mingle"] = "人群聚会",
    ["Rebel"] = "叛乱",
    ["Sky & Squid Game"] = "天空与鱿鱼游戏",
    ["TP To End"] = "传送到终点",
    ["TP To Start"] = "传送到起点",
    ["Remove Injury"] = "移除受伤状态",
    ["Anti Crawl"] = "防爬行",
    ["Freeze On Red Light"] = "红灯时冻结",
    ["Auto TP End Last Second"] = "最后时刻自动传送到终点"
}

-- 2. 单次静态清洗函数（仅在菜单出现时执行一次）
task.spawn(function()
    -- 等待菜单加载出来
    task.wait(1.5)
    
    pcall(function()
        -- 遍历当前所有已经存在的 UI 文本
        local function scanAndReplace(root)
            for _, obj in ipairs(root:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                    local txt = obj.Text
                    if Translations[txt] then
                        obj.Text = Translations[txt]
                    else
                        for en, cn in pairs(Translations) do
                            if txt:find(en) then
                                obj.Text = txt:gsub(en, cn)
                            end
                        end
                    end
                end
            end
        end

        -- 分别对 PlayerGui 和 CoreGui 进行一次性清理
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            scanAndReplace(player.PlayerGui)
        end
        
        local coreGui = game:GetService("CoreGui")
        scanAndReplace(coreGui)
        
        print("单次静态汉化执行完毕，已释放资源")
    end)
end)
