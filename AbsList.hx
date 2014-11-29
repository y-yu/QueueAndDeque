abstract AbsList<X>(List<X>) {
	public function new(x) {
		this = x;
	}

	@:from public static function fromStrict<T>(x : StrictList<T>) : AbsList<StrictList<T>> {
		return new AbsList(Strict(x));
	}

	@:from public static function fromLazy<T>(x : Stream<T>) : AbsList<Stream<T>> {
		return new AbsList(Lazy(x));
	}

	@:from public static function fromList<T>(x : List<T>) : AbsList<T> {
		return new AbsList(x);
	}

	@:to public function toX() : X {
		return switch (this) {
			case Strict(x) : x;
			case Lazy(x)   : x;
		}
	}

	@:to public function toAbsList() : AbsList<X> {
		return this;
	}
}
