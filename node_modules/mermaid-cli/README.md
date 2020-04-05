# mermaid-cli

Render [mermaid chart description][mermaid] files to PNG or SVG.

## DEPRECATION NOTICE

As of [mermaid v0.3.0](https://www.npmjs.com/package/mermaid) this package has
been merged into mermaid core. Please do an `npm install -g mermaid` to get
the mermaid CLI functionality. This package will see no further updates, and
any new features will be added directly into mermaid.

## Installation

Install the module globally to expose the `mermaid` command to your environment.

```bash
npm install -g mermaid-cli
```

## Usage

```
$ mermaid --help

Usage: mermaid [options] <file>...

file    The mermaid description file to be rendered

Options:
  -s --svg          Output SVG instead of PNG (experimental)
  -p --png          If SVG was selected, and you also want PNG, set this flag
  -o --outputDir    Directory to save files, will be created automatically, defaults to `cwd`
  -h --help         Show this message
  -v --verbose      Show logging
  --version         Print version and quit
```

## Known Issues

- SVG output currently does some replacement on text, as mermaid's output is
  only appropriate for browsers. Text color and background color is not yet
  replicated; please use PNGs for most purposes until this is resolved.
- SVG output is decidedly non-standard. It works, but may cause issues in some
  viewers.

## History

- **v0.2.4**  
Adds deprecation notice.

- **v0.2.3**  
Adds tests, fixes output directory when creating SVGs

- **v0.2.2**  
Cleanup of phantom script, better handling of multiple files

- **v0.2.1**  
Makes things easier to read; makes 'verbose' do something

- **v0.2.0**  
Pretty good PNG output, rudimentary SVG output

- **v0.1.0**  
Simplify SVG output, default to PNG

- **v0.0.1**  
Functional PNG support.

- **v0.0.0**  
Early release.

[mermaid]: https://github.com/knsv/mermaid/

## The MIT License (MIT)

Copyright (c) 2014 Nathan Wittstock

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
