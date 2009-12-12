# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_excortex_session',
  :secret      => '587fdbd5c3b34e1872d2c4f09c842b01f2412a85c92fca40b76f964884a8a32621a708883bd134e89063b1d55ac732e5adabedeca023cb447acb1e745660de98'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
