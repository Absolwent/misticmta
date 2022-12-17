function loadDx()
    restartResource(getThisResource())
    print("m_dx | Loaded all DirectX Addons")
end
addEventHandler("onResourceStart", root, loadDx)
