Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E286622;
	Fri, 24 May 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554662; cv=none; b=k8jL/qjplAwzzUntN0vtv4z4CpiSn++XJELKUXtUkgcVU/M0+H7q1FDQ3FWfjp10QA+SUPvF7WXwmVhTWsiL9AglyH3Pzshz4HouwlwQl+6acumt385gtZ7GQcuCDWJmYjrzI5798FrR3wSrDlDiVhnUJ8SL5PVFdGdYtDXrzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554662; c=relaxed/simple;
	bh=+akjN8xEx7ZjnuU29UI3tF++BPRLwXDCghjCuPkJXYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7APZoKqY5r/i0awwAtLiEimYp0BRgCnpwznpSMX2oRqGyrUBiGjrDBiRXlmRQD9IG4FrfgTZQYQPdF9Zit9XfS7kJ3lEnbgW3CzJZ+XWYMQVclhq3hPvCPRcuqgz4LprslU1/r59b1aqbyDNt4ltMX+Izgc38KNVc3tgq9Mtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0USLNg9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zm3qwWMA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0USLNg9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zm3qwWMA"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716554659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0TKtE8H0MnGIpMIfgmjmWqr87+04SmxZZt6+GpG7ZW4=;
	b=Q0USLNg9FkCK0bAbRJH/vQChKJpiOvUDzTAq6adJ0+UZ0W7hwi0munxXQUYHU14Es5wi3P
	vTv/ptZXdLqtKlIfuMvm93olHd/kL5qxt5UTEWIQJbCTUEgInmkUxId7GTYotxSiSC0ynb
	bBt/dB2ZoQyPnLA9Hq+oaiKjpJro25sy89b6FmmSxT+g3mFECPJ34CqCpGDFkccIeqBFmr
	9PWQtzyJrUOZqmIQSLnnc5eEQw1k0TERAk7flEtY788gnRTcj+IaC9WhnhXnxnCy1FpVJn
	eJx3GXlCZwjX5chX9rSokxCYDNHn6WeOzAtOxCj6QxMsuLAQUfIFoaA61jA8rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716554659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0TKtE8H0MnGIpMIfgmjmWqr87+04SmxZZt6+GpG7ZW4=;
	b=zm3qwWMAEB6bhwOW7DFXwhENPq6FNgdmtSZ6OBbWRhe76cGHKj7deScesyNnzT+7R5ZQq2
	QLr5kjqtkO6L8EBw==
To: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Nick Desaulniers
 <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
 Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
In-Reply-To: <87ed9re7i4.ffs@tglx>
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
 <87ed9re7i4.ffs@tglx>
Date: Fri, 24 May 2024 14:44:19 +0200
Message-ID: <87bk4ve5wc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 24 2024 at 14:09, Thomas Gleixner wrote:
> On Fri, May 17 2024 at 20:22, Justin Stitt wrote:
> I dug into history to find a Fixes tag. That unearthed something
> interesting.  Exactly this check used to be there until commit
> eea83d896e31 ("ntp: NTP4 user space bits update") which landed in
> 2.6.30. The change log says:
>
>     "If some values for adjtimex() are outside the acceptable range, they
>      are now simply normalized instead of letting the syscall fail."
>
> The problem with that commit is that it did not do any normalization at
> all and just relied on the actual time_maxerror handling in
> second_overflow(), which is both insufficient and also prone to that
> overflow issue.
>
> So instead of turning the clock back, we might be better off to actually
> put the normalization in place at the assignment:
>
>     time_maxerror = min(max(0, txc->maxerror), NTP_PHASE_LIMIT);
>
> or something like that.

So that commit also removed the sanity check for time_esterror, but
that's not doing anything in the kernel other than being reset in
clear_ntp() and being handed back to user space. No idea what this is
actually used for.

Thanks,

        tglx
