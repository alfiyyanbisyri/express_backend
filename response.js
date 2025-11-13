const response = (statusCode, data, message, res) => {
  res.status(statusCode).json({
    products: data,
      
    pagination: {
      prev: "",
      next: "",
      max: ""
    }
  });
};

module.exports = response;
