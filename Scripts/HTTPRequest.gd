extends HTTPRequest

# Called when the node enters the scene tree for the first time.
func get_random_words(number_of_words: int) -> void:
	var headers: PoolStringArray = []
	self.set_use_threads(true)
	self.connect("request_completed", self, "return_random_words")
	self.request("https://random-word-api.vercel.app/api?words=" + str(number_of_words))

func return_random_words(result, response_code, headers, body: PoolByteArray):
	var words = []

	if(response_code == 200):
		var json = body.get_string_from_utf8()
		if json != null and json.size() > 0:
			for i in json:
				words.append(i)
		return words.join(" ")
	else:
		print('response_code: ', response_code)
		print('problem on the server')
