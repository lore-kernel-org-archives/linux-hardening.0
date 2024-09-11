Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E418C3E
	for <linux-hardening@vger.kernel.org>; Wed, 11 Sep 2024 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038369; cv=none; b=MlW7HdeaCx933u1INxZQ343g0rI7J/7t+D9a+aSZfmpXGdV6gtfBxoH2zhLvMzlIB6hqBX1poOnpL228rzg5RVvL2MEBlDyTc1Kh9FepT7M4jfsKTFRyFb8Bg9eqx1r67+xefKY8F18Rk0kqOoCqULSywh/LXu4F9eoDO4vf730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038369; c=relaxed/simple;
	bh=0b+H/BE+jApyTxPRgbovf2DWpRDM7wW4dD4QlgiHhjo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rfyju+v5KxMTGZhddA3oIxPO8B/5/7lexjRq/7rUnzcIiQsN+DHoVp6C9CqBT6MIIxfIXb4irRTU6SW5Fbec7rn3KSbe9vpY1Hr2essQTHfhPIci5ThXIfPT3ax3xl+vHp8g4PVpeeGs1+SIIsUoLEIqbF6rxLKAuEzlfGywsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ffEDCzUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2rHOgsD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ffEDCzUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2rHOgsD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3ECBC1380366;
	Wed, 11 Sep 2024 03:06:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 03:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726038365;
	 x=1726124765; bh=bHII3Cm6loFpZp6H7Gnl7+gXCQ5l/Em9b9Bg0DcZJZM=; b=
	ffEDCzUQ20rFSfskf0dH5Cu7gyV4ZkXGJRVRoRYl3E+9NljpjOxdF2nQFqv1PVEl
	uT3O7bynjqpSizNHtMwbcAP9wAlmorwlDaKbbqRzsTnlvq0jIqg/AQb0MxWHBQ3Q
	rnl3jr6RVbW3Yd9EAUAadfiaI/LLZByhHbbVR1FVD0VZNt+X5buMP4Czf2AOSGzd
	4NHKJQD7NGD9aVaF1AntgkPreajnCWFSLnw3gKwEAD8q19B5x/QnRFneAtkAg1Au
	ZWn0SVnINkpI8z8WRhZnE0xQrvMSt2e6mXlhrqdTdnvrEZtlADA3F7shPMPCCPZO
	u4hkHR/iY+0nkeXCtQBJgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726038365; x=
	1726124765; bh=bHII3Cm6loFpZp6H7Gnl7+gXCQ5l/Em9b9Bg0DcZJZM=; b=B
	2rHOgsDKZZyBHu4WSyAZ9FurG2j7JzJvcu3alhgdyMZcmMqAbLaP5thdEYSDQ5DN
	JQ91iMegtXjhnpaScyv6bYzF1eQxLOSSlk3yZEGc8Bq2Vb6AvUE7R4pc+zGgY8M4
	Uyme5mvdpx8b74YpoSrNH2scmC9z4wVtGUid36qpOLaxDMH1s6Ts1KMnedY6EAi4
	nsTeAuC63Wr4nfBPJtYbqxB926kunQeUyOVxZrG9GG2AbvdbLkA/Iw/Cr5PmOLMC
	1l1aDeiB0mscyzV+3K70zkGPlCf+vlQqw1IgJDRMwr88TYyoKgVY+/nWp150J7ij
	oup72vbKWAmIcuy7Q1hkQ==
