# `adocker` is alias to `azk docker`
all:
	# latest
	adocker build -t azukiapp/ruby           ./2.4

	# version tagged
	adocker build -t azukiapp/ruby:1.9       ./1.9
	adocker build -t azukiapp/ruby:2.0       ./2.0
	adocker build -t azukiapp/ruby:2.1       ./2.1
	adocker build -t azukiapp/ruby:2.2       ./2.2
	adocker build -t azukiapp/ruby:2.3       ./2.3
	adocker build -t azukiapp/ruby:2.4       ./2.4

--no-cache:
	# latest
	adocker build --rm --no-cache -t azukiapp/ruby           ./2.4

	# version tagged
	adocker build --rm --no-cache -t azukiapp/ruby:1.9       ./1.9
	adocker build --rm --no-cache -t azukiapp/ruby:2.0       ./2.0
	adocker build --rm --no-cache -t azukiapp/ruby:2.1       ./2.1
	adocker build --rm --no-cache -t azukiapp/ruby:2.2       ./2.2
	adocker build --rm --no-cache -t azukiapp/ruby:2.3       ./2.3
	adocker build --rm --no-cache -t azukiapp/ruby:2.4       ./2.4
