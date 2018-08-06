const webpack = require("webpack");

const path = require("path");
const objectAssign = require("object-assign");

const NODE_ENV = process.env.NODE_ENV;

const env = {
  production: NODE_ENV === "production",
  staging: NODE_ENV === "staging",
  test: NODE_ENV === "test",
  development: NODE_ENV === "development" || typeof NODE_ENV === "undefined"
};

objectAssign(env, {
  build: (env.production || env.staging)
});

module.exports = {
  target: "web",
  entry: [path.join(__dirname, "../index.jsx")],
  output: {
    path: path.join(__dirname, "../../assets/js"),
    publicPath: "/js/",
    filename: "bundle.js"
  },
  module: {
    loaders: [
      {
        test: /\.js(x?)$/,
        cacheDirectory: true,
        exclude: [/node_modules/],
        loader: "babel-loader?presets[]=es2015&presets[]=react"
      }
    ]
  },
  resolve: {
    modulesDirectories: ["node_modules"],
    extensions: ["", ".js", ".jsx"]
  },
  plugins: [
  ],
  cache: true
};
