from __future__ import print_function
from __future__ import division 
from __future__ import absolute_import
# python 2/3 compatibility

#import cv2

'''
from d import debug
from save import save
from viz import pltshow
if debug:
  modulename='matplotlib'
  if modulename not in sys.modules:
    import matplotlib as mpl
    mpl.use('Agg')      # TkAgg
    from matplotlib import pyplot as plt  # NOTE:  problem on Nathan's machine (Dec. 21, 2018) is JUST with pyplot.  None of the rest of matplotlib is a problem AT ALL.
'''
ACROSS=1
def pltshow(im):
    plt.imshow(im); plt.show(); plt.close()


#=========================================================================
def pn(n=0):
  print('\n'*n)
#=========================================================================
def pif(s=''):
    if debug: print (s)
#=========================================================================
def pe(n=89): print('='*n)
#=========================================================================

#======================================================================================================
#======================================================================================================
# imports from seg.py:                          NOTE start seg.py copy-paste
#======================================================================================================
#======================================================================================================


WHITE=255
BLACK=0
TRANSPARENT=0

import os, tarfile, tempfile
import glob
import numpy as np
np.seterr(all='raise')
#import tensorflow as tf
#import scipy
#from scipy.ndimage.measurements import center_of_mass as CoM
from io import BytesIO
#import imageio as ii
#import skimage
#from PIL import Image

import sys
import subprocess as sp


#from matplotlib import gridspec
#from six.moves import urllib
#from scipy.ndimage import shift  # TODO: make all imports precisely like THIS.  from math import pi.  It's short, it's searchable (debuggable), 

from copy import deepcopy

'''
import matplotlib
matplotlib.use('Agg')      
'''
# NOTE: The above lines didn't end up being necessary.    But it's a good FYI so future programmers can solve matplotlib display problems, though

#================================================================
class DeepLabModel(object):
  INPUT_TENSOR_NAME = 'ImageTensor:0'
  OUTPUT_TENSOR_NAME = 'SemanticPredictions:0'
  INPUT_SIZE = 513
  FROZEN_GRAPH_NAME = 'frozen_inference_graph'

  def __init__(self, tarball_path):
    self.graph = tf.Graph()
    graph_def = None
    tar_file = tarfile.open(tarball_path)
    for tar_info in tar_file.getmembers():
      if self.FROZEN_GRAPH_NAME in os.path.basename(tar_info.name):
        file_handle = tar_file.extractfile(tar_info)
        graph_def = tf.GraphDef.FromString(file_handle.read())
        break

    tar_file.close()

    with self.graph.as_default():
      tf.import_graph_def(graph_def, name='')
    self.sess = tf.Session(graph=self.graph)
#================================================================
  def run(self, image):
    #print(type(image)) # type(image) is    <class 'PIL.PngImagePlugin.PngImageFile'>
    width, height = image.size
    resize_ratio = float(self.INPUT_SIZE / max(width, height))
    target_size = (int(resize_ratio * width), int(resize_ratio * height))
    resized_image = image.convert('RGB').resize(target_size, Image.ANTIALIAS)
    batch_seg_map = self.sess.run(
        self.OUTPUT_TENSOR_NAME,
        feed_dict={self.INPUT_TENSOR_NAME: [np.asarray(resized_image)]})
    seg_map = batch_seg_map[0]
    return resized_image, seg_map
#================================================================
  def seg_nparr(self, img):
    '''
      Segments many shapes of images
      In the method, we resize to a shape (ie. (513,288)) where one of the dimensions is 513 is required
    '''
    # tODO: understand better
    print('running deeplab segmentation on image')
    width, height, RGB = img.shape
    resize_ratio = float(self.INPUT_SIZE / max(width, height)) # 513/ bigger of width and height
    target_size = (int(resize_ratio * width), int(resize_ratio * height), 3)
    resized_image = skimage.transform.resize(img, target_size, mode='constant', anti_aliasing=True)

    # return segmentation mask
    return (self.sess.run(
        self.OUTPUT_TENSOR_NAME,
        feed_dict={self.INPUT_TENSOR_NAME: [resized_image]})[0], 
      resized_image)
  #=============== end segment_nparr(self, img): ===============
  #================================================================
# end class definition DeepLabModel()
#================================================================


#================================================================
def reduce_resolution(verts,faces):
  # NOTE: currently DOESN'T WORK.  Just idea-stage
  # NOTE: currently DOESN'T WORK
  # NOTE: currently DOESN'T WORK
  '''
    For each triangle with 3 adjacent triangles, take the centroids of the 3 adjacents and turn those into a triangle that replaces the original 4.
    Then, recurse until the whole mesh is lower resolution. 

    Maybe we have to find the implicit function "underneath the mesh" and then change the resolution of the triangle mesh overlying it, then.  This idea is half-taken from "Voronoi based variational reconstruction of unoriented point sets" by Alliez, et al.

    Issues I foresee:
      Edges, corners, weird edge cases.
      How do we 
  '''
  # NOTE: there's like, 0% chance this will work.
  # This function is for Pier and Simone.  Something about 3DS Max wanting lower resolution or something.
  for face in faces:
    print(face)
  return verts_reduced, faces_reduced
  
#================================================================
def create_pascal_label_colormap():
  colormap = np.zeros((256, 3), dtype=int)
  ind = np.arange(256, dtype=int)

  for shift in reversed(range(8)):
    for channel in range(3):
      colormap[:, channel] |= ((ind >> channel) & 1) << shift
    ind >>= 3

  return colormap
#================================================================
def label_to_color_image(label):
  if label.ndim != 2:
    raise ValueError('Expect 2-D input label')
  colormap = create_pascal_label_colormap()
  if np.max(label) >= len(colormap):
    raise ValueError('label value too large.')
  return colormap[label]


#================================================================
def binarize(mask_3_colors):
  RED=0; CERTAIN=256.0; probable = np.array(int(CERTAIN / 2)-1) # default color is magenta, but the red part shows 
  mask_binary = deepcopy(mask_3_colors[:,:,RED])
  return mask_binary.astype('bool')
# end binarize(mask_3_colors):
#================================================================
def run_visualization(url, model):
  try:
    f = urllib.request.urlopen(url)
    jpeg_str = f.read()
    original_im = Image.open(BytesIO(jpeg_str))
  except IOError:
    print('Cannot retrieve image. Please check url: ' + url)
    return
  if debug:
    print('running deeplab on image %s...' % url)
  resized_im, seg_map = model.run(original_im)
  if save:
    ii.imwrite("_segmented____binary_mask_.jpg", seg_map)  
    # I think something in the saving process ***ks up the mask with noise.  Dec. 14, 2018
  #PROBABLE = 127  # NOTE:  experimental from 1 data point;  PLEASE DOUBLE CHECK if u get a noisy segmentation
  #ii.imwrite("_segmented____binary_mask_.jpg", np.greater(seg_map, PROBABLE).astype('bool'))
  return np.rot90(seg_map,k=3) # k=3 b/c it gives us the result we want   (I tested it experimentally.  Dec. 26, 2018)   # this is true for the URL version, not the other
