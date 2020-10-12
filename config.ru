require_relative './config/environment'

use ApplicationController
run CandidatesController

# map('/candidates') { run CandidatesController }
# map('/') { run ApplicationController }
