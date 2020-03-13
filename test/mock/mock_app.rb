class MockApp
  attr_reader :middlewares, :callcount

  def initialize
    @middlewares = []
    @callcount = 0
  end

  def call _env
    @callcount += 1
  end

  def use(middleware, *params, &block)
    @middlewares << [middlewares, params, block]
  end
end
