Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AB4052C4;
	Sat, 26 Sep 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436459; cv=none; b=C5PJCg29xiiz2+72YvsWKjH+hZX5qv/81k1mrD4/Pxlct07Wpa2JSwJfeeA/4ASGEdgtugJj5teSxUkmzVRei760XOkbyY+PeZzQDjB4+NU2eP7+GkIAA5K3TtiiDD2EfhRIJpgzq/wmCQ+1BGWNx5X/jR9Hi1e0LAvmum7KX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436459; c=relaxed/simple;
	bh=+xjcz8nLIIJX8fK6dKDCwgu+xS5L2cxDGJt1yLKiNKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izNVKU860JcJDcMUlok7W4OlLlcrxDlR0kEo878VLScLXLabKMntJXIaeJjQuW3VSfrRp5gnZDmQLlVM772xg3yWxf+aMm9PkzHuqEtHrzDr7Jt6VC3pB07qV0B1zrXBQhzY8h4Z36VdzRZQzGFXVaeT8xjWLn5aCMkujSqqbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CLthkADt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CLthkADt"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5ABC0408B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1790436457; bh=E+Q6hF7V9TA2udl8Xyg0aj+FaZq+4HVqvk+0lqYue/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CLthkADt4wB5puBdlNthPLhtg+5yOG0fnnt5OubyZG7nBI9m+tsxIpFBZ6PSRG5To
	 B9kB5uusdyXK8VOcW22pTJuJEibu9VE4O9lHzYGu3kUxoiNf8nBQnCh86RnSDdcCT2
	 Mt0lP65sYJv/Qe4oybOzvE6v5BtNI7SAWejti8G93kRe7M6xEKdwggw3B3C/nQoKr+
	 HfpNro42xgYf3Ybf70imtITXZZBC2dXTPwYfMdK5FSIvZNsuJ688ASOT88yTgXtfhN
	 sF6cDNXj89h8dj6/Mepin6Sp1Qs108d2S5sSV3Dc12PLfd+gXvKezvABtiufC3uCu2
	 BsD1F6tP9rOfQ==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5ABC0408B3;
	Sat, 26 Sep 2026 15:27:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, Maximilian Huber
 <maximilian.huber@tngtech.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Luis Augenstein
 <luis.augenstein@tngtech.com>, Breno Leitao <leitao@debian.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Andrew Jones <andrew.jones@linux.dev>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: Makefile: Add a testdocs target for the
 documentation unit tests
In-Reply-To: <20260916184107.i.183-kees@kernel.org>
References: <20260916184107.i.183-kees@kernel.org>
Date: Sat, 26 Sep 2026 09:27:36 -0600
Message-ID: <87fqyw3udz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:

> tools/unittests/run.py discovers and runs the unit tests there (which
> are primarily documentation tools), but nothing in the build calls it,
> so the tests are only run by whoever remembers that the script is there.
>
> Give it a target, next to the other checks that need no Sphinx. The name
> ends in "docs", so it matches the "%docs" pattern already in
> no-dot-config-targets and runs without a configured tree, and it sets
> PYTHONPYCACHEPREFIX as the other Python targets here do, to keep
> __pycache__ directories out of the source tree.
>
>   $ make testdocs
>   ...
>   Ran 121 tests
>
> with "make dochelp" listing it between refcheckdocs and cleandocs.
>
> Tested with GNU Make 4.4.1 and Python 3.14.7, on a tree with no .config,
> where it ran 121 tests and left no __pycache__ behind.
>
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I debated the naming here, since "tools/unittests/" is such a general
> directory location, but figured I'd start with a target that made the most
> logical sense given what is actually being tested there? I dunno. Maybe
> "make testtools"? But that reads weird.
> ---
>  Makefile               | 2 +-
>  Documentation/Makefile | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

jon
