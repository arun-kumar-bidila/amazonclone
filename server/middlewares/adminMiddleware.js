const jwt = require("jsonwebtoken");
const User=require("../models/userModel")

const admin =  async (req, res, next) => {

    try {
        const token = req.header("x-auth-token");
        if (!token)
            return res.status(401).json({ msg: "Invalid token and error in middleware" });
        const verified = jwt.verify(token, "PasswordKey");
        if (!verified)
            return res.status(401).json({ msg: "Token verification failed" });

        const user=await User.findById(verified.id);

        if(user.type=="user"||user.type=="seller")
            return res.status(401).json({msg:"Your not an admin"});

        req.user=verified.id;
        req.token=token;
        next();

    } catch (err) {

        res.status(500).json({error:err.message})

    }
}

module.exports=admin;