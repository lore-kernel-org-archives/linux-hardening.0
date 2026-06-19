Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50189368974;
	Fri, 19 Jun 2026 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862704; cv=none; b=Y4gP15tEaeKwMbWtc43aa9LQpGKd7PbPT9T8ITM4iOACh8PVfGUF9GPr0ryNn9KxP/2kMcpUdvdq1eWmUjBPRaGeBoWRJq63pRDUNVmJNMQ94YtRxU4RR+mq6jdCAOhVuibfbsOok997Ce/4yj9XQ8uJdOwMJ+UD2tSOYM/zqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862704; c=relaxed/simple;
	bh=w+4Vzbgm5K2WXSz+9lLD2L+l+sM5mXttC7DZrFqjd0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVabpCrCy7LNfxmgnxNsi8sPY+4QXdA3o3jFVN4j1Spquft0N2KikUPcbafYQio7f+rATOCMjQU5QN0gOkKA9NGT9+Qy34axTI7QHHoTqYkuN4Xb5LWZ3hf5kiAlH5dxNfRI7V3J+LkmN0GxxJm+AgIDsg8wssjU2wkCRNZaE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gpiQOgJ+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpiQOgJ+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o3HIHRfjnXsIUv9uVJUPUvrCRWgfpigblPsyfbstNuU=; b=gpiQOgJ+j01lkL2FJCvGIZMLLv
	g9gAD9go3A37PHaeeHyfX2dVEXqhFs7CrcAqc2xgjohlj8im1D/XSACMYkSac02aIk5HQaN0hpGP/
	IQQiMud4pCxBCIBrGisuHxsXYd/rgJOji+o8sysb+L7IjxsdFdx5vuzARs0hRE37XinrrqqwXszp1
	nXy+Li53622sx5QMJdADYGojoPuxXgemB8hGjmtst/4I5pOdYvKIIk6wgQiEW1NL1Q8F64dPIaH8u
	KwLtXKMxGUmAkdDd0p/kpyG9BpszNrYNU1f9bXmbuaGQ/wZTqpe+rngkojtepkOdxI88R56AHP22Z
	SKOLKK+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1waVso-0000000EMVz-2G4J;
	Fri, 19 Jun 2026 09:51:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4778300578; Fri, 19 Jun 2026 11:51:29 +0200 (CEST)
Date: Fri, 19 Jun 2026 11:51:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	llvm@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kunit: cfi: Add test for kCFI indirect-call type
 checks
Message-ID: <20260619095129.GE49529@noisy.programming.kicks-ass.net>
References: <20260618210946.it.538-kees@kernel.org>
 <20260619093708.GT49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619093708.GT49951@noisy.programming.kicks-ass.net>

On Fri, Jun 19, 2026 at 11:37:08AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 18, 2026 at 02:09:50PM -0700, Kees Cook wrote:
> 
> > diff --git a/kernel/cfi.c b/kernel/cfi.c
> > index 4dad04ead06c..8cb6a274c865 100644
> > --- a/kernel/cfi.c
> > +++ b/kernel/cfi.c
> > @@ -8,12 +8,61 @@
> >  #include <linux/bpf.h>
> >  #include <linux/cfi_types.h>
> >  #include <linux/cfi.h>
> > +#include <linux/rcupdate.h>
> >  
> >  bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
> >  
> > +#if IS_ENABLED(CONFIG_CFI_KUNIT_TEST)
> > +static bool (*cfi_kunit_failure_hook)(void);
> > +
> > +void cfi_kunit_set_failure_hook(bool (*hook)(void))
> > +{
> 	BUG_ON(cfi_kunit_failure_hook);
> > +	WRITE_ONCE(cfi_kunit_failure_hook, hook);
> > +
> > +	/*
> > +	 * On unregister, wait for any in-flight cfi_kunit_handled() caller to
> > +	 * finish before the (possibly module-resident) hook can be freed.
> > +	 */
> > +	if (!hook)
> > +		synchronize_rcu();
> > +}
> > +EXPORT_SYMBOL_GPL(cfi_kunit_set_failure_hook);
> EXPORT_SYMBOL_FOR_MODULES(cfi_kunit_set_failure_hook, "cfi_kunit")

> >  enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
> >  				      unsigned long *target, u32 type)
> >  {
> > +	/*
> > +	 * Let a registered KUnit test consume and count its own deliberate
> > +	 * violations. If it claims the failure, suppress the report and tell
> > +	 * the arch handler to skip the trap and resume the thread, regardless
> > +	 * of CFI_PERMISSIVE.
> > +	 */
> > +	if (cfi_kunit_handled())
> > +		return BUG_TRAP_TYPE_WARN;
> 
> Somewhat ironic to make an indirect call failure do an indirect call,
> which can fail...
> 
> This is really rather horrible. Also, now all an attacker needs to do is
> ensure cfi_kunit_handled() unconditionally returns true. IOW, no distro
> must ever have this KUNIT crap enabled.

Also, if this lives, the check should at least trip the cfi_warn path,
being completely silent is terrible.

That is:

	if (cfi_warn || cfi_kunit_handled())

And then we must ensure that this warn is not suppressible by that other
kunit crud.
