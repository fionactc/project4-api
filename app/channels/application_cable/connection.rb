module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.id
      # self.current_user = find_verified_user
      # console.log(self.current_user);
      # return nil unless cookies[:auth_headers]
      # auth_headers = JSON.parse cookies[:auth_headers]

      # expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
      # current_renter = Renter.find_by(uid: auth_headers["uid"])
      # display debuggin information in the console
      # logger.add_tags 'ActionCable', current_user.email
    end

    protected

    # this checks whether a user is authenticated with devise
    def find_verified_user
      # env['warden'].user fetches the currently logged-in user
    #   if verified_user = env['warden'].user
    #     verified_user
    #   else
    #     reject_unauthorized_connection
    #   end
      return nil unless cookies[:auth_headers]
      auth_headers = JSON.parse cookies[:auth_headers]

      if verified_user = Renter.find_by(uid: auth_headers["uid"])
        verified_user
      elsif verified_user = Agent.find_by(uid: auth_headers["uid"])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
