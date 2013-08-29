#!/usr/bin/env coffee

path = require 'path'
shelljs = require 'shelljs'
pkgmeta = require './package'
{quote} = require 'shell-quote'
watchr = require 'watchr'
path = require 'path'
fs = require 'fs'


COFFEE_SRC_DIR = "#{__dirname}/src"
COFFEE_OUTPUT_DIR = "#{__dirname}"
NODE_MODULES = path.join __dirname, 'node_modules/'
NODE_BIN_DIR = "#{NODE_MODULES}.bin/"


option '-d', '--dev', 'Run tasks in dev mode (defaults to false)'


{cd, rm, find, mv} = shelljs
findCoffee = (dir) -> find(dir).filter (f) -> f.match /.*\.(coffee|litcoffee)$/
exec = (cmd, args, opts) ->
  shelljs.exec quote([cmd, args...]), opts


buildCoffee = (file) ->
  baseName = path.basename file
  compiledName = baseName.replace('.coffee', '.js')
  minName = baseName.replace('.coffee', '.min.js')
  shelljs.exec "#{NODE_BIN_DIR}coffee -l -c --map -o #{COFFEE_OUTPUT_DIR} #{file}"
  shelljs.exec "#{NODE_BIN_DIR}uglifyjs -o #{COFFEE_OUTPUT_DIR}/#{minName} #{COFFEE_OUTPUT_DIR}/#{compiledName}"
  fs.createReadStream('src/muckraking.coffee').pipe(fs.createWriteStream('README.md'));





task 'build:docs', "build the #{pkgmeta.name} CoffeeScript docs", ->
  for f in findCoffee(COFFEE_SRC_DIR)
    dir = path.relative COFFEE_SRC_DIR, path.dirname(f)
    exec "#{NODE_BIN_DIR}docco", [f, '-o', "./docs/coffee/#{dir}"]



task 'build:coffee', ->
  cd COFFEE_SRC_DIR
  for f in findCoffee '.'
    console.log "Compiling #{f}..."
    buildCoffee f
  cd __dirname


task 'build', ->
  invoke 'build:code'
  invoke 'build:docs'


task 'watch', ->

  watchr.watch
    paths: ["#{COFFEE_SRC_DIR}",]
    listeners:
      change: (changeType,filePath,fileCurrentStat,filePreviousStat) ->

        if path.extname(filePath) is '.coffee'
          console.log 'Change detected to ', filePath
          buildCoffee(filePath)

