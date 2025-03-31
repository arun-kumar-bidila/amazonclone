const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routers/authRouter");
const adminRouter = require("./routers/admin");

const PORT = 3000;
const app = express();
const db = "mongodb+srv://arunkumar:Arun5452@cluster0.3pnl6.mongodb.net/myDatabaseName";

// Middleware
app.use(express.json()); // Parses incoming JSON requests
app.use(authRouter);
app.use(adminRouter);

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
