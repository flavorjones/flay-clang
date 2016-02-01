require "flay" # prerequisite
require "flay/clang"

class Flay
  def process_c filename
    Clang.sexp_for(filename)
  end
end
