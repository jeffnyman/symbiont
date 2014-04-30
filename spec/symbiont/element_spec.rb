require 'spec_helper'

describe Symbiont::Element do
  include_context :page
  include_context :element

  provides_an 'element generator for', %w{text_field button}
end
