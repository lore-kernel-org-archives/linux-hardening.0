Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12619D06E
	for <linux-hardening@vger.kernel.org>; Tue,  1 Oct 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792930; cv=none; b=OYK7If/quyjHo7nctiZNgSceTzhB/HCNj4k9khnjeUXKjf/xIpxs4ypvgdF8e/0LPL6LqTtVQVUxI7uIdAhXjYiyQDBAJIonU8sRWxXLC0fmeLMvEWK4ZvearYREL0oIhR7SB+G562cX/hge+9SxJ5c9JKoKKsd9BwYzGAIQOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792930; c=relaxed/simple;
	bh=F/YLFP6/0c6drwukWFfkh31m8jzGAO9Mmmtzh7lMT/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWeOptpQYhCI4+oAzcmqJsPTyqydbk7bdSHSkFFYaCSX6Z+R/cq8BMm2uqhhUwOnOSD/3HC90kwPdlksdqCf7PuF+Yd1YlKhlQ8p5saBbX+KLUueMRw74pNp4RPPaaquj83e61gRaaI3BoKCu+NerH0XmDgC5gNj1rK0/chirI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CA3E1C0003;
	Tue,  1 Oct 2024 14:28:44 +0000 (UTC)
Message-ID: <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
Date: Tue, 1 Oct 2024 16:28:43 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
Content-Language: en-US
To: Jason Montleon <jmontleo@redhat.com>, Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-riscv@lists.infradead.org
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
 <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org>
 <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
 <202409221511.9AF49BD@keescook>
 <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
 <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org>
 <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Jason,

On 25/09/2024 16:32, Jason Montleon wrote:
> On Tue, Sep 24, 2024 at 1:36 PM Kees Cook <kees@kernel.org> wrote:
>>
>>
>> On September 24, 2024 8:58:57 AM PDT, Jason Montleon <jmontleo@redhat.com> wrote:
>>> On Sun, Sep 22, 2024 at 6:38 PM Kees Cook <kees@kernel.org> wrote:
>>>> Can you try this patch? It should avoid using the "WARN" infrastructure
>>>> (if that is the source of blocking boot), but should still provide some
>>>> detail about what tripped it up (via the "regular" pr_*() logging). And
>>>> if it boots, can you look at the log to find what it reports for the
>>>> "Wanted to write ..." line(s)?
>>>>
>>>> Thanks!
>>>>
>>>> -Kees
>>>>
>>>>
>>>> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
>>>> index 0d99bf11d260..469a3439959d 100644
>>>> --- a/include/linux/fortify-string.h
>>>> +++ b/include/linux/fortify-string.h
>>>> @@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>>>>                                           const size_t q_size,
>>>>                                           const size_t p_size_field,
>>>>                                           const size_t q_size_field,
>>>> -                                        const u8 func)
>>>> +                                        const u8 func,
>>>> +                                        const char *field)
>>>>   {
>>>>          if (__builtin_constant_p(size)) {
>>>>                  /*
>>>> @@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>>>>           * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
>>>>           */
>>>>          if (p_size_field != SIZE_MAX &&
>>>> -           p_size != p_size_field && p_size_field < size)
>>>> -               return true;
>>>> +           p_size != p_size_field && p_size_field < size) {
>>>> +               if (p_size_field == 0)
>>>> +                       pr_warn("Wanted to write %zu to a 0-sized destination: %s\n",
>>>> +                               size, field);
>>>> +               else
>>>> +                       return true;
>>>> +       }
>>>>
>>>>          return false;
>>>>   }
>>>> @@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>>>>          const size_t __q_size_field = (q_size_field);                   \
>>>>          fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,  \
>>>>                                       __q_size, __p_size_field,          \
>>>> -                                    __q_size_field, FORTIFY_FUNC_ ##op), \
>>>> +                                    __q_size_field, FORTIFY_FUNC_ ##op,\
>>>> +                                    #p " at " FILE_LINE), \
>>>>                    #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
>>>>                    __fortify_size,                                       \
>>>>                    "field \"" #p "\" at " FILE_LINE,                     \
>>>>
>>>>
>>>> --
>>>> Kees Cook
>>>>
>>> Hi Kees,
>>> Sorry for the delay in responding. Your patch also caused the system
>>> to hang booting, but I took it as inspiration to try some things.
>>> TL;DR I see these two print several times:
>>>
>>> Wanted to write 8 to a 0-sized destination: oldptr at
>>> arch/riscv/errata/thead/errata.c:185
>>> Wanted to write 28 to a 0-sized destination: oldptr at
>>> arch/riscv/errata/thead/errata.c:185
>>>
>>> Since I suspected CONFIG_ERRATA_THEAD_MAE which relies on
>>> CONFIG_RISCV_ALTERNATIVE_EARLY I suspected it is just too early for
>>> pr_*, etc. I tried trace_printk but that didn't produce any traces,
>>> and then I found a comment which makes me think we're too early for
>>> that too.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/kernel/alternative.c?h=v6.11#n214
>>>
>>> I didn't want to give up so I wrote a simple module to figure out how
>>> to use sbi_ecall and then incorporated that idea into your patch,
>>> although even that was not straightforward:
>>> https://gist.github.com/jmontleon/f3536ad70dc92bed992139ad5b266d5c
>> Oh nice work! Probably something riscv-specific needs to be wired up to the printk routines to do what you have there until printk is fully available  But that's a separate issue, I guess.
>>
>>> Full output: https://gist.github.com/jmontleon/823facff38e28b717f153e38adcfd7fe
>> Does the system boot with your patch?
> Yes. It boots fully. It also booted with trace_printk, it just didn't
> produce a trace, which again I think is expected at that stage. It
> seems as long as there are no 'normal' print attempts, pr_()*, etc. it
> works.


Hmmm I don't see what in your patch would fix your issue.

I sent a patch 
(https://lore.kernel.org/linux-riscv/20240829165048.49756-1-alexghiti@rivosinc.com/) 
that was merged in v6.11-rc7 which fixes something similar, could that 
be what fixed your problem?

The problem with this early code is that the MMU is not enabled yet and 
if your kernel is relocatable, the relocations are set "virtually" and 
then without the MMU, a call to an external function results in a 
trap...Which happens way too often, I have a few ideas to fix that, I 
need to find time to tackle this though.

I don't know FORTIFY_SOURCE, but I guess this could cause a call to an 
external function and then cause the issue I describe above right? We 
already remove all instrumentations from this early code so maybe we 
should remove FORTIFY_SOURCE too?

Thanks for digging into this,

Alex


>
>> I would guess that this line at arch/riscv/errata/thead/errata.c:168:
>>
>> void *oldptr, *altptr;
>>
>> Should be:
>>
>> u8 *oldptr, *altptr;
> I tried this, but it didn't appear to make a difference, I will try
> some more today, though I admit to being out of my element.
>
>
>
>> But maybe __ALT_PTR needs adjustment too? Hmm. I would have expected void * to have a size of SIZE_MAX here, though, so something else might be confusing the check.
>>
>>
>> --
>> Kees Cook
>>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