#===== end run_visualization(url): =====
#================================================================
def seg_map(img, model):
  # basically total fluff.  TODO: kill.
  print('running deeplab on image')
  seg_map, resized_im = model.seg_nparr(img) # within def seg_map(img, model)
  if debug:
    pltshow(seg_map)
  if save:
    fname = "_segmented____binary_mask_.jpg"
    print('saving segmentation map in ', fname)
    ii.imwrite(fname, seg_map)  # Dec. 14, 2018:  I think something in the saving process ***ks up the mask with noise
  return np.rot90(seg_map,k=3) # k=3 b/c it gives us the result we want   (I tested it experimentally.  Dec. 26, 2018)
#=========== end ============ seg_map(img, model): ==============  # NOTE: only need to do this if func is REALLY long.

#================================================================
def seg(img):
  img=img.astype("float64")
  #================================================================  labels
  LABEL_NAMES = np.asarray([
      'background', 'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
      'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse', 'motorbike',
      'person', 'pottedplant', 'sheep', 'sofa', 'train', 'tv'
  ])
  #================================================================
  FULL_LABEL_MAP = np.arange(len(LABEL_NAMES)).reshape(len(LABEL_NAMES), 1)
  FULL_COLOR_MAP = label_to_color_image(FULL_LABEL_MAP)
  MODEL_NAME = 'mobilenetv2_coco_voctrainaug'
  _DOWNLOAD_URL_PREFIX = 'http://download.tensorflow.org/models/'
  _MODEL_URLS = {
      'mobilenetv2_coco_voctrainaug': 'deeplabv3_mnv2_pascal_train_aug_2018_01_29.tar.gz',
      'mobilenetv2_coco_voctrainval': 'deeplabv3_mnv2_pascal_trainval_2018_01_29.tar.gz'
  }
  _TARBALL_NAME = 'deeplab_model.tar.gz'
  model_dir = './' # tODO: generalize this location
  download_path = os.path.join(model_dir, _TARBALL_NAME)
  # urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], download_path)
  MODEL = DeepLabModel(download_path) # segment_local()
  FAIRLY_CERTAIN=127
  seg_map, resized_im = MODEL.seg_nparr(img)
  return seg_map
#=====  end seg(params) =====
#================================================================
def segment_local(local_filename):
  #img=scipy.ndimage.io.imread(local_filename)
  img=np.asarray(ii.imread(local_filename)).astype('float64') # TODO: delete this commented-out line
  #================================================================
  #================================================================
  LABEL_NAMES = np.asarray([
      'background', 'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
      'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse', 'motorbike',
      'person', 'pottedplant', 'sheep', 'sofa', 'train', 'tv'
  ])
  #================================================================
  #================================================================
  FULL_LABEL_MAP = np.arange(len(LABEL_NAMES)).reshape(len(LABEL_NAMES), 1)
  FULL_COLOR_MAP = label_to_color_image(FULL_LABEL_MAP)
  MODEL_NAME = 'mobilenetv2_coco_voctrainaug'
  _DOWNLOAD_URL_PREFIX = 'http://download.tensorflow.org/models/'
  _MODEL_URLS = {
      'mobilenetv2_coco_voctrainaug': 'deeplabv3_mnv2_pascal_train_aug_2018_01_29.tar.gz',
      'mobilenetv2_coco_voctrainval': 'deeplabv3_mnv2_pascal_trainval_2018_01_29.tar.gz'
  }
  _TARBALL_NAME = 'deeplab_model.tar.gz'
  model_dir = './'
  download_path = os.path.join(model_dir, _TARBALL_NAME)
  # urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], download_path)
  MODEL = DeepLabModel(download_path) # segment_local()
  FAIRLY_CERTAIN=127
  return seg_map(img, MODEL)
#=====  end segment_local(local_filename) =====

#================================================================
#==================================================
def segment_URL(IMG_URL):
  '''
    NOTE: segmentation requires internet connection
  '''
  # TODO:   allow us to set the URL from parameter
  LABEL_NAMES = np.asarray([
      'background', 'aeroplane', 'bicycle', 'bird', 'boat', 'bottle', 'bus',
      'car', 'cat', 'chair', 'cow', 'diningtable', 'dog', 'horse', 'motorbike',
      'person', 'pottedplant', 'sheep', 'sofa', 'train', 'tv'
  ])

  FULL_LABEL_MAP = np.arange(len(LABEL_NAMES)).reshape(len(LABEL_NAMES), 1)
  FULL_COLOR_MAP = label_to_color_image(FULL_LABEL_MAP)
  MODEL_NAME = 'mobilenetv2_coco_voctrainaug'

  _DOWNLOAD_URL_PREFIX = 'http://download.tensorflow.org/models/'
  _MODEL_URLS = {
      'mobilenetv2_coco_voctrainaug': 'deeplabv3_mnv2_pascal_train_aug_2018_01_29.tar.gz',
      'mobilenetv2_coco_voctrainval': 'deeplabv3_mnv2_pascal_trainval_2018_01_29.tar.gz'
  }
  _TARBALL_NAME = 'deeplab_model.tar.gz'

  model_dir = './'
  download_path = os.path.join(model_dir, _TARBALL_NAME)
  # urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], download_path)

  MODEL = DeepLabModel(download_path)

  FAIRLY_CERTAIN=127
  return np.greater(run_visualization(IMG_URL, MODEL), FAIRLY_CERTAIN)
#===== end segment_URL(IMG_URL): =====




#====================================================================
def segment_black_background(local_fname):
  '''
    BLACK is 0; so this function can be used to "add" two images together to superimpose them.
  '''
  # TODO: debug, generalize, etc.  Something ain't working (one of the last parts)
  # NOTE:  PIL.resize(shape)'s shape has the width and height in the opposite order from numpy's height and width
  # NOTE: weird sh!t happened when I tried to convert to 'float64' in the `np.array(Image.open(fname))` line.
  segmap  = segment_local(local_fname) # segment_black_background()
  #print("segmap.shape: \n{0}".format(segmap.shape)) # (513, 288).  Everything important happens in "segment_local()"
  segmap  = segmap.reshape(segmap.shape[0],segmap.shape[1],1)
  segmap  = np.rot90(       np.concatenate((segmap,segmap,segmap),axis=2)        )
  # I really OUGHT to scale the mask to fit the dimensions of the image (we'd have better resolution this way)
  img     = Image.open(local_fname)
  img     = img.resize((segmap.shape[1],segmap.shape[0]), Image.ANTIALIAS)
  img     = np.array(img) 
  if debug:
    pltshow(img); pltshow(segmap)
  # as of (Wed Feb 20 17:49:37 EST 2019), segmap is 0 for background, 15 for human ( before astype('bool'))
  segmap=np.logical_not(segmap.astype('bool'))

  # cut out the human from the img
  img[segmap]=BLACK
  if debug:
    pltshow(img)
  fname='person_cutout__black_background.png'
  ii.imwrite(fname,img)
  return img, np.logical_not(segmap)
  # logical_not() because mask should be where there's a person, not where there's background
#========== end segment_black_background(params): ==========

#======================================================================================================
#======================================================================================================
#                                               NOTE end copy-paste from seg.py
#======================================================================================================
#======================================================================================================



# imports useful for access in python shell rather than for use in utils.py
#import pandas as pd
#from   mpl_toolkits.mplot3d import Axes3D   # import no longer used (Dec. 16, 2018).  plots VERY BASIC 3d shapes
#import imageio as ii # imageio is not in hmr virtualenv.  I can comment out when necessary.

