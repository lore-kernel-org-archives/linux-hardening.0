Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0017E0;
	Wed, 19 Mar 2025 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742352791; cv=none; b=CKMXgmNxm2u5mnX/ol/QoGRGhakNGLiLSQ5d98fleEXjKy311v3YvjXT2v0xOZAm6Qc/TKc1glGmv/a5zEEoO0PjCnBZAqVDWFtZBwK74j5R2orPyrs0VFm8Mgjm9DPV730CKgMKPKA09nAbBOTV5LCC9UHOe0ntjI489vlxPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742352791; c=relaxed/simple;
	bh=wpYsSDR41MfaAiMPx0O5P1NhWwX3o1+ObAksS0JJ1zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsQzFVOokS742pPsE7es6WbtX2OshmkYUg+TCYQZOV3LbwHXyB6L5PtAjgbrq3OR6KqPTr8fofHa7SK9rt9Yh2aWGpx69CZwmx/6oHaG979ZbBUIQZP5ZIR9WDTw0XcuR7g6+ZxPdfH5EdRjbFeujJ7W0ZGS7wpRjrozbm56qx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaEIXVls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaEIXVls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E33C4CEE3;
	Wed, 19 Mar 2025 02:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742352789;
	bh=wpYsSDR41MfaAiMPx0O5P1NhWwX3o1+ObAksS0JJ1zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaEIXVlsohNMsV8z35hj94tg0JO7HvFgv0EbrWOBiNLvAlkslMADfJVZMbt4xFdzq
	 NfHjRj34VZpuEXFrTNPCEB6wE9aEcq/ptb9gJTkbArV+MrO8Y8VxWLwqO4ETLxbfFM
	 dgHEjBVKY9YevVis5qtC4WQlFxElclI3qRfw2QyWv4ol3hTyjOGJixAulU4Jf2riQo
	 M89eW93Qg2ZOm8slsYN277Ea37ISbJpH3Rt717Ra9yglSKwhdpRd31jGfoj364aWR1
	 VJj5yBhxSlbwXFLNQ6j7qGDYieDWWOXN45xjYHjFHtVM9NTzcfrfKVtUwx37tKfkO4
	 HJlh6/XIzqYQQ==
Date: Tue, 18 Mar 2025 19:53:06 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/fortify: Replace "volatile" with
 OPTIMIZER_HIDE_VAR()
Message-ID: <202503181950.805640C@keescook>
References: <20250312000439.work.112-kees@kernel.org>
 <20250317174840.GA1451320@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317174840.GA1451320@ax162>

On Mon, Mar 17, 2025 at 10:48:40AM -0700, Nathan Chancellor wrote:
> Hi Kees,
> 
> On Tue, Mar 11, 2025 at 05:04:40PM -0700, Kees Cook wrote:
> > It does seem that using "volatile" isn't going to be sane compared to
> > using OPTIMIZER_HIDE_VAR() going forward. Some strange interactions[1]
> > with the sanitizers have been observed in the self-test code, so replace
> > the logic.
> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
> > Signed-off-by: Kees Cook <kees@kernel.org>
> ...
> > diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
> > index 18dcdedf777f..29ffc62a71e3 100644
> > --- a/lib/tests/fortify_kunit.c
> > +++ b/lib/tests/fortify_kunit.c
> ...
> > @@ -993,8 +1003,11 @@ static void fortify_test_memcmp(struct kunit *test)
> >  {
> >  	char one[] = "My mind is going ...";
> >  	char two[] = "My mind is going ... I can feel it.";
> > -	size_t one_len = sizeof(one) + unconst - 1;
> > -	size_t two_len = sizeof(two) + unconst - 1;
> > +	size_t one_len = sizeof(one) - 1;
> > +	size_t two_len = sizeof(two) - 1;
> > +
> > +	OPTIMIZER_HIDE_VAR(one_len);
> > +	OPTIMIZER_HIDE_VAR(two_len);
> >  
> >  	/* We match the first string (ignoring the %NUL). */
> >  	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
> 
> I am sorry for bringing this up some time after you sent this change, as
> I have only now had a chance to actually sit down and understand the
> results of my bisect. I am still seeing a __read_overflow error when
> building lib/tests/fortify_kunit.o with Fedora's configuration + LTO in
> next-20250317, which contains this change. I do not think it is issue
> 2075, as I can reproduce it without UBSAN enabled altogether. This is
> with LLVM 20.1.0.

Hmpf. Well, I guess I'll continue to debug these. I think I'll keep the
patch that refactors volatile -- I prefer OPTIMIZER_HIDE_VAR() as it's a
more direct way to indicate what I want the compiler to ignore. I've
been trying to move to using it instead of my old style volatile uses.

> $ cat kernel/configs/repro.config
> CONFIG_FORTIFY_KUNIT_TEST=m
> CONFIG_FORTIFY_SOURCE=y
> CONFIG_KUNIT=y
> # CONFIG_LTO_NONE is not set
> CONFIG_LTO_CLANG_THIN=y

Thanks for the config that pokes it!

> 
> # or x86_64
> $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper {def,repro.}config lib/tests/fortify_kunit.o
> ld.lld: error: call to __read_overflow marked "dontcall-error": detected read beyond size of object (1st parameter)
> make[6]: *** [scripts/Makefile.build:203: lib/tests/fortify_kunit.o] Error 1
> 
> Selectively reverting this avoids the problem, which is definitely
> odd... Maybe issue 2075 is related more to issue 2077 and this patch
> should not be entertained?

Yeah, I don't yet see what is going on with these. :|

-Kees

-- 
Kees Cook
