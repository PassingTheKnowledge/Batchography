	
def gen_2chrs():
	# A-Z
	__chr = []
	for x in range(ord('A'), ord('Z')+1):
		__chr.append('"%d=%s"' % (x, chr(x)))

	# a-z
	for x in range(ord('a'), ord('z')+1):
		__chr.append('"%d=%s"' % (x, chr(x)))

	# 0-9
	for x in range(ord('0'), ord('9')+1):
		__chr.append('"%d=%s"' % (x, chr(x)))

	return "(%s)" % " ".join(__chr)


def gen_upper2lower():
	# A-Z
	__chr = []
	for x in range(ord('A'), ord('Z')+1):
		__chr.append('"%s=%s"' % (chr(x), str(chr(x)).lower()))

	return "(%s)" % " ".join(__chr)

def gen_lower2upper():
	# A-Z
	__chr = []
	for x in range(ord('a'), ord('z')+1):
		__chr.append('"%s=%s"' % (chr(x), str(chr(x)).upper()))

	return "(%s)" % " ".join(__chr)

print("\n:: ord2chr")
print(gen_2chrs())

print("\n:: gen_upper2lower")
print(gen_upper2lower())

print("\n:: gen_lower2upper")
print(gen_lower2upper())