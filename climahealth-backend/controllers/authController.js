const bcrypt=require("bcryptjs");
const jwt=require("jsonwebtoken");
const User=require("../models/User");


const registerUser= async (req,res)=>{
    try{
        const{
            fullName,
            mobile,
            email,
            password
        }=req.body;

        if(!fullName||!mobile||!password||!email){
            return res.status(400).json({
                success:false,
                message:"All required feilds must be provided"
            });
        }

        const existingUser=await User.findOne({
            email:email.toLowerCase()
        });

        if(existingUser){
            return res.status(400).json({
                success:false,
                message:"Email is already Registered"
            });
        }

        const hashedPassword=await bcrypt.hash(password,10);

        const user=await User.create({
            fullName,
            mobile,
            email:email.toLowerCase(),
            password:hashedPassword
        });

        res.status(201).json({
            success:true,
            message:"User Registered Successfully",
            user:{
                id:user._id,
                fullName:user.fullName,
                mobile:user.mobile,
                email:user.email
            }
        });

    }catch(error){
        console.error("Registration error",error);
        res.status(500).json({
            success:false,
            message:"Server error"
        });
    }
};



const loginUser=async (req,res)=>{
    try{
        const{email,password}=req.body;

        if(!email||!password){
            return res.status(400).json({
                success:false,
                message:"Email and password are required"
            });
        }

        const user=await User.findOne({
            email:email.toLowerCase()
        });

        if(!user){
            return res.status(401).json({
                success:false,
                message:"Invalid email or password"
            });
        }
        
        const isPasswordCorrect =await bcrypt.compare(
            password,
            user.password
        );

        if(!isPasswordCorrect){
            return res.status(401).json({
                success:false,
                message:"Invalid email or password"
            });
        }

        ///Generate The JWT Token
        const token=jwt.sign(
            {
                userId:user._id
            },
            process.env.JWT_SECRET,
            {
                expiresIn:"7d"
            }
        );


        //send response
        res.status(200).json({
            success:true,
            message:"Login Successfully",
            token:token,
            user:{
                id:user._id,
                fullName:user.fullName,
                mobile:user.mobile,
                email:user.email
            }
        });

    }catch(error){
        console.log("Login error ",error);
        res.status(500).json({
            success:false,
            message:"Server error"
        });
    }
};






module.exports={
    registerUser,
    loginUser
};