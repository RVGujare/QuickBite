const express = require("express");

const router = express.Router();
const outletController = require("../controllers/outlets");

//to get the outlets
router.get("/outlets", outletController.getOutlets);

// to update the cart quantity //POST /cart/update
router.post('/cart/update', outletController.updateCart);

//to get the cart details for the quantity button
router.get('/cart/:userId', outletController.getCart);

//to get the complete populated cart details for the cart page
router.get('/cart/complete/:userId', outletController.getCompleteCart);

//to place an order
router.post('/order/place/:userId', outletController.placeOrder);

//to get the order details
router.get('/order/:userId', outletController.getOrders);

module.exports = router;
