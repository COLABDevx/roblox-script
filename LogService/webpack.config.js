const path = require('path')
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const nodeExternals = require('webpack-node-externals')
const WebpackShellPluginNext = require('webpack-shell-plugin-next');


module.exports = {
    entry: './src/index.ts',
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: 'ts-loader',
                exclude: /node_modules/,
            },
        ],
    },
    resolve: {
        extensions: ['.tsx', '.ts', '.js'],
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, '.colab-hub-cache'),
    },
    mode: "development",
    target: "node",
    devServer: {
        devMiddleware: {
            writeToDisk: true
        },
        port: 7070,
    },
    externals: [nodeExternals()],
    plugins: [
        new CleanWebpackPlugin(),
        // new WebpackShellPluginNext({ 
        //     onBuildEnd:{
        //       scripts: ['node .colab-hub-cache/main.bundle.js'],
        //       blocking: false,
        //       parallel: true
        //     }
        //   })
      
    ],
};