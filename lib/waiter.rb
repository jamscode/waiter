module Waiter

  def wait_until(timeout: 15, sleep: 0.1)
    start_time = Time.now.to_f

    until Time.now.to_f - start_time > timeout
      begin
        return true if yield
      rescue StandardError
      end

      sleep sleep
    end

    raise WaiterError
  end

  class WaiterError < StandardError; end

end
