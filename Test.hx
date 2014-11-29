class Test {
	static function listBenchmark<T> (maker : ListFactoryInterface<Int, T>, n : Int, ?str : String, f : Bool) {
		var a : Float = 0.0;

		for (i in 0 ... 10) {
            var timer = Date.now().getTime();
            
			{
				var x = maker.cons(1, maker.nil());
				var y = maker.cons(2, maker.nil());

				if (f) 
					for (j in 0 ... n)
						x = maker.append(x, y);
				else
					for (j in 0 ... n)
						y = maker.append(x, y);
			}

            a += Date.now().getTime() - timer;
        }
        trace("---- " + str + " ----");
        trace(a / 10);
        trace("---- end ----");
	}

	static function miniTest<T>(maker : ListFactoryInterface<Int, T>) {
		var x = maker.cons(3, maker.cons(2, maker.cons(1, maker.nil())));
		var y = maker.cons(6, maker.cons(5, maker.cons(4, maker.nil())));

		trace(maker.toArray(maker.append(maker.append(x, y), y)));
		trace(maker.toArray(maker.append(y, maker.append(x, y))));
	}

	static function main() {
		miniTest(new StrictListFactory<Int>());
		miniTest(new LazyListFactory<Int>());
		var x = new LazyListFactory<Int>();
		trace(x.toArray( x.take(x.drop(x.cons(3, x.cons(2, x.cons(1, x.nil()))), 1), 2) ));

		var m = new QueueFactory<Int, StrictList<Int>>( new StrictListFactory<Int>() );
		m.insert(1, m.empty());

		var n = new QueueFactory<Int, Stream<Int>>( new LazyListFactory<Int>() );
		n.insert(1, n.empty());

		var l = new DequeFactory<Int, Stream<Int>>( new LazyListFactory<Int>() );
		var x = l.shift(l.insert(2, l.insert(1, l.empty())));
		trace(x.fst, l.toArray(x.snd));

		// listBenchmark(new StrictListFactory<Int>(), 2000, "StrictList 200 A", true);
		// listBenchmark(new StrictListFactory<Int>(), 2000, "StrictList 200 B", false);
		// listBenchmark(new StrictListFactory<Int>(), 4000, "StrictList 400 A", true);
		// listBenchmark(new StrictListFactory<Int>(), 4000, "StrictList 400 B", false);
        // 
		// listBenchmark(new LazyListFactory<Int>(), 2000, "LazyList 200 A", true);
		// listBenchmark(new LazyListFactory<Int>(), 2000, "LazyList 200 B", false);
		// listBenchmark(new LazyListFactory<Int>(), 4000, "LazyList 400 A", true);
		// listBenchmark(new LazyListFactory<Int>(), 4000, "LazyList 400 B", false);
	}
}