import numpy as np
np.seterr(all='raise')
#from PIL import Image
#import skimage

import pickle as pkl

import datetime
import sys
import os
import math
from   math import sin, cos, tan, pi, radians, degrees, floor, ceil, sqrt
from   collections import OrderedDict
from   pprint import pprint as p

from   os import listdir as ls
from   time import sleep
import subprocess as sp
import random
from   copy import deepcopy

#from   d import debug
#from viz import pltshow
import readline

# TODO:   vim "repeat any"
# TODO:   vim command "undo any"
# TODO:   auto-updating ls, l, pwd, etc. commands (variable gets updated every 10 seconds within python shell and automatically pretty-prints)

# TODO:   refactor: move all pltshow(), show_3d(), etc. type functions into utils.py or something like utils.py and rename it
# TODO:   def pif(txt): if global_debug_boolean: print(txt)

#######################################################################################################
#################################    utility functions    #############################################
#######################################################################################################


#=========================================================================
def mask_info(mask):
  locs=np.nonzero(mask)
  locs=np.concatenate((locs[0].reshape(locs[0].shape[0],1)    ,locs[1].reshape(locs[1].shape[0],1)),axis=1) # shape (n,2)
  top , left  = np.min(locs,axis=0)
  bot , right = np.max(locs,axis=0)
  w=right - left
  h=bot   - top
  return {'right' : right,
          'left'  : left,
          'top'   : top,
          'bottom': bot,
          'width' : w,
          'height': h
          }
#=========================================================================
def neg(tup):
  """
    Negate a mask?         
      (I wrote this documentation many months after this was written (on Tue Oct  1 14:00:42 EDT 2019)
      )
  """
  locs=np.nonzero(mask)
  mask_left=np.min(locs[0])
  mask_top=np.min(locs[0])
  mask_left=np.min(locs[0])
  mask_top=np.min(locs[0])
  negged=()
  for e in tup:
    negged+=(-e,)
  return negged
#=========================================================================
def merge_2_dicts(x, y):
    z = x.copy()   # start with x's keys and values
    z.update(y)    # modifies z with y's keys and values & returns None
    return z
#=========================================================================
def sq(x):
    return x*x
#=========================================================================
def blenderify(nparr):
    '''
        A more descriptive name would be "def make_list_of_tuples_from_nparr(arr):"
        3-tuples contain (x, y, z) locations of the nonzero elements in arr
        precondition: len(arr.shape)==3
    '''
    li=[]
    for i in range(arr.shape[0]):
        for j in range(arr.shape[1]):
            for k in range(arr.shape[2]):
                if(arr[i][j][k]):
                    li.append((i,j,k))
    return li
#=========================================================================
def approx_eq(x,y):
    '''
        approx_eq() is only for np arrays
        curr just 2-d arrs, but should extend to 3d later
      already exists [here](https://docs.scipy.org/doc/numpy/reference/generated/numpy.isclose.html)
    '''
    if not x.shape == y.shape:
      print ("the shapes are not the same:\n first_param.shape is {0} \n second_param.shape is {1} \n".format(x,y))
      return False
    for i in range(x.shape[0]):
      for j in range(x.shape[1]):
        e=x[i,j]; tolerance=abs(e)/20
        if abs(y[i,j]-x[i,j]) > tolerance:
          return False
    return True
#=========================================================================
def eq(x,y):
    '''
        eq() is only for np arrays
    '''
    return np.array_equal(x,y)
#=========================================================================
def sort_fnames_list(fnames_list):
    '''
        assumes filenames fnames are all precisely of format:
          0.0.png
          45.0.png
          90.0.png
          ...
          315.0.png
        Terminating decimals are okay, but repeating (ie. 3.33333333) are not supported
    '''
    trimmed = []
    for fname in fnames_list:
        trimmed.append(float(fname.replace('.png', '')))  # TODO: extend to image filetypes other than png.  Best way TODO this is by reverse-searching for the last decimal pt and trimming that way instead
    _sorted = sorted(trimmed)
    final = []
    for num in _sorted:
        final.append(str(num)+'.png')
    return final
#=========================================================================


#==============================================================
def prepend_0s(int_str, num_digits=9):
  '''
    Params:
    -------
    int_str is a string

  '''
  #NOTE: I know there's a less "hack-y" way of putting zeros in front of a number.  But I don't wanna look it up when I can just rewrite the code myself.
  return '0'*(num_digits-len(int_str))+int_str
#==============================================================

#============================================================================================================================
#======================================================== NOTE ==============================================================
#============================================================================================================================
#=============================================== BIG PICTURE FUNCTION =======================================================
#============================================================================================================================
#======================================================== NOTE ==============================================================
#============================================================================================================================
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
#============================================================================================================================
def vid_2_mesh(
  vid_local_path="/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_jesus_pose_legs_together_0227191404.mp4",
  secs_btwn_frames=1/3.):
  '''
    -------
    Params:
    -------
    vid_local_path:     string.  supported 1 trial of .mp4 and 1 trial of .webm.
    secs_btwn_frames:    float.  1/3. is empirical; 15 degree angles from nathan_jesus_pose_legs_together_0227191404.mp4

    ------ 
    Notes:
    ------ 
    Sources:
      https://stackoverflow.com/questions/33311153/python-extracting-and-saving-video-frames

    -------
     TODOS
    -------
    Testing
    Generalize this to multiple vid filetypes, not just mp4.  
      It worked on a .webm file!
  '''
  '''
    Big picture:
  2.  frames  = cut(vid)
  3.  mask    = seg(frame)
  4.  angle   = detect(mask, vid) 
  5.  model   = upd8(model, mask, angle)
    #Use that angle and the image (and resultant segmentation mask) at that angle to mask the voxels
  6.  smpl    = fit(model)
  '''
  # You're in function "vid_2_mesh(params):"

  # This "10" in delay=int(round(10 * secs_btwn_frames)) is because cv2 defaults to opening a new frame approx every 0.1 seconds
  delay = int(round(10 * secs_btwn_frames))
  print("Reading a frame from the video every {0} seconds".format(secs_btwn_frames))

  # Get frames from the input video file and process them.
  vidcap  = cv2.VideoCapture(vid_local_path)
  count   = 0
  # The following is basically a "do while:"
  success, img  =vidcap.read()
  print("img.shape is ",img.shape)
  while success:
    # Make mask, upd8 voxels, build SMPL.
    if count % delay == 0:

      # BGR to RGB
      img=img[:,:,::-1]
      mask = seg(img)
      print("mask.shape = ",mask.shape) # (513,288)
      #mask=mask.astype('bool')
    # end if count % delay == 0:
    count += 1
    success, img = vidcap.read()
  mesh=np.eye(3) # TODO:   This is just a placeholder for mesh.  Real one should use smpl or some other complex but accurate method of returning the mesh
  return mesh
