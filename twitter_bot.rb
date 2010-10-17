#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'oauth'
require 'json'
require 'hpricot'
require 'open-uri'
require 'yaml'
require 'parsedate'
require "kconv"
require File.dirname(__FILE__) + '/twitter_oauth'

# Usage:
#  1. このファイルと同じディレクトリに以下5つのファイルを設置します。
#   * twitter_oauth.rb
#    * http://github.com/japanrock/TwitterTools/blob/master/twitter_oauth.rb
#   * sercret_key.yml
#    * http://github.com/japanrock/TwitterTools/blob/master/secret_keys.yml.example
#   * words.yml
#    * http://github.com/japanrock/TwitterProgrammingHistoricRemark/blob/master/words.yml 
#  2. このファイルを実行します。
#   ruby twitter_bot.rb

class ProgrammingHistoricRemark
  attr_reader :selected_culture
  attr_reader :select

  def initialize
    @culture = YAML.load_file(File.dirname(__FILE__) +  '/words.yml')
  end

  def head
    ""
  end

  def random_select
    @selected_culture = @culture[select]
  end

  # ポストする範囲を指定する
  def select
    @select = rand(194)
  end
end

twitter_oauth = TwitterOauth.new
programming_historic_remark = ProgrammingHistoricRemark.new

content  = programming_historic_remark.random_select
head     = programming_historic_remark.head
url      = programming_historic_remark.selected_culture["url"]
contents = programming_historic_remark.selected_culture["contents"]

twitter_oauth.post(head + contents + " " + url)
