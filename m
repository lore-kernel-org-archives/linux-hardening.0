Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879E1F94A;
	Fri,  4 Jul 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751628508; cv=none; b=oio1Gd53PUPx1pIgjdNLqnEnnVGzpSFHyq48LD/Ne3MQOqtHwl76aybGpHgdjhv9cnjVxUxOz2vCRrKxFNR8g8LhkD5Nzp3mSogRs+9KAxJGStpH4owWJls7Lw2lQclQ+EW6mPF/fVC0FNiob9olgDgZer9Wls2Ra8t4cw1pjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751628508; c=relaxed/simple;
	bh=UnmwrU3QJv4GZMxWgvZ9CpARRSyCpjfVPQ0/mJuafNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVTw7L8aa8l7xtwfjLsNKxsW+nRIlv+m3Dyw1FgDylT5ENZ0f27ScAOVsqUCcW9h9Q9HYR2WvTJ/T9CaDYoxKaru0Up0x0v4ntbYSMXAASm7LcwF5k4xUEWC2weYnkggrMjKcWqfiIN0y/GDiBCzL8LgYqzNwoakKzxr0n36J6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQh1xmeM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixbMam1Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQh1xmeM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixbMam1Z"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751628504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0LURxOcxuqwAQQqO4WfSPEKfoNEYt9GKdhYl2Q/biE=;
	b=kQh1xmeMp2qdFaP4M6OOXYXTdL0pbpi+auZzOKS5nS2dc4cDyGkizNRhelF0nC8SLgVAd/
	BfX4yITZhlpSrGQBqF6WysDFPsiId6OZAVeNOLZU1xJhfC32bRaTFtWLio3VH0b1cVFRKy
	h/xPUbZ6M0oacwr2FNmkdxSNfsGF/am1ZIge0cgA9WhP70wghLJa8lF0SQpxGKtJrNKLTh
	8ZWD9gUQbgWRj3WmfICHCPI2WrMqPpdI3AYtZEkui9KkASAELExHkmn5Ej7nhIInmCA32K
	2gY5eNoZuY5WN+b/Ya3BwLlxRMUG69o+2C1SVYHRS1qOFD/qCncaU2eD02i+XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751628504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0LURxOcxuqwAQQqO4WfSPEKfoNEYt9GKdhYl2Q/biE=;
	b=ixbMam1Z8xOq1NWaBjeqiYelhvbQuwPpRiEvZ7MRWR511SFpzNfgbyBS93dJ6e5SIoubFT
	7xV1LY6/4GmZwABA==
To: Petr Mladek <pmladek@suse.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Dan Carpenter
 <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, "Gustavo A . R .
 Silva" <gustavoars@kernel.org>, David Gow <davidgow@google.com>, Arnd
 Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Petr Mladek
 <pmladek@suse.com>
Subject: Re: [PATCH 1/3] printk: ringbuffer: Explain why the KUnit test
 ignores failed writes
In-Reply-To: <20250702095157.110916-2-pmladek@suse.com>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-2-pmladek@suse.com>
Date: Fri, 04 Jul 2025 13:34:23 +0206
Message-ID: <844ivskxew.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-02, Petr Mladek <pmladek@suse.com> wrote:
> The KUnit test ignores prb_reserve() failures on purpose. It tries
> to push the ringbuffer beyond limits.
>
> Note that it is a know problem that writes might fail in this situation.
> printk() tries to prevent this problem by:
>
>   + allocating big enough data buffer, see log_buf_add_cpu().
>
>   + allocating enough descriptors by using small enough average
>     record, see PRB_AVGBITS.
>
>   + storing the record with disabled interrupts, see vprintk_store().
>
> Also the amount of printk() messages is always somehow bound in
> practice. And they are serialized when they are printed from
> many CPUs on purpose, for example, when printing backtraces.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
