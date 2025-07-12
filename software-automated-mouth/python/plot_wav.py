import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile
import argparse

def plot_wav_time_domain(filename):
    # Read WAV file
    fs, data = wavfile.read(filename)

    # Convert to mono if stereo
    if data.ndim > 1:
        data = data[:, 0]

    # Normalize depending on bit depth
    if data.dtype == np.uint8:
        data_f = data.astype(np.float32) / 255.0
    elif data.dtype == np.int16:
        data_f = data.astype(np.float32) / 32768.0
    else:
        data_f = data.astype(np.float32)

    # Time axis in seconds
    t = np.arange(len(data_f)) / fs

    # Plot
    plt.figure(figsize=(14, 5))
    plt.plot(t, data_f, linewidth=0.8)
    plt.title(f"Waveform in Time Domain ({filename})")
    plt.xlabel("Time (seconds)")
    plt.ylabel("Amplitude (normalized)")
    plt.grid(True)
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Plot WAV file in time domain.")
    parser.add_argument("filename", type=str, help="Path to WAV file")
    args = parser.parse_args()

    plot_wav_time_domain(args.filename)
