module.exports = {
  ensureAuthenticated: function(req, res, next) {
    if (req.isAuthenticated()) {
      console.log('still authenticated');
      return next();
    }
  }
}
