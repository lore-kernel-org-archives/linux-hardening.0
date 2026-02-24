Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BB226D00;
	Tue, 24 Feb 2026 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969732; cv=none; b=aH6qc9UQd6zmOxGm/x73A8nb1X7CHQo2/T9tuoHWc85f5OTgG/XbZ7CKvyT8CCA8VkpQ6SODIIpabnahogOOUdf1j5KTqY/rRUw39uKBCaGij4dXrFQbuJSucTUjZwh4FVZinvJbp5caZFY+ERclBcHux/WiezLXb3lVL8r0bKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969732; c=relaxed/simple;
	bh=CBsGpsY2aMNwx8WrDOH4mczG4gg3cu75ErPQFMi6ZMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1QQMXxJLBtzpp0muTLv6ceKTQJV0MZadqLdSCNrnPufpEVBKsdyERWjdmJIXQvgbBhybP2fIu9ZCmrrAan06wPWpQ/S+S9A318Kj37KPozC8mP7iv9edx3cyje04g3A8x/P9zZhUj3qAt3W4y7ICeUP2CjJdF/RDmg9cVYabM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRLuFxup; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRLuFxup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C2EC116D0;
	Tue, 24 Feb 2026 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771969732;
	bh=CBsGpsY2aMNwx8WrDOH4mczG4gg3cu75ErPQFMi6ZMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRLuFxupUxHJ+yOl5ZAuTZdIJ919jEQpqcrkaEwk5poOwbfwk/OU5CqD/vm3+X3Oi
	 AXCj7lf3MLAGgXw199giJAWOePqyb2DV7ZS5d3f4UaHV4udcmzONXBzYzB3WIOaUYD
	 TTj8VKJrgGFtEfcN1InPPihEopWpbF4thYFyzjjw5XSH7VahU7GNGUkq6EAwmaYEzN
	 m+VGw5BKYO8Wm+Jiqd+8WIePtyixw4gHc6Axomfc5fdYIBUNu7queIf+R7xUJCBxjt
	 4/N2fXjdyn4yujNFz+euMkCRaX/bZBvY04nV439EuW5t+wPV7K+2vBThiUwb3Ef9z0
	 Re/KREjY+BbCA==
Date: Tue, 24 Feb 2026 13:48:51 -0800
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kcsan: test: Adjust "expect" allocation type for
 kmalloc_obj
Message-ID: <202602241316.CFFF256ED6@keescook>
References: <20260223222226.work.188-kees@kernel.org>
 <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>

On Tue, Feb 24, 2026 at 11:09:44AM +0100, Marco Elver wrote:
> On Mon, 23 Feb 2026 at 23:22, Kees Cook <kees@kernel.org> wrote:
> >
> > Instead of depending on the implicit case between a pointer to pointers
> > and pointer to arrays, use the assigned variable type for the allocation
> > type so they correctly match. Solves the following build error:
> >
> > ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> > [-Wincompatible-pointer-types]
> >   171 |         expect = kmalloc_obj(observed.lines);
> >       |                ^
> >
> > Tested with:
> >
> > $ ./tools/testing/kunit/kunit.py run \
> >         --kconfig_add CONFIG_DEBUG_KERNEL=y \
> >         --kconfig_add CONFIG_KCSAN=y \
> >         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
> >         --arch=x86_64 --qemu_args '-smp 2' kcsan
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Marco Elver <elver@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: <kasan-dev@googlegroups.com>
> > ---
> >  kernel/kcsan/kcsan_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index 79e655ea4ca1..056fa859ad9a 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> >         if (!report_available())
> >                 return false;
> >
> > -       expect = kmalloc_obj(observed.lines);
> > +       expect = kmalloc_obj(*expect);
> 
> This is wrong. Instead of allocating 3x512 bytes it's now only
> allocating 512 bytes, so we get OOB below with this change. 'expect'
> is a pointer to a 3-dimensional array of 512-char arrays (matching
> observed.lines).

Why did running the kunit test not trip over this? :(

Hmpf, getting arrays allocated without an explicit cast seems to be
impossible. How about this:


diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 056fa859ad9a..ae758150ccb9 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
 	if (!report_available())
 		return false;
 
-	expect = kmalloc_obj(*expect);
+	expect = (typeof(expect))kmalloc_obj(observed.lines);
 	if (WARN_ON(!expect))
 		return false;
 



-- 
Kees Cook
