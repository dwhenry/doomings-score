module TestID
  def click_test_id(id)
    find(%{[data-test-id="#{id}"]}).click
  end
end

RSpec.configure do |config|
  config.include TestID
end
