Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D288266B50;
	Wed, 30 Apr 2025 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038593; cv=none; b=J9UNpEsRQPYpPd+L9/HSI5qHwGK/VslzcUqm0ga9bJfxOx4GvgUDxo18f4BRY0i1gKysKZhxjWHS1sJCEVg42uAzY18FBtqzFmgNAQ6m41PYfxh4LEpP1Nx5DA8IPFTIR4V8y5EnfOXXYaCjXbUbKtTLxLg+99Hc5qB7dJoYi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038593; c=relaxed/simple;
	bh=i/nN4fIZ0hrYmvZ/3og6dUa1DZESXgLU6NgPCzt569g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDfQebJeK/MTVS4qakwIHo3eW1Nnu3mqkP24G9HpWdJb817xth6wmNESK4dXjS/py+1aPlEG0xVMY5DGAlS7SP3RS/JrippotpBtvFVizJQlFkHWgVbpPQcVnNsJ0dGUZDzcl11jrXb9peOFFmWvzWHttTlRDFEnWzyIVV2UYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=Ne8hi8z/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkXrLnmr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="Ne8hi8z/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkXrLnmr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C2BD114026B;
	Wed, 30 Apr 2025 14:43:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 14:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1746038590; x=1746124990; bh=rQMATKoquDscGeyRc5D5X
	nmAVj7VRkv10II17QRwoew=; b=Ne8hi8z/VzecCcO2kuiUovL9Ok2Lk8E+ztf1F
	mwxi4QZKhYMPELCv1iJc5o/nN2IMLQ18JUdxZVpxFL4wOCRNmYhV9OCqFNqQUWBk
	Z8qqjFLl9nuvjWADqP+hwu3tqqyityPdjWz+z3CphIEJlD9UopM23H0tGBJdAKwQ
	hxRxCPmFfZGMJYs9T190sqK+fZdlCdfAkT30NlvrhSPC6t8CIDW9bWK3C6WMlml2
	2qWb10iIjshPI6mLz1IPe2TG/reIl6BxJnQomxTPCFB3K5YNGUxownVMpRkjIKEf
	zwPl2NVYapvhWZufBGlUjqS7asxEMPWDUoA0lCbAx6JUUUDzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746038590; x=1746124990; bh=rQMATKoquDscGeyRc5D5XnmAVj7VRkv10II
	17QRwoew=; b=hkXrLnmry7HPUUzVR+Y1mV74oy7YQFTtSdzqCAeX3qT1LfhdTso
	YbjuXGIMeRhV31jPRtm/20QTvFJsx6XU4TI6YPJpDafe6gEDx22TYDFqjqcBlPDp
	E41q0zaleLre35mRYKczvLsBE8iLyX/FWpg3j9jj0yD/phGSmU2npShs829iRJEQ
	kM7hXqTGvl3SJ7cDjBq7ziyrIW87B+lMi/AW08DvwZGycuwRZSLRLRXXCj75XN8L
	PgoTCqx5LOmWLcLD1mUP2KIIpUrEFvxjjWVlYXS/Rgh3+KAPSUSu7F1EldUElomq
	veSCa/g+fWafsw/+SDNwsMPsgeyFbbaDPJQ==
X-ME-Sender: <xms:PW8SaJfor6wQBA8JJXhgkJmffX634Nr1K7jublFR0LobbGRt47hUdw>
    <xme:PW8SaHPOBzcTignAYDQpnJ0R3uM3VpZDqwYwFvrr4mK_Vt4I_EF2-fX-V1dm25zQD
    UInbjjr6BNNOhF8WGI>
X-ME-Received: <xmr:PW8SaCiRMnUABsCLAFzMaeaaGqf59OdGTybvuqSSrF48Y8ju5OFujA7IZIbJzuEY6xEJDpRyhYo9srSpPjZgVWt5tbra2mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdludehmdenucfjughrpefhvfevufff
    kffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrh
    cuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeeliedvhfev
    gfegtdeiudejveffheejhfetgeettedvheejjeekhfdvgfeggffhveenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttgdpnhgspghrtghpthhtohepud
    dvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmohhrsghosehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehthhhorhhsthgvnhdrsghluhhmsehtohgslhhugidrtg
    homhdprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjuhhsthhinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehlihhnuhigqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PW8SaC8qtRq-0uDexsCDIqtvbXzzghwrgKRmpwr916vVQcUGO6odaA>
    <xmx:PW8SaFv0oAQIB88qwSTHxC30Joq4Z1ft2KpRR5BwDLCPSn4uVL88wA>
    <xmx:PW8SaBFp3EIxEcw7IGUF1-QrNwNuA9ET5DqoP2gE-VIaDYJXSn5ipA>
    <xmx:PW8SaMOTh4qz3gKzynRVAOzEDyXMuYeNiAGkk6YkeF2CJeL8G5eG2Q>
    <xmx:Pm8SaDwforoxjQazBxax1wlbNRXMjdg8NeskGJA8jmOTblGilIRZlxkb>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 14:43:08 -0400 (EDT)
From: Jan Hendrik Farr <kernel@jfarr.cc>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Bill Wendling <morbo@google.com>,
	thorsten.blum@toblux.com,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jan Hendrik Farr <kernel@jfarr.cc>
Subject: [PATCH 0/1] hardening: simplify CONFIG_CC_HAS_COUNTED_BY
Date: Wed, 30 Apr 2025 20:42:30 +0200
Message-ID: <20250430184231.671365-1-kernel@jfarr.cc>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kees,

here's the patch to remove the build test from CONFIG_CC_HAS_COUNTED_BY,
which is no longer needed with the release of gcc 15.1.

Removing the build test once gcc 15.1 is released was originally
suggested by Nathan in [1], so I added the Suggested-by tag.
Let me know if you're okay with that tag, Nathan.

[1] https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m4a5fd6e098f996740619cc4bedc03c929693709e

Best Regards
Jan

Jan Hendrik Farr (1):
  hardening: simplify CONFIG_CC_HAS_COUNTED_BY

 init/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.49.0

