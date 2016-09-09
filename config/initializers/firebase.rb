require 'firebase'
require 'rubygems'

base_uri = 'https://innohack-7bb17.firebaseio.com'

FIREBASE = Firebase::Client.new(base_uri)