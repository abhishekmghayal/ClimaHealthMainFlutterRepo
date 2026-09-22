const mongoose=require("mongoose");

const userSchema=new mongoose.Schema(
    {
        fullName:{
            type:String,
            required:true,
            trim:true
        },
        mobile:{
            type:String,
            required:true,
            trim:true
        },
        email:{
            type:String,
            required:true,
            unique:true,
            lowercase:true,
            trim:true
        },
        password:{
            type:String,
            required:true,
            minlength:6
        },
        bloodGroup:{
             type: String,
            required: false,
            trim: true
        },
        height:{
            type:Number,
            required:false
        },

        birthDate:{
            type:Date,
            required:false
        }
    },

    {
        timestamps:true
    }
);

const User=mongoose.model("User",userSchema);
module.exports=User;