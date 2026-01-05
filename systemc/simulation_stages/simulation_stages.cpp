// The systemC application has three phases/stages of operation:
//   1. Elaboration: execution of statements prior to sc_start().
//     The primary purpose is to create internal data structures to support the semantics of simulation.
//     During elaboration, the parts of the module hierarchy (modules, ports, primitive channels, and processes) are created, and ports and exports are bound to channels.
//   2. Execution: further break-down to two stages:
//     a) Initialization
//       simulation kernel identifies all simulation processes and place them in either a runnable or waiting process set.
//       All simulation processes are in runnable set except those requesting "no initialization".
//     b) Simulation
//       is commonly described as a state machine that schedules processes to run, and advances simulation time. It has two internal phases:
//         1) evaluate: run all runnable processes one at a time. Each process runs till reaches wait() or return. Stops if no runnable processes left.
//         2) advance-time: once the set of runnable processes is emptied, simulation enters advance-time phase where it does:
//           a) move simulated time to the closest time with a scheduled event
//           b) move processes waiting for that particular time into the runnable set
//           c) return to evaluation phase
//         The progression from evaluate to advance-time continues until one of the three things occurs. Then it moves to the cleanup phase.
//           a) all processes have yielded
//           b) a process has executed sc_stop()
//           c) maximum time is reached
//   3. Cleanup or post-processing: destroy objects, releases memory, close open files etc.
//
// Four callback functions are called by the kernel at various stages during elaboration and simulation. They have the following declarations:
//   1. virtual void before_end_of_elaboration(): called after the construction of the module hierarchy
//   2. virtual void end_of_elaboration(): called at the very end of elaboration after all callbacks to before_end_of_elaboration have completed and after the completion of any instantiation or port binding performed by those callbacks and before starting simulation.
//   3. virtual void start_of_simulation():
//     a) called immediately when the application calls sc_start for the first time or at the very start of simulation, if simulation is initiated under the direct control of the kernel.
//     b) if an application makes multiple calls to sc_start, start_of_simulation is called on the first call to sc_start.
//     c) called after the callbacks to end_of_elaboration and before invoking the initialization phase of the scheduler.
//   4. virtual void end_of_simulation():
//     a) called when the scheduler halts because of sc_stop or at the very end of simulation if simulation is initiated under the direct control of the kernel.
//     b) called only once even if sc_stop is called multiple times.

#include <systemc>
using namespace sc_core;

// TODO