#==================== vid_2_mesh ==============================
#============================================================================================================================
#======================================================== NOTE ==============================================================
#============================================================================================================================
#=============================================== BIG PICTURE FUNCTION =======================================================
#============================================================================================================================
#======================================================== NOTE ==============================================================
#============================================================================================================================
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
#============================================================================================================================
def vid_2_mesh_sandbox(
  vid_local_path="/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_jesus_pose_legs_together_0227191404.mp4",
  secs_btwn_frames=1/3.):
  '''
    -------
    Params:
    -------
    vid_local_path:     string.  supported 1 trial of .mp4 and 1 trial of .webm.
    secs_btwn_frames:    float.  1/3. is empirical; 15 degree angles from nathan_jesus_pose_legs_together_0227191404.mp4

    ------ 
    Notes:
    ------ 
    Sources:
      https://stackoverflow.com/questions/33311153/python-extracting-and-saving-video-frames

    -------
     TODOS
    -------
    Testing
    Generalize this to multiple vid filetypes, not just mp4.  
      It worked on a .webm file!
  '''
  '''
    Big picture:
  2.  frames  = cut(vid)
  3.  mask    = seg(frame)
  4.  angle   = detect(mask, vid) 
  5.  model   = upd8(model, mask, angle)
    #Use that angle and the image (and resultant segmentation mask) at that angle to mask the voxels
  6.  smpl    = fit(model)
  '''
  # You're in function "vid_2_mesh_sandbox(params):"


  STILL_FRAMES=10 # This one I made up; we should test to see which value gives the best result
  # This "10" in delay=int(round(10 * secs_btwn_frames)) is because cv2 defaults to opening a new frame approx every 0.1 seconds.  I got this empirically from 1 example, but cv2 says it's 30 in the command "vidcap.get(cv2.CAP_PROP_FPS)"
  fps=10
  #fps = vidcap.get(cv2.CAP_PROP_FPS) # Is this correct, though?  It said 30 for '/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_jesus_pose_legs_together_0227191404.mp4'
  delay = int(round(fps * secs_btwn_frames))
  print("Reading a frame from the video every {0} seconds".format(secs_btwn_frames))

  # Get frames from the input video file and process them.
  vidcap  = cv2.VideoCapture(vid_local_path)
  count   = 0
  success, img  =vidcap.read() # img.shape == (1920,1020)

  vidcap.set(cv2.CAP_PROP_POS_AVI_RATIO,1) # vid's end
  endtime=vidcap.get(cv2.CAP_PROP_POS_MSEC) / 1000.
  # "endtime" initially in millisecs, 1000 puts it in seconds
  num_masks=int(round((endtime*fps)+STILL_FRAMES+1)) # if I made a fencepost error somewhere, the +1 will fix it and not cost too much extra space
  print("num_masks = ",num_masks)
  vidcap.set(cv2.CAP_PROP_POS_AVI_RATIO,0) # vid's beginning

  if success:
    mask=seg(img) #  mask.shape == (513,288)
    tensor_shape= mask.shape+ (num_masks,)
    masks=np.zeros(tensor_shape) # what is the default type?
    mask_ws=np.zeros(num_masks)
    # might not matter to be this precise "(masks=np.zeros((*mask.shape,num_masks)))," but if I do the work of already making it ready for optimization, it'll be easier to optimize (speed up) later
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
      # TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO
  mask_idx=0
  # read in all the masks
  while success:
    # Make mask, upd8 voxels, build SMPL.
    if count < STILL_FRAMES or count % delay == 0:
      img=img[:,:,::-1] # BGR to RGB
      mask=seg(img)
      masks[:,:,mask_idx]= mask
      # Something is wrong either with storage or segmentation here.  I just got a bunch of blank masks
      mask_ws[mask_idx]=np.max(np.count_nonzero(mask,axis=ACROSS))
      mask_idx+=1
    # end if count % delay == 0:
    count += 1
    success, img = vidcap.read()
  side_2_front_idxes=np.argsort(mask_ws) # the masks of the side views ought to be at the beginning of this variable

  # show the first n masks
  n=10
  for i in range(n):
    pltshow(masks[:,:,side_2_front_idxes[i]])
    pltshow(masks[:,:,side_2_front_idxes[len(side_2_front_idxes)-1-i]]) # -1 b/c fencepost error
  #print("masks: ",masks)
  '''
  for mask in masks:
    pltshow(mask) # BUNCH of blanks
  '''
  mesh=np.eye(3) # TODO:   This is just a placeholder for mesh.  Real one should use smpl or some other complex but accurate method of returning the mesh
  return mesh
#==================== vid_2_mesh_sandbox ==============================
#============================================================================================================================
def masks_2_angles_sandbox(
  mask_dir="/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/masks/2019_03_03____09:08_AM___/",
  secs_btwn_frames=1/3.):
  '''
    Uses cached masks: (load masks from directory)
    Precondition: the user will give video where they take small, incremental steps instead of continuously rotating in a circle and constantly changing their pose in order to take those steps
  '''

  mask_fnames=files_from_dir(mask_dir)
  mask_fnames=sorted(mask_fnames,key=os.path.getctime)
  num_masks=len(mask_fnames)
  mask=np_img(mask_fnames[0])
  tensor_shape= mask.shape+ (num_masks,)
  masks=np.zeros(tensor_shape) # What is the default type?
  mask_ws=np.zeros(num_masks)

  for mask_idx in range(num_masks):
    mask=np_img(mask_fnames[mask_idx])
    masks[:,:,mask_idx]= mask
    mask_ws[mask_idx]=np.max(np.count_nonzero(mask,axis=ACROSS))
    if 5 < mask_idx < 12:
      pltshow(mask)
  side_2_front_idxes=np.argsort(mask_ws) # the masks of the side views ought to be at the beginning of this variable
  # show the first n masks
  n=10 # This "n" should be adapted to the particular video case.  For instance, it depends whether there are any "zero width" masks
  #longest=mask_ws[side_2_front_idxes[num_masks-n:]]
  longest=mask_ws[num_masks-1] # TODO: denoise somehow
  shortest=mask_ws[side_2_front_idxes[:n]]
  torso_w_pix=np.median(shortest)
  both_arms_max_w=np.median(longest)
  max_wingspan=both_arms_max_w-torso_w_pix
  print("torso_w_pix  : ",torso_w_pix)
  print("max_wingspan : ",max_wingspan)
  print("\n"*5)
  for mask_idx in range(num_masks):
    mask        = masks[:,:,mask_idx]
    curr_w      = mask_ws[mask_idx]
    curr_arms_w = curr_w-torso_w_pix
    angle       = np.arccos(curr_arms_w /max_wingspan) # arccos() returns radians
    angle      *= 180/pi
    print("curr angle = ",angle)
    pltshow(mask)
  """
  for i in range(n):
    pltshow(masks[:,:,side_2_front_idxes[i]])
    '''
    pltshow(masks[:,:,side_2_front_idxes[len(side_2_front_idxes)-1-i]])
    '''
    # works
  #
  """
  # This'll just HAVE to be easier with a motorized lazy susan.  It's hard to see a way around it.  Even with the motorized lazy susan, the noise from the segmasks will make it very very hard to do properly.
  # All this is almost certainly why hmr did it the way they did it: getting all the data from one front-facing picture sure makes things easier.
  return
#==================== masks_2_angle_sandbox ==============================


