Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79AD38838F;
	Thu, 17 Sep 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631735; cv=none; b=gCH8IuLPqdCLVPVxKhpbWLtKwpwNmR5dVXlNuUptfJmBhR/LvaFxG46cf1JjGULsSFRxS6pImNO+SyEQt7LwJg5IjZkY1Ytu5qnAdFzLlL55bEz350F+j6pbv2J2+vGLw5nqtmCKC960lXP2t8YObA+pEpeOEXVEnQxKpujaWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631735; c=relaxed/simple;
	bh=RlhF7L+pBEDU5OBMw41Kj2szL2t3Yun19dG2JjwZqOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1MYor8iSrF4HWmOTQsHne94MEhM/pIXjtQTb1+KhYknxIVrcNK4oJQPlTclSDqCuEwa80DW1fQc44HEvrFbl35tvGilFUYRwcQoUDUjkf8VdhmLuCjiyDgCuqFmhyzjH/YOdJkuzdxFuE5h5t28uOav/A1OK1/G/vQkommKrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NL7Nk2ML; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NL7Nk2ML"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y+BBorB8UjNfPj18a02Ttz+ma2x3+ZsgejxOfpcGN8g=; b=NL7Nk2MLiJlR+bTcMjLA3n2OhA
	pIlu4U13+s0silnfT0lEjwzhW+1t5WKZh9uSuH6nc0l/q4wU2Dvs+u6+VKvjjIY6/nnsvtFZYis0Z
	goMk6nj1iZgQkm39d+fhOvdJWcVZtElyqXjgusloWY99JkSEnlwfWphitKCylhZiyzn2G7TvhewvS
	g0FocsINtLn0BajDeo4+pL/rIf+tgj9X8vvl3yv58aPwITYfGYyKHOKteO4+eAtp1noy5uhhMrfmI
	BSu3HmXGUbq/2CPq40sKsKoWG8TEXMYLNOYnW3sV9uM60dNw5TV2+CROjbbP2W0PitSTnuvRLS0qi
	HW1FeSig==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x76xd-005nU1-0M;
	Thu, 17 Sep 2026 07:55:13 +0000
Date: Thu, 17 Sep 2026 00:54:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Kees Cook <kees@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Maximilian Huber <maximilian.huber@tngtech.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Luis Augenstein <luis.augenstein@tngtech.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrew Jones <andrew.jones@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: Makefile: Add a testdocs target for the
 documentation unit tests
Message-ID: <aqucmDHFYxH1s4H6@gmail.com>
References: <20260916184107.i.183-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916184107.i.183-kees@kernel.org>
X-Debian-User: leitao

On Wed, Sep 16, 2026 at 11:41:11AM -0700, Kees Cook wrote:
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

Very nice! Thanks!

> with "make dochelp" listing it between refcheckdocs and cleandocs.
> 
> Tested with GNU Make 4.4.1 and Python 3.14.7, on a tree with no .config,
> where it ran 121 tests and left no __pycache__ behind.
> 
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
