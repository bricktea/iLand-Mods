// load data
var DATA_PATH = "plugins\\land-data\\"

// dev mode
if (false)
{
    DATA_PATH = "plugins\\LXL_Plugins\\iLand\\land-data\\"
}

// import iland apis
var GetVersion = lxl.import("ILAPI_GetVersion")
var CreateLand = lxl.import("ILAPI_CreateLand")
var UpdatePermission = lxl.import("ILAPI_UpdatePermission")
var UpdateSetting = lxl.import("ILAPI_UpdateSetting")

// logger
function INFO(msg)
{
    log("[ILand] |Conventer| "+msg)
}

function ERROR(msg)
{
    log("[ILand] |ERROR| "+msg)
}

// main
mc.regConsoleCmd('iconv','land converter',function(args){

    // check iland
    var ILVER = GetVersion()
    if (ILVER!=null && ILVER < 224)
    {
        ERROR("ILand not found or too old, please update/install iland!")
        return false
    }

    // pland
    if (args[0]=='pland')
    {
        var da = data.parseJson(file.readFrom(DATA_PATH+"pland.json"))
        Object.keys(da.landdata).forEach(function(key){
            var land = da.landdata[key]
            var owner = land.playerxuid
            var spos = {x:land.x1,y:land.y1,z:land.z1}
            var epos = {x:land.x2,y:land.y2,z:land.z2}
            if (land.Dim == '2D')
            {
                spos.y=0
                epos.y=255
            }
            var dimid = land.worldid
            var landId = CreateLand(owner,spos,epos,dimid)
            if (!landId)
            {
                ERROR("Something wrong in land ['"+key+"'], continue.")
                return;
            }
            UpdatePermission(landId,'allow_destroy',land.destroyblock)
            UpdatePermission(landId,'allow_open_chest',land.openchest)
            UpdatePermission(landId,'allow_place',land.putblock)
            UpdateSetting(landId,'share',land.shareplayer)
            if (land.sign.displayname!=null)
            {
                UpdateSetting(landId,'nickname',land.sign.displayname)
            }
            if (land.sign.message!=null)
            {
                UpdateSetting(landId,'describe',land.sign.message)
            }
            if (land.sign.push_block!=null)
            {
                UpdateSetting(landId,'ev_piston_push',land.sign.push_block)
            }
            INFO('PLand => landId: '+landId+" owner: "+owner)
        })
        INFO('PLand => Complete, converted '+Object.keys(da.landdata).length+" lands.")
        return false
    }

    // pfland
    if (args[0]=='pfland')
    {
        var da = data.parseJson(file.readFrom(DATA_PATH+"testpfland.json"))
        Object.keys(da.Lands).forEach(function(key){
            var land = da.Lands[key]
            var spos = {x:land.X1,y:land.Y1,z:land.Z1}
            var epos = {x:land.X2,y:land.Y2,z:land.Z2}
            var dimid = land.Dimension
            var owner = land.PlayerXuid
            if (land.LandType=="2D")
            {
                spos.y=0
                epos.y=255
            }
            var landId = CreateLand(owner,spos,epos,dimid)
            if (!landId)
            {
                ERROR("Something wrong in land ['"+key+"'], continue.")
                return;
            }
            var friends = new Array()
            land.PlayersShared.forEach(function(pl,index){
                friends.push(pl.PlayerXuid)
            })
            UpdateSetting(landId,'share',friends)
            if (land.DefaultShared.DestroyBlock!=null)
            {
                UpdatePermission(landId,'allow_destroy',land.DefaultShared.DestroyBlock)
            }
            if (land.DefaultShared.DropItem!=null)
            {
                UpdatePermission(landId,'allow_dropitem',land.DefaultShared.DropItem)
            }
            if (land.DefaultShared.PickUpItem!=null)
            {
                UpdatePermission(landId,'allow_pickupitem',land.DefaultShared.PickUpItem)
            }
            if (land.DefaultShared.PlaceBlock!=null)
            {
                UpdatePermission(landId,'allow_place',land.DefaultShared.PlaceBlock)
            }
            if (land.DefaultShared.OpenChest!=null)
            {
                UpdatePermission(landId,'allow_open_chest',land.DefaultShared.OpenChest)
            }
            if (land.DefaultShared.FarmLandDecay!=null)
            {
                UpdateSetting(landId,'ev_farmland_decay',land.DefaultShared.FarmLandDecay)
            }
            if (land['Sign.Displayname']!=null)
            {
                UpdateSetting(landId,'nickname',land['Sign.Displayname'])
            }
            if (land['Sign.Message']!=null)
            {
                UpdateSetting(landId,'describe',land['Sign.Message'])
            }
            INFO('PFLand => landId: '+landId+" owner: "+owner)
        })
        INFO('PFLand => Complete, converted '+da.Lands.length+" lands.")
        return false
    }

    // land-g7
    if (args[0]=='landg7' || args[0]=='land-g7')
    {
        ERROR("If you're using land-g7, please convert data to 'pland' by pland at first.")
        return false
    }

    // disable output
    ERROR("Unknown land data type '"+args[0]+"', please check or contact with author.")
    return false
})

INFO('=> pland loaded.')
INFO('=> pfland loaded.')
