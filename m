Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F12D1F5E;
	Thu, 31 Jul 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969176; cv=none; b=n3grNvTepA1VAS9P122r4HTts9qg4lTNPC4FvrS/peWnedQfapK/WynQ9vZcbx3bFzzbbm3Xd5C+a4NGDuvRUrVaLVkMYzb9X0yIk3mn4+Gnk5w5cOk1XhLltQZHgwDI6D1WDINEpbiQ/kMkdvVlLESxp5zSh7EEeKL3yjgCLxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969176; c=relaxed/simple;
	bh=DHzxW4z7i+CXhdWSmzCXYo6enZhSy7uMlpru0wwZgZw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LmpAEyi2ZJPEYYIwOf3C95/qQIXlUCs+VfjzgM78wNbGOuY9JzC3YwRNEkVnlY0jZIr+IXZT4UB1xINF98r38Agc8jIRplDGhJyR37gZvnNrTJCvOtAbr7lE/Izyr6xHHmwRcKIc2iI3+zuYvgmRBEAEqqBHVVpJWda+bwFvBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QV8qFqae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PR32dTtF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QV8qFqae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PR32dTtF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 62BFE1D00111;
	Thu, 31 Jul 2025 09:39:33 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 09:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753969173;
	 x=1754055573; bh=1YF+JczTPXawKb3atPxsO0xvbePgUamnMYYtX/LaCcM=; b=
	QV8qFqaejLczQjU7HFGOb68T+honsBwSkrB3P65VSOo0MAV5fhXjvOT4gYY44rQW
	q1A/ucDS1TUbjUtb4/yOoKz29jRJeVSnR0Qif/7Ix0pJsXNlHpvg6i/0DTfn7WaT
	9aZl/Yz4DRBDJHwcK/44Vo/gXkIuey0E6lJhzZnnIwRRoxkg9nCnl8EkXKDzvMs4
	2GcqM3lEZiajKbTs9X8yCf1B+tUoxDP9tE0/mqzuZYyO4RcDvXvjojQTTap9aj8l
	RzyLygFxV1kkiYfGEtWY+ueqx+bbC27bNCS8oTakffUCZGMnUayXIpqYspTRilpF
	R+P1pLRo707mAQVYDf2TdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753969173; x=
	1754055573; bh=1YF+JczTPXawKb3atPxsO0xvbePgUamnMYYtX/LaCcM=; b=P
	R32dTtFGt85EPM6UM40Vw4o36Kaws2L6gm5LW1GVK19tMu6VP0BBM+rLaM16Is2h
	g51kLDQMst5yQSaAVQUmq6BN1LgAHRgbgZD12cnKCV0+yrGcqeKjsuiWXAN20AWF
	t7tBCX0p6Kn1lbEQxb9hZljAuYhcXzGn9Jv6Qp7m1L/an+7L88AZJmRDJnLdGGK3
	c/7GmQGPrVozt98oLDH/R/sCaOMNoihWqEVGhn3EERiRUjdlx8bBn9W+DKmcEcdq
	SEfikhIViGg5BlPtDVVlW8X4hFyYNCr/Z3BJdRu9PY2f0Cr/BZXdsuyyiqNsr63+
	ECf20+k8lbp5OwpjqMD4g==
X-ME-Sender: <xms:FHKLaAPuWTnlMrGgIVZETtG3SuQiJ-yELDrr6FZb5eV26vvX-yHKrw>
    <xme:FHKLaG8l24MW3o3LJT1ZACCyEca7Me1UhkwGKnMtuYtAV_9L1ffcXMywBI2D_TRQe
    RZszfyOeZArhzAInr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhushhtrghvoh
    grrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    sggvnhhjrghmihhnrdgtohhpvghlrghnugeslhhinhgrrhhordhorhhgpdhrtghpthhtoh
    epuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnhgr
    rhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehlkhhfth
    dqthhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrghdprhgtphhtthhopehrvghg
    rhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:FHKLaOQg_mipmuyaN2Y9BLVaTMNOlDfTt-Zl5o3Hih9S0bMIGThEgQ>
    <xmx:FHKLaJRve1YRZQ2wFN2QBlOyzreRaK4QYSm5UpUk-wfdqhVYbUOs3g>
    <xmx:FHKLaK5LPBgzOTghixn1PHgopDTMxcwY70_ff4x-q0VfbfbvtZg7wQ>
    <xmx:FHKLaOWaq-92a7-PQGAyCilY-6s1lmG6Ia6cWGxB1biWRswW9qO7Bg>
    <xmx:FXKLaHS6aX6R2mWuyYjN4lrDrkI7-pEBgv27AbNV8lo1A2acYzMTRH6l>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA950700069; Thu, 31 Jul 2025 09:39:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf7077733e96ba33e
Date: Thu, 31 Jul 2025 15:39:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Kees Cook" <kees@kernel.org>, "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Benjamin Copeland" <benjamin.copeland@linaro.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>
Message-Id: <86f6a314-8aa0-46c3-8984-784a07a302c3@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYv-c6D6tJKw9x05+U_VxrpTAQCKADTeYg4jsjaJkX+isw@mail.gmail.com>
References: 
 <CA+G9fYv-c6D6tJKw9x05+U_VxrpTAQCKADTeYg4jsjaJkX+isw@mail.gmail.com>
Subject: Re: next-20250730 x86, s390, riscv gcc-8 hardening.config vmlinux symbol
 `.modinfo' required but not present
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 31, 2025, at 15:32, Naresh Kamboju wrote:
> Regressions while building x86, S390 and riscv64 with hardening.config on the
> Linux next-20250730 and next-20250731.
>
> Build pass with gcc-13 with hardening.config fails with gcc-8
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
>
> First seen on the next-20250730
> Good: next-20250729
> Bad: next-20250730
>
> Build regression: next-20250730 x86 gcc-8 hardening.config vmlinux
> symbol `.modinfo' required but not present
> Build regression: next-20250730 S390 gcc-8 hardening.config vmlinux
> symbol `.modinfo' required but not present
> Build regression: next-20250730 riscv64 gcc-8 hardening.config vmlinux
> symbol `__rela_dyn_end' required but not present
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

My guess is that this is caused by 94564d1bb059 ("kbuild: keep .modinfo
section in vmlinux.unstripped")

See also
https://lore.kernel.org/all/202507310505.tEYm1za7-lkp@intel.com/
https://lore.kernel.org/all/20250728135753.432695A72-agordeev@linux.ibm.com/

Reverting 94564d1bb059 solved the problem for me on arm64.

      Arnd
