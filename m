Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF41649D9
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965076; cv=none; b=PQfK3wzXGLhSkzoM0c+X+aRwHW8suoXbh+F0gkGLrNznCC+S8i7UMYBY3D5uk2SFoeQ/ftieAToR8FaZfhgMNr3xv+SReS4vP8rUXj42ryGfNRrMfNprVwTasoVSjQi7GwuNb+eVA37PZ7GMKb2GaRokpnMCORWjfsB7b0JZLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965076; c=relaxed/simple;
	bh=c51mzqMYKT+KzfXkwENeuh6CaM8eixI6Vz7oeXPEAp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=F3luxFgRCE9U4kwkxPuVynadzFbzjEgcKi9Ch+PT2u4BBytue7b3y/sunqoOpegyg3Gm6qAnFYt6ufK4A+tt242BW0OqOQcDy2DLp0JQtLmtqcbwZIVOzxzFOZJ59/chKIib5v6XOEImrCDKKZBM86+XXtgyhi/c40HlsihHVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1716965063-1eb14e15780fae0001-PleebU
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id KiQ179UxPXisbgiN (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 29 May 2024 14:44:23 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 29 May
 2024 14:44:23 +0800
Received: from [10.32.65.162] (10.32.65.162) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Wed, 29 May
 2024 14:44:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <199ba55d-8eb8-47df-9f42-55a865b51ab7@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date: Wed, 29 May 2024 14:44:14 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-ASG-Orig-Subj: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <keescook@chromium.org>,
	<tony.luck@intel.com>, <gpiccoli@igalia.com>, <mat.jonczyk@o2.pl>,
	<rdunlap@infradead.org>, <alexandre.belloni@bootlin.com>,
	<mario.limonciello@amd.com>, <yaolu@kylinos.cn>, <bhelgaas@google.com>,
	<justinstitt@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <2553dd17-f763-4894-89b7-5f76c03d3a37@zhaoxin.com>
Content-Language: en-US
In-Reply-To: <2553dd17-f763-4894-89b7-5f76c03d3a37@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1716965063
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 8025
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125494
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/5/29 12:39, Tony W Wang-oc wrote:
> 
> 
> On 2024/5/29 06:12, Thomas Gleixner wrote:
>>
>>
>> [这封邮件来自外部发件人 谨防风险]
>>
>> On Tue, May 28 2024 at 07:18, Dave Hansen wrote:
>>> On 5/27/24 23:38, Tony W Wang-oc wrote:
>>> ...> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
>>>> index c96ae8fee95e..ecadd0698d6a 100644
>>>> --- a/arch/x86/kernel/hpet.c
>>>> +++ b/arch/x86/kernel/hpet.c
>>>> @@ -804,6 +804,12 @@ static u64 read_hpet(struct clocksource *cs)
>>>>       if (in_nmi())
>>>>               return (u64)hpet_readl(HPET_COUNTER);
>>>>
>>>> +    /*
>>>> +     * Read HPET directly if panic in progress.
>>>> +     */
>>>> +    if (unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID))
>>>> +            return (u64)hpet_readl(HPET_COUNTER);
>>>> +
>>>
>>> There is literally one other piece of the code in the kernel doing
>>> something similar: the printk() implementation.  There's no other
>>> clocksource or timekeeping code that does this on any architecture.
>>>
>>> Why doesn't this problem apply to any other clock sources?
>>
>> I principle it applies to any clocksource which needs a spinlock to
>> serialize access. HPET is not the only insanity here.
>>
>> Think about i8253 :)
>>
>> Most real clocksources, like TSC and the majority of the preferred clock
>> sources on other architectures are perfectly fine. They just read and be
>> done.
>>
>>> Why should the problem be fixed in the clock sources themselves?  Why
>>> doesn't printk() deadlock on systems using the HPET?
>>
>> Because regular printk()s are deferred to irq work when in NMI and
>> similar contexts, but that obviously does not apply to panic
>> situations. Also NMI is treated special even in the HPET code. See
>> below.
>>
>>> In other words, I think we should fix pstore to be more like printk
>>> rather than hacking around this in each clock source.
>>
>> pstore is perfectly fine. It uses a NMI safe time accessor function
>> which is then tripping over the HPET lock. That's really a HPET specific
>> problem.
>>
>> Though what I read out of the changelog is that the MCE hits the same
>> CPU 'x' which holds the lock. But that's fairy tale material as you can
>> see in the patch above:
>>
>>          if (in_nmi())
>>                  return (u64)hpet_readl(HPET_COUNTER);
>>
>> For that particular case the dead lock, which would actually be a live
>> lock, cannot happen because in kernel MCEs are NMI class exceptions and
>> therefore in_nmi() evaluates to true and that new voodoo can't be
>> reached at all.
>>
>> Now there are two other scenarios which really can make that happen:
>>
>>   1) A non-NMI class exception within the lock held region
>>
>>      CPU A
>>      acquire(hpet_lock);
>>      ...                 <- #PF, #GP, #DE, ... -> panic()
>>
>>      If any of that happens within that lock held section then the live
>>      lock on the hpet_lock is the least of your worries. Seriously, I
>>      don't care about this at all.
>>

