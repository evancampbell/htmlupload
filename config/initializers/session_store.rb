# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_htmlupload_session',
  :secret      => 'c995176a411d194e220239ebf86ac0852498d7b218e6ef03df1336522a72a14b41150cd8cedd214766e64b0c96fc3616886090a92cda14d46d7e7cb3b40f44a8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
