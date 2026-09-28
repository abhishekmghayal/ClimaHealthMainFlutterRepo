const User=require("../models/User");
const bcrypt=require("bcryptjs");
const getProfile=async (req,res)=>{

    try{
        const userId=req.user.userId;
        const user=await User.findById(userId).select("-password");
        if(!user){
            return res.status(404).json({
                success:false,
                message:"User Not found"
            });
        }
        
        //send user Profile
        res.status(200).json({
            success:true,
            message:"Profile fetched Successfully",
            user:{
                id:user._id,
                fullName:user.fullName,
                mobile:user.mobile,
                email:user.email,
                bloodGroup:user.bloodGroup,
                height:user.height,
                birthDate:user.birthDate,
                profileImage: user.profileImage
            }
        });
    }catch(error){
        console.error("Get profile error ", error);
        res.status(500).json({
            success:false,
            message:"Server Error"
        });
    }
};


const updateProfile=async (req,res)=>{
    try{
        const userId=req.user.userId;
        
        const {
            fullName,
            mobile,
            email,
            bloodGroup,
            height,
            birthDate
        }=req.body;

        if(!fullName|| !mobile|| !email){
            return res.json({
                success:false,
                message:"Full Name email Mobile are required"
            });
        }

        const existingUser=await User.findOne({
            email:email.toLowerCase().trim(),
            _id:{ $ne:userId}
        });

        if(existingUser){
            return res.json({
                success:false,
                message:"Email is already registered by another user"
            });
        }

        ///Update the loggeed user 

        const updatedUser=await User.findByIdAndUpdate(
            userId,{
                fullName:fullName.trim(),
                mobile:mobile.trim(),
                email:email.toLowerCase().trim(),
                bloodGroup:bloodGroup ? bloodGroup.trim(): undefined,
                height:height !== undefined ? height:undefined,
                birthDate:birthDate || undefined 
            },
            {
                new:true,
                runValidators:true
            }
        ).select("-password");
        if(!updatedUser){
            return res.status(400).json({
                success:false,
                message:"User Not Found"
            });
        }
        res.status(200).json({
            success:true,
            message:"Profile updated Successfully",
            user:{
                id: updatedUser._id,
                fullName: updatedUser.fullName,
                mobile: updatedUser.mobile,
                email: updatedUser.email,
                bloodGroup: updatedUser.bloodGroup,
                height: updatedUser.height,
                birthDate: updatedUser.birthDate
            }
        });
    }catch(error){
        console.error("Update profile error:", error);
        res.status(500).json({
            success: false,
            message: "Server Error"
        });
    }
};






const changePassword=async (req,res)=>{
    try{
        const userId=req.user.userId;
        const{
            currentPassword,
            newPassword
        }=req.body;
        if(!currentPassword||!newPassword){
            return res.status(400).json({
                success:false,
                message:"Current password and new password are required"
            });
        }

        if(newPassword.length<6){
            return res.status(400).json({
                success:false,
                message:"New Password must be at least 6 characters"
            });
        }

        const user=await User.findById(userId);
        if(!user){
            return res.status(404).json({
                success:false,
                message:"User not found"
            });
        }

        const isPasswordCorrect=await bcrypt.compare(
            currentPassword,user.password
        );

        if(!isPasswordCorrect){
            return res.status(401).json({
                success:false,
                message:"Current Password is incorrect"
            });
        }
        const hashedPassword=await bcrypt.hash(newPassword,10);
        user.password=hashedPassword;
        await user.save();
        res.status(200).json({
            success:true,
            message:"Password changed successfully"
        });
    }catch(error){
        console.error("change password error ",error);
        res.status(500).json({
            success:false,
            message:"Server error"
        });
    }
};



const uploadProfileImage = async (req, res) => {
    try {
        const userId = req.user.userId;

        if (!req.file) {
            return res.status(400).json({
                success: false,
                message: "Profile image is required"
            });
        }

        const imageUrl = `/uploads/${req.file.filename}`;

        const updatedUser = await User.findByIdAndUpdate(
            userId,
            {
                profileImage: imageUrl
            },
            {
                new: true
            }
        ).select("-password");

        if (!updatedUser) {
            return res.status(404).json({
                success: false,
                message: "User not found"
            });
        }

        res.status(200).json({
            success: true,
            message: "Profile image uploaded successfully",
            profileImage: imageUrl
        });

    } catch (error) {
        console.error("Upload profile image error:", error);

        res.status(500).json({
            success: false,
            message: "Server Error"
        });
    }
};


module.exports={
    getProfile,
    updateProfile,
    changePassword,
    uploadProfileImage
};