import 'dart:collection';

class FixedSizeQueue<T> {
  final int maxSize;
  final Queue<T> _queue = Queue<T>();

  FixedSizeQueue(this.maxSize);

  void add(T value) {
    //if item already exists in the queue, do not add it again
    if (_queue.contains(value)) {
      return; // 
    }

    if (_queue.length >= maxSize) {
      _queue.removeFirst(); // Remove the oldest item
    }
    _queue.addLast(value);
  }

  List<T> get items => _queue.toList();
}
