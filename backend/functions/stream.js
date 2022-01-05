const fs = require('fs');

function videoStream (path,range,chunk){
    const fileStat = fs.statSync(path)
    const fileSize = fileStat.size
    
    const parts = range.replace("bytes=",'').split('-');
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
   // response.writeHead(206,reshead);
    
    const stream = fs.createReadStream(path,{start,end});
    return ({reshead,stream})
    //stream.pipe(res)
  }

  module.exports.videoStream = videoStream