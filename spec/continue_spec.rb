require "spec_helper"

RSpec.describe Continue do
  it "has a version number" do
    expect(Continue::VERSION).not_to be nil
  end

  describe "Run" do
    it "calls the provided lambda" do

      a = ->() {}

      expect(a).to receive(:call)

      Continue::Run [a]
    end

    it "calls successive lambdas after a call to success" do

      a = ->(s, _e, _v) { s.call }
      b = ->(s, _e, _v) { s.call }

      expect(a).to receive(:call).and_call_original
      expect(b).to receive(:call)

      Continue::Run [a, b]
    end

    it "does not call successive lambdas after a call to error" do

      a = ->(_s, e, _v) { e.call }
      b = ->() { }

      expect(a).to receive(:call).and_call_original
      expect(b).not_to receive(:call)

      Continue::Run [a, b]
    end

    it "works with the example from the readme" do

      o = double
      expect(o).to receive(:do_the_first_thing) { true }
      expect(o).to receive(:do_the_second_thing) { true }
      expect(o).to receive(:do_the_third_thing) { true }

      Continue::Run [
        ->(s, e, _v) { o.do_the_first_thing ? s.call : e.call },
        ->(s, e, _v) { o.do_the_second_thing ? s.call : e.call },
        ->(s, e, _v) { o.do_the_third_thing ? s.call : e.call }
      ]
    end

    it "calls a custom error proc" do

      err = ->() { "custom error" }
      a = ->(_s, e, _v) { e.call }

      expect(err).to receive(:call)

      Continue::Run [
        a
      ], :unused_state, err
    end

    it "calls procs returned by command" do
      o = double
      expect(o).to receive(:test).exactly(3).times

      Continue::Run [
        Continue::Command() { |_e| o.test; true },
        Continue::Command() { |_e| o.test; true },
        Continue::Command() { |_e| o.test; true }
      ]
    end

    it "halts the chain when a command calls error" do
      o = double
      expect(o).to receive(:test).exactly(2).times

      Continue::Run [
        Continue::Command() { |_e| o.test; true },
        Continue::Command() { |e| o.test; false },
        Continue::Command() { |_e| o.test; true }
      ]
    end
  end

  describe "Command" do
    it "returns a proc that calls the provided block" do
      o = double

      command = Continue::Command() { |_e| o.test }

      expect(command).to be_a Proc

      expect(o).to receive(:test)

      command.call(->(){},->(){},nil)
    end
  end
end