X-ME-Sender: <xms:XEHhZvdnA56IDPHJHgjoGpXIlnhKQCWg2rB_94wXw4jfxX-NlxhIOA>
    <xme:XEHhZlNKhaiAlDJtbzwUMYPsZ33JtF9G6hLG3_3yzkgOGbFxYXgNwOrvOq3fFiri9
    b6bp8_tEhB5b015l_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekleevvdekgeekuddtleeuieeltedtteeludff
    vdegkeevleejieeuffefjeefleenucffohhmrghinhepuggvsghirghnrdhnvghtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgt
    phhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqhh
    grrhguvghnihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XEHhZoiPa_d7WoRy3Du8KGesqZEnxHMTFMwNfGDm_h0Br0BKDSdTKQ>
    <xmx:XEHhZg-5A4Ip1irYPEHHZT-KRw8YvW_xPh5e51Y80_-Muf3M79icPQ>
    <xmx:XEHhZrsJ8YtdhooXCWZQFaHspLCxUBiMy2hOXnRC5Df5O4vwem2g7A>
    <xmx:XEHhZvHCqcd0DAvC_7e1z_QEydh5tsaumem85fjtd1tNWetvk2m3Yw>
    <xmx:XUHhZk5z7wgIinJwj291WmREJDmUKJEzGO_SFhrfzy6k34spOTlbm-Jg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C65472220071; Wed, 11 Sep 2024 03:06:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 07:05:44 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: linux-hardening@vger.kernel.org
Message-Id: <ea7a604f-b3b7-40ef-bea2-27c2e83ceef1@app.fastmail.com>
In-Reply-To: <202409101722.C8E47DF@keescook>
References: <Zt73a3t8Y8uH5MHG@smile.fi.intel.com>
 <202409101722.C8E47DF@keescook>
Subject: Re: -Wformat-trunctation with `make W=1`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 11, 2024, at 00:26, Kees Cook wrote:
> On Mon, Sep 09, 2024 at 04:26:03PM +0300, Andy Shevchenko wrote:
>> Recently I'm trying to compile my (almost) x86_64_defconfig based kernel with
>> `make W=1` while having CONFIG_WERROR=y. With a handful of patches I was able
>> to achieve that with clang-18, however GCC 14.2.0 issues a lot of additional
>> warnings that are mostly related to -Wformat-truncation [1]. Any suggestions,
>> plans, comments on how to address them?
>> 
>> [1]: https://paste.debian.net/hidden/46106f2a/
>
> Since it's behind W=1, fixing those issues hasn't been a very high
> priority. That said, I would love to see it done. Patches have slowly
> been landing for various W=1 things related to the -Wstringop-... and
> -Wformat... options, though. But I don't think there has been a
> concerted effort to wipe them out completely. And at least sometimes
> these warnings are effectively false positives, related to unexpected
> behaviors in GCC's value range tracking, though that has mostly been an
> issue for getting -Warray-bounds to build cleanly.
>
> As for fixing them, I think one will need to just look at each instance
> one at a time to figure out the best solution.

I have a series from earlier this year, let me see what I had
in there:

 -Wformat-truncation triggers in 133 files with arm64 allmodconfig,
  which is more than any other W=1 warnings. Addressing them
  individually is probably a good idea, but most of the other
  W=1 warnings seem more helpful if we can just enable them
  after a few patches.
 -Wformat-truncation-non-kprintf only happens in a single file
  and we should fix that. We can probably just enable the
  default -Wformat warnings on clang at last..
 -Wunused-const-variable=2 needs a lot of patches but they are
  all trivial (mostly extraneous of_match_ptr()), just need to
  be split up better. My tree builds  randconfig cleanly with
  this enabled.
 -Wtautological-constant-out-of-range-compare needs four
  more patches that I have sent previously
 -Wstringop-truncation can be enabled globally
 -Woverride-init just needs to be disabled in a couple of
  key places that intentionally use defaults
 -Wmissing-format-attribute triggers in only 9 files, but
  I don't think I have patches for those.
 -Wformat-overflow= triggers in 15 files with gcc but 35 with
  clang, I don't have patches for these.
 -Wunused-but-set-variable triggers in 8 files, I sent some
  patches for these in the past.
 -Wenum-enum-conversion has 93 files with warnings in clang-20
 -Wvoid-pointer-to-enum-cast shows up in 19 files with clang-20

       Arnd
