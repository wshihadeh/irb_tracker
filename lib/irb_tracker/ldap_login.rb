require 'net/ldap'

module IRBTracker
  class LDAPLogin
  	class << self
      attr_reader :current_user

      def authenticate(username, password)
        @current_user = username
        conn = ldap_connection
        filter = Net::LDAP::Filter.eq("mail", username)
        conn.bind_as(filter: filter, password: password)
      rescue
        false
      end

    private

      def ldap_connection
        conn = Net::LDAP.new(
          host: ENV['LDAP_HOST'],
          port: ENV['LDAP_PORT'],
          base: ENV['LDAP_BASE'],
          encryption: nil
        )
        conn.auth ENV['LDAP_ADMIN_USER'], ENV['LDAP_ADMIN_PASSWORD']
        return false unless conn.bind
        conn
      end
    end
  end
end
