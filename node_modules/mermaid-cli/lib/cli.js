var fs = require('fs')
  , chalk = require('chalk')
  , info = chalk.blue.bold
  , parseArgs = require('minimist')

var cli = function(options) {
  this.options = {
      alias: {
          help: 'h'
        , png: 'p'
        , outputDir: 'o'
        , svg: 's'
        , verbose: 'v'
      }
    , 'boolean': ['help', 'png', 'svg']
    , 'string': ['outputDir']
  }

  this.errors = []
  this.message = null

  this.helpMessage = [
    , info('Usage: mermaid [options] <file>...')
    , ""
    , "file    The mermaid description file to be rendered"
    , ""
    , "Options:"
    , "  -s --svg          Output SVG instead of PNG (experimental)"
    , "  -p --png          If SVG was selected, and you also want PNG, set this flag"
    , "  -o --outputDir    Directory to save files, will be created automatically, defaults to `cwd`"
    , "  -h --help         Show this message"
    , "  -v --verbose      Show logging"
    , "  --version         Print version and quit"
  ]

  return this
}

cli.prototype.parse = function(argv, next) {
  var options = parseArgs(argv, this.options)

  if (options.version) {
    var pkg = require('../package.json')
    this.message = "version " + pkg.version
  }
  else if (options.help) {
    this.message = this.helpMessage.join('\n')
  }
  else {
    options.files = options._

    if (!options.files.length) {
      this.errors.push(new Error("You must specify at least one source file."))
    }

    // ensure that parameter-expecting options have parameters
    ;['outputDir'].forEach(function(i) {
      if(typeof options[i] !== 'undefined') {
        if (typeof options[i] !== 'string' || options[i].length < 1) {
          this.errors.push(new Error(i + " expects a value."))
        }
      }
    }.bind(this))
  }

  if (options.svg && !options.png) {
    options.png = false
  }
  else {
    options.png = true
  }

  this.parsedOptions = options

  if (typeof next === 'function') {
    // we return the array of errors if there are any, otherwise null
    next(this.errors.length > 0 ? this.errors : null, this.message, options)
  }

  return this
}


module.exports = function() {
  return new cli()
}()
