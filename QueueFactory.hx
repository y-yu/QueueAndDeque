class QueueFactory<X, Y> implements QueueFactoryInterface<X, Y> {
	private var mkr : ListFactoryInterface<X, Y>;

	public function new(maker : ListFactoryInterface<X, Y>) {
		this.mkr = maker;
	}

	private inline function makeq(l, r) : Queue<Y> {
		if (mkr.length(r) == mkr.length(l) + 1) {
			return {f : rotate(l, r, mkr.nil()), r : mkr.nil()}
		} else {
			return {f : l, r : r};
		}
	}

	private inline function rotate(f : AbsList<Y> , r : AbsList<Y>, a : AbsList<Y>) : AbsList<Y> {
		return switch (mkr.length(f)) {
			case 0: mkr.cons(mkr.hd(r), a);
			case _: mkr.cons(mkr.hd(f), rotate(mkr.tl(f), mkr.tl(r), mkr.cons(mkr.hd(r), a)));
		}
	}

	public function empty() : Queue<Y> {
		return {f : mkr.nil(), r : mkr.nil()};
	}

	public inline function insert(e : X, q : Queue<Y>) : Queue<Y> {
		return makeq(q.f, mkr.cons(e, q.r));
	}

	public inline function remove(q : Queue<Y>) : Tuple<X, Queue<Y>> {
		return {fst : mkr.hd(q.f), snd : makeq(mkr.tl(q.f), q.r)};
	}

	public inline function length(q : Queue<Y>) : Int {
		return mkr.length(q.r) + mkr.length(q.f);
	}

	public inline function toArray(q : Queue<Y>) : Array<X> {
		return mkr.toArray(q.f).concat(mkr.toArray(mkr.reverse(q.r)));
	}
}
