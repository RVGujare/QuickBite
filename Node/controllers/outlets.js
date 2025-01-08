const Outlet = require("../models/outlet");
const User = require("../models/user");
const Order = require("../models/order");
const mongoose = require("mongoose");
const { format } = require('date-fns');

exports.getOutlets = async (req, res, next) => {
  const outlets = await Outlet.find();
  if (!outlets) {
    const error = new Error("No outlets found");
    error.statusCode = 404;
    throw error;
  }

  outlets.map((outlet) => {
    const outletJSON = outlet.toJSON();

    return outletJSON;
  });

  return res.status(200).json({ outlets: outlets });
};

exports.updateCart = async (req, res, next) => {
  const userId = req.body.userId;
  const outletId = req.body.outletId;
  const itemId = req.body.itemId;
  const quantity = req.body.quantity;

  try {
    const user = await User.findById(userId);
    var objectIdOutlet;
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (outletId !== "") {
      objectIdOutlet = new mongoose.Types.ObjectId(`${outletId}`);
    }

    const objectIdItem = new mongoose.Types.ObjectId(`${itemId}`);

    const itemIndex = user.cart.findIndex(
      (item) => item._id.toString() === objectIdItem.toString()
    );
    if (itemIndex > -1) {
      if (quantity > 0) {
        user.cart[itemIndex].quantity = quantity;
      } else {
        user.cart.splice(itemIndex, 1);
      }
    } else {
      if (outletId !== "") {
        user.cart.push({
          outletId: objectIdOutlet,
          _id: objectIdItem,
          quantity,
        });
      }
    }
    await user.save();

    res
      .status(200)
      .json({ message: "Cart updated successfully", cart: user.cart });
  } catch (error) {
    console.error("Error updating user:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};

exports.getCart = async (req, res, next) => {
  const userId = req.params.userId;
  try {
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res
      .status(200)
      .json({ message: "Cart fetched successfully", cart: user.cart });
  } catch (error) {
    console.error("Error fetching user:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};

exports.getCompleteCart = async (req, res, next) => {
  const userId = req.params.userId;

  try {
    const user = await User.findById(userId).populate({
      path: "cart.outletId",
      model: "Outlet",
      select: "items name prepTime isOpen",
    });

    if (!user) {
      throw new Error("User not found");
    }

    const detailedCart = user.cart.map((cartItem) => {
      const outlet = cartItem.outletId;

      const itemDetails = outlet.items.find(
        (item) => item._id.toString() === cartItem._id.toString()
      );

      if (!itemDetails) {
        throw new Error(
          `Item with ID ${cartItem.itemId} not found in Outlet ${outlet._id}`
        );
      }

      const objectIdItem = new mongoose.Types.ObjectId(`${itemDetails._id}`);

      return {
        outletName: outlet.name,
        prepTime: outlet.prepTime,
        isOpen: outlet.isOpen,
        _id: objectIdItem,
        itemName: itemDetails.name,
        price: itemDetails.price,
        itemImage: itemDetails.image,
        quantity: cartItem.quantity,
      };
    });

    res
      .status(200)
      .json({ message: "complete cart fetched", cart: detailedCart });
  } catch (error) {
    console.error("Error fetching user cart:", error.message);
    throw error;
  }
};

exports.placeOrder = async (req, res, next) => {
  try {
    const userId = req.params.userId;
    const totalPrice = req.body.totalPrice;
    const pickUpTime = req.body.pickUpTime;

    const user = await User.findById(userId);

    if (!user) {
      throw new Error("User not found");
    }

    if (user.cart.length == 0) {
      throw new Error("Cart is empty");
    }

    const currentDate = new Date();
    const pickUpDateTime = new Date(
      currentDate.getFullYear(),
      currentDate.getMonth(),
      currentDate.getDate(),
      pickUpTime.hour,
      pickUpTime.minute
    );

    const newOrder = new Order({
      items: user.cart,
      totalAmount: totalPrice,
      pickUpTime: pickUpDateTime,
    });

    await newOrder.save();

    user.orders.push(newOrder._id);
    user.cart = [];
    await user.save();

    res.status(200).json({ message: "Order placed", cart: user.cart });
  } catch (error) {
    console.error("Error placing order:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};

exports.getOrders = async (req, res, next) => {
  const userId = req.params.userId;
  try {
    const user = await User.findById(userId).populate({
      path: "orders", // Populate orders array
      populate: {
        path: "items.outletId", // Populate outlet details for each item
        model: "Outlet", // Your Outlet schema
      },
    });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const detailedOrders = user.orders.map((order) => {
      const processedItems = order.items.map((orderItem) => {
        const outlet = orderItem.outletId;

        // Find specific item details in the outlet's items array
        const itemDetails = outlet.items.find(
          (item) => item._id.toString() === orderItem._id.toString()
        );

        if (!itemDetails) {
          throw new Error(
            `Item with ID ${orderItem._id} not found in Outlet ${outlet._id}`
          );
        }

        return {
          outletName: outlet.name, 
          itemName: itemDetails.name,
          price: itemDetails.price,
          itemImage: itemDetails.image,
          quantity: orderItem.quantity,
        };
      });
      const pickUpTime = format(new Date(order.pickUpTime), "dd/MM/yyyy, hh:mm a");
      const createdAt = format(new Date(order.createdAt), "dd/MM/yyyy, hh:mm a");
      
      return {
        _id: order._id.toString(),
        items: processedItems,
        totalAmount: order.totalAmount,
        status: order.status,
        pickUpTime: pickUpTime.toLocaleString(),
        createdAt: createdAt.toLocaleString(),
      };
    });
    
    

    res.status(200).json({ orders: detailedOrders });
  } catch (error) {
    console.error("Error fetching orders");
    res.status(500).json({ message: "Internal server error" });
  }
};
