#! /opt/homebrew/opt/ruby/bin/ruby
require "open-uri"
require "optparse"

USAGE = "Usage: down [file paths] [-h] [-o | --output [output path]]"

options = {}
OptionParser.new do |opt|
    opt.banner = USAGE
    opt.on("-o", "--output PATH") { |o| options[:output] = o }
    opt.on("-h", "--help") do
        puts opt.banner
        exit
    end
end.parse!

OUTPATH_DEFAULT = nil
outpath = options[:output]
if !outpath.is_a?(String) then
    outpath = OUTPATH_DEFAULT
elsif outpath.length < 1 then
    outpath = OUTPATH_DEFAULT
end

(outpath[0] = "" if outpath[0] == ".") if outpath != nil


if ARGV.length != 1 then
    puts USAGE
    exit
end

inputurl = ARGV[0]

if inputurl.start_with? "https://github.com/" then
    s = inputurl.split("/")[3..]
    s[2] = "" if s[2] == "blob"
    inputurl = "https://raw.githubusercontent.com/" + s.join("/")
end


begin
    download = URI.open(inputurl)
rescue OpenURI::HTTPError
    puts "url '#{inputurl}' does not exist"
    exit
end


if outpath == nil then
    outpath = inputurl.split("/")[-1]
end

puts "replaced '#{outpath}'" if File.exist? outpath
IO.copy_stream(download, outpath)