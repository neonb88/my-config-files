import numpy as np
import bpy
from  math import sqrt

# NOTE:
#         verts_nparr and faces_nparr are both from output of
#         measure.marching_cubes_lewiner()
#
#
#
#
#
#
#
#

#================================================================
def make_verts(verts_arr):
  '''
      output a list of tuples that blender can read, ie.:

       (    x  ,    y  ,    z  ),

      [(   0.0 ,   0.0 ,   0.0 ),
       (  10.0 ,  10.0 ,   0.0 ),
       (  10.0 ,   0.0 ,  10.0 ),
       (   0.0 ,  10.0 ,  10.0 ),
       ...
       ]
       

      input format: np array of shape (large_num, 3)

     pt:  [x  y, z]

   array([[2, 1, 0]
          [0, 3, 2],
          [0, 1, 4]], dtype=int32)
  '''
  tups=[]
  for vert in verts_arr:
    tups.append(
      (vert[0],vert[1],vert[2]))
  return tups
#================================================================
def make_faces(faces_arr):
  '''
        input format: np array of shape (large_num, 3)
           this face is made from verts 2, 1, and 0:
     array([[2, 1, 0]
            [0, 3, 2],
            [0, 1, 4]], dtype=int32)

        output format: list of tuples:
        [ (2,1,0),
          (0,3,2),
          (0,1,4)]
  '''
  tups=[]
  for face in faces_arr:
    tups.append(
      (face[0], face[1], face[2]))
  return tups
#================================================================

# TODO: edit 'filename' variables to have current verts and faces.npy files
verts_filename='/home/u/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/verts_nathan_.npy'
faces_filename='/home/u/p/fresh____as_of_Dec_12_2018/vr_mall____fresh___Dec_12_2018/faces_nathan_.npy'

verts_arr = np.load(verts_filename)
verts = make_verts(verts_arr)
faces_arr = np.load(faces_filename)
faces = make_faces(faces_arr)

"""
verts=[
    ( 1         , -1/sqrt(3)    , -1/sqrt(6)    ),
    (-1         , -1/sqrt(3)    , -1/sqrt(6)    ),
    ( 0         ,  2/sqrt(3)    , -1/sqrt(6)    ),
    ( 0         ,  0            ,  3/sqrt(6)    )
]
"""
"""
verts=[
    ( 101         , -1/sqrt(3)    , -1/sqrt(6)    ),
    (  99         , -1/sqrt(3)    , -1/sqrt(6)    ),
    ( 100         ,  2/sqrt(3)    , -1/sqrt(6)    ),
    ( 100         ,  0            ,  3/sqrt(6)    )
]
"""
#(±1, −1/√3, −1/√6)        (0, 2/√3, −1/√6)      (0, 0, 3/√6)

mesh_data = bpy.data.meshes.new("cube_mesh_data")
mesh_data.from_pydata(verts, [], faces)
mesh_data.update()

obj = bpy.data.objects.new("My_Object", mesh_data)

scene = bpy.context.scene
scene.objects.link(obj)
obj.select = True

