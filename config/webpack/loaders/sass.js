const cssLoader = require('@rails/webpacker/package/rules/css')
const cloneDeep = require('lodash/fp/cloneDeep')
const deepMerge = require('@rails/webpacker/package/utils/deep_merge')

let sassLoader = cloneDeep(cssLoader)
module.exports = deepMerge(sassLoader, {
    test: /\.(scss|sass)$/i,
    use: [{
        loader: 'sass-loader',
        options: {
            includePaths: ['node_modules'],
            sourceMap: true,
        },
    }]
})