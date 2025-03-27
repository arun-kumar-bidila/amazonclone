const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;
                return re.test(value);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        type: String,
        required: true,
        validate:{
            validator:(value)=>{
                if(value.lenght>=5)
                return true;

                
            },
            message:"The length of the password should be atleast 5"
        }
        
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "user",
    },
    // cart: {
    //     type: Array,
    //     default: [],
    // },
});

const User = mongoose.model("User", userSchema);
module.exports = User;
