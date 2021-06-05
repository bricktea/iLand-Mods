local enabled=true
if not(enabled) then return end
--------------------------------
-- Main
local json = require('dkjson')
local lib = require('library')
if not(lib.IfFile('input-data\\pland.json')) then
    print('[Error] land-g7 data file not found!');return
end
local pldata=json.decode(lib.ReadAllText('input-data\\pland.json'))
print('[INFO] Reading data ... ')
local owners={}
local data={}
local landId=''
for i,v in pairs(pldata.landdata) do
    local info=lib.split(i,':')
    local pos1=lib.split(info[2],'.')
    local pos2=lib.split(info[3],'.')
    local result={lib.fmCube(pos1[1],pos1[2],pos1[3],pos2[1],pos2[2],pos2[3])}
    local posA=result[1]
    local posB=result[2]
    if info[1]=='2D' then
        posA.y=1
        posB.y=255
    end
    landId=lib.getGuid()
    -- DATA
    data[landId]={} --data Version: iLand-1.1.4
    data[landId].range={}
    data[landId].settings={}
    data[landId].settings.share=v.shareplayer

    local nnm,desc
    if v.sign.displayname~=nil then
        nnm=v.sign.displayname
    else
        nnm=''
    end
    if v.sign.message~=nil then
        desc=v.sign.message
    else
        desc=''
    end

    data[landId].settings.nickname=nnm
    data[landId].settings.describe=desc
    data[landId].range.start_position={}
    data[landId].range.start_position[1]=posA.x
    data[landId].range.start_position[2]=posA.y
    data[landId].range.start_position[3]=posA.z
    data[landId].range.end_position={}
    data[landId].range.end_position[1]=posB.x
    data[landId].range.end_position[2]=posB.y
    data[landId].range.end_position[3]=posB.z
    data[landId].range.dim=v.worldid
    data[landId].permissions={}
    data[landId].permissions.allow_destory=v.destroyblock
    data[landId].permissions.allow_place=v.putblock
    data[landId].permissions.allow_use_item=v.useitem
    data[landId].permissions.allow_attack=v.attack
    data[landId].permissions.allow_open_chest=v.openchest
    data[landId].permissions.allow_exploding=false
    data[landId].permissions.allow_open_barrel=false
    data[landId].permissions.allow_pickupitem=false
    data[landId].permissions.allow_dropitem=true
    -- OWNER
    if owners[v.playerxuid]==nil then
        owners[v.playerxuid]={}
    end
    table.insert(owners[v.playerxuid],#owners[v.playerxuid]+1,landId)
    -- OPT
    lib.WriteAllText('output-data\\data.json',json.encode(data))
    lib.WriteAllText('output-data\\owners.json',json.encode(owners))
    print('[INFO] LandId = '..landId..' | Owner = '..v.playerxuid)
end