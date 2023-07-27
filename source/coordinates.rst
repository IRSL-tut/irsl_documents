===========
Coordinates
===========

**************************
Coordinate Transformations
**************************

^^^^^^^^^^^
3D Position
^^^^^^^^^^^

The 3D position is a vector of three real numbers, represented using lower-case boldface letters.

The three elements represent positions on the x-, y-, and z-axis, respectively.

It is often denoted as a vertical vector.

3D position :math:`\mathbf{p}` is denoted below.

.. math::
   \mathbf{p} = [ \; x, \; y, \; z \;]^{T}

^^^^^^^^^^^
3D Rotation
^^^^^^^^^^^

Rotations in 3D can be represented using a rotation matrix.

The rotation matrix is a 3x3 matrix.
It is the x-, y-, and z-axis of the rotated coordinate series aligned in columns,
as referenced from the original coordinate system.

Rotation matrix :math:`\mathbf{R}` is denoted below.

.. math::
   \mathbf{R} = [ \; \mathbf{x} \quad \mathbf{y} \quad \mathbf{z} \; ]

Rotation matrix is an orthogonal matrix, which means that the transpose and inverse of the matrix are equival

Inverse of a rotation matrix is denoted below.

.. math::
   \mathbf{R}^{-1} = \mathbf{R}^{T}


Other ways to represent 3D rotations are
Roll-Pitch-Yaw angle (RPY), Quaternion, AngleAxis, etc.

Although the degree of freedom (DOF) of rotation is 3,
a rotation matrix that is easy to use in calculations,
and a quaternion that has no singular points and is easy to interpolate are used.

Please refer to the reference book.

........................
AngleAxis representation
........................



^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Homogeneous transformation matrix
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

6DOF-Position in 3D can be represented using 3D position and 3D rotation,
with 3 DOF for position and 3 DOF for rotation,
for a total of 6 DOF.

The homogeneous transformation matrix
is used to represent 6DOF-Position in 3D.

The homogeneous transformation matrix T is represented as a 4x4 matrix
using a 3D position vector :math:`\mathbf{p}`
and a 3D rotation matrix :math:`\mathbf{R}` as follows.

.. math::
   T = \begin{pmatrix}
   \mathbf{R}  & \mathbf{p} \\
   \mathbf{0}  & 1
   \end{pmatrix}

The inverse matrix of T is as follows.

.. math::
   T^{-1} = \begin{pmatrix}
   \mathbf{R}^{-1}  & - \mathbf{R}^{-1}\mathbf{p} \\
   \mathbf{0}  & 1
   \end{pmatrix}

The multiplication of :math:`\mathbf{T}_{a}`
and :math:`\mathbf{T}_{b}` is as follows.

.. math::
   T_a \times T_b = \begin{pmatrix}
   \mathbf{R}_a\mathbf{R}_b  & \mathbf{R}_a\mathbf{p}_b  + \mathbf{p}_a \\
   \mathbf{0}  & 1
   \end{pmatrix}

where :math:`\mathbf{T}_{a}` and :math:`\mathbf{T}_{b}` are as follows.

.. math::
   T_a = \begin{pmatrix}
   \mathbf{R}_a  & \mathbf{p}_a \\
   \mathbf{0}  & 1
   \end{pmatrix}

.. math::
   T_b = \begin{pmatrix}
   \mathbf{R}_b  & \mathbf{p}_b \\
   \mathbf{0}  & 1
   \end{pmatrix}

^^^^^^^^^^^^^^^^^^^^^
System of coordinates
^^^^^^^^^^^^^^^^^^^^^


^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Coordinate system of rigid body link
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


************************************************************
Relation between system of coordinates and coordinates class
************************************************************

coordinates class (cnoid.IRSLCoords.coordinates)
is a class for manipulating homogeneous transformation matrices.

An instance of the coordinates class has
3D position vector :math:`\mathbf{p}` and
3D rotation matrix :math:`\mathbf{R}` .

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Access to a position and a rotation matrix
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:math:`\mathbf{p}` and :math:`\mathbf{R}` can be retrieved
by accessing to properties of coordinates class.

In the following, T is an instance of the coordinates class.

.. math::
   T = \begin{pmatrix}
   \mathbf{R}  & \mathbf{p} \\
   \mathbf{0}  & 1
   \end{pmatrix}

.. code-block:: python

    >>> p = numpy.array([1, 2, 3])
    >>> R = numpy.array([[0, -1, 0],[1, 0, 0], [0, 0, 1]])
    >>> T = coordinates(v, R)
    >>> T
    <coordinates[address] 1 2 3 / 0 0 0.707107 0.707107 >

.. code-block:: python

    >>> T.pos ## getting 3D position
    array([1., 2., 3.])

.. code-block:: python

    >>> T.rot ## getting rotation-matrix
    array([[ 0., -1.,  0.],
           [ 1.,  0.,  0.],
           [ 0.,  0.,  1.]])

.. code-block:: python

    >>> T.cnoidPosition ## getting 4x4 homogeneous transformation matrix
    array([[ 0., -1.,  0.,  1.],
           [ 1.,  0.,  0.,  2.],
           [ 0.,  0.,  1.,  3.],
           [ 0.,  0.,  0.,  1.]])

.. code-block:: python

    >>> T.quaternion ## getting quaternion
    array([0.        , 0.        , 0.70710678, 0.70710678])

.. code-block:: python

    >>> T.RPY ## getting roll-pitch-yaw angle
    array([ 0.        , -0.        ,  1.57079633])

.. code-block:: python

    >>> T.angleAxis ## getting angle-axis
    array([0.        , 0.        , 1.        , 1.57079633])

^^^^^^^^^^^^^^^^^^^^^^^^^^^
Methods to convert a vector
^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the following,
:math:`\mathbf{v}` is 3D vector (numpy.array).

.. code-block:: python

    >>> v = numpy.array([0.1, 0.2, 0.3])
    >>> T.rotate_vector(v)
    array([-0.2,  0.1,  0.3])

.. code-block:: python

    >>> T.inverse_rotate_vector(v)

.. code-block:: python

    >>> T.transform_vector(v)

.. code-block:: python

    >>> T.inverse_transform_vector(v)


^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Methods to return a coordinate (not changing itself)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. math::
   A = \begin{pmatrix}
   \mathbf{R}_{a}  & \mathbf{p}_{a} \\
   \mathbf{0}  & 1
   \end{pmatrix}

.. code-block:: python

    >>> T.inverse_transformation()

.. code-block:: python

    >>> T.transformation(A)


^^^^^^^^^^^^^^^^^^^^^^^^
Methods to change itself
^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

    >>> T.newcoords(A)

.. code-block:: python

    >>> T.move_to(A)

.. code-block:: python

    >>> T.translate(A)

.. code-block:: python

    >>> T.locate(A)

.. code-block:: python

    >>> T.transform(A)

^^^^^^^^
Examples
^^^^^^^^

**************
Reference book
**************

実践ロボット制御 https://www.ohmsha.co.jp/book/9784274224300/

第2章 姿勢の記述 及び 第4章 運動学の一般的表現 の内容が参考になる
