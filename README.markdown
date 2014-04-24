Outline Grep
============

Given a text file with a Python-style indentation structure, `ogrep`
searches the file for a regular expression.  It prints matching lines, with
their "parent" lines as context.  For example, if input.txt looks like this:

    2009-01-01
      New Year's Day!
        No work today.
        Visit with family.
    2009-01-02
      Grocery store and library.
    2009-01-03
      Stay home.
    2009-01-04
      Back to work.
        Remember to set an alarm.

then `ogrep work input.txt` will produce the following output:

    2009-01-01
      New Year's Day!
        No work today.
    2009-01-04
      Back to work.

Installation
------------

Get the source code: `git clone git://github.com/mbrubeck/outline-grep.git; cd
outline-grep`

OS X or Windows users, download the [Haskell Platform][1].  Then type `cabal
install`.

[1]: http://hackage.haskell.org/platform/

Debian/Ubuntu users, run: `sudo aptitude install libghc6-regex-posix-dev`,
then run:

    ./Setup.lhs configure
    ./Setup.lhs build
    sudo ./Setup.lhs install

Or to try the program without building and installing it, just run
`./OutlineGrep.lhs` in the source directory after installing the Haskell
Platform (or the libghc6-regex-posix-dev package).

Copyright
---------

Copyright (c) 2009 Matt Brubeck

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
