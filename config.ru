require_relative './config/environment'
require './env' if File.exist?('env.rb')

use CandidatesController
use UsersController
run Application
