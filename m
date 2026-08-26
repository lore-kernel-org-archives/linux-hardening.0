Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC543A80C;
	Wed, 26 Aug 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755908; cv=none; b=K99rJysILAVQ6lIdoN+Tol8hU+Xtnk+8BYfzxhwJqCmcPhOEw3VyBsgSFDheQRSaieSdJNt8krb/nOoxGVnVRJ6S0C3u5ASdtc0c03FY+8qUjUf87JMeSfRNif+S4UwM2p0v3VsIZTGvmTyjFRTIh7UJ43MT2GhkQRovAJOR19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755908; c=relaxed/simple;
	bh=iiqe+im2qEFCgys9Hjopl/eW5lbQ6V585hNj0ZbOCrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFUwYtkM/BtDd3g91hpwPFyiBDz91cwKxztjn7ammaXn9XVPbcr15LaNETK+uY9zeAKE5EUo/7dirYqiTH/SMKOGGlxyR66l5qUeDZWISCV/jx36eIBL3emdqKGvqRvCdt4OVZuWLf7HXlLdPPMzYg440m2sp42zMFQECEgBcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgdqU/S5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GlLpcl5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgdqU/S5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GlLpcl5b"
Date: Wed, 26 Aug 2026 16:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787755905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03nZkMrd4NhyaNZKGwtdHqhils9/g9ozkpbtETK+F3k=;
	b=YgdqU/S5nc2EMWcYu35+kUd/MFqbRh1JxnSLviU0U6NRi/iYYyqUf3t4fa4ZG5ARhd+3Jk
	rQk58yEG2SL/Yx2MZWV4X0TSoc/7bkGRBTkg3BHSQZE7Gd2gbVw4vcamp3ouzNcCwwDSVG
	nSg+qesO/pQoMYQHsX5Wtpi0eQAREhtrWvAXu9tBSlnOdpB+oxEa8I3A+vQpGX/F+cPAmM
	Xk3dBYGuJ2jXLZ/EQ69FK4/tQ0UStohRaWmQbIcnBry6jINpI+MmfCDcwLk6gQ7o+XjyrN
	nysznA4+5mxm2XqIXqa+lzIVOW9rMg0eYGnHV07YJg6Kmb67hNYEzMtBjuAziA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787755905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03nZkMrd4NhyaNZKGwtdHqhils9/g9ozkpbtETK+F3k=;
	b=GlLpcl5baYvV395gH8z9iNAgD/f6ZVzm2GWSbRJQ3LLDPIEIiblgl5a9V7gldUxWZ18oE9
	nxGL0j0NPnLhIYDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH v2 0/2] vsprintf: Don't leak pointers
Message-ID: <20260826145144.vQDHb2bb@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821152614.2202196-1-bigeasy@linutronix.de>

On 2026-08-21 17:26:12 [+0200], To linux-kernel@vger.kernel.org wrote:
> It is possible to leak pointers via %ps without KALLSYMS enabled.
> With KALLSYMS pointers can be leaked if they can not be resolved.
> 
> The tiny series has two patches, first addresses the first issue, the
> second documents why we want to keep it that way.

sashiko is now happy
	https://sashiko.dev/#/patchset/20260821152614.2202196-1-bigeasy%40linutronix.de

It points out the "leaked if they can not be resolved" case but we can
either allow it to ease port-mortem analysis or hide it and get
complains.

Andrew?

Sebastian
