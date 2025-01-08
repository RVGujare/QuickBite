const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const outletSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    required: true,
  },
  isOpen: {
    type: Boolean,
    required: true,
  },
  prepTime: {
    type: Number,
    required: true,
  },
  items: [
    {
      _id: {
        type: mongoose.Types.ObjectId,
        required: true,
      },
      name: {
        type: String,
        required: true,
      },
      image: {
        type: String,
        required: true,
      },
      price: {
        type: Number,
        required: true,
      },
      description: {
        type: String,
        required: true,
      },
      
    },
  ],
});

outletSchema.methods.toJSON = function () {
  const obj = this.toObject();
  // Convert ObjectId to string for each item

  obj.items.forEach((item) => {
    item._id = item._id.toString(); // Convert ObjectId to string
  });
  return obj;
};

module.exports = mongoose.model("Outlet", outletSchema);
