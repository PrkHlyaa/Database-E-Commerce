import multiprocessing as mp
import numpy as np
from Crypto.Cipher import AES
from Crypto.Util.Padding import pad 

AES_KEY = b"16 digit key1234"  # AES key must be 16 bytes for AES-128

def encrypt_without_multiprocessing(arr):
  cipher = AES.new(AES_KEY, AES.MODE_ECB)
  encrypted_list = []
  for element in arr:
    plaintext = element.encode('utf-8')
    ciphertext = cipher.encrypt(pad(plaintext, AES.block_size))
    print(ciphertext)
    # encrypted_list.append(ciphertext.hex())
  return encrypted_list

print(encrypt_without_multiprocessing(['ab'*8]))