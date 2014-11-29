interface ListFactoryInterface<X, Y> {
	public function nil() : AbsList<Y>;
	public function cons(x : X, l : AbsList<Y>) : AbsList<Y>;
	public function hd(l : AbsList<Y>) : X;
	public function tl(l : AbsList<Y>) : AbsList<Y>;
	public function append(a : AbsList<Y>, b : AbsList<Y>) : AbsList<Y>;
	public function reverse(l : AbsList<Y>) : AbsList<Y>;
	public function take(l : AbsList<Y>, n : Int) : AbsList<Y>;
	public function drop(l : AbsList<Y>, n : Int) : AbsList<Y>;
	public function length(l : AbsList<Y>) : Int;
	public function toArray(l : AbsList<Y>) : Array<X>;
	public function switchCase<T>(l : AbsList<Y>, f : {cons : X -> AbsList<Y> -> Int -> T, nil : Void -> T}) : T;
	public function pp(l : AbsList<Y>) : String;
}
