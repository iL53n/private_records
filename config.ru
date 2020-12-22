require_relative './config/environment'
require './env' if File.exist?('env.rb')

use CandidatesController
use UsersController
run ApplicationController

# map('/candidates') { run CandidatesController }
# map('/') { run ApplicationController }
