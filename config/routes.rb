
# GET    /resource           # index  - get a list of the resources
# GET    /resource/:id       # show   - get a specific resource
# GET    /resource/new       # new    - get an HTML page with a form
# POST   /resource           # create - create a new resource

class Routes
  def initialize(request)
    @request = request
  end

  def route!
    if klass = controller_class
      add_route_info_to_request_params!

      controller = klass.new(@request)
      action = route_info[:action]

      if controller.respond_to?(action)
        puts "\nRouting to #{klass}##{action}"
        return controller.public_send(action)
      end
    end

    not_found('Not Found')
  end

  private

  def add_route_info_to_request_params!
    @request.params.merge!(route_info)
  end

  def not_found(msg)
    [404, { 'Content-Type' => 'text/plain' }, [msg]]
  end

  def route_info
    @route_info ||= begin
                      resource = path_fragments[0] || "base"
                      id, action = find_id_and_action(path_fragments[1])
                      { resource: resource, action: action, id: id }
                    end
  end

  def path_fragments
    @fragments ||= @request.path.split("/").reject { |s| s.empty? }
  end

  def find_id_and_action(fragment)
    case fragment
    when "new"
      [nil, :new]
    when nil
      action = @request.get? ? :index : :create
      [nil, action]
    else
      [fragment, :show]
    end
  end

  def controller_name
    "#{route_info[:resource].capitalize}Controller"
  end

  def controller_class
    Object.const_get(controller_name)
  rescue NameError
    nil
  end
end