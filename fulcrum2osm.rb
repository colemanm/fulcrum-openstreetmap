#!/usr/bin/env ruby

require 'rubygems'
require 'thor'
require 'csv'
require 'json'
require 'fileutils'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash'

class Fulcrum2osm < Thor

  desc "surveillance", "Convert Fulcrum surveillance cams to .osm format"
  method_option :file, :aliases => '-f', :desc => "Fulcrum exported CSV file to convert"
  def surveillance
    data = File.read(File.expand_path(options[:file]))
    nodes = []
    index = 1
    CSV.foreach(options[:file], :headers => true) do |row|
      parts = []
      parts << "<node id='-#{index}' action='modify' visible='true' lat='#{row["latitude"]}' lon='#{row["longitude"]}'>"
      %w(surveillance_type surveillance camera_type mount).each do |item|
        parts << "<tag k='#{row[item].split("=").first}' v='#{row[item].split("=").last}' />"
      end
      %w(note source).each do |item|
        parts << "<tag k='#{item}' v='#{row[item]}' />"
      end
      index = index + 1
      parts << "</node>"
      nodes << parts.join("\n")
    end

    puts "#{header}#{nodes.join("\n")}\n#{footer}"

  end

  no_tasks do
    def header
      <<-EOS
<?xml version='1.0' encoding='UTF-8'?>
<osm version='0.6' upload='true' generator='JOSM'>
      EOS
    end

    def footer
      <<-EOS
</osm>
      EOS
    end
  end

end

Fulcrum2osm.start