const express = require("express");
// import 'package:express/express.dart' it is same in express
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin.js");
const advertiseRouter = require("./routes/advertise.js");

//Imports From Other Files
const authRouter = require("./routes/auth.js");
const productRouter = require("./routes/product.js");
const userRouter = require("./routes/user.js");

//INIT
const PORT = process.env.PORT || 3000;
const app = express();

const DB =
  "mongodb+srv://Luffy:luffy@cluster0.xdtg4.mongodb.net/RajMaggiStation";

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(advertiseRouter);

app.use(userRouter);

//Connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at port ${PORT}`);
});
