Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509421BC41
	for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616908; cv=none; b=d3Oh4DiUH5SeW1QcdQZDRsbUdlzd3zsc27Rrg+MbUOiuBlvVEO9lDKtbVD74MOW1a8yP2YT1mKnYa8GgaQq7B0oqzK4bOgm3gSJhViWSPeAjwr/4I/vZ0e98Gl//KWwFMhsk4qca0+2nRtRD/XkJmVxyMgA/ixhGdYQsfes6PLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616908; c=relaxed/simple;
	bh=fRJlH7kNUSDocrzE0lEp7fqD1PYriP8xfE/k+BnbDpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDAED4V4yZ90xLNBQtlkZKAFl9hyanO+skTvYACt9wtzzG83J2gqVMDLqEKuQYbWpd3HE/WSIxumNTzzKpkXGBglgTT9tQg6fH3cTolr99t4JKdQZIl//ikMI+b9Mb8ttxLBc6A4WxKUfoTk947/+3csIEZtIwi69zGgv3ucyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=SzurFprk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="SzurFprk"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso2880175e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 16:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740616904; x=1741221704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fRJlH7kNUSDocrzE0lEp7fqD1PYriP8xfE/k+BnbDpY=;
        b=SzurFprkjBwmx+jpvt2JROZmd1UTRekQXWF5I2byZQ9UnzGNK1ShAzjekLoMkkLMxl
         E1hVNZsKffkNkm/xjrqjBXGSiRyA84hGKRiDQ+2sD8oS68q1L/pQRaTIpGlGMB8+zxMf
         nmlBx7PdwD1N2YEIJRY0MGTmEoPCtt9PU+Qws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616904; x=1741221704;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRJlH7kNUSDocrzE0lEp7fqD1PYriP8xfE/k+BnbDpY=;
        b=WZF6zgDxtB08ivEp2hmKDecO/zt5xUmuqafE0QpLxqsV0dHtrVjVmMznTs7GIJBvQS
         8XhFttciJxsy4YQps350SPjMR4igToGc9BfTlyjWVi/Ob64skiMwJ7C3I3kFBFfDP1X6
         6+2NddDsEuTciEPv3nlpDzX6xeVOQf73O97iFVfd4GoNl9Z09lqyVXqtxa0TSHI7ZqzX
         ojV7VkOuOfW7NeQRShNrb3W9vAR4LxRx2jpezwVnlRMLDr5BvfDFVgQEOISbh+R9MaVD
         2cIzZ0BmCPHc7jbmRLBmNTRjhlf1jzH6dyJZYQr4W6xRJlM50StybHx0Touf5HM+DlrN
         HnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPwbLrKsG3XzpE1ZxbMVvYf+BJBpFpoJZEzz0Jav5gGZ6Filw2w7a+et/rhk7KebeJkPAJnbatYrnsOPOkE60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6AKnrkdYjpvSNbSPAqZYsCoC5JAEfKnm4xeARxLs74uQmtqK
	v7zsqM7FDR+dGcULI18xygT+S4HFjtBHq53QMQJQ8JvkxUmGmT9r5kEsM3zJkzs=
X-Gm-Gg: ASbGnctHMtV6D2xXEuqrEaQsxAi6Huxp1MBhwZXqDvSb/YPPDOLcWpu7+dFkYvT38cH
	Gc17xR4xNb+G0AZBoLLezZsg///dxIXlpnUpGnHRG/WEOz6Vi09VOfKr4wrtohvp1w+F5WKgi8H
	dNej9k0RWcEwccKQNWZSgLP0hpDUteiH7VSEEIVXI+ZATaXDZ94PmrO8/Pe1n4dEdIg5r2nd1zJ
	4hB6Jh/32bnZkl33nKAZEVzN2J8FP8xzCwwewnrqGH5Q122mNE26JUF2imgaABfxkwCytiKq9TC
	4flh6ciTlPXVkwI0EAEkcdpoEeFn28JJNs0QSZS7NJjjUxNPJG173oW9QvsfILGToA==
X-Google-Smtp-Source: AGHT+IHWnOOPooSqF1ecS0H7RP93ExnU//NEwa08DTIJ64bwxESKVhEMTPrCU8Udzk8p/lXqS7nZIg==
X-Received: by 2002:a05:600c:21d1:b0:439:7ef0:a112 with SMTP id 5b1f17b1804b1-43b04da6fd9mr10351965e9.10.1740616904502;
        Wed, 26 Feb 2025 16:41:44 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27af83sm5300435e9.30.2025.02.26.16.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:41:43 -0800 (PST)
