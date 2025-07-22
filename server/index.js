const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routers/authRouter");
const adminRouter = require("./routers/admin");
const productRouter = require("./routers/product");
const userRouter=require("./routers/userRouter");
require("dotenv").config();


const PORT = 3000;
const app = express();
const db = process.env.MONGO_URI;

// Middleware
app.use(express.json()); // Parses incoming JSON requests
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
// Database connection
mongoose
    .connect(db, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log("Database connection successful");
    })
    .catch((e) => {
        console.error("Database connection error:", e);
    });

// Start server
app.listen(PORT, "0.0.0.0", () => {
    console.log(`App started at port ${PORT}`);
});
