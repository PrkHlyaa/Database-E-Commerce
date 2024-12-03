import multiprocessing as mp
import numpy as np

# Constants
ARR_SIZE = 10000
NUM_PROCESS = 10
SEGMENT_SIZE = ARR_SIZE // NUM_PROCESS

# Function for each worker process
def compute_and_write(segment_index, segment_size, arr, ans):
  # Calculate the segment range
  start_index = segment_index * segment_size
  end_index = start_index + segment_size
      
  # Compute each element in the segment and write directly to the shared array
  for i in range(start_index, end_index):
    ans[i] = arr[i] * 2  # Replace this with any operation like hashing, encryption, etc.

def main():
  arr = np.arange(ARR_SIZE)  # Original array
      
  # Using Manager to create a shared list that works across processes
  with mp.Manager() as manager:
    ans = manager.list([0] * ARR_SIZE)  # Initialize shared list for results

    # Create a pool of workers
    with mp.Pool(processes=NUM_PROCESS) as pool:
      # Prepare tasks for each segment of the array
      tasks = [(i, SEGMENT_SIZE, arr, ans) for i in range(NUM_PROCESS)]
      
      # Execute tasks in parallel, each worker directly writes its segment
      pool.starmap(compute_and_write, tasks)

    # Check if ans is in correct order
    print(ans)
    print(list(ans) == list(range(0, ARR_SIZE * 2, 2)))  # Should print True if correctly ordered

if __name__ == "__main__":
  main()
