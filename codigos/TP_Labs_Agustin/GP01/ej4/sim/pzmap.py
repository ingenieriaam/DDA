#ref: https://www.dsprelated.com/showcode/244.php PYTHON ZPLANE FUNCTION

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
from plot_zplane import zplane

b = np.array([1,-1,1,1])
a = np.array([1,-0.5,-0.25,0])

b = np.array([0,0,0,1])
a = np.array([1,-0.5,0.25,0.5])
#zplane(b,a)

w, h = sp.signal.freqz(b, a, worN=512, whole=False, plot=None, fs=44100)

fig, ax1 = plt.subplots()
ax1.set_title('Digital filter frequency response')

ax1.plot(w, 20 * np.log10(abs(h)), 'b')
ax1.set_ylabel('Amplitude [dB]', color='b')
ax1.set_xlabel('Frequency [Hz]')

ax2 = ax1.twinx()
angles = np.unwrap(np.angle(h))
ax2.plot(w, angles, 'g')
ax2.set_ylabel('Angle (radians)', color='g')
ax2.grid(True)
ax2.axis('tight')
plt.show()