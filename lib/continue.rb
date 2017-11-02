require "continue/version"

module Continue

  def self.Run(procs, value=nil, error=nil)

    run = ->(p,v,e) do
      f, *r = p
      s = -> () { run.call(r,v,e) }
      e ||= ->() { false }
      f.call(s,e,v) if f
    end

    run.call(procs, value, error)
  end

  def self.Command(&block)
    ->(s,e,v) { block.call(v) ? s.call : e.call  }
  end

end
