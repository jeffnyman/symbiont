#require 'symbiont/ready'

RSpec.describe Symbiont::Ready do
  let(:test_page) do
    Class.new do
      include Symbiont::Ready

      def page_object_action
        :page_object_action
      end
    end
  end

  describe 'page_ready' do
    it 'adds validations to the ready_validations list' do
      expect { test_page.page_ready { true } }.to change { test_page.ready_validations.size }.by(1)
    end
  end

  describe 'ready validations' do
    it 'returns the ready validations from the current and all ancestral classes in hierarchical, defined order' do
      subclass = Class.new(test_page)
      validation_1 = -> { true }
      validation_2 = -> { true }
      validation_3 = -> { true }
      validation_4 = -> { true }

      subclass.page_ready(&validation_1)
      test_page.page_ready(&validation_2)
      subclass.page_ready(&validation_3)
      test_page.page_ready(&validation_4)

      expect(subclass.ready_validations).to eql [validation_2, validation_4, validation_1, validation_3]
    end
  end

  describe 'when ready' do
    it 'requires a block to be processed' do
      expect { test_page.new.when_ready }.to raise_error ArgumentError
    end

    it 'executes and yields itself to a provided block when all ready validations pass' do
      test_page.page_ready { true }
      instance = test_page.new

      expect(instance).to receive(:page_object_action)

      instance.when_ready do |action|
        action.page_object_action && true
      end
    end

    it 'raises an exception if any ready validation fails' do
      fake_page = spy

      test_page.page_ready { true }
      test_page.page_ready { false }

      expect do
        test_page.new.when_ready { fake_page.test_action }
      end.to raise_error(Symbiont::Errors::PageNotValidatedError, /no reason provided/)

      expect(fake_page).not_to have_received(:test_action)
    end

    it 'raises an exception with specific error message if available when a readdy validation fails' do
      test_page.page_ready { [false, 'reason provided'] }

      expect do
        test_page.new.when_ready { puts 'testing' }
      end.to raise_error(Symbiont::Errors::PageNotValidatedError, /reason provided/)
    end

    it 'raises immediately on the first validation failure' do
      validation_1 = spy(valid?: false)
      validation_2 = spy(valid?: false)

      test_page.page_ready { validation_1.valid? }
      test_page.page_ready { validation_2.valid? }

      expect do
        test_page.new.when_ready { puts 'testing' }
      end.to raise_error(Symbiont::Errors::PageNotValidatedError)

      expect(validation_1).to have_received(:valid?).once
      expect(validation_2).not_to have_received(:valid?)
    end

    it 'executes validations only once for nested calls' do
      fake_page = spy
      validation_1 = spy(valid?: true)

      test_page.page_ready { validation_1.valid? }
      instance = test_page.new

      instance.when_ready do
        instance.when_ready do
          instance.when_ready do
            fake_page.test_action
          end
        end
      end

      expect(fake_page).to have_received(:test_action)
      expect(validation_1).to have_received(:valid?).once
    end

    it 'resets the ready cache at the end of the block' do
      test_page.page_ready { true }

      instance = test_page.new
      expect(instance.ready).to be nil

      instance.when_ready do |i|
        expect(i.ready).to be true
      end

      expect(instance.ready).to be nil
    end
  end

  describe 'ready?' do
    let(:inherit_test_page) { Class.new(test_page) }

    it 'returns true if all ready validations pass' do
      test_page.page_ready { true }
      test_page.page_ready { true }
      inherit_test_page.page_ready { true }
      inherit_test_page.page_ready { true }

      expect(inherit_test_page.new).to be_ready
    end

    it 'returns false if any ready validation fails' do
      test_page.page_ready { true }
      test_page.page_ready { true }
      inherit_test_page.page_ready { true }
      inherit_test_page.page_ready { false }

      expect(inherit_test_page.new).not_to be_ready
    end

    it 'returns false if any ready validation fails in the inheritance chain' do
      test_page.page_ready { true }
      test_page.page_ready { false }
      inherit_test_page.page_ready { true }
      inherit_test_page.page_ready { true }

      expect(inherit_test_page.new).not_to be_ready
    end

    it 'sets load_error if a failing load_validation supplies one' do
      test_page.page_ready { [true, 'will not fail'] }
      test_page.page_ready { [false, 'will fail'] }
      inherit_test_page.page_ready { [true, 'will not fail'] }
      inherit_test_page.page_ready { [true, 'will not fail'] }

      instance = inherit_test_page.new
      instance.ready?
      expect(instance.ready_error).to eql 'will fail'
    end

    it 'recognizes if a ready value is cached' do
      validation_1 = spy(valid?: true)
      test_page.page_ready { validation_1.valid? }
      instance = test_page.new
      instance.ready = true

      expect(instance).to be_ready
      expect(validation_1).not_to have_received(:valid?)
    end
  end
end
