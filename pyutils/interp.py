
import numpy as np

def interpolate360(d, p):
    p = np.array(p)
    angles = np.arange(0, 2 * np.pi, d * np.pi / 180)
    sin = np.sin(angles)
    cos = np.cos(angles)

    rot_matrices = np.empty((angles.shape[0], 2, 2))
    rot_matrices[..., 0, 0] = cos
    rot_matrices[..., 0, 1] = -sin
    rot_matrices[..., 1, 0] = sin
    rot_matrices[..., 1, 1] = cos

    return np.dot(rot_matrices, p)

