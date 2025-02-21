Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506B1DE896;
	Fri, 21 Feb 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128413; cv=none; b=fmMz1YKtvQnhI56YyT4FMnNuLyOxsp6ndXSPSHUpk56oW1DWJOuugABrkRaaQAuvFw+EQnYuYO4H9z8/9bNaoyQYXy3GjBAVDVpPWnkyYrz9xIoXERiSb9gw1OwxtId4OxGEjU8nqYszWZ7mWta0lUWyU12Ta1FQjk/OYEbfpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128413; c=relaxed/simple;
	bh=xkit/bBxrP/47/FJNxQVtKp/kzEycbPTUEmxxkZe/qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0y73oEW3vG3Bz+kqMZBzvw52NKPDN9NrQELUhzdb+8YG0aoVUGvSYVstQpLZrO39jsqYI+60dcfdrsHKzFiSVUK40Rf9ZXgyrWYswcdt86kct351Dj/NsO9OtrzjbCpAeUnE8vQB4lkBQYVuTBk2np/edVQSmyu7GhNai+usvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fjFRHyE+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OFsgpslr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fjFRHyE+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFsgpslr"
Date: Fri, 21 Feb 2025 10:00:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/G8u2w8Nz/6LNRqOihn9/E0oO4aWnl10a49dAoNX2lw=;
	b=fjFRHyE+thVo4Q5iFcC3ygYJmMOFVyg6DuwmklDo2Uu/mBBp03Dj4HTV+CIXGklN0JeAG2
	w9HeBnK6ZRp35pq5VJxKiQwvrJ5ayUZ+dTRQj46e4raD5blYmkvJi2lUVDSJ6vYOTwKux6
	Wfsj6pl8KrDm8dVmP5BgJGKjPNd4ktY4f8xrw98q1E6UZL5V4hCB7F1065ubf4ltY1t9yy
	WmkRvexmH6g9fuHPxxLeBP5zGsVYMW6ttLu9qrU/t6CIT//fGT0ZA/FcxpWFPH1Hzzt3Rb
	kcOQXgAkTvJLYdMXncpROhdPJqlS69G8Oylnw2SbGImSET+LtxETv/PaRE+J5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/G8u2w8Nz/6LNRqOihn9/E0oO4aWnl10a49dAoNX2lw=;
	b=OFsgpslrBT/3cxqqJfdOkE1EMygeHC3qIqcF2YoYX+56MorvTojESh7Ho87/zwdXhMGskh
	lOjDRtOfUnp3sOBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marco Elver <elver@google.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Petr Pavlu <petr.pavlu@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [linux-next:master] [x86] 66fbf67705:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <20250221090008.5aWGygvI@linutronix.de>
References: <Z7bUC9QY815Cv6nb@xsang-OptiPlex-9020>
 <20250220155722.2Z2a-3z0@linutronix.de>
 <CANpmjNN9zpcPa4S+Zq+vJWJ3EcO0zCZJ=Z4FgNzDRXdi0YQA9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNN9zpcPa4S+Zq+vJWJ3EcO0zCZJ=Z4FgNzDRXdi0YQA9g@mail.gmail.com>

On 2025-02-20 17:30:22 [+0100], Marco Elver wrote:
> > How much do we care here? Is this something that makes UBSAN + KASAN
> > folks uncomfortable? Or is lockdep slowing things down anyway?
> 
> Does this series from Waiman help?
> https://lore.kernel.org/all/20250213200228.1993588-4-longman@redhat.com/

I have applied

| locking/lock_events: Add locking events for rtmutex slow paths
| locking/lock_events: Add locking events for lockdep
| locking/lockdep: Disable KASAN instrumentation of lockdep.c
| locking/lockdep: Add kasan_check_byte() check in lock_acquire()

and with this I am down to:

| ~# time ./hardware_disable_test
| Random seed: 0x6b8b4567
| 
| real    0m29.517s
| user    0m0.493s
| sys     0m10.891s

Which is the pre-RCU case. Yes, the series from Waiman helps. This is my
favorite solution.

Sebastian
