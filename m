Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CA239DBD4;
	Thu, 17 Sep 2026 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627180; cv=none; b=L0aH434/GIkE6lTnE222SqJJreCPhD6KcrJ/Mo0sry5Q3DoYl/H4or5B/bPBlUYER93TiIHdCPrGtpKJpVlSv28z39TXjdovpuani9mPhDfqm5war/mqOGLRSTxPoiRhz7zbUK9n+m/hq/KJxblhpW1BHDJbtEjiczBtZEafZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627180; c=relaxed/simple;
	bh=G8cK6STjqhingX/SdzI6FFC1mcIYRsQQzml3h99cHDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdRJx1Vk2wgNkqrTg8gzT1pEkW57gaCKGMlAuzn05YfnOamcnd75iK1AmBW0VEPlcydpO+h2myMrzee1BS2YMor/CIuIUuSKlw6NWQ7OpiTDmziVdVwrhGDshieNllEkzT4QmMFS8CSaO+ZUms++EqR5Z1uIqTkergvJfygKwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=jhhsxFe5; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="jhhsxFe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1789627130; bh=G8cK6STjqhingX/SdzI6FFC1mcIYRsQQzml3h99cHDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhhsxFe5qem39p9bMgy2w03yPjT2s0zuq/sX1SZaG852QxI9VVKwbd+yq4OLtC3JE
	 V0xLwF0p0H9+YjROOxMzLxniSCMd4v8Yj+eAqJUXkIgk9x6re5Ukw9Sfbhq+rsSuU3
	 /qn1lCpwxckBxkgUg320quFPmgQ/t+04MmqiYafFAn8OIne8smHo7r0oEVxUnhtDBw
	 +0tsfU1jmVlkWiUUE2fZsGIGH2x95kGvM8ECVop1DHDutBb9tCuHGvMVOklxh66J14
	 3GkRrVjJZLLt4LJXEyeqfSkqXnDO9G2XVKlL+UDy4mfS4h9TPwuwZ1M0BfMCHfuM64
	 5SmsC3MuAFm2g==
Received: from [212.42.244.78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6aab8af9-6dc7-7f0000032729-7f000001ae78-1
	for <multiple-recipients>; Thu, 17 Sep 2026 08:38:49 +0200
Received: from mail-auth.fritz.com (unknown [212.42.244.78])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 08:38:49 +0200 (CEST)
Date: Thu, 17 Sep 2026 08:38:48 +0200
From: Nicolas Schier <n.schier@fritz.com>
To: Kees Cook <kees@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	Maximilian Huber <maximilian.huber@tngtech.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Luis Augenstein <luis.augenstein@tngtech.com>,
	Breno Leitao <leitao@debian.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Jones <andrew.jones@linux.dev>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: Makefile: Add a testdocs target for the
 documentation unit tests
Message-ID: <20260917-parrot-of-eminent-persistence-2dbf0c@l-nschier-aarch64>
References: <20260916184107.i.183-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916184107.i.183-kees@kernel.org>
Organization: FRITZ! Technology GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1789627129-8E48C0BC-3C5D976E/0/0
X-purgate-type: clean
X-purgate-size: 1538
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-03  mail-id: F417FA01E3  external: no

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
> 

I agree with Randy, 'testdocs' sounds good to me, too.

Tested-by: Nicolas Schier <n.schier@fritz.com>
Reviewed-by: Nicolas Schier <n.schier@fritz.com>

-- 
Nicolas
