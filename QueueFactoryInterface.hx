interface QueueFactoryInterface<X, Y> {
	public function empty() : Queue<Y>;
	public function insert(x : X, q : Queue<Y>) : Queue<Y>;
	public function remove(q : Queue<Y>) : Tuple<X, Queue<Y>>;
	public function length(q : Queue<Y>) : Int;
	public function toArray(q : Queue<Y>) : Array<X>;
}
