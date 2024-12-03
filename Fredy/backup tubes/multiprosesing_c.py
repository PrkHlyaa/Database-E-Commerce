# try concurrency in python

import multiprocessing as mp
import numpy as np
import os

# Constants
ARR_SIZE = 10000
NUM_PROCESS = 10
SEGMENT_SIZE = ARR_SIZE // NUM_PROCESS

# Shared memory array (similar to mmap)
shared_counter = mp.Value('i', 0)
flag = mp.Value('i', 0)
arr = np.arange(ARR_SIZE)
ans = mp.Array('i', ARR_SIZE)  # Array to store results across processes

def process_task(segment_index, segment_size, shared_counter, arr, ans, pipe_out, flag):
  with shared_counter.get_lock():
    shared_counter.value += 1
  anak_ke = shared_counter.value
  print(f"Child process {anak_ke} working on segment {segment_index}")
      
  # Calculate the segment values
  part_arr = [arr[segment_index * segment_size + i] * 2 for i in range(segment_size)]
      
  # Wait until it's this process's turn to write to the pipe
  while flag.value != anak_ke - 1:
    pass

  # Send the processed part of the array through the pipe
  pipe_out.send(part_arr)
  pipe_out.close()

  # Update flag to allow the next process to proceed
  with flag.get_lock():
    flag.value = anak_ke

def main():
  # Create a pipe for communication between processes
  pipes = [mp.Pipe(duplex=False) for _ in range(NUM_PROCESS)]
      
  # Create processes
  processes = []
  for i in range(NUM_PROCESS):
    p = mp.Process(
      target=process_task,
      args=(i, SEGMENT_SIZE, shared_counter, arr, ans, pipes[i][1], flag)
    )
    processes.append(p)
    p.start()

  # Read from the pipe in the main process to collect results
  for i, (parent_conn, _) in enumerate(pipes):
    part_arr = parent_conn.recv()  # Receive the processed array segment
    for j, value in enumerate(part_arr):
      ans[i * SEGMENT_SIZE + j] = value

  # Wait for all processes to complete
  for p in processes:
    p.join()

  # Print the results
  for i in range(ARR_SIZE):
    print(ans[i])

  print(list(ans) == [2*i for i in range(ARR_SIZE)], type(list(ans))==list)

if __name__ == "__main__":
  main()
