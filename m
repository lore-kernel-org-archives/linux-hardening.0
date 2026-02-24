Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F82E11BC;
	Tue, 24 Feb 2026 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972869; cv=none; b=Mig9uyf4hOtRqKaHKMZdxr6WnrloxaxXi46ihHhXb2aXWt3Nn3fuKvK8jwbUiMqxH+/klRroPj2j4qh9qAsgvTY3bJa4jBXQfPnxGzDdWcjpZYpjmtnxGK2E6W/VIajl/d5jN8jYtuyYDv80NhQsMTzR4CXRKsrg0agLstK0Bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972869; c=relaxed/simple;
	bh=HEvL7iJoDuZoFJgl9yQvLLzRnK1Y0nTJoMOqs/1OpOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWEjygurNPAAxePT6RF9OBdJxlC3UUFDv4+enZTyfp9a/vTOmH0HtnDISN+7nj0YiOSzLn2OjF8cSkKfOkNir0cn8DUksutyBw2QH25daKXbVT1Jl1NY2YPFF5TyU06kdx7LnpGatUFSe/bRdAu7KS1cFP5R7a8UqkS+UtI7lbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXOqAJIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXOqAJIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A3DC116D0;
	Tue, 24 Feb 2026 22:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972868;
	bh=HEvL7iJoDuZoFJgl9yQvLLzRnK1Y0nTJoMOqs/1OpOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXOqAJIzVzDC+V2y+5wCgPm+rs6gmycze84+08G3ihi3+K2IPXtJOjuiLTng5FvGa
	 XGWReziky2zIFyVMgjofIxdnl7iFHx8PZccnAjCOEQa7yO+wJbS/0Eii82JTMGbzrc
	 Xcc5AvX4bzgWXrdoqI8gMs7HjaKNVaDjLUxb88r2UZH2RnaKArokKp6QLYM1Y3b/zo
	 9ALmmdAhi6lmadLHOCPJh/oBFkqLX/Xi6HqJIaCTXyuQFnHVcLerELcLZELst7OWJ9
	 HI+0DuO5Mu+xs8bClDFsrlKoFGDC9G54LOx5LweqXnRyaJOBgaD2cYW6iAM5aktuVA
	 bfVsvHjXE/JeA==
Date: Tue, 24 Feb 2026 14:41:08 -0800
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kcsan: test: Adjust "expect" allocation type for
 kmalloc_obj
Message-ID: <202602241440.1D885B8@keescook>
References: <20260223222226.work.188-kees@kernel.org>
 <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>
 <202602241316.CFFF256ED6@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602241316.CFFF256ED6@keescook>

On Tue, Feb 24, 2026 at 01:48:51PM -0800, Kees Cook wrote:
> On Tue, Feb 24, 2026 at 11:09:44AM +0100, Marco Elver wrote:
> > On Mon, 23 Feb 2026 at 23:22, Kees Cook <kees@kernel.org> wrote:
> > >
> > > Instead of depending on the implicit case between a pointer to pointers
> > > and pointer to arrays, use the assigned variable type for the allocation
> > > type so they correctly match. Solves the following build error:
> > >
> > > ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > > ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> > > [-Wincompatible-pointer-types]
> > >   171 |         expect = kmalloc_obj(observed.lines);
> > >       |                ^
> > >
> > > Tested with:
> > >
> > > $ ./tools/testing/kunit/kunit.py run \
> > >         --kconfig_add CONFIG_DEBUG_KERNEL=y \
> > >         --kconfig_add CONFIG_KCSAN=y \
> > >         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
> > >         --arch=x86_64 --qemu_args '-smp 2' kcsan
> > >
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > > Cc: Marco Elver <elver@google.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: <kasan-dev@googlegroups.com>
> > > ---
> > >  kernel/kcsan/kcsan_test.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > > index 79e655ea4ca1..056fa859ad9a 100644
> > > --- a/kernel/kcsan/kcsan_test.c
> > > +++ b/kernel/kcsan/kcsan_test.c
> > > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> > >         if (!report_available())
> > >                 return false;
> > >
> > > -       expect = kmalloc_obj(observed.lines);
> > > +       expect = kmalloc_obj(*expect);
> > 
> > This is wrong. Instead of allocating 3x512 bytes it's now only
> > allocating 512 bytes, so we get OOB below with this change. 'expect'
> > is a pointer to a 3-dimensional array of 512-char arrays (matching
> > observed.lines).
> 
> Why did running the kunit test not trip over this? :(
> 
> Hmpf, getting arrays allocated without an explicit cast seems to be
> impossible. How about this:
> 
> 
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 056fa859ad9a..ae758150ccb9 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
>  	if (!report_available())
>  		return false;
>  
> -	expect = kmalloc_obj(*expect);
> +	expect = (typeof(expect))kmalloc_obj(observed.lines);
>  	if (WARN_ON(!expect))
>  		return false;

Or:

	expect = kmalloc_objs(*observed.lines, ARRAY_SIZE(observed.lines));

I think the quoted cast is probably better...

-- 
Kees Cook
