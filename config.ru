require_relative './config/environment'
require './env' if File.exist?('env.rb')

use CandidatesController
use UsersController
use AdRoutes
run ApplicationController

# map('/candidates') { run CandidatesController }
# map('/') { run ApplicationController }
