class DbConnectionFail
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue ActiveRecord::ConnectionNotEstablished
    [503, {}, []]
  end
end
