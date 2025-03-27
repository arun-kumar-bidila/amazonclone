const jwt=require("jsonwebtoken");
const User = require("../models/userModel");

const auth=(req,res,next)=>{
   try {
    const token =req.header("x-auth-token");
    if(!token){
        return res.status(401).json({msg:"No auth access"});
    }
    const verified=jwt.verify(token,"PasswordKey");
    if(!verified){
        return res.status(401).json({msg:"Not verified token"});
    
    }
    req.user=verified.id;
    req.token=token;
    next();
    
    
   } catch (e) {
    res.status(500).json({error:e.message});
    
   }
}

module.exports=auth;