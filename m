Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0828B7EA;
	Sat, 10 Oct 2026 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608864; cv=none; b=ZabzS8lzVwDhzzhrXP6GR1uGnSH1uhwbQLodRlYpcoVP3kib4R2NaYIxn0KjOLjMbVT+cYpE4ggh9r9Pbq/af+cHKqSzxjqqX95QoskxyMAHip8bz5mRjpCxtbY0YgvlkRwEgoNCNRaQWvmCFv4gvrfW1jPbiyvLRMXdvCMWoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608864; c=relaxed/simple;
	bh=lJWK4OJfGMepDxYAS/ax0chVHA3aBeIdMPdHZLLbZGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTX2OPp7YlJ8C/ZgUA8ixSpe9qcvyfjHzYJRByXdzQz9XT0JMGbhw70qxG4WC94IMjRs+bExy/kVnmFeHjp0lkwDcQTYAlqH2tQJ8ARoPRCgpz4Inbu74iIQBY4WCkUy5IlTFvsD1idER1ENtOKyFm1buWsaBFy04Uu6/g5TdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6wvMquQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6wvMquQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8181F000FF;
	Sat, 10 Oct 2026 05:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791608863;
	bh=FN3Qs5oxJT4JGR6GGOANgppDV98lCujbNX/7L+5VtPs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=a6wvMquQhZKO84eDRfsZb8q2nnMTDqhVRMzCz6vbfGclLauc7SZnu9gZ+P4DYVUoX
	 8Vf7YRxn1UDUMMBjyM+23qYRPcm+NbCFt2/DdGlW9LEkihKBbsqw2zIRf1EUIXSEGl
	 Qhp/h2hN3xPkpA+1Zc3ZhDGHswmPPkNoCZ1g/cTneO12K6Cco8gubm8K+I58MJG0Ud
	 0ZegAN+lTSaBJJPESpMKz5KZL9zELcxH9i4S+O5bCE2EiTeUDo5JhuJr9NmpmSL2k+
	 VDSNcxnT45dfo0Val6uwVgYPxl0WjDy6TjHuNr/dpnMh4Y/uu58n5V0UclttwqThsh
	 LF0C2mLzuffJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C08DCE0D77; Fri,  9 Oct 2026 22:07:43 -0700 (PDT)
Date: Fri, 9 Oct 2026 22:07:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <6f077bd6-3919-43d3-a683-15156253330b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
 <7fa8e996-d015-4f8d-a197-3f8901e0b31a@paulmck-laptop>
 <202610091923.FE842614D4@keescook>
 <7109f423-7249-49fb-a923-2824711fe197@paulmck-laptop>
 <202610092145.5247B47@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202610092145.5247B47@keescook>

On Fri, Oct 09, 2026 at 09:46:47PM -0700, Kees Cook wrote:
> On Fri, Oct 09, 2026 at 09:27:57PM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 09, 2026 at 07:25:42PM -0700, Kees Cook wrote:
> > > On Fri, Oct 09, 2026 at 08:51:18AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 08, 2026 at 11:27:30PM -0700, Kees Cook wrote:
> > > > > Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
> > > > > available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
> > > > > takes the job slots make has free. GNU Make passes the jobserver pipe
> > > > > only to recipes it treats as recursive, but leaves --jobserver-auth in
> > > > > MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
> > > > > the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
> > > > > jobserver-exec cannot open it, runs pigz on one thread, and prints:
> > > > > 
> > > > >   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> > > > > 
> > > > > Mark the gzip recipes as recursive with "+", as commit ecab4115c44cc
> > > > > ("kbuild: mark `rustc` (and others) invocations as recursive") did for
> > > > > rustc. As with those, "make -n" now runs them.
> > > > > 
> > > > > Tested ARCH=x86_64 and ARCH=arm64 defconfig with GNU Make 4.3 plus
> > > > > CentOS Stream 9's make-4.3-cloexec.patch, GCC 16.2.0, and -j64: without
> > > > > this change the warning appears and pigz runs with "-p 1"; with it there
> > > > > is no warning, and pigz runs with "-p 54" and "-p 64".
> > > > 
> > > > Thank you, Kees!
> > > > 
> > > > My initial test of this patch (using rcutorture) still showed the failure.
> > > 
> > > Oh! So the patch didn't fix it for you?
> > > 
> > > > I am running GCC 11.5.0 and without any patches to "make".  I take it
> > > > that I need to find and apply CentOS Stream 9's make-4.3-cloexec.patch?
> > > > 
> > > > But if I use "make -j" instead of rcutorture, this patch does work fine.
> > > > Even with "make -j632".
> > > 
> > > Without rcutorture was "make -jNN" broken for you without this patch?
> > > 
> > > > I put rcutorture in the background using nohup and full redirection,
> > > > but "nohup make -j632 > /tmp/Make.out 2>&1 < /dev/null &" works just
> > > > fine.  And running rcutorture in the foreground still fails.
> > > > 
> > > > Very strange.
> > > 
> > > O_O It only breaks ... when backgrounded? Oh my. Okay, I will try to
> > > figure that out.
> > 
> > Apologies, let me present my results in a more organized fashion:
> > 
> > 			foreground	background
> > 			-next	Fix	-next	Fix
> > 
> > 	make -jN	Bug	Good	Bug	Good
> > 
> > 	kvm.sh [1]	Bug	Bug	Bug	Bug
> > 
> > [1] tools/testing/selftests/rcutorture/bin/kvm.sh --build-only --allcpus --configs TREE02 --trust-make
> > 
> > Here, -next is next-20261008, and Fix is with your patch on it.
> > 
> > Just as mystifying to me, to be honest!
> 
> Ah, I think I found it, but I'm not sure why kvm.sh tripped it but bare
> "make" didn't. I missed the non-literal forms:
> 
> 	$(call if_changed,$(compress-y))
> 
> I'll send a v2 with docs updated too.

Done for the day, but I will test tomorrow.  Again, thank you!

							Thanx, Paul
