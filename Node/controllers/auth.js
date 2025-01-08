const { default: mongoose } = require("mongoose");
const User = require("../models/user");

exports.fetchUserStatus = async (req, res, next) => {
  const email = req.params.email;
  try {
    const user = await User.findOne({ email: email });
    console.log(user);
    if (!user) {
      return res.status(200).json(false);
    }
    return res.status(200).json(true);
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.fetchUser = async (req, res, next) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId);

    if (!user) {
      const error = new Error("User not found");
      error.statusCode = 400;
      throw error;
    }

    res.status(200).json({ user: user});
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500;
    }
    next(err);
  }
};

exports.updateUserDetails = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const updatedData = req.body;

    if (!updatedData || Object.keys(updatedData).length === 0) {
      return res.status(400).json({ message: "No data provided for update" });
    }

    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    user.firstName = updatedData.firstName || user.firstName;
    user.lastName = updatedData.lastName || user.lastName;
    user.phone = "+91" + updatedData.phone || user.phone;
    user.cart = [];

    const savedUser = await user.save();

    res.status(200).json({
      message: "User updated successfully",
      user: savedUser,
    });
  } catch (error) {
    console.error("Error updating user:", error);
    res.status(500).json({ message: "Internal server error" });
  }
};

exports.signup = async (req, res, next) => {
  try {
    const email = req.body.email;
    const uid = req.body.uid;
    const user = new User({
      _id: uid,
      email: email,
    });
    await user.save();
    res
      .status(201)
      .json({ message: "User created", userId: user._id });
  } catch (error) {
    res.status(500).json({ message: "Server error", error: error.message });
  }
};
