local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):NewLocale(ADDON_NAME, "zhCN")
if not L then return end
L["Action"] = "执行"
L["Add Name"] = "新增名称"
L["Add incoming prefixes"] = "新增接收的字首"
L["Add incoming prefixes to the prefix list."] = "新增接收的字首到字首清单。"
L["Add outgoing prefixes"] = "新增传送的字首"
L["Add outgoing prefixes to the prefix list."] = "新增传送的字首到字首清单。"
L["Add sender name to list"] = "新增传送者名称到清单"
L["Added incoming prefix |cffffff00%s|r (|cffffff00%s|r) from |cffffff00%s|r."] = "已新增接收的字首 |cffffff00%s|r (|cffffff00%s|r)来自|cffffff00%s|r。"
L["Added outgoing prefix |cffffff00%s|r (|cffffff00%s|r)."] = "已新增传送的字首|cffffff00%s|r (|cffffff00%s|r)。"
L["Added: "] = "已新增:"
L["Addon: "] = "插件:"
L["All"] = "全部"
L["Allow"] = "允许"
L["Allow all incoming and outgoing"] = "允许所有接收与传送"
L["Allowed"] = "已允许"
L["Block"] = "阻挡"
L["Block all incoming and outgoing"] = "阻挡所有接收与传送"
L["Block messages incoming and outgoing to these players"] = "阻挡讯息接收及传送给那些玩家"
L["Blocked"] = "已阻挡"
L["Chat Frame"] = "聊天视窗"
L["Chat frame to print messages to"] = "在聊天视窗中列出讯息"
L["Click the plus (+) sign for prefix options"] = "点击加号(+)为字首选项"
L["Default Action"] = "预设的执行"
L["Default action for new incoming prefixes"] = "设定新接收的字首为预设的执行"
L["Default action for new outgoing prefixes"] = "设定新传送的字首为预设的执行"
L["Enables / Disables the addon"] = "启用/停用该插件"
L["Globally"] = "总体"
L["Incoming"] = "接收"
L["Input a name to block"] = "输入一个名称来阻挡"
L["Name"] = "名称"
L["Names"] = "名称"
L["New"] = "新的"
L["Off"] = "关"
L["Outgoing"] = "传送"
L["Per profile"] = "每个设定档"
L["Players"] = "玩家"
L["Prefixes"] = "字首"
L["Print Messages"] = "列出讯息"
L["Print message"] = "列出讯息"
L["Print this prefix's messages to chat frame."] = "列出此字首的讯息到聊天视窗。"
L["Print your incoming messages to a chat frame."] = "列出你接收的讯息到聊天视窗。"
L["Print your outgoing messages to a chat frame."] = "列出你传送的讯息到聊天视窗。"
L["Remove Name"] = "移除名称"
L["Remove Prefix"] = "移除字首"
L["Remove prefix from list."] = "从清单中移除字首。"
L["Remove sender name from list"] = "从清单移除传送者名称"
L["Removed |cffffff00%s|r from list."] = "已从清单移除 |cffffff00%s|r。"
L["Save Prefixes & Players"] = "储存字首及玩家"
L["Save prefix & player settings globally or per profile."] = "储存字首及玩家设定到总体或每个设定档。"
L[ [=[StopAddonMessage
Please note. There's no benefit in blocking prefixes if you're not running the addon that receives them.]=] ] = [=[StopAddonMessage
请注意。如果你没有运行该插件然後接收的话，那麽阻挡该字首是没有好处的。]=]
L["Test"] = "测试"
L["Unknown"] = "未知"
L["What to do when message is received."] = "当讯息接收时该如何处理。"
L["What to do when message is sent."] = "当讯息传送时该如何处理。"
L["blockedGuildMsg"] = "|cffffff00%s|r尝试发送一个讯息到公会频道。"
L["blockedRaidMsg"] = "|cffffff00%s|r尝试发送一个讯息到团队频道。"
