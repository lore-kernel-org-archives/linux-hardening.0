Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADECF266B50;
	Wed, 30 Apr 2025 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038604; cv=none; b=ir0PSulZdkrvDCyCxY2dt1lkMrErv/z+FqJTy/QPTs97ieFxkBingviYjTMRfGgEBpj8UKlPqB2FYVZysD4ZXR4VhJNks9sUVY4waAaK856qB2l68/6innb+t3mOVG9rKHhcAI14awNq9dH5A1PjVjtljYbzWxdfCP0xj2hP0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038604; c=relaxed/simple;
	bh=8zkve0jIYjeWA0TSL1FMcjqVdabxWRogLMopXPDSjwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGlMmTv22pXq7h2C2RiA6HIxdo83udBg6K7txHrU3dowFpSkMWfFjLeziMv/LaJg3xM1vwuDZid+7BeED3zHbqPib9YK2nvmanV2yvCXbBGNpxZ/EpYvqJxV8tLmyKUJUjQ0COSl1Ccmn+HwV/dZtGTCv9FIIVgCx4zXEPStj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=TOfhB6yz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9C6dEro; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="TOfhB6yz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9C6dEro"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C353C1140084;
	Wed, 30 Apr 2025 14:43:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 14:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746038601; x=
	1746125001; bh=ZuRVpTC+n0CaVb5yhtsXJMQw5rLBTYoPjs45sPP/f/0=; b=T
	OfhB6yz2wy942Vuv1ubX98zbIRpB9xpF0YFTLT6i7kfL4It//f8lNjPi8iZghrH+
	x234J0crjnmU4vaLnIWiAMMPCya80pLpbS0prJlC7KkJ7gcoYwcy/MuJVHI73L1W
	eq8AdlsuuClDFX2E1KsokZ9ZBtev/jM2kYblskH4FQM8pXtpcM1dqW/ybSM6lRtX
	YPjjPMuT+0ZufdIfeWXesHfNPRqvGizdJWLAKlFUwXkVLoHP6uHXhxJSoN4DbvEM
	jmdaFNltF9YSXEWI/W2X8u36/7EOc1i41/69PK/uEccq+U11dEb6xnnSUrzNxV2e
	NMIadLUoh2t2UL14Kaqcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746038601; x=1746125001; bh=Z
	uRVpTC+n0CaVb5yhtsXJMQw5rLBTYoPjs45sPP/f/0=; b=k9C6dEroMsvSbjLpf
	xGZENr/riWg0X1Ondh5y6yZHqGAJ+TIUUTjx92XiAEbpExTMg/x6n4/K6zextn7L
	H98a5MOoEScEpTjtaDWkZ7Q7ge+DNL/tKYJGIQNt5+4EZQIM3ZomrQM2d+Ne5VRg
	bpurJZlao5XmNSEhI+AgUZwOCsEHUpL6DSwqwJj7iJ8H+NLEwn4qTvpyyQEHn9J+
	1mc2L4py2K1VrNXfRF7NLedYpKk3m6KLfMQQzekC22wdY5Uz40BLvYV14Ba3aGgW
	4ALLHgLIyM7kmDXdFG8kOlUkN0ucwt+oigKSAsZ4uMSBWlw0dBBaf/2K04h5x2n1
	d9pYw==
X-ME-Sender: <xms:SW8SaATyxV-coI9amE7KIGRU0PmledGmx0BSGT86xVmrws_uNhfaeQ>
    <xme:SW8SaNy_XXqZLJaMf1VmeCKwVyKkeBEukz-Nqpk_0Dkm4sbn3Hg3FMfroaHzWbykO
    YvJRn-ahhQgWX_Zkpw>
X-ME-Received: <xmr:SW8SaN2wevIfHtI1aFEvZhCE_b2r23TIyeUYEW-Wlzn2kXgzDjocJXQLJtcfcfVYGuSI_8DL3RH9EEtGcqXERF9QDiYpXvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdluddtmdenucfjughrpefhvfevufff
    kffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrg
    hrrhcuoehkvghrnhgvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpedvjefh
    feejveffjeeuheeljefggefgueetueefjeelieefudevueeiveduhffhteenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpghhnuhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlh
    esjhhfrghrrhdrtggtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthh
    grnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhhorhgsohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepth
    hhohhrshhtvghnrdgslhhumhesthhosghluhigrdgtohhmpdhrtghpthhtohepghhushht
    rghvohgrrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtkhdruggvshgruh
    hlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhushhtihhn
    shhtihhtthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqhhgrrhguvg
    hnihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SW8SaEBIw28e18CrncAsNvQUQPXpfIGykRzzfcUVtjoNrXv9l4Heng>
    <xmx:SW8SaJgHU2A-vtlBTNBdyxTujAzHBIYv9EYwSwdSPN_3MqE2Ja8z2w>
    <xmx:SW8SaApoM-28JZFgYUrRJoqxp53UKtSjZSGlG8JOFGKMY0953-DKqQ>
    <xmx:SW8SaMjZMTaSUEZzydYX4Oq879ZDh6ovE20eondfU5-HDELrS5EFDg>
    <xmx:SW8SaMoycHcZfoI4sy1HYd4KrK5Fgvbksu2pxbXrP9GLk3c6NMsv0C-u>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 14:43:20 -0400 (EDT)
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
Subject: [PATCH 1/1] hardening: simplify CONFIG_CC_HAS_COUNTED_BY
Date: Wed, 30 Apr 2025 20:42:31 +0200
Message-ID: <20250430184231.671365-2-kernel@jfarr.cc>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430184231.671365-1-kernel@jfarr.cc>
References: <20250430184231.671365-1-kernel@jfarr.cc>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies CONFIG_CC_HAS_COUNTED_BY by removing the build test and
relying solely on gcc/clang version numbering (GCC_VERSION >= 150100 and
CLANG_VERSION >= 190103).

The build test was used to allow unreleased gcc 15.0 builds to use the
__counted_by attribute. Now that gcc 15.1.0 has been released, this is
not needed anymore. Note: This will disable __counted_by on unreleased
gcc 15.0 builds.

clang version support for __counted_by remains unchanged.

Link: https://lore.kernel.org/all/Zw8iawAF5W2uzGuh@archlinux/T/#m204c09f63c076586a02d194b87dffc7e81b8de7b
Link: https://lore.kernel.org/r/20241029140036.577804-2-kernel@jfarr.cc
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jan Hendrik Farr <kernel@jfarr.cc>
---
 init/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 63f5974b9fa6..017fde21d0ba 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -121,13 +121,14 @@ config CC_HAS_NO_PROFILE_FN_ATTR
 	def_bool $(success,echo '__attribute__((no_profile_instrument_function)) int x();' | $(CC) -x c - -c -o /dev/null -Werror)
 
 config CC_HAS_COUNTED_BY
-	# TODO: when gcc 15 is released remove the build test and add
-	# a gcc version check
-	def_bool $(success,echo 'struct flex { int count; int array[] __attribute__((__counted_by__(count))); };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
+	bool
 	# clang needs to be at least 19.1.3 to avoid __bdos miscalculations
 	# https://github.com/llvm/llvm-project/pull/110497
 	# https://github.com/llvm/llvm-project/pull/112636
-	depends on !(CC_IS_CLANG && CLANG_VERSION < 190103)
+	default y if CC_IS_CLANG && CLANG_VERSION >= 190103
+	# supported since gcc 15.1.0
+	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+	default y if CC_IS_GCC && GCC_VERSION >= 150100
 
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) = { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
-- 
2.49.0

