# https://tommaso.pavese.me/2016/06/05/a-rack-application-from-scratch-part-1-introducting-rack/
require './application'

use Rack::Reloader, 0

run Application.new