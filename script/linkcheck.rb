#!/usr/bin/env ruby
# Check that every internal link in the built site resolves.
#
#   ruby script/linkcheck.rb [_site]
#
# A bare directory only counts as resolved if it contains an index.html,
# because GitHub Pages returns 404 for a directory with no index.

require "find"

root = (ARGV[0] || "_site").chomp("/")
abort "not a directory: #{root}" unless File.directory?(root)

missing = []
Find.find(root) do |path|
  next unless path.end_with?(".html")
  html = File.read(path, encoding: "UTF-8", invalid: :replace)
  html.scan(/(?:href|src)="([^"#?:]+)"/) do |(link)|
    next if link.empty? || link.start_with?("//")
    target = link.start_with?("/") ? File.join(root, link) : File.join(File.dirname(path), link)
    ok = if File.directory?(target)
           File.exist?(File.join(target, "index.html"))
         else
           File.exist?(target) || File.exist?("#{target}.html")
         end
    missing << "#{path.sub(%r{\A#{Regexp.escape(root)}/}, "")} -> #{link}" unless ok
  end
end

if missing.empty?
  puts "PASS: no broken internal links"
else
  puts "FAIL: #{missing.size} broken internal link(s)"
  puts missing.uniq.sort
  exit 1
end
