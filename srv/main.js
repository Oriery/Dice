module.exports = cds.service.impl(async function () {
    const { Users } = cds.entities

    this.on("getUsersByIds", async (req) => {
        const {ids} = req.data
        console.log(ids)

        if (ids) {
            var response = await cds.tx(req).run(SELECT.from(Users).where `ID in ${ids}`)
            return response
        } else {
            req.reject(400, 'No "ids" array found in body object');
        }
    })
})
