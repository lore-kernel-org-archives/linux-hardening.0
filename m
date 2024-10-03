Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2B19F421
	for <linux-hardening@vger.kernel.org>; Thu,  3 Oct 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966493; cv=none; b=mP78SkeiEqWXMGRZV/Hxv/ysffdXSxz0U3ApVPM7AGpdNHuUbbe0E8nEZzNNRbxgcpkbjYvFDMJU/nOiZxVXXSRY6N/idY2Udt/rAWVJuHqfDJQj68/behbw0R+Eo1B/dlXlRomHpMUoNo/v3m9hqEcHW4rBoxaXPUDmJGz+enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966493; c=relaxed/simple;
	bh=/4DwEZ+ACr45IflPZarQF4Ugol0X5PbJ9rDDOy4zFeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKE7T3bymk11f+OJzZF/rFnhR8I6Av6UroMvtlbU1nCbXZ+nvf2e0sWcKYaqncacJMu9b9qI+/pzr7ZnQW/luPGg1V/wOz5NVwS5XbbeK+JtR3DOoXRIRoIXUnkHAlc0tK7Oail6SG1/RuRqmah1kutlJG45vJcq7p7dHP4CZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4993CE0004;
	Thu,  3 Oct 2024 14:41:27 +0000 (UTC)
Message-ID: <f9d17698-0c74-42b7-acc8-3ca3adf3ba4d@ghiti.fr>
Date: Thu, 3 Oct 2024 16:41:26 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
To: Jason Montleon <jmontleo@redhat.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-riscv@lists.infradead.org
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
 <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org>
 <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
 <202409221511.9AF49BD@keescook>
 <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
 <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org>
 <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
 <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
 <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Jason,

