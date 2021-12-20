const router = require('express').Router();
const fs = require('fs');
const file = require('../config')

router.get("/stream",(req,res)=>{
 //get the video id/name
    
 //video info
 const path = file.path+"video1.mp4"
 const fileStat = fs.statSync(path)
 const fileSize = fileStat.size
//video info
//stream parting
if(!req.headers.range){
    return res.status(416).send("no range provided")
}
const chunk = 10**6;
const parts = req.headers.range.replace("bytes=",'').split('-');
const start = parseInt(parts[0]);
const end = Math.min(start+chunk, fileSize-1);
const contentSize = (end-start)+1

//http range headers
const reshead = {
        'Content-Range': `bytes ${start}-${end}/${fileSize}`,
        'Accept-Ranges': 'bytes',
        'Content-Length': contentSize,
        'Content-Type': 'video/mp4',
      }
res.writeHead(206,reshead);

fs.createReadStream(path,{start,end}).pipe(res)
})

module.exports = router;