#==============================================================
def vid_cut(
  vid_local_path="/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_jesus_pose_legs_together_0227191404.mp4",
  root_img_dir="/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/imgs",
  should_put_timestamps=True,
  output_img_filetype='jpg',
  how_many_angles=8):
  '''
    Assumes constant angular velocity omega during video of 360 degree rotation of body.
 
    -------
    Params:
    -------

    secs_btwn_frames=1/3. is empirical; 15 degree angles from nathan_jesus_pose_legs_together_0227191404.mp4


    ------ 
    Notes:
    ------ 
    Sources:
      https://stackoverflow.com/questions/25182278/opencv-python-video-playback-how-to-set-the-right-delay-for-cv2-waitkey
      https://stackoverflow.com/questions/33311153/python-extracting-and-saving-video-frames


    -------
     TODOS
    -------
    Testing
    Generalize this to multiple vid filetypes, not just mp4.  
      It worked on a .webm file!
    Get cv2 integrated with conda environment "cat"
      This might work with a new version of conda, etc.
    There's probably a better (simpler, more pythonic) way to do the prepend_0s() function

    Refactor?
      This "do while" can be made into a for loop with a break condition:

      success, img  =vidcap.read()
      while success:
        if count % delay == 0:
          cv2.imwrite(img_write_dir+"{0}.{1}".format(prepend_0s(str(count)),output_img_filetype), img)
        count += 1
        success, img = vidcap.read()
  '''

  delay = int(round(10 * secs_btwn_frames))
  # The "10" in delay=int(round(10 * secs_btwn_frames)) is because cv2 defaults to opening a new frame approx every 0.1 seconds

  # Make folder to store the images
  img_write_dir=root_img_dir
  if not root_img_dir.endswith('/'):
    img_write_dir+='/'
  if should_put_timestamps:
    timestamp=datetime.datetime.now().strftime('%Y_%m_%d____%H:%M_%p__') # p is for P.M. vs. A.M.
    img_write_dir+=timestamp+'/'
  print("Saving images to: ",img_write_dir)
  print("Saving a frame from the video every {0} seconds".format(secs_btwn_frames))
  os.system('mkdir '+img_write_dir)
  # Even if the folder to be created already exists,  the frames of the video STILL get written into the already-existing folder

  # Write images from the input video file
  vidcap  = cv2.VideoCapture(vid_local_path)
  count   = 0
  # The following is basicaaly a "do while:"
  success, img  =vidcap.read()
  while success:
    if count % delay == 0:
      img=img[:,:,::-1] # BGR 2 RGB
      pltshow(img)
      if input("Save this image? y/n").lower()=='y':
        fname=img_write_dir+"{0}.{1}".format(prepend_0s(str(count)),output_img_filetype)
        cv2.imwrite(fname, img)
    count += 1
    success, img = vidcap.read()
  return root_img_dir #img_write_dir # success
#===== end func def of  manual_vid_cut(**lotsa_params): =====
def manual_vid_cut(
  vid_local_path="/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_jesus_pose_legs_together_0227191404.mp4",
  root_img_dir="/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/imgs",
  secs_btwn_frames=1/3.,
  should_put_timestamps=True,
  output_img_filetype='jpg'):
  '''
    -------
    Params:
    -------

    secs_btwn_frames=1/3. is empirical; 15 degree angles from nathan_jesus_pose_legs_together_0227191404.mp4


    ------ 
    Notes:
    ------ 
    Sources:
      https://stackoverflow.com/questions/25182278/opencv-python-video-playback-how-to-set-the-right-delay-for-cv2-waitkey
      https://stackoverflow.com/questions/33311153/python-extracting-and-saving-video-frames


    -------
     TODOS
    -------
    Testing
    Generalize this to multiple vid filetypes, not just mp4.  
      It worked on a .webm file!
    Get cv2 integrated with conda environment "cat"
      This might work with a new version of conda, etc.
    There's probably a better (simpler, more pythonic) way to do the prepend_0s() function

    Refactor?
      This "do while" can be made into a for loop with a break condition:

      success, img  =vidcap.read()
      while success:
        if count % delay == 0:
          cv2.imwrite(img_write_dir+"{0}.{1}".format(prepend_0s(str(count)),output_img_filetype), img)
        count += 1
        success, img = vidcap.read()
  '''
  # This function is called "manual_vid_cut(params):"

  delay = int(round(10 * secs_btwn_frames))
  # The "10" in delay=int(round(10 * secs_btwn_frames)) is because cv2 defaults to opening a new frame approx every 0.1 seconds

  # Make folder to store the images
  img_write_dir=root_img_dir
  if not root_img_dir.endswith('/'):
    img_write_dir+='/'
  if should_put_timestamps:
    timestamp=datetime.datetime.now().strftime('%Y_%m_%d____%H:%M_%p__') # p is for P.M. vs. A.M.
    img_write_dir+=timestamp+'/'
  print("Saving images to: ",img_write_dir)
  print("Saving a frame from the video every {0} seconds".format(secs_btwn_frames))
  os.system('mkdir '+img_write_dir)
  # Even if the folder to be created already exists,  the frames of the video STILL get written into the already-existing folder

  # Write images from the input video file
  vidcap  = cv2.VideoCapture(vid_local_path)
  count   = 0
  # The following is basicaaly a "do while:"
  success, img  =vidcap.read()
  while success:
    if count % delay == 0:
      img=img[:,:,::-1] # BGR 2 RGB
      pltshow(img)
      if input("Save this image? y/n").lower()=='y':
        fname=img_write_dir+"{0}.{1}".format(prepend_0s(str(count)),output_img_filetype)
        ii.imwrite(fname, img)
    count += 1
    success, img = vidcap.read()
  return root_img_dir #img_write_dir # success
#===== end func def of  manual_vid_cut(**lotsa_params): =====
#==============================================================
def save_vid_as_imgs(
  vid_local_path="/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_jesus_pose_legs_together_0227191404.mp4",
  root_img_dir="/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/imgs",
  secs_btwn_frames=1/3.,
  should_put_timestamps=True,
  output_img_filetype='jpg'):
  '''
    -------
    Params:
    -------

    secs_btwn_frames=1/3. is empirical; 15 degree angles from nathan_jesus_pose_legs_together_0227191404.mp4


    ------ 
    Notes:
    ------ 
    Sources:
      https://stackoverflow.com/questions/25182278/opencv-python-video-playback-how-to-set-the-right-delay-for-cv2-waitkey
      https://stackoverflow.com/questions/33311153/python-extracting-and-saving-video-frames


    -------
     TODOS
    -------
    Testing
    Generalize this to multiple vid filetypes, not just mp4.  
      It worked on a .webm file!
    Get cv2 integrated with conda environment "cat"
      This might work with a new version of conda, etc.
    There's probably a better (simpler, more pythonic) way to do the prepend_0s() function

    Refactor?
      This "do while" can be made into a for loop with a break condition:

      success, img  =vidcap.read()
      while success:
        if count % delay == 0:
          cv2.imwrite(img_write_dir+"{0}.{1}".format(prepend_0s(str(count)),output_img_filetype), img)
        count += 1
        success, img = vidcap.read()
  '''
  # This function is called "save_vid_as_imgs(params):"

  #import cv2 
  #"import cv2" is in this local function ONLY because I was having issues installing cv2 into the conda "cat" environment.  I wish I remembered which package was the issue off the top of my head.
  delay = int(round(10 * secs_btwn_frames))
  # The "10" in delay=int(round(10 * secs_btwn_frames)) is because cv2 defaults to opening a new frame approx every 0.1 seconds

  # Make folder to store the images
  img_write_dir=root_img_dir
  if not root_img_dir.endswith('/'):
    img_write_dir+='/'
  if should_put_timestamps:
    timestamp=datetime.datetime.now().strftime('%Y_%m_%d____%H:%M_%p__') # p is for P.M. vs. A.M.
    img_write_dir+=timestamp+'/'
  print("Saving images to: ",img_write_dir)
  print("Saving a frame from the video every {0} seconds".format(secs_btwn_frames))
  os.system('mkdir '+img_write_dir)
  # Even if the folder to be created already exists,  the frames of the video STILL get written into the already-existing folder

  # Write images from the input video file
  vidcap  = cv2.VideoCapture(vid_local_path)
  count   = 0
  # The following is basicaaly a "do while:"
  success, img  =vidcap.read()
  while success:
    if count % delay == 0:
      fname=img_write_dir+"{0}.{1}".format(prepend_0s(str(count)),output_img_filetype)
      cv2.imwrite(fname, img)
    count += 1
    success, img = vidcap.read()
  return root_img_dir #img_write_dir # success
