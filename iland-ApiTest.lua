logger.setTitle('ApiTest')

local global_player = nil

mc.regPlayerCommand('landtest',function (pl,args)
    global_player = pl
    local testafter = false
    for k,v in pairs(TestModule) do
        if testafter then
            mc.broadcast('testing -> '..k)
            thisApi = ll.import('ILAPI_'..k)
            v()
        end
        if nowOn == '' or k == nowOn then
            testafter = true
        end
    end
end)

logger.info('loaded.')