Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78A913DDA1;
	Tue, 28 May 2024 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716934368; cv=none; b=d6krU/cLQRfbqsnAYUSIQ2QMXa3iWMmic/HQRgPcfLVmm+p0FhltNJYO99KW0F3+3xFsI+W5pK5kbKqUuNZ208WdVRDG194Syn979uqJTI12AEEkGDD+hzgrgtQOCtG7C5lVmUqnP8MbGIn8ZYAjl4Dcktskpc0FffGp8TW5AFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716934368; c=relaxed/simple;
	bh=1hLjs6HYpgIThhhT9gGLIDRvVYnA1jimJtxl/FXjhzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lh29IKxvkF9yG6EGNTPToN2I+szaKEmquXXXbO/macn/TiIKvnCjzw6+XDuAJ9M27LvOzYVYKmyWjsMO+IIqHtkn3jPNelJ6934TO+iuOCFM5g+/Gc9QuVsAZ9LddZ7edu/NgTqHARrfFtdca40ygQG3RE53upUXefNGCXg7brM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10EpJ6hN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNfAxC6G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10EpJ6hN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNfAxC6G"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716934363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZub3AKGtf3m0WqaMw01L0KFTwsMRo2LAh+Cg+JRsv0=;
	b=10EpJ6hNlROGnXgv687DoZ4wgrzIzfraguXluq2TvrA53ZzXTtjgzsRZ2ntZiDyk/sEXUR
	Nry6KMgOAzHcXuIvuzVYZcK2ArTMU644G4vdAqqpMa7EGFNWM2+ykO/VkE0EUGG+baruFQ
	uARHLnUAFKHBRj9jbK+VoQMcupN5KkiEtvvBoEv8ucRCCaVzBClfoAllvSCUD624cvx3WL
	sYSpqCgfwZ0p/Wa2yVukWBPO8bTtq1QQYE6d7jaCm9Yw/QDsmUFZaX8zF5nzOnxkDInZD3
	lwyfDDNg6YQpvUUtQYdcs4tpGO9dpGHdzYj+FURtGK+em5+saXBYVYImnLD1Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716934363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZub3AKGtf3m0WqaMw01L0KFTwsMRo2LAh+Cg+JRsv0=;
	b=YNfAxC6G+tEJE6ZRI9e2UBKdG84tVoH4nusCdtPdZV2AGpGAdsn5bo+qXBR8qrsZa1LCZY
	AFQ1L/bahS1cvKDg==
To: Dave Hansen <dave.hansen@intel.com>, Tony W Wang-oc
 <TonyWWang-oc@zhaoxin.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 mat.jonczyk@o2.pl, rdunlap@infradead.org, alexandre.belloni@bootlin.com,
 mario.limonciello@amd.com, yaolu@kylinos.cn, bhelgaas@google.com,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
In-Reply-To: <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com>
Date: Wed, 29 May 2024 00:12:43 +0200
Message-ID: <87wmnda8mc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 28 2024 at 07:18, Dave Hansen wrote:
> On 5/27/24 23:38, Tony W Wang-oc wrote:
> ...> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
>> index c96ae8fee95e..ecadd0698d6a 100644
>> --- a/arch/x86/kernel/hpet.c
>> +++ b/arch/x86/kernel/hpet.c
>> @@ -804,6 +804,12 @@ static u64 read_hpet(struct clocksource *cs)
>>  	if (in_nmi())
>>  		return (u64)hpet_readl(HPET_COUNTER);
>>  
>> +	/*
>> +	 * Read HPET directly if panic in progress.
>> +	 */
>> +	if (unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID))
>> +		return (u64)hpet_readl(HPET_COUNTER);
>> +
>
> There is literally one other piece of the code in the kernel doing
> something similar: the printk() implementation.  There's no other
> clocksource or timekeeping code that does this on any architecture.
>
> Why doesn't this problem apply to any other clock sources?

I principle it applies to any clocksource which needs a spinlock to
serialize access. HPET is not the only insanity here.

Think about i8253 :)

Most real clocksources, like TSC and the majority of the preferred clock
sources on other architectures are perfectly fine. They just read and be
done.

> Why should the problem be fixed in the clock sources themselves?  Why
> doesn't printk() deadlock on systems using the HPET?

Because regular printk()s are deferred to irq work when in NMI and
similar contexts, but that obviously does not apply to panic
situations. Also NMI is treated special even in the HPET code. See
below.

> In other words, I think we should fix pstore to be more like printk
> rather than hacking around this in each clock source.

pstore is perfectly fine. It uses a NMI safe time accessor function
which is then tripping over the HPET lock. That's really a HPET specific
problem.

Though what I read out of the changelog is that the MCE hits the same
CPU 'x' which holds the lock. But that's fairy tale material as you can
see in the patch above:

  	if (in_nmi())
  		return (u64)hpet_readl(HPET_COUNTER);

For that particular case the dead lock, which would actually be a live
lock, cannot happen because in kernel MCEs are NMI class exceptions and
therefore in_nmi() evaluates to true and that new voodoo can't be
reached at all.

Now there are two other scenarios which really can make that happen:

 1) A non-NMI class exception within the lock held region

    CPU A
    acquire(hpet_lock);
    ...                 <- #PF, #GP, #DE, ... -> panic()

    If any of that happens within that lock held section then the live
    lock on the hpet_lock is the least of your worries. Seriously, I
    don't care about this at all.

 2) The actual scenario is:

    CPU A                       CPU B
    lock(hpet_lock)
                                MCE hits user space
                                ...
                                exc_machine_check_user()
                                  irqentry_enter_from_user_mode(regs);

    irqentry_enter_from_user_mode() obviously does not mark the
    exception as NMI class, so in_nmi() evaluates to false. That would
    actually dead lock if CPU A is not making progress and releases
    hpet_lock.

    Sounds unlikely to happen, right? But in reality it can because of
    MCE broadcast. Assume that both CPUs go into MCE:

    CPU A                       CPU B
    lock(hpet_lock)
                                exc_machine_check_user()
                                  irqentry_enter_from_user_mode();
    exc_machine_check_kernel()    do_machine_check()
      irqentry_nmi_enter();         mce_panic()
      do_machine_check()            if (atomic_inc_return(&mce_panicked) > 1)
        mce_panic()                     wait_for_panic(); <- Not taken

        if (atomic_inc_return(&mce_panicked) > 1)
            wait_for_panic(); <- Taken

                                    ....
                                    hpet_read()

    -> Dead lock because in_nmi() evaluates to false on CPU B and CPU A
       obviously can't release the lock.

So the proposed patch makes sense to some extent. But it only cures the
symptom. The real underlying questions are:

  1) Should we provide a panic mode read callback for clocksources which
     are affected by this?

  2) Is it correct to claim that a MCE which hits user space and ends up in
     mce_panic() is still just a regular exception or should we upgrade to
     NMI class context when we enter mce_panic() or even go as far to
     upgrade to NMI class context for any panic() invocation?

#1 Solves it at the clocksource level. It still needs HPET specific
   changes.

#2 Solves a whole class of issues

   ... while potentially introducing new ones :)

   To me upgrading any panic() invocation to NMI class context makes a
   lot of sense because in that case all bets are off.

   in_nmi() is used in quite some places to avoid such problems. IOW,
   that would kill a whole class of issues instead of "curing" the HPET
   problem locally for the price of an extra conditional. Not that the
   extra conditional matters much if HPET is the clocksource as that's
   awfully slow anyway and I really don't care about that.

   But I very much care about avoiding to sprinkle panic_cpu checks all
   over the place.

Thanks,

        tglx
