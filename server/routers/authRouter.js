const express = require("express");
const User = require("../models/userModel");
const bcryptjs=require("bcryptjs");
const jwt=require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password } = req.body;

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "Email already exists" });
        }

       const hashedPassword= await bcryptjs.hash(password,8);


        let newUser = new User({
            name,
            email,
            password:hashedPassword,
        });

        newUser = await newUser.save();
        res.json(newUser);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

authRouter.post("/api/signin",async(req,res)=>{
    try {
        const {email,password}=req.body;
    const user=await User.findOne({email});
    if(!user){
        res.status(400).json({
            msg:"invalid email address"
        });
    }

    const isMatch=await bcryptjs.compare(password,user.password);

    if(!isMatch){
         res.status(400).json({
            msg:"username and password do not match"
        });
    }

    const token=await jwt.sign({id:user._id},"PasswordKey",{expiresIn:"1h"});
    
    res.status(200).json({msg:"Login successful",token,...user._doc});
        
    } catch (e) {
        res.status(500).json({error:e.message});
        
    }
    
});


authRouter.post("/tokenIsValid",async(req,res)=>{
try {
    const token=req.header("x-auth-token");
    if(!token){
        return res.json(false);
    }
    const verified=await jwt.verify(token,"PasswordKey");
    if(!verified){
        return res.json(false);
    }
    const user=await User.findById(verified.id);
    if(!user){
        return res.json(false);
    }
    console.log(token);
    res.json(true);
    
} catch (e) {
    res.status(500).json({error:e.message});
    
   }
});


authRouter.get("/",auth,async(req,res)=>{
    try {
        const user=await User.findById(req.user);
    res.json({token:req.token,...user._doc});
   
        
    } catch (e) {
        res.status(500).json({error:e.message});
        
       }
    

});
module.exports = authRouter;