On 02/10/2024 17:14, Jason Montleon wrote:
> On Tue, Oct 1, 2024 at 10:53 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Jason,
>>
>> On 25/09/2024 16:32, Jason Montleon wrote:
>>> On Tue, Sep 24, 2024 at 1:36 PM Kees Cook <kees@kernel.org> wrote:
>>>>
>>>> On September 24, 2024 8:58:57 AM PDT, Jason Montleon <jmontleo@redhat.com> wrote:
>>>>> On Sun, Sep 22, 2024 at 6:38 PM Kees Cook <kees@kernel.org> wrote:
>>>>>> Can you try this patch? It should avoid using the "WARN" infrastructure
>>>>>> (if that is the source of blocking boot), but should still provide some
>>>>>> detail about what tripped it up (via the "regular" pr_*() logging). And
>>>>>> if it boots, can you look at the log to find what it reports for the
>>>>>> "Wanted to write ..." line(s)?
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> -Kees
>>>>>>
>>>>>>
>>>>>> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
>>>>>> index 0d99bf11d260..469a3439959d 100644
>>>>>> --- a/include/linux/fortify-string.h
>>>>>> +++ b/include/linux/fortify-string.h
>>>>>> @@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>>>>>>                                            const size_t q_size,
>>>>>>                                            const size_t p_size_field,
>>>>>>                                            const size_t q_size_field,
>>>>>> -                                        const u8 func)
>>>>>> +                                        const u8 func,
>>>>>> +                                        const char *field)
>>>>>>    {
>>>>>>           if (__builtin_constant_p(size)) {
>>>>>>                   /*
>>>>>> @@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>>>>>>            * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
>>>>>>            */
>>>>>>           if (p_size_field != SIZE_MAX &&
>>>>>> -           p_size != p_size_field && p_size_field < size)
>>>>>> -               return true;
>>>>>> +           p_size != p_size_field && p_size_field < size) {
>>>>>> +               if (p_size_field == 0)
>>>>>> +                       pr_warn("Wanted to write %zu to a 0-sized destination: %s\n",
>>>>>> +                               size, field);
>>>>>> +               else
>>>>>> +                       return true;
>>>>>> +       }
>>>>>>
>>>>>>           return false;
>>>>>>    }
>>>>>> @@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>>>>>>           const size_t __q_size_field = (q_size_field);                   \
>>>>>>           fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,  \
>>>>>>                                        __q_size, __p_size_field,          \
>>>>>> -                                    __q_size_field, FORTIFY_FUNC_ ##op), \
>>>>>> +                                    __q_size_field, FORTIFY_FUNC_ ##op,\
>>>>>> +                                    #p " at " FILE_LINE), \
>>>>>>                     #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
>>>>>>                     __fortify_size,                                       \
>>>>>>                     "field \"" #p "\" at " FILE_LINE,                     \
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Kees Cook
>>>>>>
>>>>> Hi Kees,
>>>>> Sorry for the delay in responding. Your patch also caused the system
>>>>> to hang booting, but I took it as inspiration to try some things.
>>>>> TL;DR I see these two print several times:
>>>>>
>>>>> Wanted to write 8 to a 0-sized destination: oldptr at
>>>>> arch/riscv/errata/thead/errata.c:185
>>>>> Wanted to write 28 to a 0-sized destination: oldptr at
>>>>> arch/riscv/errata/thead/errata.c:185
>>>>>
>>>>> Since I suspected CONFIG_ERRATA_THEAD_MAE which relies on
>>>>> CONFIG_RISCV_ALTERNATIVE_EARLY I suspected it is just too early for
>>>>> pr_*, etc. I tried trace_printk but that didn't produce any traces,
>>>>> and then I found a comment which makes me think we're too early for
>>>>> that too.
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/alternative.c?h=v6.11#n214
>>>>>
>>>>> I didn't want to give up so I wrote a simple module to figure out how
>>>>> to use sbi_ecall and then incorporated that idea into your patch,
>>>>> although even that was not straightforward:
>>>>> https://gist.github.com/jmontleon/f3536ad70dc92bed992139ad5b266d5c
>>>> Oh nice work! Probably something riscv-specific needs to be wired up to the printk routines to do what you have there until printk is fully available  But that's a separate issue, I guess.
>>>>
>>>>> Full output: https://gist.github.com/jmontleon/823facff38e28b717f153e38adcfd7fe
>>>> Does the system boot with your patch?
>>> Yes. It boots fully. It also booted with trace_printk, it just didn't
>>> produce a trace, which again I think is expected at that stage. It
>>> seems as long as there are no 'normal' print attempts, pr_()*, etc. it
>>> works.
>>
>> Hmmm I don't see what in your patch would fix your issue.
>>
>> I sent a patch
>> (https://lore.kernel.org/linux-riscv/20240829165048.49756-1-alexghiti@rivosinc.com/)
>> that was merged in v6.11-rc7 which fixes something similar, could that
>> be what fixed your problem?
>>
> Hi Alex, Thank you for having a look.
>
> Although I narrowed it down to starting with 6.11-rc1, the first time
> I encountered this was actually with an rc7 Fedora build.
> http://riscv.rocks/koji/buildinfo?buildID=338433
>
> I also did a build from upstream 6.11.1 last night and still see the
> problem trying to boot with it this morning.
>
>> The problem with this early code is that the MMU is not enabled yet and
>> if your kernel is relocatable, the relocations are set "virtually" and
>> then without the MMU, a call to an external function results in a
>> trap...Which happens way too often, I have a few ideas to fix that, I
>> need to find time to tackle this though.
>>
>> I don't know FORTIFY_SOURCE, but I guess this could cause a call to an
>> external function and then cause the issue I describe above right? We
>> already remove all instrumentations from this early code so maybe we
>> should remove FORTIFY_SOURCE too?


So I was able to reproduce the issue on qemu by adding a few tweaks, and 
indeed we trap in __warn_printk() on a virtual address but MMU is not 
enabled yet.

The following diff though allows me to pass this failure but I can't get 
much further in the boot since the tweaks I added won't allow it, can 
you give the following a try?

diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index 8a27394851233..4913f3b3f198c 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -2,6 +2,10 @@ ifdef CONFIG_RELOCATABLE
  KBUILD_CFLAGS += -fno-pie
  endif

+ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
+KBUILD_CFLAGS += -D__NO_FORTIFY
+endif
+
  obj-$(CONFIG_ERRATA_ANDES) += andes/
  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
  obj-$(CONFIG_ERRATA_THEAD) += thead/


Thanks,

Alex


>>
> What you are describing here does not seem unreasonable to me, but I
> simply do not know enough to say one way or the other.
> Is there something I can do to collect more information to determine
> if this is the cause?
>
> Thank you again for having a look,
> Jason
>
>> Thanks for digging into this,
>>
>> Alex
>>
>>
>>>> I would guess that this line at arch/riscv/errata/thead/errata.c:168:
>>>>
>>>> void *oldptr, *altptr;
>>>>
>>>> Should be:
>>>>
>>>> u8 *oldptr, *altptr;
>>> I tried this, but it didn't appear to make a difference, I will try
>>> some more today, though I admit to being out of my element.
>>>
>>>
>>>
>>>> But maybe __ALT_PTR needs adjustment too? Hmm. I would have expected void * to have a size of SIZE_MAX here, though, so something else might be confusing the check.
>>>>
>>>>
>>>> --
>>>> Kees Cook
>>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
