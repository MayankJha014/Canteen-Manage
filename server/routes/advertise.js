const express = require("express");
const advertiseRouter = express.Router();
const auth = require("../middlewares/auth");
const { Advertise } = require("../models/advertise");

//Get all your products

advertiseRouter.get("/api/ads", async (req, res) => {
  try {
    const advertises = await Advertise.find();
    res.json(advertises);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = advertiseRouter;
