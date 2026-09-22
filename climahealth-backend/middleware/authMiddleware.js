const jwt=require("jsonwebtoken");
const authMiddleware=(req,res,next)=>{
    try{
        const authHeader=req.headers.authorization;
        if(!authHeader){
            return res.status.json({
                success:false,
                message:"Authorization header is missing"
            });
        }

        const token=authHeader.split(" ")[1];
        if(!token){
            return res.status.json({
                success:false,
                message:"Token is missing"
            });
        }
        const decoded=jwt.verify(
            token,
            process.env.JWT_SECRET
        );
        req.user=decoded;
        next();
    }catch(error){
        return res.status(401).json({
            success:false,
            message:"Invalid Or expired token"
        });
    }
};
module.exports=authMiddleware;