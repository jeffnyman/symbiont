require 'timeout'

module Symbiont
  module Element
    def element(name, *identifier)
      build(name, *identifier) do
        define_method(name.to_s) do |*options|
          find_first(*identifier, *options)
        end
      end
    end

    def elements(name, *identifier)
      build(name, *identifier) do
        define_method(name.to_s) do |*options|
          find_all(*identifier, *options)
        end
      end
    end

    private

    def build(name, *identifier)
      add_to_mapped_elements(name)
      yield
      add_element_methods(name, *identifier)
    end

    def add_to_mapped_elements(name)
      @mapped_elements ||= []
      @mapped_elements << name.to_s
    end

    def add_element_methods(name, *identifier)
      create_existence_check(name, *identifier)
      create_nonexistence_check(name, *identifier)
      create_wait_check(name, *identifier)
      create_visible_check(name, *identifier)
      create_invisible_check(name, *identifier)
    end

    def create_element_method(_name, *_identifier)
      yield
    end

    def create_existence_check(name, *identifier)
      method_name = "has_#{name}?"
      create_element_method(method_name, *identifier) do
        define_method(method_name) do |*args|
          wait_time = Symbiont.use_implicit_waits ? Capybara.default_max_wait_time : 0
          Capybara.using_wait_time(wait_time) do
            element_exists?(*identifier, *args)
          end
        end
      end
    end

    def create_nonexistence_check(name, *identifier)
      method_name = "has_no_#{name}?"
      create_element_method(method_name, *identifier) do
        define_method(method_name) do |*args|
          wait_time = Symbiont.use_implicit_waits ? Capybara.default_max_wait_time : 0
          Capybara.using_wait_time(wait_time) do
            element_does_not_exist?(*identifier, *args)
          end
        end
      end
    end

    def create_wait_check(name, *identifier)
      method_name = "wait_for_#{name}"
      create_element_method(method_name, *identifier) do
        define_method(method_name) do |timeout = nil, *args|
          timeout = timeout.nil? ? Capybara.default_max_wait_time : timeout
          Capybara.using_wait_time(timeout) do
            element_exists?(*identifier, *args)
          end
        end
      end
    end

    def create_visible_check(name, *identifier)
      method_name = "wait_until_#{name}_visible"
      create_element_method(method_name, *identifier) do
        define_method(method_name) do |timeout = Capybara.default_max_wait_time, *args|
          Timeout.timeout(timeout, Symbiont::Errors::ElementVisibleTimeout) do
            Capybara.using_wait_time(0) do
              sleep(0.05) until element_exists?(*identifier, *args, visible: true)
            end
          end
        end
      end
    end

    def create_invisible_check(name, *identifier)
      method_name = "wait_until_#{name}_invisible"
      create_element_method(name, *identifier) do
        define_method(method_name) do |timeout = Capybara.default_max_wait_time, *args|
          Timeout.timeout(timeout, Symbiont::Errors::ElementNonVisibleTimeout) do
            Capybara.using_wait_time(0) do
              sleep(0.05) while element_exists?(*identifier, *args, visible: true)
            end
          end
        end
      end
    end
  end
end
