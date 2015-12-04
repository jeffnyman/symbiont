RSpec.describe Symbiont::Elements do
  include_context :page
  include_context :element

  provides_an 'element generator for', %w{text_field button}
  provides_an 'element set generator for', %w{text_field file_field textarea}
  provides_an 'element select generator for', %w{select_list}
end
