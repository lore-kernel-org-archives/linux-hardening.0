Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20214A01;
	Fri, 24 May 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591265; cv=none; b=CpJAxOYznaFmoqrk25wy9dyaQnuC1bv2q9lpBX/VsKZYyguydYQG/V7rn98IHlkD7XkrRVaQNROxLtFzeVb5swtDiGs0o5NEXaLp0jvBXl0LSk4F1/Ij+wIs5qRwJKihYpMrX8ZTRl2hIY5/BbhUNvtXF+h0aJ0Tqis6WyybsNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591265; c=relaxed/simple;
	bh=h/EU+nzRR8CEV7/SrL/+1rdRmmab8gKxvqbj51zPtmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RFKUerFcpTcA+M3vieKFI4SaoJChcq6mlvXOSIiyWGmAIBmRlviTSqo2Kr8xcHjIppO1vJk/6VisumlhGfQyR0IbMrBUfs75SpfL+RlVEXgGfokBKh4wAp3se6uo91EvWo7AEmYXhNFp0mXUt7BPH5XsRL0Sug4+xb9KXApVGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dwsL7amQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByDHtJZ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dwsL7amQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByDHtJZ+"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716591261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCMwl4CJ1P6TxmuppacIYNhDQ7TDCETZfazQEPDvVXA=;
	b=dwsL7amQZUciw1KVwOKvuBJLutl7EsVGYknVXwN+2r1vv2SG7GW/0TughWKQLuR/0A39KM
	BoXOtkXAWKha37SS1YSmGFPg5Ix49P2e5fX6066+a8lJKSPHCBmhOynVRA3D+1qdJTCmiq
	GzTm0ohZQ6mFD0kJ8XIU8Tq9cnwvIUUfFmq/c6UOvxVzjUU8zGSUGnr1hui1S0qF6s6jDZ
	MjxzpbTPpUaL54ZL+1/3/uJxCmO0hOHYV8A3Ht5nVOcmfRLe+9riNK4bCC8Qqk9Vt02gL9
	9zKSS4QUovIRkoNUtDudGp5YF/4z7TI6x19X89RjAUsP90oaAT25ZeinHtlFxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716591261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCMwl4CJ1P6TxmuppacIYNhDQ7TDCETZfazQEPDvVXA=;
	b=ByDHtJZ+kSkCCFuX3D8HZBo6eBdAno5yPFJl/Y7giV/e2hZNMp0jJgkRfNwlCrZtsOj8C+
	W3dYwM1v7abxsJCQ==
To: Justin Stitt <justinstitt@google.com>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org, Miroslav Lichvar
 <mlichvar@redhat.com>
Subject: Re: [PATCH v2] ntp: remove accidental integer wrap-around
In-Reply-To: <CAFhGd8o0eFh0sqXtOcw=E+WBaKCTatpv18fA1Pzr_M1aC9OQ=A@mail.gmail.com>
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
 <87ed9re7i4.ffs@tglx>
 <CAFhGd8o0eFh0sqXtOcw=E+WBaKCTatpv18fA1Pzr_M1aC9OQ=A@mail.gmail.com>
Date: Sat, 25 May 2024 00:54:21 +0200
Message-ID: <87le3yddnm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Justin!

On Fri, May 24 2024 at 15:43, Justin Stitt wrote:
> I appreciate you reviewing my patches.

You're welcome!

> On Fri, May 24, 2024 at 5:09=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> So instead of turning the clock back, we might be better off to actually
>> put the normalization in place at the assignment:
>>
>>     time_maxerror =3D min(max(0, txc->maxerror), NTP_PHASE_LIMIT);
>
> A saturating resolution strategy is one that I've taken with some of
> my other overflow patches.
>
> ... but how about: clamp(txc->maxerror, 0, NTP_PHASE_LIMIT)

Duh. You are right, but that's too obvious :)

Thanks,

        tglx
