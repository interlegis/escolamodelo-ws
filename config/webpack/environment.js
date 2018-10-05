const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const sass = require('./loaders/sass')

environment.loaders.append('typescript', typescript)
environment.loaders.append('sass', sass)
module.exports = environment
