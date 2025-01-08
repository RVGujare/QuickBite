const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const orderSchema = new Schema({
  items: [
    {
      outletId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Outlet",
      },
      _id: {
        type: mongoose.Schema.Types.ObjectId,
      },
      quantity: {
        type: Number,
      },
    },
  ],
  totalAmount: Number,
  createdAt: { type: Date, default: Date.now },
  status: {
    type: String,
    default: 'Placed'
  },
  pickUpTime: Date
});

module.exports = mongoose.model("Order", orderSchema);
