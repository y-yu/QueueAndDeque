class LazyListFactory<T> implements ListFactoryInterface<T, Stream<T>> {
	public function new () { }

	public inline function nil() : AbsList<Stream<T>> {
		return function () { return StreamCell.Nil; };
	}

    public inline function cons(x : T, s : AbsList<Stream<T>>) : AbsList<Stream<T>> {
        return function() : StreamCell<T> {
            return Cons(x, s, length(s) + 1);
        };
    }

	public inline function length(s : AbsList<Stream<T>>) : Int {
		var x : Stream<T> = s;
		return switch(x()) {
			case Cons(h, t, n) : n;
			case Nil: 0;
		}
	}
    
    public inline function hd(s : AbsList<Stream<T>>) : T  {
		var x : Stream<T> = s;
        return switch(x()) {
            case Cons(h, _, _): h;
            case Nil: throw "stream headd error!";
        }
    }
    
    public inline function tl(s : AbsList<Stream<T>>) : AbsList<Stream<T>> {
		var x : Stream<T> = s;
        return switch(x()) {
            case Cons(_, t, _): t;
            case Nil: nil();
        }
    }

	public inline function append(a : AbsList<Stream<T>>, b : AbsList<Stream<T>>) : AbsList<Stream<T>> {
		var x : Stream<T> = b;
		function loop (s : Stream<T>) : StreamCell<T> {
			return switch(s()) {
				case Cons(h, t, n): Cons(h, function () { return loop(t); }, n + length(b));
				case Nil: x();
			}
		}
		return function () { return loop(a); }
	} 
    
    public inline function reverse(s : AbsList<Stream<T>>) : AbsList<Stream<T>> {
		var x : Stream<T> = s;
		var n = switch (x()) {
			case Cons(_, _, n): n;
			case Nil: 0;
		}

        function loop(s : Stream<T>, a : StreamCell<T>) : StreamCell<T> {
            return switch(s()) {
				case Cons(h, t, i):
					loop(t, Cons(h, function () { return a; }, n - i + 1));
                case Nil : a;
			}
		}
        
		return function () { return loop(s, Nil); };
    }

	public inline function toArray(s : AbsList<Stream<T>>) : Array<T> {
		var x : Stream<T> = s;
		return switch (x()) {
			case Cons(h, t, _): [h].concat( toArray(t) );
			case Nil: [];
		}
	}
    
    public inline function take(s : AbsList<Stream<T>>, n : Int) : AbsList<Stream<T>> {
		return switch(n) {
			case i if (i == 0): nil();
			case i if (i > 0): cons(hd(s), take(tl(s), i - 1));
			case _: throw "error!";
		}
    }

	public inline function drop(s : AbsList<Stream<T>>, n : Int) : AbsList<Stream<T>> {
		return switch(n) {
			case i if (i <= 0): s;
			case i : drop(tl(s), i - 1);
		}
	}

	public inline function switchCase<U>(s : AbsList<Stream<T>>, f : {cons : T -> AbsList<Stream<T>> -> Int -> U, nil : Void -> U}) : U {
		var x : Stream<T> = s;
		return switch(x()) {
			case Cons(h, t, n): f.cons(h, t, n);
			case Nil: f.nil();
		}
	}

	public inline function pp(s : AbsList<Stream<T>>) : String {
		var x : Stream<T> = s;

		return switch(x()) {
			case Cons(h, t, n): "Cons[" + n + "](" + Std.string(h) + ", " + pp(t) + ")";
			case Nil: "Nil";
		}
	}
}

