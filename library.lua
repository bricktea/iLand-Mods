local _SHARE={}

function _SHARE.split(str,reps) -- [NOTICE] This function is from Internet
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function (w)
        table.insert(resultStrList,w)
    end)
    return resultStrList
end
function _SHARE.ReadAllText(path)
	local file=assert(io.open(path,'r'))
	local data=''
	for line in file:lines() do
		data=data..'\n'..line
	end
	file:close()
	return data
end
function _SHARE.WriteAllText(path,content)
    local file = assert(io.open(path,'w'))
    file:write(content)
    file:close()
end
function _SHARE.IfFile(path)
	local file = io.open(path,'r')
	if file == nil then return false
	else
		file:close();return true
	end
end
function _SHARE.getGuid() -- [NOTICE] This function is from Internet.
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
function _SHARE.buildVec(x,y,z,dim)
	local t={}
	t.x=x
	t.y=y
	t.z=z
	if dim~=nil then
		t.dim=dim
	end
	return t
end
function _SHARE.formatXYZ(sX,sY,sZ,eX,eY,eZ)
	local A=buildVec(sX,sY,sZ)
	local B=buildVec(eX,eY,eZ)
	local tmp1
	if A.x>B.x then tmp1=A.x;A.x=B.x;B.x=tmp1 end
	if A.y>B.y then tmp1=A.y;A.y=B.y;B.y=tmp1 end
	if A.z>B.z then tmp1=A.z;A.z=B.z;B.z=tmp1 end
	return A,B
end
function _SHARE.test()
    return 'OK!'
end

return _SHARE