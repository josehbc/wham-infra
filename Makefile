encrypt:
	tar zcvf - ssh | gpg --encrypt --recipient tgamble@thoughtworks.com --recipient gheine@gilt.com -o metadata.tar.gz.gpg

decrypt:
	gpg -o - metadata.tar.gz.gpg | tar xvz

