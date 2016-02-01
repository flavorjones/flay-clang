require "flay/clang/version"
require "flay/clang/visitor"
require "flay/clang/sexp_visitor"
require "ffi/clang"

class Flay
  module Clang
    def self.sexp_for filename
      index = FFI::Clang::Index.new
      translation_unit = index.parse_translation_unit(filename)
      cursor = translation_unit.cursor
      SexpVisitor.new(filename).accept(cursor)
    end
  end
end
