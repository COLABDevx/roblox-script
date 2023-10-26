const webpack = require('webpack');
const webpackConfig = require('./webpack.config')
const { spawn } = require("child_process");
const compiler = webpack(webpackConfig);

let spawnProcess;
compiler.hooks.watchRun.tap('Dev', (compile) => {
  if (spawnProcess) {
    spawnProcess.kill();
    spawnProcess = undefined;
  }
});

compiler.watch({}, (err, stats) => {

  if (err) {
    console.error(err);
  } else if (stats.hasErrors()) { 
    console.error(stats.toString('errors-only'));
  } else { 
    // console.log(stats.toString({ colors: true }));
    spawnProcess = spawn('node', ['./.colab-hub-cache/main.bundle.js'],{ stdio: "inherit", });
  }
})