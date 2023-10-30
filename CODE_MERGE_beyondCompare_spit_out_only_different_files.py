#   TODO:  copy this script.py into     /i/     and/or     "I:"

#   TODO: fix the bug(s)!!!       Feb 20, 2023

import os
import sys
from pprint import pprint as p
from pprint import pprint





def get_filenames_with_real_diffs(root_dir_1, root_dir_2):
    '''
        Useful for BeyondCompare        (especially when comparing with "EM")

        f
        TODO:   Test it on smaller output.
            truncate output to not include "root_dir_1" and "root_dir_2"
    '''
    all_paths_1 = sorted([os.path.join(root, name)
      for root, dirs, files in os.walk(root_dir_1)
      for name in files ])
    all_paths_2 = sorted([os.path.join(root, name)
      for root, dirs, files in os.walk(root_dir_2)
      for name in files ])

    pprint(all_paths_1)
    pprint(all_paths_2)
    # When do we increment i2?      (Versus i1?)
    #   if path1 < path2, we "continue";    otherwise we do     i2+=1
    out=[]
    i2 = 0
    l1=len(root_dir_1)
    l2=len(root_dir_2)
    for i1,path1 in enumerate(all_paths_1):
      # just debug statements:
      print("="*99)
      print("out: ")
      pprint(out)
      print("="*99)

      path2 = all_paths_2[i2]
      if path1[ len(root_dir_1) :]  == path2[ len(root_dir_2) :]     :
        with open(path1,'r') as wp:
          lines1 = set(wp.readlines() )
        with open(path2,'r') as wp:
          lines2 = set(wp.readlines() )
        # Check file contents identical.  If not, add to output.
        if lines1 - lines2:
          out.append( path1[ l1:] )
          out.append( path2[ l2:] )

          # just debug statements:
          print("="*99)
          print("path1[ l1:] : ")
          pprint(path1[ l1:] )
          print("path2[ l2:] : ")
          pprint(path2[ l2:] )
          print("="*99)

      else:
        #     TODO: double check for off-by-1 error(s)     in these lines
        store1=i1
        store2=i2
        one_has_the_match = False
        two_has_the_match = False
        # Search through all_paths_2 for match(es):
        for idx_tmp2, fname2 in enumerate(all_paths_2[i2:] ):
          if path1[ len(root_dir_1) :] == fname2[ len(root_dir_2) :]:
            paths_to_append_2_output = all_paths_2[ store2: i2+idx_tmp2][ l2: ]
            print("="*99)
            print("if path1 == fname2: \n\n")
            print("paths_to_append_2_output: ")
            pprint(paths_to_append_2_output)
            print("="*99)
            out += paths_to_append_2_output # TODO: double check for off-by-1 error(s)
            idx_tmp2 = store2
            two_has_the_match=True
            break

        # Search through all_paths_1 instead:
        if not two_has_the_match:
          # serach through all_paths_1 instead:
          for idx_tmp1, fname1 in enumerate(all_paths_1[i1:] ):
            if path2[ len(root_dir_2) :] == fname1[ len(root_dir_1) :]:
              print("="*99)
              pprint("all_paths_1[ store1: i1+idx_tmp1][ l1: ] ")
              pprint(all_paths_1[ store1: i1+idx_tmp1][ l1: ] )
              print("="*99)
              out += all_paths_1[ store1: i1+idx_tmp1][ l1: ] # TODO: double check for off-by-1 error(s)
              idx_tmp1 = store1
              one_has_the_match=True
              break
        # both files are new.
        if (not two_has_the_match) and (not one_has_the_match):
          print("="*99)
          print("both files are new: \n\n ")
          print("path1[ l1:] : ")
          pprint(path1[ l1:] )
          print("="*99)
          out.append(path1[ l1: ])
          out.append(path2[ l2: ])
          i2+=1
    return out








if __name__=="__main__":
    fnames_diff = get_filenames_with_real_diffs(      sys.argv[1],     sys.argv[2])
    pprint ( fnames_diff )
    print("\n"*5)
    print("="*99)
    print(" num files: {}", fnames_diff)
    print("="*99)
    print("\n"*2)
    






