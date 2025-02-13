Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F64266B54;
	Thu, 13 Feb 2025 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479668; cv=none; b=rJiVBRJt2xPbyo3GeqtVo3yutX3X9s7R0U6eJkf3R+AtGRo6Abum0CQQ8idHpT+JbOWJ5OaKwsL7o6yCmqVvc4BLWtu2CXrsK311aObKr2vF6IWSQQqru82hgVevg9UG30SPEKQMFOwGIjQCHR3TROrJD6bp/hm4YWi08oisckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479668; c=relaxed/simple;
	bh=xsAbZvVEr/6Fsigt2bodFoyIOZi8VkbXaR8jtN+QkDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvpC/b30Rqsv2H3mug0rBxM0Z8XgLnLWyatdDysuFjPnXZzE+mXiv/MEXMiyvp0YO9O14eZZhxWa/DaWVh/Q+KI/Rf6t+Txo01Iedn2smyYtVmBB/SxlDLAqyNzmWjhTQvGVCrP2OgkDaLDj0u7/hWUwguVd+vECq3jfDtQ1FT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbIPR2EJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbIPR2EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA490C4CED1;
	Thu, 13 Feb 2025 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739479667;
	bh=xsAbZvVEr/6Fsigt2bodFoyIOZi8VkbXaR8jtN+QkDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbIPR2EJry14RyYsG9OCmVXECu2vsr0QZbP5dy8vQ+3FZtIl/NpwkB5HEH5/fh4us
	 INQLijhO1RSLiewpXCDSOHETuy1rT42+mCLSnaiqRvT6KLftMmuV3p1Em0FQdkKusT
	 e/51FOAu7XdYFlKIUjMrzgsvwdMBQgNHYojfPcPEm/j1heAvzysaBaOoTBtGo0M265
	 HE+W36jwO68BOszt/wtWJS+7cePSXs8gdBUBcM2RAi4Nd6KMsOBna6wYdqHf+knkZO
	 EX9iZ0yF3+UnbED0ge0nACKO0T1Wm6ME+68+NqBSZ+nZGq1KAzJrBo0HdTeCq97LTF
	 AsmW36O62vZlA==
Date: Thu, 13 Feb 2025 12:47:47 -0800
From: Kees Cook <kees@kernel.org>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org,
	akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com,
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net, hca@linux.ibm.com,
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
Message-ID: <202502131240.A57C749@keescook>
References: <20250212032155.1276806-1-jeffxu@google.com>
 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
 <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
 <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>

On Thu, Feb 13, 2025 at 07:59:48PM +0000, Pedro Falcato wrote:
> On Wed, Feb 12, 2025 at 2:02 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > (sorry I really am struggling to reply to mail as lore still seems to be
> > broken).
> >
> > On Wed, Feb 12, 2025 at 12:37:50PM +0000, Pedro Falcato wrote:
> > > On Wed, Feb 12, 2025 at 11:25 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > The commit message in the first patch contains the full description of
> > > > > this series.
> > > >
> > [...]
> > >
> > > FWIW, although it would (at the moment) be hard to pull off in the
> > > libc, I still much prefer it to playing these weird games with CONFIG
> > > options and kernel command line options and prctl and personality and
> > > whatnot. It seems to me like we're trying to stick policy where it
> > > doesn't belong.
> >
> > The problem is, as a security feature, you don't want to make it trivially
> > easy to disable.
> >
> > I mean we _need_ a config option to be able to strictly enforce only making
> > the feature enable-able on architectures and configuration option
> > combinations that work.
> >
> > But if there is userspace that will be broken, we really have to have some
> > way of avoiding the disconnect between somebody making policy decision at
> > the kernel level and somebody trying to run something.
> >
> > Because I can easily envision somebody enabling this as a 'good security
> > feature' for a distro release or such, only for somebody else to later try
> > rr, CRIU, or whatever else and for it to just not work or fail subtly and
> > to have no idea why.
> 
> Ok so I went looking around for the glibc patchset. It seems they're
> moving away from tunables and there was a nice
> GNU_PROPERTY_MEMORY_SEAL added to binutils.
> So my proposal is to parse this property on the binfmt_elf.c side, and
> mm would use this to know if we should seal these mappings. This seems
> to tackle compatibility problems,
> and glibc isn't sealing programs without this program header anyway. Thoughts?

It seems to me that doing this ties it to the binary, rather than
execution context, which may want to seal/not-seal, etc. I have a sense
that it's be better as a secure bit, or prctl, or something like that. The
properties seem to be better suited for "this binary _can_ do a thing"
or "this binary _requires_ a thing", like the GNU_STACK bits, etc. But
maybe there's more to this I'm not considering?

> > I mean one option is to have it as a CONFIG_ flag _and_ you have to enable
> > it via a tunable, so then it can become sysctl.d policy for instance.
> 
> sysctl is also an option but the idea of dropping a random feature
> behind a CONFIG_ that's unusable by lots of people (including the
> general GNU/Linux ecosystem) is really really unappealing to me.

I agree 100%, but I think we need to make small steps. Behind a CONFIG
means we get it implemented, and then we can look at how to make it more
flexible. I'm motivated to figure this out because I've long wanted to
have a boot param to disable CRIU since I have distro systems that I
don't use CRIU on, and I don't want the (very small) interface changes
it makes available into seccomp filter visibility. And if CRIU could be
run-time based, so could system mapping sealing. :)

-- 
Kees Cook
