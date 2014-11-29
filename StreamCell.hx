enum StreamCell<T> {
    Cons(h : T, t : Stream<T>, n : Int) : StreamCell<T>;
    Nil : StreamCell<T>;
}
