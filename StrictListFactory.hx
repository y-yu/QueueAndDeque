class StrictListFactory<T> implements ListFactoryInterface<T, StrictList<T>> {
    public function new() {}
    
	public function nil() : AbsList<StrictList<T>> {
		return StrictList.Nil;
	}

    public inline function cons(x : T, l : AbsList<StrictList<T>>) : AbsList<StrictList<T>> {
		return StrictList.Cons(x, l, length(l) + 1);
    }
    
    public inline function hd(l : AbsList<StrictList<T>>) : T {
		var x : StrictList<T> = l;
        return switch(x) {
            case StrictList.Cons(h, _, _): h;
            case StrictList.Nil: throw "error!";
        }
    }
    
    public inline function tl(l : AbsList<StrictList<T>>) : AbsList<StrictList<T>> {
		var x : StrictList<T> = l;
        return switch(x) {
            case StrictList.Cons(_, t, _): t;
            case StrictList.Nil: StrictList.Nil;
        }
    }
    
    public inline function append(a : AbsList<StrictList<T>>, b : AbsList<StrictList<T>>) : AbsList<StrictList<T>> {
		function loop (l : StrictList<T>, k : StrictList<T> -> StrictList<T>) {
			return switch(l) {
				case StrictList.Cons(h, t, _):
					loop(t, function (x) { return k( cons(h, x) ); });
				case StrictList.Nil:
					k(b);
			}
		}

		return loop(a, function (x) { return x; });
    }
    
	public function length(l : AbsList<StrictList<T>>) : Int {
		var x : StrictList<T> = l;
		return switch (x) {
			case StrictList.Cons(_, _, n): n;
			case StrictList.Nil: 0;
		}
	}

	public inline function take(l : AbsList<StrictList<T>>, n : Int) : AbsList<StrictList<T>> {
		return switch(n) {
			case i if (i <= 0): l;
			case i: cons(hd(l), take(tl(l), i - 1));
		}
	}

	public inline function drop(l : AbsList<StrictList<T>>, n : Int) : AbsList<StrictList<T>> {
		return switch(n) {
			case i if (i <= 0): l;
			case i: drop(tl(l), i - 1);
		}
	}

    public inline function reverse(l : AbsList<StrictList<T>>) : AbsList<StrictList<T>> {
		function loop(l : StrictList<T>, a : StrictList<T>) {
			return return switch(l) {
				case StrictList.Cons(h, t, n): loop(t, StrictList.Cons(h, a, n));
				case StrictList.Nil: a;
			}
		}

		return loop(l, StrictList.Nil);
    }

    public inline function toArray(l : AbsList<StrictList<T>>) : Array<T> {
        function loop(l : StrictList<T>, a : Array<T>) : Array<T> {
            return switch(l) {
                case StrictList.Cons(h, t, _): a.push(h); loop(t, a);
                case StrictList.Nil: a;
            };
        }
        
        return loop(l, []);
    }

	public inline function switchCase<U>(l : AbsList<StrictList<T>>, f : {cons : T -> AbsList<StrictList<T>> -> Int -> U, nil : Void -> U}) : U {
		var x : StrictList<T> = l;
		return switch(x) {
			case Cons(h, t, n): f.cons(h, t, n);
			case Nil: f.nil();
		}
	}

	public inline function pp(l : AbsList<StrictList<T>>) : String {
		var x : StrictList<T> = l;
		return switch(x) {
			case Cons(h, t, n): "Cons[" + n + "](" + Std.string(h) + ", " + pp(t) + ")";
			case Nil: "Nil";
		}
	}
}

