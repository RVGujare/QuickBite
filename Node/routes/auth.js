const express = require('express');

const router = express.Router();

const authController = require('../controllers/auth');


//to signup user  // POST /auth/signup
router.post('/signup', authController.signup);

//to check if user exists  // GET /auth/user/:email
router.get('/user/status/:email', authController.fetchUserStatus);

//to get the user data  // GET /auth/user/:userId
router.get('/user/:userId', authController.fetchUser);

//to update the user data  // PUT /auth/user/:userId
router.put('/user/:userId', authController.updateUserDetails);

module.exports = router;