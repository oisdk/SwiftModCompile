public func tarjan<H:Hashable,C:CollectionType where C.Generator.Element == H>(graph: [H:C]) -> Set<Set<H>> {
  
  var info: [H:(index: Int, lowlink: Int, onStack: Bool)] = [:]
  var (index,stack,sccs): (Int,[H],Set<Set<H>>) = (0,[],[])
  
  func strongconnect(v: H) {
    info[v] = (index,index,true)
    ++index
    stack.append(v)
    for w in graph[v]!{
      switch info[w]{
      case let (i,_,true)?: info[v]!.lowlink = min(info[v]!.lowlink, i)
      case .Some: continue
      case nil:
        strongconnect(w)
        info[v]!.lowlink = min(info[v]!.lowlink, info[w]!.lowlink)
      }
    }
    
    if case let (i,l,_)? = info[v] where i == l {
      var scc: Set<H> = [v]
      for (var w = stack.removeLast();;w = stack.removeLast()) {
        info[w]!.onStack = false
        if w == v { break }
        scc.insert(w)
      }
      sccs.insert(scc)
    }
  }
  
  for v in graph.keys {
    if case nil = info[v] {
      strongconnect(v)
    }
  }
  
  return sccs
  
}