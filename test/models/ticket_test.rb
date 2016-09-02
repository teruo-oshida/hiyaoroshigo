require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "default passcode is valid" do
    ticket = Ticket.new
    assert_match(/\A[0-9a-f]{6}\z/, ticket.passcode)
  end

  test "signup_url returns correct urls" do
    ticket = Ticket.new
    assert_equal("https://matsuetranquilo.shimane-oss.org/signup?passcode=" +
                 ticket.passcode,
                 ticket.signup_url)
  end
end
