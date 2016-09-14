require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test "default passcode is valid" do
    ticket = Ticket.new
    assert_match(/\A[0-9a-f]{6}\z/, ticket.passcode)
    ticket2 = Ticket.new
    assert_not_equal(ticket, ticket2)
  end

  test "signup_url returns correct urls" do
    ticket = Ticket.new
    assert_equal("https://matsuetranquilo.shimane-oss.org/signup?passcode=" +
                 ticket.passcode,
                 ticket.signup_url)
  end

  test "unused return true or false" do
    ticket = Ticket.new(drinker_id:"jon due", passcode:"abcdefg")
    assert_not ticket.unused?, " 既にdrinker_idが代入されているなら、falseでなければならない"
    ticket.drinker_id = nil
    assert ticket.unused?, "drinker_idがnilなら、trueでなければならない"
  end
end
