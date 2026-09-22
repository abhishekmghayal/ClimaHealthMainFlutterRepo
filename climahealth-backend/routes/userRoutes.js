const express=require("express");

const authMiddleware=require("../middleware/authMiddleware");
const {
    getProfile,
    updateProfile,
    changePassword
}=require("../controllers/userController");

const router=express.Router();
router.get(
    "/profile",
    authMiddleware,
    getProfile
);
router.put(
    "/profile",
    authMiddleware,
    updateProfile
);
router.put(
    "/change-password",
    authMiddleware,
    changePassword
);

module.exports=router;