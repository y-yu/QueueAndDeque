enum List<X> {
	Strict<T>(x : StrictList<T>) : List<StrictList<T>>;
	Lazy<T>(x : Stream<T>) : List<Stream<T>>;
} 
