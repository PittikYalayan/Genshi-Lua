local mint = CS.UnityEngine.GameObject.Find("Item_Drop_Plant_LY_Mint_01_Vo")
local lotus = CS.UnityEngine.GameObject.Find("Item_Drop_Plant_LY_Lotus_01_Vo")
if mint ~= nil and lotus ~= nil then
    -- Remove all children from mint drop
    for i = mint.transform.childCount-1, 0, -1 do
        local c = mint.transform:GetChild(i).gameObject
        CS.UnityEngine.Object.Destroy(c)
    end
    -- Add lotus model as child
    local clone = CS.UnityEngine.GameObject.Instantiate(lotus)
    clone.transform:SetParent(mint.transform, false)
    clone:SetActive(true)
    CS.MoleMole.ActorUtils.ShowMessage("Mint drop visually changed to lotus!")
end
