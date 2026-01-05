// A simulation process:
//   1. is a member function of a sc_module class, and
//   3. has no input argument and returns no value, and
//   2. is registered with the simulation kernel
//
// How to register a simulation process:
//   1. SC_METHOD(func): does not have its own thread of execution, consumes no simulated time,
//   cannot be suspended, and cannot call code that calls wait()
//   2. SC_THREAD(func): has its own thread of execution, may consume simulated time, can be
//   susupended, and can call code that calls wait()
//   3. SC_CTHREAD(func, event): a special form of SC_THREAD thatcan only have a static sensitivity
//   of a clock edge event
//
// When can registration happen:
//   1. in the body of the constructor,
//   2. in the before_end_of_elaboration or end_of_elaboration callbacks of a module,
//   3. or in a member function called from the constructor or callback
//
// Restrictions:
//   1. registration can only be performed on member functions of the same module.
//   2. SC_CTHREAD shall not be invoked from the end_of_elaboration callback.
//
// Note:
//   1. SC_THREAD can do everything that SC_METHOD or SC_CTHREAD does. I'll mostly use this process
//   in the examples.
//   2. In order for an SC_THREAD or SC_CTHREAD process to be called again, there shall be a while
//   loop making sure it never exits.
//   3. An SC_METHOD process doesn't require a while loop. It is invoked again by next_trigger()
//   4. simulated time in systemC is not the actual time a program runs. It's a counter managed by
//   the simulation kernel. To be explained later.

#include <systemc>
using namespace sc_core;

SC_MODULE(PROCESS) {
  sc_clock clk;
  SC_CTOR(PROCESS) : clk("clk", 1, SC_SEC) {
    SC_METHOD(method);
    SC_THREAD(thread);
    SC_CTHREAD(cthread, clk);
  }

  // no while loop here, use next_trigger() to be invoked again
  void method(void) {
    printf("method triggered @ %f s\n", sc_time_stamp().to_seconds());
    next_trigger(sc_time(1, SC_SEC));
  }

  // define the thread member function
  // infinite loop make sure it never exits
  void thread() {
    while (true) {
      printf("thread triggered @ %f s\n", sc_time_stamp().to_seconds());
      wait(1, SC_SEC);
    }
  }

  // like thread(), but triggered by clock edge
  void cthread() {
    while (true) {
      printf("cthread triggered @ %f s\n", sc_time_stamp().to_seconds());
      // wait for next clk event, which comes after 1 sec
      wait();
    }
  }
};

int sc_main(int, char *[]) {
  // init module
  PROCESS process("process");
  printf("execution phase begins @ %s\n", sc_time_stamp().to_string().c_str());
  // run simulation for 2 second
  sc_start(2, SC_SEC);
  printf("execution phase ends @ %s\n", sc_time_stamp().to_string().c_str());
  return 0;
}
