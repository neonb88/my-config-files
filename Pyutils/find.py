str1 = "this_is_really_a_string_example....wow!!!";
str2 = "is";

idx  = str1.rfind(str2)
'''
print str1.rfind(str2)
print str1.rfind(str2, 0, 10)
print str1.rfind(str2, 10, 0)
'''

print str1[:idx]
print str1[idx:]

'''
print str1.find(str2)
print str1.find(str2, 0, 10)
print str1.find(str2, 10, 0)
'''

s1  = 'filenamefilname_rms_stallman_soimpsons_bart.png'
print s1
print s1[
            :s1.rfind('.')
        ]

