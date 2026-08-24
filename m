Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A153B42D0;
	Mon, 24 Aug 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553715; cv=none; b=n4n1n6Tucs0kxjE0+uC3G87xQJ38A/wosMX2rg404qKXiyLxVYrlQ2LoXnrlX4KgMft0GfSz3Qw6dBxaLsd17qz3+1zH3PWmhaQDuJTMnXaQgTxjcBpNkeUoLSA0UJN2aZ/ihqXOc8VutWBAuj9xWSpZTlWFuiKNzqQwP73J6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553715; c=relaxed/simple;
	bh=3PCsfniQhFGRXBnuoNv1DWWS3GKspW+tp81RcRwQSuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+GmtMhU7TZSrIUdXe5x7WtoCIuP/uyc3oukbPaox6YcqF2tJ0W2+sy1cvQ0TgTgLnIYMD+0PhxwOkZFAccNbUWT4L05gNY9gyLDl6aZOlZ6gFMXLnK39Y3uJkxK5MDBAxcpdClCwsLwrzlUZDBKjyZJtjFY74n9+gMG2Mb8dCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EkBJD9vx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKP6WXjf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EkBJD9vx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKP6WXjf"
Date: Mon, 24 Aug 2026 08:41:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787553711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ/oJDckZY1z/B4BbBXe5zypr99eyfD/LDs4CTbgQaQ=;
	b=EkBJD9vxIAQQtzBVzwXUtzHzspL8Ya14rf73Vfa32EZ4fAgp1qHA8KzbhlVmJydW+Z8rZW
	XnR4e/FclUN6W7ExQfFWycLs0dEix6dxCSTOht9P35S76Xw6B16U5vRVo9UN4a3rM0b7id
	iIg4EJMp45HQAyCsurZc54/rfFwgB4J5S7X6ddz7hcfJb6ghNmxeCuYRTKalDXinHzcghX
	bKYYxk87O/Agi74W6Ftu+ESA/mazXVuEAxeMfuX7Y/d8/9hD0NY+RJKsBvnMDczVRydaYC
	o4cBgkgM3iGrUhEddjfgOI9/ZmFhiDgvet/NJBMg9KDLC+ufYyM0fxPtGIO65A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787553711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQ/oJDckZY1z/B4BbBXe5zypr99eyfD/LDs4CTbgQaQ=;
	b=LKP6WXjf5vfVYfkVZELvMZMvVHGu1L4rYbBy5VpNigFjlGjWqsxTq0qE/i2mFuLRh+TzYY
	O5jfgwG1nggJ1VBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Ryota Sakamoto <sakamo.ryota@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Petr Mladek <pmladek@suse.com>, Kir Chou <note351@hotmail.com>, 
	codemender-patching+linux@google.com, linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/2] lib/tests: Add KUnit test for struct stack_trace
 __counted_by_ptr attribute
Message-ID: <20260824083538-d0eff358-e1d4-4af6-9e61-d4d816783266@linutronix.de>
References: <20260823123549.1120133-1-morbo@google.com>
 <20260823123549.1120133-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823123549.1120133-3-morbo@google.com>

On Sun, Aug 23, 2026 at 12:35:33PM +0000, Bill Wendling wrote:
> Add a custom KUnit test suite 'stacktrace_counted_by' to verify that the
> __counted_by_ptr annotation on the 'entries' field of 'struct stack_trace'
> behaves correctly.

The implementation of __counted_by_ptr should be tested by a dedicated unittest
for that feature. And I am fairly sure that already exists. It should not be
tested in random subsystems.

> The test verifies that 'max_entries' correctly limits and validates access
> to 'entries' when CONFIG_ARCH_STACKWALK is not defined. If it is defined,
> the test is cleanly skipped at runtime to prevent compile-time or runtime
> failures due to 'struct stack_trace' being undefined on modern
> architectures.
> 
> Assisted-by: Gemini Next
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <david@davidgow.net>
> Cc: Rae Moar <raemoar63@gmail.com>
> Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Dmitry Antipov <dmantipov@yandex.ru>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Kir Chou <note351@hotmail.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/Kconfig.debug            | 10 +++++++
>  lib/kunit/.kunitconfig       |  1 +
>  lib/tests/Makefile           |  1 +
>  lib/tests/stacktrace_kunit.c | 51 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+)
>  create mode 100644 lib/tests/stacktrace_kunit.c

(...)

> diff --git a/lib/tests/stacktrace_kunit.c b/lib/tests/stacktrace_kunit.c
> new file mode 100644
> index 000000000000..7ec48edf84fe
> --- /dev/null
> +++ b/lib/tests/stacktrace_kunit.c
> @@ -0,0 +1,51 @@

(...)

> +}
> +#else
> +static void test_stack_trace_counted_by(struct kunit *test)
> +{
> +	kunit_skip(test, "CONFIG_ARCH_STACKWALK is enabled, struct stack_trace is not defined");

If the test requires a specific kconfig symbol, then depend on it in kconfig.
Putting all of the code behind a single, giant ifdef is pointless.

> +}
> +#endif

(...)
