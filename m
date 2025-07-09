Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35291A285;
	Wed,  9 Jul 2025 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065616; cv=none; b=Q1r11vHsY21wgcrnFy65S9jPYEp7Vv8GzkUeDaV4RJ9oXy09BJiPQDfOJmO2dLsNcdQlaqyRCJJJB6Tx+ooIjwDhC6BzqbpbrxDMCIUQmbXmU6ckG0PoHxvvCcljyPvmYAife/4EI8Bvge8NxgK8JcHOARBpO0fyYvb+09HvqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065616; c=relaxed/simple;
	bh=7ZgBSHUUgA/KGLY3mSgIuEnMmqMC3guSaL+E3cU4ijU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/wuOJD3MbFtKUfHsjYzIJwAql4ijXpcOjwPcD9gtLdMW6ggCy4RZWURXuDy89DxXr8pP1Hel+pdv0ezPSB1UUSqxjLV4Opp1MulQ8X+ni8sa2WZ4pZcjPdHWWAmfvkMrG46cAmTAxQVBdPEpUsxs7h1i2TquPZueOEVfsws8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=me+mpkST; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=46CJixdF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="me+mpkST";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="46CJixdF"
Date: Wed, 9 Jul 2025 14:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752065612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8clNqNVMJuj1KlbBMK3XL98FGf5ffsp4cRxWVfag48=;
	b=me+mpkSThZKXMO7GMyF5lSe/F9EHgoLtxsq/F7rxb9Mf9/+wfAFZURIlBl4JYOjBIPMfW1
	VyqBc1dzU/f8tQp+rJGV70XbQlI7Nix8rFQpttO0LDxuk0Qu+XSjM03PRl5AYYNgAwbLpW
	ZU3xbRnFyWJKestgcpnavWU1u+/jRqov4VTrzaZRKTuau0L102VBOeWS4z+L6+iRDIsfY3
	+Kw+TlAR5jHPCZfr1fFN9XFXhOBIPwLCbO7tyVaTYhpNogG4uJ0iJWr7+fplYW1vqnHKqa
	yESehjYKvvaaMbSi7AEyRQdMO9Njw5tLoYD3iUFyZ5SByu4u9Z+FhK2HyiHObg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752065612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8clNqNVMJuj1KlbBMK3XL98FGf5ffsp4cRxWVfag48=;
	b=46CJixdF0Xo5+iL9V4VxRKCnIAQDoSUJl7DA52y3DnlGnuYM/y6JNQL2wBhH2ceeRA7p1s
	rGu9Py1gs/VinmBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <20250709144706-efda2e7c-c3e4-4905-91ad-7553c46ed2e2@linutronix.de>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com>
 <20250702202835.GA593751@ax162>
 <aG0qLaeAoTGaRs0n@pathway.suse.cz>
 <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>
 <aG5ULpdSoAR6nF5R@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG5ULpdSoAR6nF5R@pathway.suse.cz>

On Wed, Jul 09, 2025 at 01:36:14PM +0200, Petr Mladek wrote:
> On Tue 2025-07-08 16:48:47, Arnd Bergmann wrote:
> > On Tue, Jul 8, 2025, at 16:24, Petr Mladek wrote:
> > > On Wed 2025-07-02 13:28:35, Nathan Chancellor wrote:
> > >> On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
> > >
> > > Thanks a lot for the nice report.
> > >
> > > The problem is how cpumask_var_t is defined in include/linux/cpumask_types.h:
> > >
> > > #ifdef CONFIG_CPUMASK_OFFSTACK
> > > typedef struct cpumask *cpumask_var_t;
> > > #else
> > > typedef struct cpumask cpumask_var_t[1];
> > > #endif /* CONFIG_CPUMASK_OFFSTACK */
> > >
> > > And KUNIT_DEFINE_ACTION_WRAPPER() expect that the 3rd parameter
> > > is a pointer.
> > >
> > > I am going to solve this by adding a wrapper over free_cpumask_var()
> > > which would work with a pointer to cpumask_var_t.
> > 
> > I'm not familiar enough with the cleanup mechanism of kunit,
> > but can't you just move the mask allocation outside of
> > test_readerwriter()?
> 
> The only solution would be global variable.

When the cpumask is allocated on the stack, free_cpumask_var() is a no-op.
So while the stack address would be leaked to another thread,
it should be fine as nothing is ever done with it.
For more clarity it could also be gated explicitly:

if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK)) {
	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
	KUNIT_ASSERT_EQ(test, err, 0);
}

<snip>
