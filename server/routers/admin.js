const express = require("express");
const adminRouter = express.Router();
const {Product} = require("../models/productModel");

const admin = require("../middlewares/adminMiddleware");



adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {

        console.log("admin Router called");

        const { name, description, images, quantity, price, category } = req.body;

        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category

        });

        product = await product.save();

        res.json(product);

    } catch (err) {
        res.status(500).json({ error: err.message });

    }
});

//get all your products

adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
        const products = await Product.find({});

        res.json(products);


    } catch (err) {
        res.status(500).json({ error: err.message }); e

    }
});

//delete the product

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);

       
        res.json(product);
    } catch (err) {
        res.status(500).json({ error: err.message })
    }
})

module.exports = adminRouter;
