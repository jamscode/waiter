require_relative '../../lib/waiter.rb'

describe Waiter do
  include Waiter

  it 'should take a block and yield to it' do
    expect { |b| wait_until(&b) }.to yield_control
  end

  context 'block evaluates to true' do
    it 'should return true' do
      expect(wait_until { true }).to be_true
    end

    it 'should return immediately' do
      start_time = time_now

      wait_until { true }

      expect(time_now - start_time).to be <= 0.01
    end
  end

  context 'timeout has been reached' do
    it 'should throw an exception' do
      expect { wait_until(timeout: 2) { false } }.to raise_error(Waiter::WaiterError)
    end
  end

  context 'timeout has not been reached' do
    shared_examples 'a block executer that keeps waiting and trying' do
      it 'should keep trying' do
        counter = 0

        proc = Proc.new { counter += 1; result.call }

        begin
          wait_until(timeout: 3, sleep: 1, &proc)
        rescue
        end

        expect(counter).to be >= 2
      end

      it 'should pause between executions' do
        counter = 0

        proc = Proc.new { counter += 1; result.call }

        begin
          wait_until(timeout: 3, sleep: 1, &proc)
        rescue
        end

        expect(counter).to be_within(1).of(3)
      end

      it 'should keep trying for the time specified' do
        start_time = time_now

        begin
          wait_until(timeout: 3, sleep: 1) { result.call }
        rescue
        end

        expect(time_now - start_time).to be >= 3
      end
    end

    context 'block evaluates to false' do
      it_behaves_like 'a block executer that keeps trying' do
        let(:result) { false }
      end
    end

    context 'block raises exception' do
      it_behaves_like 'a block executer that keeps trying' do
        let(:result) { raise StandardError }
      end
    end
  end

  def time_now
    Time.now.to_f
  end

end