extension Dictionary {
  private func hasKey(key: Key) -> Bool {
    switch self[key] {
    case .Some: return true
    case .None: return false
    }
  }
}

public func tarjan<H:Hashable,C:CollectionType where C.Generator.Element == H>(graph: [H:C]) -> Set<Set<H>> {
  
  var info: [H:(index: Int, lowlink: Int, onStack: Bool)] = [:]
  var index = 0
  var stack: [H] = []
  var result: Set<Set<H>> = []
  
  
  func strongconnect(v: H) {
    info[v] = (index,index,true)
    ++index
    stack.append(v)
    for w in graph[v]!{
      switch info[w]{
      case nil:
        strongconnect(w)
        info[v]!.lowlink = min(info[v]!.lowlink, info[w]!.lowlink)
      case let (i,_,true)?:
        info[v]!.lowlink = min(info[v]!.lowlink, i)
      default: continue
      }
    }
    
    if case let (i,l,_)? = info[v] where i == l {
      var scc: Set<H> = [v]
      for (var w = stack.removeLast();;w = stack.removeLast()) {
        info[w]!.onStack = false
        if w == v { break }
        scc.insert(w)
      }
      result.insert(scc)
    }
  }
  
  for v in graph.keys {
    if case nil = info[v] {
      strongconnect(v)
    }
  }
  
  return result
  
}