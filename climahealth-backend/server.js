const express=require("express");
const cors=require("cors");
const dotenv=require("dotenv");


const connectDB=require("./config/db");
const authRoutes = require("./routes/authRoutes");
const userRoutes=require("./routes/userRoutes");

dotenv.config();

const app=express();

connectDB();

app.use(cors());
app.use(express.json());

//Routes
app.use("/api/auth",authRoutes)
app.use("/api/user",userRoutes);


app.get("/",(req,res)=>{
    res.json({message:"ClimaHeath API Is running"});
});

const PORT=process.env.PORT||3000

app.listen(PORT,()=>{
    console.log('ClimaHealth server running on port 3000');
});