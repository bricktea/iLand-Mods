-- support: land-g7
local enabled=true
local land_type='landg7'
if not(enabled) then return end
--------------------------------
-- This function(split) form:
-- https://blog.csdn.net/forestsenlin/article/details/50590577
function split(str,reps)
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(resultStrList,w)
    end)
    return resultStrList
end
function g7pos(text,mode) --mode(str)=start,end
	local n=''
	if mode=='start' then n=string.sub(text,0,string.find(text,':',1)-1) end    
	if mode=='end' then n=string.sub(text,string.find(text,':',1)+1,string.len(text)) end
	local pos={}
	local u=split(n,'.')
	pos.x=u[1]
	if mode=='start' then pos.y=0 end
	if mode=='end' then pos.y=255 end
	pos.z=u[3]
	return pos
end
--------------------------------
-- Main
local libPath=luaapi.LibPATH
local luaPath=luaapi.LuaPATH
local json = require(libPath..'dkjson')
if not(tool:IfFile(luaPath..'input-data\\landg7-player.json')) then
    print('ERR! land-g7 data file not found!')
end
local g7data=json.decode(tool:ReadAllText(luaPath..'input-data\\landg7-player.json'))
print('--------------------------------------------------')
local owners={}
local data={}
local landId=''
math.randomseed(os.time())
for i,v in pairs(g7data.limit) do
	if v.land~=nil then
		for a,b in pairs(v.land) do
			local posA=g7pos(b,'start')
			local posB=g7pos(b,'end')
			landId='id'..tostring(math.random(100000,999999))
			-- DATA
			data[landId]={} --data Version: iLand-1.1.0
			data[landId].range={}
			data[landId].setting={}
			data[landId].setting.share={}
			data[landId].range.start_x=posA.x
			data[landId].range.start_z=posA.z
			data[landId].range.start_y=posA.y
			data[landId].range.end_x=posB.x
			data[landId].range.end_z=posB.z
			data[landId].range.end_y=posB.y
			data[landId].range.dim=0
			data[landId].setting.allow_destory=v.destroyblock
			data[landId].setting.allow_place=v.putblock
			data[landId].setting.allow_use_item=v.useitem
			data[landId].setting.allow_attack=v.attack
			data[landId].setting.allow_open_chest=v.openchest
			data[landId].setting.allow_exploding=false
			data[landId].setting.allow_open_barrel=false
			data[landId].setting.allow_pickupitem=false
			data[landId].setting.allow_dropitem=true
			-- OWNER
			if(owners[i]==nil) then
				owners[i]={}
			end
			table.insert(owners[i],#owners[i]+1,landId)
			-- OPT
			tool:WriteAllText(luaPath..'output-data\\data.json',json.encode(data))
			tool:WriteAllText(luaPath..'output-data\\owners.json',json.encode(owners))
			print('[PROG] LandId = '..landId..' | Owner = '..i)
		end
	end
end


print('--------------------------------------------------')

print('[LC] ILand-Converter is loaded.')