import multiprocessing as mp
import numpy as np
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad
import random
import string

# Constants
ARR_SIZE = 10000
NUM_PROCESS = 10
SEGMENT_SIZE = ARR_SIZE // NUM_PROCESS
AES_KEY = b"16 digit key1234"  # AES key must be 16 bytes for AES-128

# Function to generate a random 16-character string
def generate_random_string(length=16):
  return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

# Function for each worker process
def compute_and_write(segment_index, segment_size, arr, ans):
  # Initialize AES cipher for encryption
  cipher = AES.new(AES_KEY, AES.MODE_ECB)
      
  # Calculate the segment range
  start_index = segment_index * segment_size
  end_index = start_index + segment_size
      
  # Encrypt each element in the segment and write directly to the shared array
  for i in range(start_index, end_index):
    plaintext = arr[i].encode('utf-8')
    ciphertext = cipher.encrypt(pad(plaintext, AES.block_size))
    ans[i] = ciphertext.hex()  # Store as hex for easy readability

# Function to encrypt without multiprocessing
def encrypt_without_multiprocessing(arr):
  cipher = AES.new(AES_KEY, AES.MODE_ECB)
  encrypted_list = []
  for element in arr:
    plaintext = element.encode('utf-8')
    ciphertext = cipher.encrypt(pad(plaintext, AES.block_size))
    encrypted_list.append(ciphertext.hex())
  return encrypted_list

def main():
  # Set a seed for reproducibility
  random.seed(0)
      
  # Create the original array of random 16-character strings
  arr = [generate_random_string(16) for _ in range(ARR_SIZE)]
      
  # Using Manager to create a shared list that works across processes
  with mp.Manager() as manager:
    ans = manager.list([''] * ARR_SIZE)  # Initialize shared list for encrypted results

    # Create a pool of workers
    with mp.Pool(processes=NUM_PROCESS) as pool:
      # Prepare tasks for each segment of the array
      tasks = [(i, SEGMENT_SIZE, arr, ans) for i in range(NUM_PROCESS)]
      
      # Execute tasks in parallel, each worker directly writes its segment
      pool.starmap(compute_and_write, tasks)

    # Check encrypted output
    print("Encrypted output sample:", list(ans)[:5])  # Print first 5 encrypted entries

    # Perform encryption without multiprocessing for comparison
    test = encrypt_without_multiprocessing(arr)
    
    # Convert ans to a list for comparison if needed
    print("Encryption results match:", list(ans) == test)
 
if __name__ == "__main__":
  main()
