# frozen_string_literal: true

[
  File.expand_path('../', __dir__),
  File.expand_path(__dir__, "/lib"),
  File.expand_path(__dir__.gsub('test', '')),
].each { |load_path| $LOAD_PATH.unshift load_path }

require "justcall_ruby"
require "minitest/autorun"