#===== end func def of  save_vid_as_imgs(**lotsa_params): =====



















 





















#=======================================================================================================================================
def np_img(img_fname):
  return np.asarray(ii.imread(img_fname))

#=======================================================================================================================================
def perim_e(a, b, precision=6):
  """Get perimeter (circumference) of ellipse

  Parameters
  ----------
  %(input)s
  a : scalar
    Length of one of the SEMImajor axes (like radius, not diameter)
  b : scalar
    Length of the other semimajor axis
  precision : int
    How close to the actual circumference we want to get.  Note: this function will always underestimate the ellipse's circumference.

  Returns
  -------
  float
    Perimeter
  gaussian_filter : ndarray
      Returned array of same shape as `input`.

  Notes
  -----
  As far as I can tell from ~5 hours working on this, the precise circumference of an ellipse is an open problem in mathematics.  If you see the integral on Wikipedia and have some idea how to solve it, please let the mathematics community (and me: [nathanbendich@gmail.com]) know!
  The real ellipse's circumference will always be more than what this infinite series predicts because the infinite series is a sum of a positive sequence.

  According to https://www.mathsisfun.com/geometry/ellipse-perimeter.html, Ramanujan's approximation that perimeter ~= pi*(a+b)*(1+(3h/(10+sqrt(4-3*h)))) seems to be higher than this series approximation.
  I think Sympy uses Approx. 3 from that ellipse page (https://www.mathsisfun.com/geometry/ellipse-perimeter.html).  I only tested for a = 10 and values of b on the page https://www.mathsisfun.com/geometry/ellipse-perimeter.html (I really hope this link doesn't end up breaking)
    But sympy is slowwww.  Maybe for refactoring, use Ramanujan's approx 3 but turn it into pure python or numpy or something fast?  Or take the mean of this series and Ramanujan's approx. 3?  There's no analytical reason for that; I'm just basing it off the fact that this series undershoots and Ramanujan's approximation overshoots.
  Another potential improvement is to actually take the time to understand the "Binomial Coefficient with half-integer factorials" mentioned on https://www.mathsisfun.com/geometry/ellipse-perimeter.html.  I attempted this for awhile, but got caught on some bug I didn't understand, opting for hard-coding 6 "levels of precision" instead.  So long as there are no overflows, extending this to arbitrary precision should be doable; it just takes a little more mathematical rigor and care than I'm giving right now.  Anyway, I've spent too long writing this documentation, but it was very personally satisfying to take the time to do this right.  I really need to be practical about churning out code faster though, haha.  While just prototyping, this level of detail might not be practical.

  Examples
  --------
  """
  # This function uses approximations mentioned in these sources:
  #   1.(https://www.mathsisfun.com/geometry/ellipse-perimeter.html) and 
  #   2. https://en.wikipedia.org/wiki/Ellipse
  #   3. https://stackoverflow.com/questions/42310956/how-to-calculate-perimeter-of-ellipse
  #   4. 
  # For more reading while refactoring, please consult the wikipedia page, https://math.stackexchange.com/, or wherever else.
  # func perim_e():
  funcname=  sys._getframe().f_code.co_name
  if b > a:
    tmp=a; a=b; b=tmp # swap such that a is always the semi-major axis (bigger than b)
  if precision <= 0:
    pn(2); print("In function ",funcname); print("WARNING:  precision cannot be that low"); pn(2)
  if precision >  6:
    # precision higher than 6 not supported as of Tue Feb 26 12:06:35 EST 2019
    pn(2); print("In function ",funcname); print("WARNING:  precision that high is not yet supported"); pn(2)
  # To understand what each symbol (h, seq, a, b) means, please see our sponsor at 
  #   https://www.mathsisfun.com/geometry/ellipse-perimeter.html.
  h=((a-b)**2)/((a+b)**2)
  seq=[  1/          h**0,
         1/        4*h**1,
         1/       64*h**2,
         1/      256*h**3,
        25/    16384*h**4, 
        49/    65536*h**5, 
       441/  1048576*h**6]  # only up to 7 terms
  perim=pi*(a+b)*sum(seq[:precision])
  return perim
#=====================================================    perim_e()   ==================================================================
















def newline(f):
    f.write('\n')

#=========================================================================

def pn(n=0):        print('\n'*n)

def pif(s=''):      
  if debug: print (s)

def pe(n=89):       print('='*n)

#===================================================================================================
# TODO: history | grep,   history | tail
def hist():
    '''
        print python history
        TODO:  hg() == UNIX hg
    '''
    import readline
    pe(39)
    for i in range(readline.get_current_history_length()):
        print (i, readline.get_history_item(i + 1))
    pe(39)


h=hist
H=h
#===================================================================================================
def ht(n=10):
  import readline
  pe(39)
  for i in range(readline.get_current_history_length()):
    if i > readline.get_current_history_length()-n:
      print (i,readline.get_history_item(i + 1))
  pe(39)
#===================================================================================================

def hgr(s='print', n=0):
  # grep through my python history
  import readline
  pn(); pe(39)
  past_lines=[]
  future_lines=[]
  found=False
  for i in range(readline.get_current_history_length()):
    line=readline.get_history_item(i + 1)
    if found and n:
      future_lines.append(line)
      if len(future_lines) == n:
        for j,future_line in enumerate(future_lines):
          print(i-n+j, future_line)
        future_lines=[]
        print()
      found=False
    if s in line:
      for j,past_line in enumerate(past_lines):
        print(i-n+j,past_line)
      print(i,line)
      future_lines=[]
      found=True
    past_lines.append(line)
    if len(past_lines) > n:
      past_lines=past_lines[1:]
  pe(39); pn()
  # TODO:   extend to a few lines around the target line.
#===================================================================================================

def print_dict(d):
    # do pprint.pprint() instead
    print_dict_recurs(d, 0)

def print_dict_recurs(d, indent_lvl=2):
    for k,v in d.items():
        print (('  ')*indent_lvl+'within key '+str(k)+': ')
        if type(v)==type({}) or type(v)==type(OrderedDict()):
            print_dict_recurs(v, indent_lvl+1)
        elif type(v)==type([]):
            print_list_recurs(v, indent_lvl+1)
        else:
            print (('  ')*indent_lvl+'  value in dict: '+str(v))

