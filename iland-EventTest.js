logger.setTitle('EventTest')

let rtnVal = true

mc.listen('onServerStarted',() => {

    // Init ILAPI.
    let registerBeforeListener = ll.import('ILAPI_AddBeforeEventListener')
    let registerAfterListener = ll.import('ILAPI_AddAfterEventListener')
    let func

    //////////  Before: onAskLicense  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[Before] >> ' + JSON.stringify(dict))
        return rtnVal
    }, func)
    registerBeforeListener('onAskLicense',func)

    //////////  Before: onCreate  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[Before] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerBeforeListener('onCreate',func)

    //////////  Before: onDelete  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[Before] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerBeforeListener('onDelete',func)

    //////////  Before: onChangeRange  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[Before] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerBeforeListener('onChangeRange',func)

    //////////  Before: onChangeOwner  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[Before] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerBeforeListener('onChangeOwner',func)

    //////////  Before: onChangeTrust  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[Before] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerBeforeListener('onChangeTrust',func)

    //////////  After: onCreate  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[After] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerAfterListener('onCreate',func)

    //////////  After: onDelete  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[After] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerAfterListener('onDelete',func)

    //////////  After: onEnter  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[After] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerAfterListener('onEnter',func)

    //////////  After: onLeave  //////////
    func = system.randomGuid()
    ll.export((dict) => {
        logger.info('Call[After] >> ' + JSON.stringify(dict))
        return rtnVal
    },func)
    registerAfterListener('onLeave',func)
    
})

logger.info('loaded.')