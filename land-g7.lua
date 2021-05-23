local enabled=true
if not(enabled) then return end
--------------------------------
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
local json = require('dkjson')
local lib = require('library')
if not(lib.IfFile('input-data\\landg7-player.json')) then
    print('[Error] land-g7 data file not found!');return
end
local g7data=json.decode(lib.ReadAllText('input-data\\landg7-player.json'))
print('[INFO] Reading data ... ')
local owners={}
local data={}
local landId=''
for i,v in pairs(g7data.limit) do
	if v.land~=nil then
		for a,b in pairs(v.land) do
			local posA=g7pos(b,'start')
			local posB=g7pos(b,'end')
			local result=lib.formatXYZ(
								tonumber(posA.x),
								tonumber(posA.y),
								tonumber(posA.z),
								tonumber(posB.x),
								tonumber(posB.y),
								tonumber(posB.z)
							)
			posA=result[1]
			posB=result[2]
			landId=lib.getGuid()
			-- DATA
			data[landId]={} --data Version: iLand-1.1.3
			data[landId].range={}
			data[landId].settings={}
			data[landId].settings.share={}
			data[landId].settings.nickname=''
			data[landId].settings.describe=''
			data[landId].range.start_position={}
			data[landId].range.start_position[1]=posA.x
			data[landId].range.start_position[2]=posA.z
			data[landId].range.start_position[3]=posA.y
			data[landId].range.end_position={}
			data[landId].range.end_position[1]=posB.x
			data[landId].range.end_position[2]=posB.z
			data[landId].range.end_position[3]=posB.y
			data[landId].range.dim=0
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
			if owners[i]==nil then
				owners[i]={}
			end
			table.insert(owners[i],#owners[i]+1,landId)
			-- OPT
			lib.WriteAllText('output-data\\data.json',json.encode(data))
			lib.WriteAllText('output-data\\owners.json',json.encode(owners))
			print('[INFO] LandId = '..landId..' | Owner = '..i)
		end
	end
end

print('[INFO] Completed.')