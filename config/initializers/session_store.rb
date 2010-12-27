# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_highscores_session',
  :secret      => '0374bdf5331c01c8172981b6553451a9cfcaa4726e9f4111d97fba493319d5438cb3176ef1839a73bad7c26d28569db0c0be7e447ec2a1704c402a0c0ba4eeab'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
