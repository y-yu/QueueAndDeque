class DequeFactory<X, Y> implements DequeFactoryInterface<X, Y> {
	private var mkr : ListFactoryInterface<X, Y>;
	private var c   : Int;

	public function new(maker : ListFactoryInterface<X, Y>, ?c : Int = 2 ) {
		this.mkr = maker;
		this.c   = c;
	}

	public inline function empty() : Deque<Y> {
		return {f : mkr.nil(), r : mkr.nil()};
	}

	private inline function rotateDrop(f : AbsList<Y>, j : Int, r : AbsList<Y>) : AbsList<Y> {
		if (j < c) {
			return rotateRev(f, mkr.drop(r, j), mkr.nil());
		} else {
			return mkr.switchCase(f, {
				cons : function (x, f, _) : AbsList<Y> {
					return mkr.cons(x, rotateDrop(f, j - c, mkr.drop(r, j)));
				},
				nil : function () {
					throw 'error';
					return mkr.nil();
				}
			});
		}
	}

	private inline function rotateRev(f : AbsList<Y>, r : AbsList<Y>, a : AbsList<Y>) : AbsList<Y> {
		return mkr.switchCase(f, {
			cons : function (x, f, _) : AbsList<Y> {
				return mkr.cons(x, rotateRev(f, mkr.drop(r, c), mkr.reverse( mkr.append(mkr.take(r, c), a))));
			},
			nil  : function () {
				return mkr.append(mkr.reverse(r), a);
			}
		});
	}

	private inline function makedq(f, r) : Deque<Y> {
		var lenf = mkr.length(f), lenr = mkr.length(r);
		if (lenf > c * lenr + 1) {
			var i  = Math.floor((lenf + lenr) / 2),
				f_ = mkr.take(f, i),
				r_ = rotateDrop(r, i, f);

			return {f : f_, r : r_};
		} else if (lenr > c * lenf + 1) {
			var i  = Math.floor((lenf + lenr) / 2),
				j  = lenf + lenr - i,
				f_ = rotateDrop(f, j, r),
				r_ = mkr.take(r, j);

			return {f : f_, r : r_};
		} else {
			return {f : f, r : r};
		}
	}

	public inline function insert(x : X, dq : Deque<Y>) : Deque<Y> {
		return makedq(mkr.cons(x, dq.f), dq.r);
	}

	public inline function push(x : X, dq : Deque<Y>) : Deque<Y> {
		return makedq(dq.f, mkr.cons(x, dq.r));
	}

	public inline function shift(dq : Deque<Y>) : Tuple<X, Deque<Y>> {
		trace(mkr.toArray(dq.f), mkr.toArray(dq.r));

		trace(mkr.pp(dq.f), mkr.pp(dq.r));
		if (mkr.length(dq.r) == 0) {
			return {fst : mkr.hd(dq.f), snd : empty()};
		} else {
			return {fst : mkr.hd(dq.r), snd : makedq(dq.f, mkr.tl(dq.r))};
		}
	}

	public inline function pop(dq : Deque<Y>) : Tuple<X, Deque<Y>> {
		if (mkr.length(dq.f) == 0) {
			return {fst : mkr.hd(dq.r), snd : empty()}
		} else {
			return {fst : mkr.hd(dq.f), snd : makedq(mkr.tl(dq.f), dq.r)};
		}
	}

	public inline function length(dq : Deque<Y>) : Int {
		return mkr.length(dq.f) + mkr.length(dq.r);
	}

	public inline function toArray(dq : Deque<Y>) : Array<X> {
		return mkr.toArray(dq.r).concat(mkr.toArray(dq.f));
	}
}
