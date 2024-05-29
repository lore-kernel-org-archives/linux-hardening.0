Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE379168C08;
	Wed, 29 May 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968567; cv=none; b=iKmJen3xWk8ELe1zXWgvHSgGxRkKZCj8PLWgYGZB8kCk5ptYq9NwEIUA61Yp8MwE74EPyS5ytP48bumXz7igrozxYPiI55DFPNyIxl9Yln4VE3CVTIoRG+bmHxL+CuyiEamXI8BAEaH6QQa4kcG6nsZNGq96kJNC7BmOg8JS9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968567; c=relaxed/simple;
	bh=ulWHMbKruyWR5uPQUxmckqv2wx9fqc+HKd1746aF3jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hWKfJsOEAbxVym59N+RdJcc8VaFPZK4R5MS9cwrBOUoWiNQSHFJ1CDmGlbRkNdUwDQ1eCU5F4p/s1FmrZFb5JrGguctKtb4IyNK1NjvJZwRy1qVmwgkLx9YgbuBrHpW2E//qa5pm4M41X5dBQT+VJ+/Vbv3x/Ctf3xnsUUYY58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuKNrxUu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZD7NnbKW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuKNrxUu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZD7NnbKW"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716968563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbBWiLYIihe5kRoqFun+3uFh9apRMozX/dNd6f8NMMU=;
	b=QuKNrxUuepGmOZ2niwSVrSYItCMUdCenMqs/1mSyWFN1dm/uTyCzfTF2uCB3BhV4aBUW11
	rn14dvy4nOHiT17kd4P0RJDfv5iLaVDU1HroT4UCbgjZObLkXfHTeRIDKVcKKVvcT8liHB
	ofPZ6CVsjRHbNV0ilJUzyaoheYKosc297ALX7KtwyVXRLOuarsAocjuS9INQ839vWqFY0c
	bO08YJ/FnFx1WjGmf9LLBSxpTYY6S2Km/VvUgD3kTBG9y1mvoyn3ajTwCl6hn9WEypNJ2E
	py89RJCGsAvJVh+9M6l1jcXRT1M26SGq5Y1DKy7O83petB93WxMMrmL/YXAPSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716968563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbBWiLYIihe5kRoqFun+3uFh9apRMozX/dNd6f8NMMU=;
	b=ZD7NnbKWri5Vxr5kPEurTWpN4jJfKvL9gpsP5J4mNIXdO5gQPwgNCi73wofqupUXeHNQQL
	CLKpJhHVA5ix6IDg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Tony W Wang-oc
 <TonyWWang-oc@zhaoxin.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 mat.jonczyk@o2.pl, rdunlap@infradead.org, alexandre.belloni@bootlin.com,
 mario.limonciello@amd.com, yaolu@kylinos.cn, bhelgaas@google.com,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
 LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
In-Reply-To: <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
Date: Wed, 29 May 2024 09:42:43 +0200
Message-ID: <87le3t9i8c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Tue, May 28 2024 at 16:22, Linus Torvalds wrote:
> On Tue, 28 May 2024 at 15:12, Thomas Gleixner <tglx@linutronix.de> wrote:
> I see the smiley, but yeah, I don't think we really care about it.

Indeed. But the same problem exists on other architectures as
well. drivers/clocksource alone has 4 examples aside of i8253

>>   1) Should we provide a panic mode read callback for clocksources which
>>      are affected by this?
>
> The current patch under discussion may be ugly, but looks workable.
> Local ugliness isn't necessarily a show-stopper.
>
> So if the HPET is the *only* case which has this situation, I vote for
> just doing the ugly thing.
>
> Now, if *other* cases exist, and can't be worked around in similar
> ways, then that argues for a more "proper" fix.
>
> And no, I don't think i8253 is a strong enough argument. I don't
> actually believe you can realistically find a machine that doesn't
> have HPET or the TSC and really falls back on the i8253 any more. And
> if you *do* find hw like that, is it SMP-capable? And can you find
> somebody who cares?

Probably not.

>>   2) Is it correct to claim that a MCE which hits user space and ends up in
>>      mce_panic() is still just a regular exception or should we upgrade to
>>      NMI class context when we enter mce_panic() or even go as far to
>>      upgrade to NMI class context for any panic() invocation?
>
> I do think that an NMI in user space should be considered mostly just
> a normal exception. From a kernel perspective, the NMI'ness just
> doesn't matter.

That's correct. I don't want to change that at all especially not for
recoverable MCEs.

> That said, I find your suggestion of making 'panic()' just basically
> act as an NMI context intriguing. And cleaner than the
> atomic_read(&panic_cpu) thing.
>
> Are there any other situations than this odd HPET thing where that
> would change semantics?

I need to go and stare at this some more.

Thanks,

        tglx
