Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60A2E1EE0;
	Tue, 24 Feb 2026 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771975684; cv=none; b=g/jKb4P6qV70xL8b7oYQs8x4P/LX/Sxu6LD8v6OZUxU2X1PCUenB7kyB4spw94Hih8z1T9FVTH/zacqyzYVXBfX3dt4JTcU/YywvZvf55gT0LmovKHD5G+kSkMDjdL88Lp8m6+a/Mb/q5mUs/owqcTocOGQ29LL+l4UIpSJ3KDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771975684; c=relaxed/simple;
	bh=uKGks8yrQ9edbBywbZLalETfr/aZb/UBoMIPeDoZYDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQcgX+3kQaRpterTb8XL26yedKX080srGhtDidbW39+o59soZs3yR8yK1Ex+uTBK0vNtM+ljjpLJK/wTWNcuZacEa48W14434COU+shmMU1blkZa0lmpEYjL5o5tmQyTQXahumt+LIHQwXTUZ8yrljw6efbsus0qi/20ljDKc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcDxK2Ij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcDxK2Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B7C116D0;
	Tue, 24 Feb 2026 23:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771975683;
	bh=uKGks8yrQ9edbBywbZLalETfr/aZb/UBoMIPeDoZYDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcDxK2Ij89eNYT/8+6SGMuTsyY0f9D8an07CWUXtI2B5J9s8bgX+lR/WZH4d4H4ow
	 fhRQADZx9l0fXZKncil05DMP3Ncz8VMlbWs0a7D4c0wHAtzIoJdSlouypwEeAaWbHL
	 Vvm5vqmVdCckzY4rldf1OHdgYpDGS9GbnVdE2QBDzKb8xotH+t8iHpWh+tNk0kyj50
	 F33toPvPSGRc/u6LPTK6sHN3+0rFXsihNPA+/dtOPwbBm4TkW0/Mh3Nvh+I7vnqQTq
	 5gwQKX4cZmmFQZ6xnIygdFClh3DljM7JOzXMPkwshXCPO6ZNxxmskfsmGXhx91m8al
	 4+Twoj34qBmAg==
Date: Tue, 24 Feb 2026 15:28:03 -0800
From: Kees Cook <kees@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kcsan: test: Adjust "expect" allocation type for
 kmalloc_obj
Message-ID: <202602241526.AE3F2F4A32@keescook>
References: <20260223222226.work.188-kees@kernel.org>
 <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>
 <202602241316.CFFF256ED6@keescook>
 <CANpmjNNZ-U4hT8LaW=V+q+NRPHb=fsxai86CBb1VdV8Pyo_xNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNZ-U4hT8LaW=V+q+NRPHb=fsxai86CBb1VdV8Pyo_xNA@mail.gmail.com>

On Tue, Feb 24, 2026 at 11:39:45PM +0100, Marco Elver wrote:
> On Tue, 24 Feb 2026 at 22:48, Kees Cook <kees@kernel.org> wrote:
> >
> > On Tue, Feb 24, 2026 at 11:09:44AM +0100, Marco Elver wrote:
> > > On Mon, 23 Feb 2026 at 23:22, Kees Cook <kees@kernel.org> wrote:
> > > >
> > > > Instead of depending on the implicit case between a pointer to pointers
> > > > and pointer to arrays, use the assigned variable type for the allocation
> > > > type so they correctly match. Solves the following build error:
> > > >
> > > > ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > > > ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> > > > [-Wincompatible-pointer-types]
> > > >   171 |         expect = kmalloc_obj(observed.lines);
> > > >       |                ^
> > > >
> > > > Tested with:
> > > >
> > > > $ ./tools/testing/kunit/kunit.py run \
> > > >         --kconfig_add CONFIG_DEBUG_KERNEL=y \
> > > >         --kconfig_add CONFIG_KCSAN=y \
> > > >         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
> > > >         --arch=x86_64 --qemu_args '-smp 2' kcsan
> > > >
> > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> > > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > > ---
> > > > Cc: Marco Elver <elver@google.com>
> > > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > > Cc: <kasan-dev@googlegroups.com>
> > > > ---
> > > >  kernel/kcsan/kcsan_test.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > > > index 79e655ea4ca1..056fa859ad9a 100644
> > > > --- a/kernel/kcsan/kcsan_test.c
> > > > +++ b/kernel/kcsan/kcsan_test.c
> > > > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> > > >         if (!report_available())
> > > >                 return false;
> > > >
> > > > -       expect = kmalloc_obj(observed.lines);
> > > > +       expect = kmalloc_obj(*expect);
> > >
> > > This is wrong. Instead of allocating 3x512 bytes it's now only
> > > allocating 512 bytes, so we get OOB below with this change. 'expect'
> > > is a pointer to a 3-dimensional array of 512-char arrays (matching
> > > observed.lines).
> >
> > Why did running the kunit test not trip over this? :(
> >
> > Hmpf, getting arrays allocated without an explicit cast seems to be
> > impossible. How about this:
> >
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index 056fa859ad9a..ae758150ccb9 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> >         if (!report_available())
> >                 return false;
> >
> > -       expect = kmalloc_obj(*expect);
> > +       expect = (typeof(expect))kmalloc_obj(observed.lines);
> 
> That works - or why not revert it back to normal kmalloc? There's
> marginal benefit for kmalloc_obj() in this case, and this really is
> just a bunch of char buffers - not a complex object. If there's still
> a benefit to be had from kmalloc_obj() here, I'm fine with the typeof
> cast.

Honestly... it's because I can't figure out how to make a exclusion for
this (nor how to get multidimensional array types) in Coccinelle to
avoid this case. (So re-running the conversion script will keep trying
to change this case.) And it's the only place in the kernel doing this
kind of thing. :P

I've sent v2 with the cast and a better commit log describing what's
happening.

-- 
Kees Cook
