const mongoose = require("mongoose");

const advertiseSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  images: [
    {
      type: String,
      required: true,
    },
  ],
  price: {
    type: Number,
    required: true,
  },
});

const Advertise = mongoose.model("Advertise", advertiseSchema);
module.exports = { Advertise, advertiseSchema };
