module.exports = {
  ensureAuthenticated: function(req, res, next) {
    if (req.isAuthenticated()) {
      console.log('req.isAuthenticated() = true')
      return next();
    }
  }
}
