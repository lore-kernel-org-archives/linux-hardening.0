Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA31A682B;
	Sat, 10 Oct 2026 04:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791607609; cv=none; b=CZf0hlZb2ZAfBJ8ZdnaohJP1Ki6v5R4fb+omuzzutPdiYIG50MSfJR9iDJbmy14T9IMrxtlG6tDiMjPDh25tPcHnMiXz/YUBo435VICifnfJHqa5JSi9QqZAlj7VVvYrX6R5YLQZ1dg+L+EJCJpTG/vW/RbAZMj6q7JDiJ6R5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791607609; c=relaxed/simple;
	bh=PcWuPgEPnHf5MO4N1q6EpgFx4Xmu2wKVOm/4Ms58WMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlrXqvVGySpzVGu2HMPTixPNuK4iQriVk8zMLmm+016bMFLYoWKg347CVzfSZgBxhMMumrObWuZ0QOGy+HNVTpQVFMolFeIh25CPak849KcJFEE0hfA+wF4Szh+n8R6/ZQK6zgqOmkRN9Zguxypmf5cddCdhwUlyqDZjfVV+qsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTc6ekoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTc6ekoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE31F000FF;
	Sat, 10 Oct 2026 04:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791607608;
	bh=A/36L1UcIFPF3nRy4NqLqHAjfXcUYocqzRYwlwuZdyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTc6ekozZLDZACY6Bg1iCEkCbarJkhEd3ZafsAY7VSDsnIrXI8uoSZg47qax+rA03
	 UMe4FF2jBU9Ap2eOgBj78yQzvKW4gCq0iMpx39XGaKFLdVcW0MAhgJOaZljgVSQWQ8
	 d2ByZOszatrWsYR7llVDImNcUWDEEKQtBdeQ0HYRf5yEY42ZibYkkDGaxuseOsZnz3
	 IhUb/dhLiwoFYSS3iy1iGAkpKgwv7jMkEVu2/UMaSumOSq7OIg+4hQplUDvrCBNVnK
	 WwyEeTXIpIk4hBNvDANkyIBo1CYNPpPHHFR5/wang8qG/bSCF9o5+KdKz4mKreb5Xx
	 EsZFjbkCTlnqw==
Date: Fri, 9 Oct 2026 21:46:47 -0700
From: Kees Cook <kees@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <202610092145.5247B47@keescook>
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
 <7fa8e996-d015-4f8d-a197-3f8901e0b31a@paulmck-laptop>
 <202610091923.FE842614D4@keescook>
 <7109f423-7249-49fb-a923-2824711fe197@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7109f423-7249-49fb-a923-2824711fe197@paulmck-laptop>

On Fri, Oct 09, 2026 at 09:27:57PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 09, 2026 at 07:25:42PM -0700, Kees Cook wrote:
> > On Fri, Oct 09, 2026 at 08:51:18AM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 08, 2026 at 11:27:30PM -0700, Kees Cook wrote:
> > > > Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
> > > > available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
> > > > takes the job slots make has free. GNU Make passes the jobserver pipe
> > > > only to recipes it treats as recursive, but leaves --jobserver-auth in
> > > > MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
> > > > the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
> > > > jobserver-exec cannot open it, runs pigz on one thread, and prints:
> > > > 
> > > >   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> > > > 
> > > > Mark the gzip recipes as recursive with "+", as commit ecab4115c44cc
> > > > ("kbuild: mark `rustc` (and others) invocations as recursive") did for
> > > > rustc. As with those, "make -n" now runs them.
> > > > 
> > > > Tested ARCH=x86_64 and ARCH=arm64 defconfig with GNU Make 4.3 plus
> > > > CentOS Stream 9's make-4.3-cloexec.patch, GCC 16.2.0, and -j64: without
> > > > this change the warning appears and pigz runs with "-p 1"; with it there
> > > > is no warning, and pigz runs with "-p 54" and "-p 64".
> > > 
> > > Thank you, Kees!
> > > 
> > > My initial test of this patch (using rcutorture) still showed the failure.
> > 
> > Oh! So the patch didn't fix it for you?
> > 
> > > I am running GCC 11.5.0 and without any patches to "make".  I take it
> > > that I need to find and apply CentOS Stream 9's make-4.3-cloexec.patch?
> > > 
> > > But if I use "make -j" instead of rcutorture, this patch does work fine.
> > > Even with "make -j632".
> > 
> > Without rcutorture was "make -jNN" broken for you without this patch?
> > 
> > > I put rcutorture in the background using nohup and full redirection,
> > > but "nohup make -j632 > /tmp/Make.out 2>&1 < /dev/null &" works just
> > > fine.  And running rcutorture in the foreground still fails.
> > > 
> > > Very strange.
> > 
> > O_O It only breaks ... when backgrounded? Oh my. Okay, I will try to
> > figure that out.
> 
> Apologies, let me present my results in a more organized fashion:
> 
> 			foreground	background
> 			-next	Fix	-next	Fix
> 
> 	make -jN	Bug	Good	Bug	Good
> 
> 	kvm.sh [1]	Bug	Bug	Bug	Bug
> 
> [1] tools/testing/selftests/rcutorture/bin/kvm.sh --build-only --allcpus --configs TREE02 --trust-make
> 
> Here, -next is next-20261008, and Fix is with your patch on it.
> 
> Just as mystifying to me, to be honest!

Ah, I think I found it, but I'm not sure why kvm.sh tripped it but bare
"make" didn't. I missed the non-literal forms:

	$(call if_changed,$(compress-y))

I'll send a v2 with docs updated too.

-- 
Kees Cook
