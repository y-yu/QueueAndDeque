interface DequeFactoryInterface<X, Y> {
	public function empty() : Deque<Y>;
	public function insert(x : X, dq : Deque<Y>) : Deque<Y>;
	public function push(x : X, dq : Deque<Y>) : Deque<Y>;
	public function shift(dq : Deque<Y>) : Tuple<X, Deque<Y>>;
	public function pop(dq : Deque<Y>) : Tuple<X, Deque<Y>>;
	public function length(dq : Deque<Y>) : Int;
	public function toArray(dq : Deque<Y>) : Array<X>;
}
