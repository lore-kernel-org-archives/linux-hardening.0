Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0042CB17;
	Mon, 31 Aug 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183027; cv=none; b=j4zeTfjey9OJ5wBE2fFSjh6efiuzKBjKfhmPl+kQTU5dd/7HputXVs2nutOC6+a65LN8MlX4Zuhe9bYCHcHm3EkAJO7Uzi6UUWW4XS+fW76R2qw7I2KTRvOuyqWJVIYmaedgft+L4T1MTz8PdI/HAxhFHfKbn+gO3+5S9VGXq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183027; c=relaxed/simple;
	bh=GpJ36QiFihR7ILzrSn52Ene7SEy6i9/ut6OVUX10yM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/jyocuaiORLSMj8RmEx81uz/F5sPTx9LlV2qmxQv7N5rC8yKcJqtfU45rRDTdsw/ODb7uauyAieWjw4i25ZSOdgLG1opRQfJXq/fnvIU60DL4xZUbt7DlP+BMBcnK0nJtjOehktua4TG1U2j1luW9O0vTzqbTzPOwdNZOtTa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9S0sHEA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLjBWjyN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9S0sHEA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLjBWjyN"
Date: Mon, 31 Aug 2026 15:30:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788183023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGuNF8qD6UqnwkTHihKqYq1cd9lNgxObqJddhRcS7Q=;
	b=E9S0sHEAR/rqboYxmQDQImgTc1cyi1TjztRchyYrKcfqXf49hbqMmE306U0eHseTaoWgvg
	kJWVM+aLOF33trW1DAMJA9vHa0IYlTmnT56EiiTeFqaoYP/z91ANoE+Fot6oUu1K9jyIuq
	c38c2cIz3zFLeYTeC3Tz4TPjkdns/BkplmAbmb/AgXzQGOCV14Blog/rIrU6muwwIetK7a
	ILhqCHAKulpyZVcLcFqaW8ikrQ+LecMnBzfz7WgoDbwOeZtgzPI5T/0TMo5v6xFnRPf3AC
	MDeuEQjc/3+961+sVkFxXfrKAlxLZI5Ti5EvDguVQBE4SRX7ed/DR08Hux9PKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788183023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGuNF8qD6UqnwkTHihKqYq1cd9lNgxObqJddhRcS7Q=;
	b=NLjBWjyNF+towU9TxmUzcgkxELcIvQyCYlvZ5RP3GywbfarxGEC3okL8hB2vLepE5dn3V/
	BkhD7r+o7FBFTMBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH v2 1/2] vsprintf: Don't leak pointers for %ps without
 KALLSYMS enabled
Message-ID: <20260831133021.PtgflU-O@linutronix.de>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-2-bigeasy@linutronix.de>
 <ao8MnDuF9nnI9KxG@pathway.suse.cz>
 <20260827091407.yUpoFiuF@linutronix.de>
 <apAIhJImGHCCPEH-@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apAIhJImGHCCPEH-@pathway.suse.cz>

On 2026-08-27 11:51:00 [+0200], Petr Mladek wrote:
> 
> I think that it is a matter of taste. I could understand that
> "(unknown)" might look more obvious to some people.
> 
> I would still prefer the hashed pointer. It make it consistent with
> %p handling. Both print addresses in this case.

For %p expect a pointer, for %pS you expect a name.

> The motivation for the hash in %p is that it is slightly more useful
> than a static string, e.g. "(address)" or "(pointer)". The hash allows
> to match the same addresses. It is not 100% reliable but better
> than nothing.

but is this helpful?

> Also the hash makes it more obvious the connection with "no_hash_pointer"
> option.

Assuming you know about the no_hash_pointer. And then you get a
randomized pointer. Enabling kallsym would be a _bigger_ help than
rebooting with no_hash_pointer.

> IMHO, the only drawback is that people might confuse the hash with
> a real value. But it is easier on 64-bit systems because the higher
> 32-bits are zeros.

That, too. Do you continue to insist on this hashed pointer output here?

> Best Regards,
> Petr

Sebastian
