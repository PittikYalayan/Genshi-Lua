-- Find the currently active player character
local function find_active_char()
    local avatarroot = CS.UnityEngine.GameObject.Find("/EntityRoot/AvatarRoot")
    for i = 0, avatarroot.transform.childCount - 1 do
        local child = avatarroot.transform:GetChild(i)
        if child.gameObject.activeInHierarchy then
            return child.gameObject
        end
    end
end

-- Find "OffsetDummy" (model parent) in the player
local function find_body(avatar)
    for i = 0, avatar.transform.childCount - 1 do
        local t = avatar.transform:GetChild(i)
        if t.name == "OffsetDummy" then
            return t
        end
    end
end

-- Find the first monster's model in MonsterRoot
local function find_first_monster_model()
    local monsterroot = CS.UnityEngine.GameObject.Find("/EntityRoot/MonsterRoot")
    if not monsterroot or monsterroot.transform.childCount == 0 then return nil end
    local monster = monsterroot.transform:GetChild(0)
    for j = 0, monster.childCount - 1 do
        local sub = monster:GetChild(j)
        if string.find(sub.name, "_Model") then
            return sub
        end
    end
    return nil
end

-- Main logic: Swap avatar model with monster model
local function swap_avatar_to_monster()
    local avatar = find_active_char()
    if not avatar then
        CS.MoleMole.ActorUtils.ShowMessage("No active avatar found!")
        return
    end
    local body = find_body(avatar)
    if not body then
        CS.MoleMole.ActorUtils.ShowMessage("OffsetDummy not found!")
        return
    end
    local player_model = body.childCount > 0 and body:GetChild(0) or nil
    if not player_model then
        CS.MoleMole.ActorUtils.ShowMessage("Player model not found!")
        return
    end

    local monster_model = find_first_monster_model()
    if not monster_model then
        CS.MoleMole.ActorUtils.ShowMessage("Monster model not found!")
        return
    end

    -- Disable the current player model
    player_model.gameObject:SetActive(false)

    -- Copy the monster model as new avatar model
    local clone = CS.UnityEngine.GameObject.Instantiate(monster_model.gameObject)
    clone.transform:SetParent(body, false)
    clone.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    clone.transform.localScale = player_model.localScale
    clone:SetActive(true)

    CS.MoleMole.ActorUtils.ShowMessage("<color=FF8888>Avatar model swapped with monster! (Client-side, visual only)</color>")
end

swap_avatar_to_monster()
