require_relative './config/environment'

use CandidatesController
run ApplicationController

# map('/candidates') { run CandidatesController }
# map('/') { run ApplicationController }