Message-ID: <e3f98cf1-71ff-4425-9deb-31d2ae989eac@citrix.com>
Date: Thu, 27 Feb 2025 00:41:42 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Rudolf Marek <r.marek@assembler.cz>, Jann Horn <jannh@google.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, luto@kernel.org,
 samitolvanen@google.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-hardening@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 x86 maintainers <x86@kernel.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
 <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
 <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
 <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
 <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz>
 <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
 <73ef8000-661e-47b4-a8b0-a02d3a849645@assembler.cz>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <73ef8000-661e-47b4-a8b0-a02d3a849645@assembler.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2025 10:48 pm, Rudolf Marek wrote:
> Hi Andrew,
>
> Dne 25. 02. 25 v 22:14 Andrew Cooper napsal(a):
>> As stand-in for "the reader", I'll point out that you need to add #DB to
>> that list or you're in for a rude surprise when running the x86
>> selftests.
>
> Thanks for pointing this out. I forgot about the interrupt shadow on
> SYSCALL
> and possibly some breakpoints possibilities in the kernel.

Isn't x86 lovely.  This is yet another thing fixed in FRED; a CPL change
cancels pending_dbg.

>
>>> The SYSCALL/SYSENTER startup has interrupts disabled, so it is the
>>> problem of NMI/#MC
>>> handler which would need deal with the normal case and attack case.
>>
>> Right, but in the case of the attack, regular interrupts are most likely
>> enabled too.  And writing this has just caused me to realise a
>> yet-more-fun case.
>> An interrupt hitting the syscall entry path (prior to SWAPGS) will cause
>> the interrupt handler's CPL check and conditional SWAPGS to do the wrong
>> thing and switch onto the user GS base too.  (Prior research e.g.
>> GhostRace has shown how to get an hrtimer to reliably hit an instruction
>> boundary.)
>
> I don't see it, because if attacker starts at syscall entry and
> interrupts are enabled and the interrupt happens right there the
> handler will just see proper IRET frame with %cs of kernel and will
> not perform swapgs. I will try to think about it again tomorrow I
> likely missed something.

Nope, you're correct.  I meant (after the SWAPGS).

The linear sequence of actions is:

* Follow bad fnptr to the SYSCALL entry
* SWAPGS (now on user gs)
* Interrupt. Handler sees %cs == kernel, so doesn't SWAPGS again
* Interrupt handler runs fully on user gs.

>
>> Interrupts and exceptions look at %cs in the IRET frame to judge whether
>> to SWAPGS or not (and this is one of the main things that paranoid_entry
>> does differently).  In the case of the attack, there's no IRET frame
>> pushed on the stack and the read of %cs is out-of-bounds, most likely
>> the stack frame of the function which followed the corrupt function
>> pointer.
>
> Thank you for your detailed explanation.
>
>> The SYSCALL entrypoint is simply the easiest to pivot on, but all can be
>> attacked in this manner.  Fixing only the SYSCALL entrypoint doesn't
>> improve things much.
>
> Maybe more elegant and cheap check on IDT entry "authenticity" would
> be to check for current %ss which needs to be NULL and possibly check
> the %CS on stack frame
> by checking kernel %cs and not just two CPL bits and/or perform more
> checks.
>
> Another ideas if you think it is still worth to discuss this topic:
>
> What about to use completely different %CS selector for all entry
> code? The early entry code would check the %cs selector and panic if
> it is wrong one.
>
> After swapgs dance, we need to perform far jump to normal kernel %CS,
> which might cost something.
>
> To fix the interrupt on fake entry problem, we could check in relevant
> IDT handlers that we never come from "completely different" %CS used
> above for the early entry code.

Ooh, this looks promising.

For IDT it's quite easy.  Have a separate DPL0 %cs in the GDT, and write
it into the IDT.

For SYSCALL/SYSENTER it's a little more complicated.  I think you want
to move the selectors so they don't alias __KERN_CS directly, so you can
then move back to __KERN_CS in a similar way.

Give or take paranoid_entry for the IST vectors, any entrypoint that
finds itself on __KERN_CS did not get there through the CPU loading a
new context.

It would depend on an attacker not being able to include a FAR CALL into
their exploit chain, or be able toe write the IDT.  I don't know how
reasonable that would be if we're ruling out all architectural paths not
beginning with an ENDBR, but FAR CALLs are rare in general owing to them
being dog slow in general, and an attacker who can write the IDT doesn't
need these kinds of games to pivot.

We do need at least one scratch register to check %cs.  For IDT and
SYSENTER entries, we can reasonably well spill to the stack (again, an
attacker that can modify the stack has won without playing these games),
and for SYSCALL, we can use the low part of %r11 as you already
demonstrated.

Anyone fancy doing a prototype of this?

>
> And very last idea would be to somehow persuade the Last Branch
> Recording to record exception entries only and just check it from MSR.
> But maybe it is too costly and/or not possible.

This doesn't cover all cases, I don't think.  It also won't work under
virt, where LBR isn't reliably available.  Also LBR is reasonably full
of errata, and quite slow.

Also VMX clears it unilaterally on vmexit, and at least we don't have an
ENDBR in that path to worry about.

~Andrew
