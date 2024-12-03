import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
import string
import random

# Set random seed for reproducibility
random.seed(0)
torch.manual_seed(0)

# Parameters
MAX_LEN = 16
CHARS = string.ascii_letters + string.digits  # Character set
VOCAB_SIZE = len(CHARS) + 1  # All characters + padding
PAD_IDX = VOCAB_SIZE - 1  # Padding index
EMBEDDING_DIM = 64
HIDDEN_DIM = 128
NUM_EPOCHS = 100

# Character to index and index to character mappings
char2idx = {ch: i for i, ch in enumerate(CHARS)}
char2idx['<PAD>'] = PAD_IDX
idx2char = {i: ch for ch, i in char2idx.items()}

# Data generator functions
def generate_random_string(length=16):
    return ''.join(random.choices(CHARS, k=length))

def func(x):
    # return ''.join([x[pow(13, i) % len(x)] for i in range(len(x))])
    return ''.join([x[(i+1)%len(x)] for i in range(len(x))])

# Dataset class
class StringDataset(Dataset):
    def __init__(self, num_samples):
        self.features = [generate_random_string(MAX_LEN) for _ in range(num_samples)]
        self.labels = [func(feat) for feat in self.features]
    
    def __len__(self):
        return len(self.features)
    
    def __getitem__(self, idx):
        feature = self.features[idx]
        label = self.labels[idx]
        # Convert to indices and pad if necessary
        feature_idx = [char2idx[ch] for ch in feature] + [PAD_IDX] * (MAX_LEN - len(feature))
        label_idx = [char2idx[ch] for ch in label] + [PAD_IDX] * (MAX_LEN - len(label))
        return torch.tensor(feature_idx), torch.tensor(label_idx)

# Model definition
class Seq2SeqModel(nn.Module):
    def __init__(self, vocab_size, embedding_dim, hidden_dim):
        super(Seq2SeqModel, self).__init__()
        self.embedding = nn.Embedding(vocab_size, embedding_dim, padding_idx=PAD_IDX)
        self.encoder = nn.LSTM(embedding_dim, hidden_dim, batch_first=True)
        self.decoder = nn.LSTM(embedding_dim, hidden_dim, batch_first=True)
        self.fc = nn.Linear(hidden_dim, vocab_size)

    def forward(self, x):
        embedded = self.embedding(x)
        encoder_outputs, (hidden, cell) = self.encoder(embedded)
        
        decoder_input = embedded
        decoder_outputs, _ = self.decoder(decoder_input, (hidden, cell))
        
        output = self.fc(decoder_outputs)
        return output

# Training function
def train_model(model, dataloader, optimizer, criterion, num_epochs):
    for epoch in range(num_epochs):
        total_loss = 0
        for feature, label in dataloader:
            optimizer.zero_grad()
            output = model(feature)
            loss = criterion(output.view(-1, VOCAB_SIZE), label.view(-1))
            loss.backward()
            optimizer.step()
            total_loss += loss.item()
        print(f"Epoch {epoch+1}/{num_epochs}, Loss: {total_loss/len(dataloader)}")

# Data and model setup
dataset = StringDataset(num_samples=1000)
dataloader = DataLoader(dataset, batch_size=32, shuffle=True)
model = Seq2SeqModel(VOCAB_SIZE, EMBEDDING_DIM, HIDDEN_DIM)
optimizer = optim.Adam(model.parameters(), lr=0.001)
criterion = nn.CrossEntropyLoss(ignore_index=PAD_IDX)

# Train the model
train_model(model, dataloader, optimizer, criterion, NUM_EPOCHS)

# Example of inference function
def predict(model, feature_str):
    feature_idx = [char2idx[ch] for ch in feature_str] + [PAD_IDX] * (MAX_LEN - len(feature_str))
    feature_tensor = torch.tensor(feature_idx).unsqueeze(0)  # Add batch dimension
    with torch.no_grad():
        output = model(feature_tensor)
        predicted_idxs = output.argmax(dim=2).squeeze().tolist()
        predicted_str = ''.join(idx2char[idx] for idx in predicted_idxs if idx != PAD_IDX)
    return predicted_str

# Test prediction
# test_feature = generate_random_string(MAX_LEN)
total_true = 0
for i in range(5):
  test_feature = dataset.features[i]
  print("Feature:", test_feature)
  predicted_label = predict(model, test_feature)
  print("Predicted Label:", predicted_label)
  val = func(test_feature)
  print(val)
  print(predicted_label == val)
  total_true += 1

print(total_true)