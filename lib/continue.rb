require "continue/version"

module Continue

  def self.Run(procs, value=nil, error=nil)

    run = ->(rem_procs,val,err,_args=nil) do
      fn, *rest = rem_procs
      s = ->(args=nil) { run.call(rest,val,err,args) }
      err ||= ->() { false }
      fn.call(s,err,val,_args) if fn
    end

    run.call(procs, value, error)
  end

  def self.Command(&block)
    ->(s,e,v,a) { block.call(v, a) ? s.call : e.call  }
  end

end
