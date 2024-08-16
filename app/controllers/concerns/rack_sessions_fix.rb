# This module is a workaround to handle sessions in environments where
# Rack sessions are not used, such as API-only applications.
module RackSessionsFix
  extend ActiveSupport::Concern # Allows this module to be easily included in controllers.

  # This class simulates a Rack session by subclassing Hash and overriding methods.
  class FakeRackSession < Hash
    # This method indicates that the fake session is not enabled.
    def enabled?
      false
    end

    # This method is a no-op to satisfy the interface for session destruction.
    def destroy; end
  end

  # This block will be executed when the module is included in a controller.
  # It adds a before_action to set up a fake session.
  included do
    before_action :set_fake_session

    private

    # This method sets a fake session object in the request environment if one doesn't already exist.
    def set_fake_session
      request.env['rack.session'] ||= FakeRackSession.new # Assigns a FakeRackSession if 'rack.session' is not present.
    end
  end
end