Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236C37A487;
	Thu, 20 Aug 2026 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240148; cv=none; b=u1ffOpAZNcsywF1E7zL4yIqBrgom07wQozoDedW+BnIt4KuUXqvmx7flC381OuSU/8iN0NsL4whltq8faF+prVEy7K4udELRnmQoFcvik3coTjjIwahjJrxFdVteGnGD1xD0x/0uH9ltBQoRu5I9r/Y1U8M61t9D+7k8OcTzOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240148; c=relaxed/simple;
	bh=v2ZdfvVE+c8VBDgC5YLyRGPciNOUQrYqWOZ2REhb+YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBs0JpANZV+F3XP5aqWWR1GHAoqOLDP9w6ro0M5X0SXaO3bt6Y94FMp3w4bWRhISwCOLpcVkovR+GwEISqMNiKK3Xwir6Vzb/LP2nPAVikOiLOzxddR8Ta3tYyP7lWdH5BVN5RsAs0sMtTgd9eps0r2Y2iU0NjVB9hR4ln3r2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kV9u1/nd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vkUK/vyJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kV9u1/nd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vkUK/vyJ"
Date: Thu, 20 Aug 2026 17:35:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787240145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+T9ZPpgIMi97gDw4k1I8pfsAVB2S1vNUsKoFuKa2Wuo=;
	b=kV9u1/nd7wDk0B3P/LZIKdRPgtn8VlaQ4eX9vjvnxoYEXnIuC3yhcQRQipQGbNU3YWTg8r
	iLX0Sh3p44huKGmLrfVvptdL+RvAbfYLiuGcmwabamU7ZdWTdH0sZrtimqpCA+KnXZ8fB7
	XKKsNxfE5haGrHiL1QH5Pl+D/Dx0BzQ5K7gdcvI5jzZOzOQa64UrwIC9BFE4/r8feDBf6+
	2YCf0Qx1cy3YYR5+UZttn92c1eZ9ZnkHArfqc5yh/OHb9Ez4bg+3ney/0XGgTGTPsTYfOi
	Xjv9C4GPUzNoYUHwsYajNepa14uSylw/Mlp5cBUsRy5FnD623upReo1lKxEsVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787240145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+T9ZPpgIMi97gDw4k1I8pfsAVB2S1vNUsKoFuKa2Wuo=;
	b=vkUK/vyJESvmU3hZAFMBiQN0S0NT34oAzLEKjCcmntr4hu/wp0kw71VhN8HZDj3tLJCidT
	ZuQI0bJ431zyCQCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 0/2] vsprintf: Don't leak pointers
Message-ID: <20260820153544.PKYwu35j@linutronix.de>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
 <20260814125647.3e10a3441ca204855b135a5e@linux-foundation.org>
 <aocdGcA6TYe5ascV@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aocdGcA6TYe5ascV@pathway.suse.cz>

On 2026-08-20 17:28:25 [+0200], Petr Mladek wrote:
> On Fri 2026-08-14 12:56:47, Andrew Morton wrote:
> > On Fri, 14 Aug 2026 16:48:52 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > 
> > > It is possible to leak pointers via %ps without KALLSYMS enabled.
> > > With KALLSYMS pointers can be leaked if they can not be resolved.
> > > 
> > > The tiny series has two patches, one for each issue.
> > > 
> > 
> > Thanks.
> > 
> > fwiw, Sashiko flagged a few possible issues:
> > 	https://sashiko.dev/#/patchset/20260814144854.746840-1-bigeasy@linutronix.de
> 
> Sashiko basically complains about that this might make
> dump_stack(), panics, and oopses useless on systems without KALLSYMS
> which is typical on embedded systems.
> 
> IMHO, it is a good point. What about using default_pointer() resp. %p
> as the fallback? It would allow to see the pointers with
> "no_hash_pointers" kernel parameter.

I didn't repost it yet. But this is what I did locally. #1 takes
no_hash_pointers into consideration and #2 is just a comment _why_ we
"leak" the actual pointer.

> Best Regards,
> Petr

Sebastian
