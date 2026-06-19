Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB7367B8C;
	Fri, 19 Jun 2026 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861841; cv=none; b=Rq5icoyvBQeQtUkLvM40ZcNLFgGW6pRr1dgjb1up5hD+SVVeLLty2e/oppDPZB9k9wS8vA+IpaHS+BGBMuDb9lYwz9n7PE8lXItGo7i9DrWzA2fZNeGcoX9ovLSqRxKYUajYJMV0/2t/oV8haIJl1+KDtAgPG9FE5E1pJ2/+WAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861841; c=relaxed/simple;
	bh=81qEHj8pLLERwbbg01FXkerCJcJRgNumawmMgfLIIlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnffZAJYekhzy7xfKsvOgXgX4e+KwPOyW8+pTmRh113+JvFJUk2PDuaTf6rbhBuooXJXDidkRBQhkPz0Sdjtkq0SDIoEHvcjQTqIGP5g2nrs8D0EuUExcpFWIznhFmcpzUxg1RBHfFdgzoGsBEsWpew/g+a19pm6tST5BceBsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kt9kYdBO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kt9kYdBO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J/MyHustVI42pP5Sdz2Cg6K2vKaRuVuA88DNvJoFljI=; b=Kt9kYdBOoAX6nsB3VArcTWDhq5
	E8yUlH7OBcfk5lDmLBdatTMH8fiV1hmj0wCb/NoZCjuEaHNUHmuYerzNikgWbPFc2fcvs8Hv8IenM
	s3SP0bnvbuo5rVCoodlI1RgTswI8uOvTXNXtdrmeBn55Bai6VtTysa13AmBOUrMO5SB+qDxs1bEOI
	KcvhMCtErchT4DaUIL6LO7m0hTSH3N+f3kkqGWtol+3sBMKu3RUenheJDon04eyVBYX5a73KvrG+R
	hN0AP0Lo5/vkHDfS61icYYWjt6diKfeT1mK8oG7vbF9q80/jilhZ8pkLnngbNbx0DYYNbFwGwX/yu
	2f4XdmOg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1waVew-0000000ELpP-1LhH;
	Fri, 19 Jun 2026 09:37:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 120D2300578; Fri, 19 Jun 2026 11:37:08 +0200 (CEST)
Date: Fri, 19 Jun 2026 11:37:08 +0200
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
Message-ID: <20260619093708.GT49951@noisy.programming.kicks-ass.net>
References: <20260618210946.it.538-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618210946.it.538-kees@kernel.org>

On Thu, Jun 18, 2026 at 02:09:50PM -0700, Kees Cook wrote:

> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 4dad04ead06c..8cb6a274c865 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -8,12 +8,61 @@
>  #include <linux/bpf.h>
>  #include <linux/cfi_types.h>
>  #include <linux/cfi.h>
> +#include <linux/rcupdate.h>
>  
>  bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
>  
> +#if IS_ENABLED(CONFIG_CFI_KUNIT_TEST)
> +static bool (*cfi_kunit_failure_hook)(void);
> +
> +void cfi_kunit_set_failure_hook(bool (*hook)(void))
> +{
	BUG_ON(cfi_kunit_failure_hook);
> +	WRITE_ONCE(cfi_kunit_failure_hook, hook);
> +
> +	/*
> +	 * On unregister, wait for any in-flight cfi_kunit_handled() caller to
> +	 * finish before the (possibly module-resident) hook can be freed.
> +	 */
> +	if (!hook)
> +		synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(cfi_kunit_set_failure_hook);
EXPORT_SYMBOL_FOR_MODULES(cfi_kunit_set_failure_hook, "cfi_kunit")

> +static bool cfi_kunit_handled(void)
> +{
> +	bool (*hook)(void);
> +	bool handled = false;
> +
> +	/*
> +	 * Runs in CFI trap context (NMI-like on some arches); RCU is watching
> +	 * by this point, and the read-side section pairs with the
> +	 * synchronize_rcu() on unregister to keep the hook alive across the
> +	 * call.
> +	 */
> +	rcu_read_lock();
> +	hook = READ_ONCE(cfi_kunit_failure_hook);
> +	if (hook)
> +		handled = hook();
> +	rcu_read_unlock();
> +
> +	return handled;
> +}
> +#else
> +static inline bool cfi_kunit_handled(void) { return false; }
> +#endif
> +
>  enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
>  				      unsigned long *target, u32 type)
>  {
> +	/*
> +	 * Let a registered KUnit test consume and count its own deliberate
> +	 * violations. If it claims the failure, suppress the report and tell
> +	 * the arch handler to skip the trap and resume the thread, regardless
> +	 * of CFI_PERMISSIVE.
> +	 */
> +	if (cfi_kunit_handled())
> +		return BUG_TRAP_TYPE_WARN;

Somewhat ironic to make an indirect call failure do an indirect call,
which can fail...

This is really rather horrible. Also, now all an attacker needs to do is
ensure cfi_kunit_handled() unconditionally returns true. IOW, no distro
must ever have this KUNIT crap enabled.
