require 'rake/clean'

CLEAN.push *Dir['public/**/*.css']
CLEAN.push *Dir['vendor/assets']

CLOBBER.push *Dir['.sass-cache']
