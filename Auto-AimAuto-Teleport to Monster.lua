local monsterRoot = CS.UnityEngine.GameObject.Find("/EntityRoot/MonsterRoot")
if monsterRoot ~= nil and monsterRoot.transform.childCount > 0 then
    local monster = monsterRoot.transform:GetChild(0).gameObject
    local mpos = monster.transform.position
    CS.MoleMole.ActorUtils.SetAvatarPos(CS.UnityEngine.Vector3(mpos.x, mpos.y, mpos.z + 3))
    CS.MoleMole.ActorUtils.ShowMessage("Teleported next to the first monster!")
end
