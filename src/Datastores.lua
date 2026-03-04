local DataStoreService = game:GetService("DataStoreService")

local Datastores = {
    Admins = DataStoreService:GetDataStore("Administer_Admins"),
    Home = DataStoreService:GetDataStore("Administer_HomeStore"),
    AppData = DataStoreService:GetDataStore("Administer_AppData"),
    Settings = DataStoreService:GetDataStore("Administer_Settings"),
}

return Datastores