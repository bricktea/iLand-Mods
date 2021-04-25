local enabled=true
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
function ReadAllText(path)
	local file=assert(io.open(path,'r'))
	local data=''
	for line in file:lines() do
		data=data..'\n'..line
	end
	file:close()
	return data
end
function WriteAllText(path,content)
    local file = assert(io.open(path,'w'))
    file:write(content)
    file:close()
end
function IfFile(path)
	local file = io.open(path,'r')
	if file == nil then return false
	else
		file:close();return true
	end
end
function getGuid() -- [NOTICE] This function is from Internet.
    local seed={'e','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'}
    local tb={}
	---math.randomseed(os.time)
    for i=1,32 do
        table.insert(tb,seed[math.random(1,16)])
    end
    local sid=table.concat(tb)
    return string.format('%s-%s-%s-%s-%s',
        string.sub(sid,1,8),
        string.sub(sid,9,12),
        string.sub(sid,13,16),
        string.sub(sid,17,20),
        string.sub(sid,21,32)
    )
end
--------------------------------
-- Main
local json = require('dkjson')
if not(IfFile('input-data\\landg7-player.json')) then
    print('[Error] land-g7 data file not found!');return
end
local g7data=json.decode(ReadAllText('input-data\\landg7-player.json'))
print('[INFO] Reading data ... ')
local owners={}
local data={}
local landId=''
for i,v in pairs(g7data.limit) do
	if v.land~=nil then
		for a,b in pairs(v.land) do
			local posA=g7pos(b,'start')
			local posB=g7pos(b,'end')
			landId=getGuid()
			-- DATA
			data[landId]={} --data Version: iLand-1.1.1
			data[landId].range={}
			data[landId].settings={}
			data[landId].settings.share={}
			data[landId].settings.nickname=''
			data[landId].range.start_position={}
			data[landId].range.start_position[1]=tonumber(posA.x)
			data[landId].range.start_position[2]=tonumber(posA.z)
			data[landId].range.start_position[3]=tonumber(posA.y)
			data[landId].range.end_position={}
			data[landId].range.end_position[1]=tonumber(posB.x)
			data[landId].range.end_position[2]=tonumber(posB.z)
			data[landId].range.end_position[3]=tonumber(posB.y)
			data[landId].range.dim=0
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
			WriteAllText('output-data\\data.json',json.encode(data))
			WriteAllText('output-data\\owners.json',json.encode(owners))
			print('[INFO] LandId = '..landId..' | Owner = '..i)
		end
	end
end

print('[INFO] Completed.')