def print_list(l):
    print_list_recurs(l, 0)
def print_list_recurs(l, indent_lvl):
    print (('  ')*indent_lvl+'printing list')
    for e in l:
        if type(e)==type({}) or type(e)==type(OrderedDict()):
            print_dict_recurs(e, indent_lvl+1)
        elif type(e)==type([]):
            print_list_recurs(e, indent_lvl+1)
        else:
            print (('  ')*indent_lvl+'  element in list: '+str(e))
 
#=========================================================================
def print_visible(s):
    '''
            Prints like the following:
    >>> print_visible(s)




        ("pad" # of newlines)


===============================================
            inputted string s here
===============================================


        ("pad" # of newlines)

    '''
    s = str(s)
    pad = 21
    num_eq = 3*len(s)
    print(pad*"\n"           +\
            (num_eq*"="+"\n")+\
            len(s)*" "+s+"\n"+\
            (num_eq*"=")     +\
            (pad*"\n"))

#=========================================================================
def count(arr):
  #np.countnonzero()?
  counts={}
  if len(arr.shape)==3:
    for subarr_1 in arr:
      for subarr_2 in subarr_1:
        for val in subarr_2:
          if val in counts:
            counts[val]+=1
          else:
            counts[val]=1
  if len(arr.shape)==2:
    for subarr_1 in arr:
      for val in subarr_1:
        if val in counts:
          counts[val]+=1
        else:
          counts[val]=1
  return counts
#=========================================================================


#=========================================================================
# NOTE:   the most basic example of exception inheritance
class MeanHasNoPtsException(RuntimeError):
    pass
#=========================================================================




















"""
#=========================================================================
def get_blender_verts():
  '''
    output param "coords" will work with numpy (np.min() and np.max())
  '''
  # NOTE: to make this function work, just copy & paste   the code into blender's python "REPL"
	import bpy
	from bpy import context
	obj = context.active_object
	v = obj.data.vertices[0]
	co_final = obj.matrix_world * v.co
	# now we can view the location by applying it to an object
	obj_empty = bpy.data.objects.new("Test", None)
	context.scene.objects.link(obj_empty)
	obj_empty.location = co_final
	coords = [(obj.matrix_world * v.co) for v in obj.data.vertices]
    #output param "coords" will work with numpy (np.min() and np.max())
  return coords
#=========================================================================
"""
#=========================================================================
def vert_info(verts):
  # only for use in python REPL in blender
  x_min,y_min,z_min=np.min(verts,axis=0)
  x_max,y_max,z_max=np.max(verts,axis=0)
  x_len,y_len,z_len=np.max(verts,axis=0)-np.min(verts,axis=0)
  return x_min,y_min,z_min, x_max,y_max,z_max, x_len,y_len,z_len
#=========================================================================























#=========================================================================
def no_color_shift(shift):
  # might cause a problem with scipy.ndimage.shift()
  shift[2]=0
  return shift
#=========================================================================
def round_tuple(tup):
  rounded=()
  for coord in tup:
    rounded+=(int(round(coord)),)
  return rounded
#=========================================================================
def shift_img(): pass
  #https://docs.scipy.org/doc/scipy/reference/generated/scipy.ndimage.shift.html
  # https://docs.scipy.org/doc/scipy-0.16.1/reference/generated/scipy.ndimage.interpolation.shift.html
#=========================================================================
def resize_im():
  # NOTE:  how do we resize a 3d np array???  (segmap)
  # sample img resize code from SOvewrflow; calling it won't actually work
  from PIL import Image

  basewidth = 300
  img = Image.open('somepic.jpg')
  wpercent = (basewidth/float(img.size[0]))
  hsize = int((float(img.size[1])*float(wpercent)))
  img = img.resize((basewidth,hsize), Image.ANTIALIAS)
  img.save('sompic.jpg')
#=========================================================================
def crop():
  from PIL import Image
  img=Image.open('/home/n/tmp.jpg')
  w,h=img.size  # TODO: check whether this works with a color img
  img=img.crop(w,h)
  # other useful image functions:
  '''
    from PIL import Image
    img = Image.open(fname)
    img = np.array(img)
  '''
#=========================================================================
def crop_person(img, mask):
  '''
    ------
    Params:
    ------
    mask and img both numpy arrays representing images  (see chest_circum() in measure.py)

    Get mask by calling seg.seg_local(fname).   (in seg.py)
  '''
  # reuse of mask from earlier call to seg(imgfname)
  # Make mask and img the same size
  if img.shape != mask.shape:
    mask=skimage.transform.resize(mask.astype('float64'),
      img.shape[:2], anti_aliasing=True)
  mask=np.round(mask).astype('int64')

  # Adaptive PAD (width of img)
  PAD=int(round(img.shape[1]*0.10)) 
  ons   = np.nonzero(mask)

  print("ons[0].shape = ",ons[0].shape)
  print("ons[1].shape = ",ons[1].shape)
  print("ons[2].shape = ",ons[2].shape)
  # Here I use max(), min() b/c adding PADding might land bounds outside of img
  top   = max(  np.min(ons[0])-PAD,     0)
  bot   = min(  np.max(ons[0])+PAD,     mask.shape[0])
  # left and right are from our (an onlooker's) perspective, 
  #   not the perspective of a person within the picture's view
  left  = max(  np.min(ons[1])-PAD,     0)
  right = min(  np.max(ons[1])+PAD,     mask.shape[1])

  # Crop.
  RGB=3
  if len(img.shape) == RGB:
    cropped=img[top:bot, left:right,:]
  else:
    cropped=img[top:bot, left:right]
  crop_amts={
    # TODO: there might be an extra +-1 offset here depending on how we use dist_bot, etc. later
    'crop_amt_bot':img.shape[0]-bot,
    'crop_amt_top':top,
    'crop_amt_left':img.shape[1]-left,
    'crop_amt_right':right,
  }
  #pltshow(cropped) # for debugging
  return cropped, crop_amts
#=========================================================================
def get_mask_y_shift(mask1, mask2):
  '''
    Should I be finding midpoint?  Perhaps diff btwn toes is better?
    Ultimately, there should be a function specializing in "nipple shift" (where nip is in one mask vs. the other)
  '''
  ons   = np.nonzero(mask1)
  top   = np.min(ons[0])
  bot   = np.max(ons[0])
  midpt1=int(round(np.mean([bot,top])))
  ons   = np.nonzero(mask2)
  top   = np.min(ons[0])
  bot   = np.max(ons[0])
  midpt2=int(round(np.mean([bot,top])))
  return midpt2-midpt1  # TODO: make this consistent (either always n1-n2 or n2-n1)
#=========================================================================













