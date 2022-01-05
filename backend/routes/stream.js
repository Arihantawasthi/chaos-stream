const router = require('express').Router();
const fs = require('fs');
const file = require('../config')
const {videoStream} = require("../functions/stream")

router.get("/stream",(req,res)=>{
 //get the video id/name
   const {videoID} = req.query;
 //video info
 const path = file.path + videoID

//video info
//stream parting
if(!req.headers.range){
    return res.status(416).send("no range provided")
}
const chunk = 10**6;
res.writeHead(206,videoStream(path,req.headers.range,chunk).reshead);
videoStream(path,req.headers.range,chunk).stream.pipe(res)
})

module.exports = router;