require_relative './config/environment'

use CandidatesController
use UsersController
run ApplicationController

# map('/candidates') { run CandidatesController }
# map('/') { run ApplicationController }
