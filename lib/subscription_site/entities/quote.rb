class Quote
  GeneratorUnavailable = Class.new(StandardError)

  def fetch
    return @fortune if defined? @fortune

    res = `which fortune`

    raise GeneratorUnavailable if res.empty?
    @fortune = `fortune`
  end
end
