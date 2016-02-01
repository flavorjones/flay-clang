require 'test_helper'

describe Flay do
  describe Flay::Clang do
    it "processes C code" do
      ast = Flay.new.process_c FLAY_CLANG_FIXTURES.join("simple.c").to_s
      ast.must_be_kind_of Sexp
      ast.inspect.must_match /simple_method/
    end
  end
end
