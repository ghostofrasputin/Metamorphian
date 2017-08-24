#---------------------------------------------------------------------
# Spritify tool
#   takes a gif and turns it into png sprite sheet
#
#   Usage: python spritify.py [path/to/file.gif]
#---------------------------------------------------------------------

import os
import sys
import shutil
from PIL import Image

# extracts frames from a gif file
# puts image frames into a temporary folder
# returns list of frame names for spritify function
def extract_frames(gif_path, file, temp_dir):
  os.makedirs(temp_dir)
  frame = Image.open(gif_path)
  frames = []
  nframes = 0
  while frame:
    image_name = "%s/%s-%s.png" % (temp_dir, file, nframes)
    frame.save(image_name)
    frames += [image_name]
    nframes += 1
    try:
      frame.seek(nframes)
    except EOFError:
      break
  return frames

# takes a list of frames
# creates spritesheet in game 
# object's art asset drectory
# (same dir as gif file)
def spritify(frames, filename, dir):
  images = [Image.open(i) for i in frames]
  widths, heights = zip(*(i.size for i in images))

  total_width = sum(widths)
  max_height = max(heights)

  sprite_sheet = Image.new("RGBA", (total_width, max_height))

  x_offset = 0
  for image in images:
    sprite_sheet.paste(image, (x_offset,0))
    x_offset += image.size[0]
  
  sprite_sheet.save(dir + "/" + filename + "_" + "sprite_sheet.png")  

# removes temporary image folder
# and files  
def clean(temp_dir):
  shutil.rmtree(temp_dir)

# main
if __name__ == "__main__":
  if len(sys.argv) == 2:
    gif_path = sys.argv[1]
    file = os.path.basename(gif_path)
    filename = os.path.splitext(file)[0]
    temp_dir = os.path.dirname(gif_path) + "/temp"
    dir = os.path.dirname(gif_path)
    frames = extract_frames(gif_path, file, temp_dir)
    spritify(frames, filename, dir)
    clean(temp_dir)
    print("Sprite sheet generated.")
  else: 
    print("Usage: python spritify.py [path/to/file.gif]")
  