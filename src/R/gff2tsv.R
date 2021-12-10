#!/usr/bin/env Rscript

# reformat_gff.R
#
# Author: daniel.lundin@dbb.su.se

suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(readr))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(dtplyr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(stringr))

SCRIPT_VERSION = "0.1"

options(warn = 1)

# Get arguments
option_list = list(
  make_option(
    c("-v", "--verbose"), action="store_true", default=FALSE, 
    help="Print progress messages"
  ),
  make_option(
    c("-V", "--version"), action="store_true", default=FALSE, 
    help="Print program version and exit"
  )
)
opt = parse_args(
  OptionParser(
    usage = "%prog [options] file0.gff[.gz] ... filen.gff[.gz]\n\n\tEach file will be transformed to tsv format and saved with a '.tsv.gz' file suffix.", 
    option_list = option_list
  ), 
  positional_arguments = TRUE
)

if ( opt$options$version ) {
  write(SCRIPT_VERSION, stdout())
  quit('no')
}

DEBUG   = 0
INFO    = 1
WARNING = 2
LOG_LEVELS = list(
  DEBUG   = list(n = 0, msg = 'DEBUG'),
  INFO    = list(n = 1, msg = 'INFO'),
  WARNING = list(n = 2, msg = 'WARNING'),
  ERROR   = list(n = 3, msg = 'ERROR')
)
logmsg    = function(msg, llevel='INFO') {
  if ( opt$options$verbose | LOG_LEVELS[[llevel]][["n"]] >= LOG_LEVELS[["INFO"]][["n"]] ) {
    write(
      sprintf("%s: %s: %s", llevel, format(Sys.time(), "%Y-%m-%d %H:%M:%S"), msg),
      stderr()
    )
  }
}

for ( f in options$args ) {
    logmsg(sprintf("Reading %s", f), DEBUG)
}
logmsg("Done")