Actually, this scenario is what this patch is trying to solve.

We encountered hpet_lock deadlock from the call path of the MCE handler,
and this hpet_lock deadlock scenario may happen when others exceptions'
handler like #PF/#GP... to call the panic. So read_hpet should avoid
deadlock if panic in progress.

Sincerely
TonyWWang-oc

>>   2) The actual scenario is:
>>
>>      CPU A                       CPU B
>>      lock(hpet_lock)
>>                                  MCE hits user space
>>                                  ...
>>                                  exc_machine_check_user()
>>                                    irqentry_enter_from_user_mode(regs);
>>
>>      irqentry_enter_from_user_mode() obviously does not mark the
>>      exception as NMI class, so in_nmi() evaluates to false. That would
>>      actually dead lock if CPU A is not making progress and releases
>>      hpet_lock.
>>
>>      Sounds unlikely to happen, right? But in reality it can because of
>>      MCE broadcast. Assume that both CPUs go into MCE:
>>
>>      CPU A                       CPU B
>>      lock(hpet_lock)
>>                                  exc_machine_check_user()
>>                                    irqentry_enter_from_user_mode();
>>      exc_machine_check_kernel()    do_machine_check()
>>        irqentry_nmi_enter();         mce_panic()
>>        do_machine_check()            if 
>> (atomic_inc_return(&mce_panicked) > 1)
>>          mce_panic()                     wait_for_panic(); <- Not taken
>>
>>          if (atomic_inc_return(&mce_panicked) > 1)
>>              wait_for_panic(); <- Taken
>>
>>                                      ....
>>                                      hpet_read()
>>
>>      -> Dead lock because in_nmi() evaluates to false on CPU B and CPU A
>>         obviously can't release the lock.
>>
> 
> Because MCE handler will call printk() before call the panic, so 
> printk() deadlock may happen in this scenario:
> 
> CPU A                            CPU B
> printk()
>    lock(console_owner_lock)
>                                   exc_machine_check_user()
>                                     irqentry_enter_from_user_mode()
> exc_machine_check_kernel()         do_machine_check()
>    irqentry_nmi_enter()               mce_panic()
>    do_machine_check()                 printk_mce()  #A
>      mce_panic()                      ...
>        wait_for_panic()               panic()
> 
> printk deadlock will happened at #A because in_nmi() evaluates to false 
> on CPU B and CPU B do not enter the panic() AT #A.
> 
> Update user space MCE handler to NMI class context is preferred?
> 
> Sincerely
> TonyWWang-oc
> 
>> So the proposed patch makes sense to some extent. But it only cures the
>> symptom. The real underlying questions are:
>>
>>    1) Should we provide a panic mode read callback for clocksources which
>>       are affected by this?
>>
>>    2) Is it correct to claim that a MCE which hits user space and ends 
>> up in
>>       mce_panic() is still just a regular exception or should we 
>> upgrade to
>>       NMI class context when we enter mce_panic() or even go as far to
>>       upgrade to NMI class context for any panic() invocation?
>>
>> #1 Solves it at the clocksource level. It still needs HPET specific
>>     changes.
>>
>> #2 Solves a whole class of issues
>>
>>     ... while potentially introducing new ones :)
>>
>>     To me upgrading any panic() invocation to NMI class context makes a
>>     lot of sense because in that case all bets are off.
>>
>>     in_nmi() is used in quite some places to avoid such problems. IOW,
>>     that would kill a whole class of issues instead of "curing" the HPET
>>     problem locally for the price of an extra conditional. Not that the
>>     extra conditional matters much if HPET is the clocksource as that's
>>     awfully slow anyway and I really don't care about that.
>>
>>     But I very much care about avoiding to sprinkle panic_cpu checks all
>>     over the place.
>>
>> Thanks,
>>
>>          tglx