#=========================================================================
def pad_color(img, biggers_shape, pads_color='white'):
    '''
        Pads 3-D img with zeros on the end til img.shape==biggers_shape
    '''
    #there's probably already a function like this in scipy, PIL, or some other library.
    # NOTE: there's probably a better way to write this function s.t. it's more general, maintainable, etc.
    # TODO:  debug dis bish.  we get weird cutoffs in the middle of shit
  #=========================================================================
    if pads_color.lower() =='white':
      color=WHITE=255
    else:
      color=BLACK=0
    def pad_top_bot(img, biggers_shape):
        '''
            Puts zeros on top and bottom of img until img.shape[1] == biggers_shape[0]
        '''
        padded         = np.copy(img)

        big_h          = biggers_shape[0]
        img_h          = img.shape[0]
 
        top_h          = (big_h - img_h) / 2.0
        if top_h.is_integer():
            bot_h      = int(top_h)
        else:
            bot_h      = int(floor(top_h + 1))
        top_h          = int(floor(top_h))
        # convert to int if not already 
        pad_w          = padded.shape[1]
        top            = np.full((top_h, pad_w, 3), color, dtype=int)
        bottom         = np.full((bot_h, pad_w, 3), color, dtype=int)
        padded         = np.concatenate((top, padded, bottom), axis = 0)

        return padded
    # end func def pad_top_bot(img, biggers_shape):
  #=========================================================================
    def pad_sides(img, biggers_shape):
        '''
            Puts zeros on sides of img until img.shape[1] == biggers_shape[0]
        '''
        padded         = np.copy(img)

        big_w          = biggers_shape[1]
        img_w          = img.shape[1]
        left_w         = (big_w - img_w) / 2.0 
        # NOTE: single slash is integer division in python2 unless dividing by 2.0
        #       This is NOT true in python3, which distinguishes '/' from '//'
        if left_w.is_integer():
            right_w    = int(left_w)
        else:
            right_w    = int(floor(left_w + 1))
        left_w         = int(floor(left_w))
        pad_h          = padded.shape[0]
        left           = np.full((pad_h, left_w,  3), color, dtype=int)
        right          = np.full((pad_h, right_w, 3), color, dtype=int)  # idk why I originally put "int" instead of "float"
        padded         = np.concatenate((left, padded, right), axis = 1)

        return padded
    # end func def pad_sides(img, biggers_shape):
  #=========================================================================
    return pad_top_bot(
                pad_sides(
                    img,
                    biggers_shape),
                biggers_shape)
  # end func def pad_sides(img, biggers_shape):
#=========================================================================
# end func def of pad_color(...args)
#=========================================================================



#=========================================================================
def pad_all(mask, biggers_shape):
    '''
        pads 2d mask with zeros on the end til mask.shape==biggers_shape
    '''
    # TODO:  debug dish bish.  we get weird cutoffs in the middle of shit
  #=========================================================================
    def pad_top_bot(mask, biggers_shape):
        '''
            puts zeros on top and bottom of mask until mask.shape[1] == biggers_shape[0]
        '''
        padded         = np.copy(mask)

        big_h          = biggers_shape[0]
        mask_h         = mask.shape[0]
     
        top_h          = (big_h - mask_h) / 2.0
        if top_h.is_integer():
            bot_h      = int(top_h)
        else:
            bot_h      = int(floor(top_h + 1))
        top_h          = int(floor(top_h))
        # convert to int if not already 
        pad_w          = padded.shape[1]
        top            = np.zeros((top_h, pad_w), dtype=int)
        bottom         = np.zeros((bot_h, pad_w), dtype=int)
        padded         = np.concatenate((top, padded, bottom), axis = 0)

        return padded
    # end func def pad_top_bot(mask, biggers_shape):
  #=========================================================================
    def pad_sides(mask, biggers_shape):
        '''
            puts zeros on sides of mask until mask.shape[1] == biggers_shape[0]
        '''
        padded         = np.copy(mask)

        big_w          = biggers_shape[1]
        mask_w         = mask.shape[1]
        left_w         = (big_w - mask_w) / 2.0 
        # NOTE: single slash is integer division in python2 unless dividing by 2.0
        #       This is NOT true in python3, which distinguishes '/' from '//'
        if left_w.is_integer():
            right_w    = int(left_w)
        else:
            right_w    = int(floor(left_w + 1))
        left_w         = int(floor(left_w))
        pad_h          = padded.shape[0]
        left           = np.zeros((pad_h, left_w), dtype=int)
        right          = np.zeros((pad_h, right_w), dtype=int)
        padded         = np.concatenate((left, padded, right), axis = 1)

        return padded
    # end func def pad_sides(mask, biggers_shape):
  #=========================================================================
    return pad_top_bot(
                pad_sides(
                    mask,
                    biggers_shape),
                biggers_shape)
  # end func def pad_sides(mask, biggers_shape):
#=========================================================================
def files_from_dir(dir_name):
  if '/' == dir_name[-1]:
    dir_name=dir_name+'*'
  elif '*' == dir_name[-1]:
    dir_name=dir_name
  else:
    dir_name=dir_name+'/*'  # '*' means grab all dirs
  return glob.glob(dir_name)
#===================================================================================================================================
def save_masks_from_imgs(
  root_img_dir="/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/imgs",
  root_mask_dir="/home/n/x/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/masks",
  img_file_extension='jpg'):

  masks=[]
  list_of_files=files_from_dir(root_img_dir)
  latest_img_dir = max(list_of_files, key=os.path.getctime)+'/' # https://docs.python.org/2/library/os.path.html.  lots of varieties, but getmtime() suits our purposes for now.  Tue Jan 15 10:16:14 EST 2019
  #oldest first
  if '/' == latest_img_dir[-1]:
    cmd=latest_img_dir+'*'
  else:
    cmd=latest_img_dir+'/*' # '*' means grab all dirs
  img_filenames = sorted(glob.glob(cmd), key=os.path.getmtime)
  timestamp=datetime.datetime.now().strftime('%Y_%m_%d____%H:%M_%p') # p for P.M. vs. A.M.
  curr_mask_dir=root_mask_dir+timestamp+"___"
  pn(3); print('='*99); print('saving masks in '+curr_mask_dir+'  ...'); print('='*99); pn(3)
  make="mkdir "+curr_mask_dir
  os.system(make)
  #print(img_filenames) #00000.jpg, 00001.jpg, etc.
  for i,img_fname in enumerate(img_filenames):
    if img_fname.endswith(img_file_extension):
      segmap = seg.segment_local(img_fname)
      masks.append(segmap)
      if debug:
        pltshow(np.rot90(segmap,k=1))
      mask_fname=curr_mask_dir+'/'+prepend_0s(str(i))+'.'+img_file_extension
      ii.imwrite(
              mask_fname,
              np.rot90(segmap,k=1))
  return masks  # TODO: standardize the return-values-upon-success for all functions in all code (in C/C++ it's '0')
  # TODO:  activate cleanup if the code is out for prod:
  '''
  if cleanup:
    os.system('rm -rf '+latest_img_dir) # NOTE: don't wanna keep their nudes.  But while we're just testing, no need to remove everything
  '''
#===== end func def of   save_masks_from_imgs(root_img_dir,root_mask_dir,file_extension='jpg'): ===== }
 


if __name__=='__main__':
    manual_vid_cut(vid_local_path='/home/n/Dropbox/vr_mall_backup/IMPORTANT/nathan_heman___legs_spread___0227191405a.mp4')
    #masks_2_angles_sandbox()
    #vid_2_mesh()
    #vid_2_mesh_sandbox()
    '''
    frames_dir=save_vid_as_imgs()
    masks=save_masks_from_imgs(frames_dir)
    for mask in masks:
        pltshow(mask)
    '''








    """
    pif(('*'*99)+'\n debug is on \n'+('*'*99))
    raise MeanHasNoPtsException(" hi i'm an exception msg")
    """








































































