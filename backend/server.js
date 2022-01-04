const express = require('express')
const bodyParser = require("body-parser")
const app = express()
const port = 3000

const stream = require('./routes/stream')

app.use(bodyParser.urlencoded({extended:true}))

app.use(stream);

app.listen(port, () => console.log(`server on port ${port}!`))