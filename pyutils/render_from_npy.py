import numpy as np
import bpy
from  math import sqrt

#================================================================
def make_list_of_tuples_from_nparr(arr):
    '''
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
    tups.append(face[0], face[1], face[2])
  return tups
#================================================================

filename  = '/home/n/Documents/IMPORTANT/business_work/cat/get_clothing_sizes_from_pix/cat_1st_demo/model_3d_of_nathan___120_x_120__shell.npy'
filename  = '/home/n/Documents/IMPORTANT/business_work/cat/get_clothing_sizes_from_pix/cat_1st_demo/model___built_from_masks_legs2018_06_19___12:58:36.npy'
shell_arr = np.load(filename)
verts = make_list_of_tuples_from_nparr(shell_arr)
#verts = verts[4:145]
# ^^ (above line) ^^^shrink the amount necessary to fit in memory so we can actually see something

#verts=[(106, 50, 60), (106, 51, 57), (106, 51, 58)]

# tetrahedron (triangular pyramid)
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

faces=[]
for i in range(2, len(verts)):
    faces.append( (i-2, i-1, i) )


mesh_data = bpy.data.meshes.new("cube_mesh_data")
mesh_data.from_pydata(verts, [], faces)
mesh_data.update()

obj = bpy.data.objects.new("My_Object", mesh_data)

scene = bpy.context.scene
scene.objects.link(obj)
obj.select = True
