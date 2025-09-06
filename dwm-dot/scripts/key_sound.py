import os
import sys
import logging
from pynput import keyboard
import pygame
import threading

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

# Initialize pygame mixer
pygame.mixer.init()

# Function to get the path to the sound directory
def resource_path(relative_path):
    """ Get absolute path to resource, works for dev and for PyInstaller """
    base_path = getattr(sys, '_MEIPASS', os.path.dirname(os.path.abspath(__file__)))
    return os.path.join(base_path, relative_path)

# Load sound files into a dictionary
default_sound = resource_path('sound_simulator/n.wav')  # Replace with your default sound file
special_sounds = {
    'backspace': resource_path('sound_simulator/backspace.wav'),  # Replace with your sound file
    'enter': resource_path('sound_simulator/enter.wav'),          # Replace with your sound file
    'space': resource_path('sound_simulator/space.wav'),          # Replace with your sound file
    'tab': resource_path('sound_simulator/tab.wav'),              # Replace with your sound file
    'caps lock': resource_path('sound_simulator/caps_lock.wav'),

    'shift': resource_path('sound_simulator/shift.wav')

    # Add more special keys and sounds if needed
}

# Variable to control if sounds are enabled
enabled = True

# Variable to control volume
volume = 1.0  # Volume ranges from 0.0 to 1.0

# Function to play sound
def play_sound(file):
    logging.debug(f'Playing sound: {file}')
    sound = pygame.mixer.Sound(file)
    sound.set_volume(volume)  # Set the volume
    sound.play()

# Function to handle key press event
def on_press(key):
    global enabled
    if not enabled:
        return

    try:
        if key.char:
            threading.Thread(target=play_sound, args=(default_sound,)).start()  # Default sound for any key
    except AttributeError:
        if key == keyboard.Key.backspace:
            threading.Thread(target=play_sound, args=(special_sounds['backspace'],)).start()
        elif key == keyboard.Key.tab:
            threading.Thread(target=play_sound, args=(special_sounds['tab'],)).start()
        elif key == keyboard.Key.enter:
            threading.Thread(target=play_sound, args=(special_sounds['enter'],)).start()
        elif key == keyboard.Key.space:
            threading.Thread(target=play_sound, args=(special_sounds['space'],)).start()
        elif key == keyboard.Key.caps_lock:
            threading.Thread(target=play_sound, args=(special_sounds['caps lock'],)).start()
        elif key == keyboard.Key.shift:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()
        elif key == keyboard.Key.shift_r:  # Shift phải
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()
        elif key == keyboard.Key.cmd:  # Shift phải
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.alt_l:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.alt_r:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.ctrl_l:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()
        
        elif key == keyboard.Key.ctrl_r:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.up:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.right:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.left:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()

        elif key == keyboard.Key.down:
            threading.Thread(target=play_sound, args=(special_sounds['shift'],)).start()
        # Add more conditions for other special keys if needed



def on_release(key):
    pass

# Start listening to the keyboard events
with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()
