module System
  module TurboHelpers
    def expect_page_not_to_be_a_preview
      expect(page).not_to have_selector("html[data-turbo-preview]")
    end

    def wait_for_turbolinks
      if has_css?(".turbolinks-progress-bar", visible: true)
        has_no_css?(".turbolinks-progress-bar", wait: timeout.presence || 5.seconds)
      end
    end
  end
end

RSpec.configure do |config|
  config.include System::TurboHelpers, type: :system
end
