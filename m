Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB1179957;
	Wed, 29 May 2024 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970688; cv=none; b=e8NgN6K1aa4/WnHTNqrpT6CZwfk6+r8gSHKGUTRQx6ajGclqT43gdZ3Nk9AjLNjHIkdtcnJ5bU87kU8RK42OA1rfLNGRAL9rw/umskthof9lFnfzOR5eAF20kvPho0l74sSr89dxgpIYVwCWAHbangNlU4uuNzqZ1Pvo6iwrNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970688; c=relaxed/simple;
	bh=PH3g73IUBo++D2q6c/meuMRPW8F0op+ZjovpZ13rJYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FXWKv4E+BCdU/KoMXimOXIXMxjIbKMdpaTA2fburUQRRMZEAtx7DZXf77RyaVCa4rFt6ZsNf3eoa2A7HibtbLbBMudBPbsyRlmdzuX5TJM46H8s2tqTg+73AnH0vismFh276H5zrBlO9K6Yz7CNXhDug2f4DGvXemEIHeyy/nss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BoTz8w7t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LE2Cl4ZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BoTz8w7t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LE2Cl4ZK"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716970685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VisuJquPIChpxFSeuXKm3BwthCpocWOziwbjGlkW3mo=;
	b=BoTz8w7tg+5pAYB3WTkk6jnPjCzUS9z0neRfqMZHzrq9h+LZXnODAKPSUNjExMTjFrP/ce
	H9jCBY90DjR7iN/BVH4DOQ23kvwi0/pDfliMzNOhHg5+J60YMJvq9GKVSubLijrywm8KjK
	SfQVRI6Y7uXPnXipACHzqpdfosQejx6RkEpBR7Cw87JqbAaoYfcYvcyA3Sy8icnc43LzC4
	nmMAGGPgsu+Q7056MyjftnY+X0e7WXcRPs7xiNjr7/nHCwRQCgVSVESc9ey1IgtnnU8nym
	XYjh9P24bmqXuI5/zp4pyX0XHUtHntvGgzrDdMj2R3DpDgIvoBcdt71ABn6c/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716970685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VisuJquPIChpxFSeuXKm3BwthCpocWOziwbjGlkW3mo=;
	b=LE2Cl4ZKSn5lUeDv71XnuhlGbLGoUjoiAiNlV/X+VkyTc0Dm60QzyXAasSVhUphLhPtuYY
	NoynSjDEiFaegtDA==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>, Nick Desaulniers
 <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
In-Reply-To: <ZlRDoyJk2Erzje_z@localhost>
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
 <87ed9re7i4.ffs@tglx> <87bk4ve5wc.ffs@tglx> <ZlRDoyJk2Erzje_z@localhost>
Date: Wed, 29 May 2024 10:18:04 +0200
Message-ID: <8734q19glf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 10:26, Miroslav Lichvar wrote:
> On Fri, May 24, 2024 at 02:44:19PM +0200, Thomas Gleixner wrote:
>> On Fri, May 24 2024 at 14:09, Thomas Gleixner wrote:
>> > So instead of turning the clock back, we might be better off to actually
>> > put the normalization in place at the assignment:
>> >
>> >     time_maxerror = min(max(0, txc->maxerror), NTP_PHASE_LIMIT);
>> >
>> > or something like that.
>
> Yes, I think that's a better approach. Failing the system call could
> break existing applications, e.g. ntpd can be configured to accept a
> large root distance and it doesn't clamp the maxerror value, while
> updating the PLL offset in the same adjtimex() call.

Thanks for confirming. I suspected that, but the original change logs
are pretty useless in that regard.

>> So that commit also removed the sanity check for time_esterror, but
>> that's not doing anything in the kernel other than being reset in
>> clear_ntp() and being handed back to user space. No idea what this is
>> actually used for.
>
> It's a lower-bound estimate of the clock error, which applications can
> check if it's acceptable for them. I think it should be clamped too.
> It doesn't make much sense for it to be larger than the maximum error.

Ok.

> Another possible improvement of adjtimex() would be to set the UNSYNC
> flag immediately in the call if maxerror >= 16s to avoid the delay of
> up to 1 second for applications which check only that flag instead of
> the maxerror value.

That needs to be a seperate change.

Thanks,

        tglx
