const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");
const User = require("../models/user");
const { Advertise } = require("../models/advertise");
const { PromiseProvider } = require("mongoose");

// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your products
adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

///////ADS////////////////////

adminRouter.post("/admin/add-ads", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let advertise = new Advertise({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    advertise = await advertise.save();
    res.json(advertise);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your Ads
adminRouter.get("/admin/get-ads", admin, async (req, res) => {
  try {
    const advertises = await Advertise.find({});
    res.json(advertises);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the ADS

adminRouter.post("/admin/delete-ads", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let advertise = await Advertise.findByIdAndDelete(id);
    res.json(advertise);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({ status: { $lt: 2 } }, { _id: 0 });

    let i = 0;
    let userName = [];
    while (i < orders.length) {
      const user = await User.findOne({ id: orders[i]._id });
      userName.push(user.name);
      i++;
    }
    let j = 0;
    let result = [];
    while (j < orders.length) {
      let ans = [];
      ans[j] = { name: userName[j], products: orders[j] };

      result.push(ans[j]);
      j++;
    }
    res.status(200).json({
      result,
    });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;

    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    // CATEGORY WISE ORDER FETCHING
    let maggiEarnings = await fetchCategoryWiseProduct("Maggi");
    let pastaEarnings = await fetchCategoryWiseProduct("Pasta");
    let sandwichEarnings = await fetchCategoryWiseProduct("Sandwich");
    let beveragesEarnings = await fetchCategoryWiseProduct("Beverages");
    let mealEarnings = await fetchCategoryWiseProduct("Meal");

    let earnings = {
      totalEarnings,
      maggiEarnings,
      pastaEarnings,
      sandwichEarnings,
      beveragesEarnings,
      mealEarnings,
    };

    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });

  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;
