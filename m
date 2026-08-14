Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48D39150E;
	Fri, 14 Aug 2026 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737410; cv=none; b=iw7mLmp6aiKPAhIzwgH4Xe8XaL6nrEG2bJmQpS/ipJvA+UlDVmztisYg7Ggt+c+HwuqLws6qzyeovjX2lVyKxNCnTfiSiRwC9qTdlFSvFxxYJjz6vVfYriGFmhKJ102NHZ+yr9LvkHCdy1q23bEfZ3nIrnVEku8r+YNj32tbTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737410; c=relaxed/simple;
	bh=MzQ1VUBbgxNAW9gLOwm9NEaScQIEvJlQNgkYZxpVWn0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n4b3SQhe3l70C1rvSSmha1sgSFLJeb8vislTSb2DWl1SoVIFeRbwNSOJ9lOhHi9ND7ZPXoQDBEm5NRxi2+TeKWxF4c1xQG4ptEOphprt3/mTwIApK9CMpwsxRexvDl+eoaeAXrBsJDJnE1QMl+D9piXT2sDLSZtRAigx9PFvD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AZcqb3i+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AZcqb3i+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595981F000E9;
	Fri, 14 Aug 2026 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786737408;
	bh=YuNGGAzC2eZf8ksSaCKBLE9s4m+Gv139JqVdt7tq24M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AZcqb3i+uPmNqx9+2kwl/U6GBWQ8k0yclngi5d9StALiJ7ubbDTWTKsq+FsQOKKcR
	 BcILgwl6JQvYjbG6CYuzoe6UVGAaRoGeYPeqg/Ne73mgATOJmSURcu3PiA+WnRxtxy
	 UBaEf0ZT7zLRDwCl2alWMmw4/UyTJKbCXHTlRHHo=
Date: Fri, 14 Aug 2026 12:56:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook
 <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 0/2] vsprintf: Don't leak pointers
Message-Id: <20260814125647.3e10a3441ca204855b135a5e@linux-foundation.org>
In-Reply-To: <20260814144854.746840-1-bigeasy@linutronix.de>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 16:48:52 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> It is possible to leak pointers via %ps without KALLSYMS enabled.
> With KALLSYMS pointers can be leaked if they can not be resolved.
> 
> The tiny series has two patches, one for each issue.
> 

Thanks.

fwiw, Sashiko flagged a few possible issues:
	https://sashiko.dev/#/patchset/20260814144854.746840-1-bigeasy@linutronix.de
