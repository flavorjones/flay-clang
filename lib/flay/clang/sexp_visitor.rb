require "flay/clang/visitor"

class Flay
  module Clang
    class SexpVisitor < Visitor
      ALL_NODES.each do |node|
        define_method "visit_#{node}" do |cursor|
          sexp = s(node.to_sym, *super(cursor))
          sexp.line = cursor.location.line
          sexp.file = cursor.location.file
          sexp
        end
      end
    end
  end
end
