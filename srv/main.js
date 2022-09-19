module.exports = cds.service.impl(async function () {
    const { v4: uuidv4 } = require("uuid")
    const { Users, Events } = cds.entities

    this.on("getUsersByIds", async (req) => {
        const { ids } = req.data
        console.log(ids)

        if (ids) {
            var response = await cds
                .tx(req)
                .run(SELECT.from(Users).where`ID in ${ids}`)
            return response
        } else {
            req.reject(400, 'No "ids" array found in body object')
        }
    })

    this.before("CREATE", "Events", (req) => {
        if (!req.data.chatID) {
            req.data.chatID = uuidv4()
        }
    })

    this.on("generateChatID", "Events", ({ req, params: [id] }) => {
        newUUID = uuidv4()
        cds.tx(req).run(UPDATE(Events, id).set`chatID = ${newUUID}`)
        return newUUID
    })
})
