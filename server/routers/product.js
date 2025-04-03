const express=require("express");
const productRouter=express.Router();
const auth=require("../middlewares/auth");
const Product=require("../models/productModel")

productRouter.get("/api/products/",auth,async (req,res)=>{
    try {
        console.log("print")
        console.log(req.query.category);
        const products=await Product.find({category:req.query.category});
        res.json(products);
        
    } catch (err) {
        res.status(500).json({error:err.message});
        
    }
} );

module.exports=productRouter;



