Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398B20371F
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739414535; cv=none; b=Gf5Vm++3AEQx5BSfFMnrJixl8uFH1ljEvrYD7cuXtEVrqR41z35hD1HE71csCPdfYzS4y82PLH2Gg8hct2BCYw1FUIQ/b3YXFFvUUpyqtjy4WYX545wbP7qCO11+tq3ST2gDn0nLftUkc26bbp5ldM8Ele4nJZ+Ch6jp+U9PlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739414535; c=relaxed/simple;
	bh=K2aQ3cwuV+990+3vtec95gEw4HSxZaYIFBG3XzYjQm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCP6WUeP9UNXS5ZK3wqOVgWPj70u+jyZxVl3MUapXbibzEZXYYYP6pyEvbfDCCaoKaKRyp2qOzVL75ujV6lMtnCGzUFmpJRgJ61+qVjBmk1TTRhzxJSgp0s79s6k7smkM2Vcac0ThZRsQubHYEH22lQxWdUil4Mw739q0Mhoz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=mzAxwb9c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="mzAxwb9c"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso2048505e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 18:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739414532; x=1740019332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee3D7VT2isu05jkFSM78Pj/eKelqSL1+sY1eaNmkBQE=;
        b=mzAxwb9cxSfD2hziZNprfcC1AuvdUyrNPHSHNGGOsnKU0BCqw2J4WChM6eVzYC2nKH
         M3XXH0K6sxObP2BKL54IwyITtCGML1xirkyXA32TOGzTmSYRXeCtMWJdeRv7K+4MfG8Q
         HVvfhu/zQCgKVTZts8qhysdQ+7eP93TVdtN/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739414532; x=1740019332;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ee3D7VT2isu05jkFSM78Pj/eKelqSL1+sY1eaNmkBQE=;
        b=eIuQ+fkOBw1g0h9KYa60j3W2VMdJeFiK/hckOOtIyv6YpQLmvzntjTgUqNZUq2UA42
         /9E/LfAzzkO1HhYft4+rDWx/ujOeVNtYSyKR/OgIhuxxNyy0q4ez2m81pRUB71RdOz1E
         EnfeHKehNIbF3cW5IrdblyNsOKedDqsWc3ImpmRG9c90hyXBkYGlSkaRuWnUWXbIaAFj
         4xMqjRD09aiXaMxGJhHfGq2k09mRs3ohHLYMQ0UD/QqFbIhAxMD9qzJ5IjAeTK9LdBic
         AsCOMeawCijE2CEGjTvkQv19GcSLQj9N4iEvZ7NhmUDdDAKJYO84fvYJ00yNEOUKCcmp
         Px4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhlmJpXmWSKLHLeSLl4N3T9eBSYny/POr+X+OcGe16hHlvPLSwv0CzpOOKqMe+IbciZXib1zePgDSgs+si52k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoalqAYSJjdC5Hnx6r3sZYm97JH1CBW5no65tQ2GnUUsr9fitQ
	X6WWGYMiDN2k2OAARwPBMmIu9JT/OzxDx/eSBIajg5PtRbR/BJCMw+/vUTxgZmA=
X-Gm-Gg: ASbGncvORborpmtoDHyRgEzcrYMkX7EFItJfAgJ6fYaT1Ig6TWaVtPmBRJcqzSmGast
	DEPRxHecyQ+Ox4s2YQ8UN32Z0QF8pHcGwpZ2EyJy0BSBUY7ENVnMTX/HLXyT9dAyumbl7gPS93Z
	zKTE5Tp+eUpo9wztFGvT/mv/TUsaAXKpeDYmCrTNMpkzlrMWye9GHeyGbEXUaWDW7X6hz8fZ9+C
	FaRPHRBK2H1XyRxCvFoS8SiQc4OvAJCnfU6Ug3oHuFUJg4cBJLIG35oaK4iEpLnZkAEjDgkOQnU
	CB12kM8Sk8gVKoTdEVKDxMZl8kjEbCIOpyDPV4g2DRkOgGzI28PGHw4=
X-Google-Smtp-Source: AGHT+IH3hGu5AwpJoqKdL7w+YFkCqgGVAPI86oFHC6u4KPZ+60ICstSirho6rz5s2LGI7RkyogahQA==
X-Received: by 2002:a05:600c:19c6:b0:439:4a4a:7863 with SMTP id 5b1f17b1804b1-43960ecd6b7mr7969585e9.15.1739414531935;
        Wed, 12 Feb 2025 18:42:11 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961826cd4sm4296145e9.24.2025.02.12.18.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 18:42:11 -0800 (PST)
Message-ID: <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
Date: Thu, 13 Feb 2025 02:42:10 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jann Horn <jannh@google.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, kees@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 luto@kernel.org, samitolvanen@google.com,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2025 2:09 am, Jann Horn wrote:
> On Thu, Feb 13, 2025 at 2:31 AM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>>>> Assuming this is an issue you all feel is worth addressing, I will
>>>> continue working on providing a patch. I'm concerned though that the
>>>> overhead from adding a wrmsr on both syscall entry and exit to
>>>> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
>>>> any feedback in regards to the approach or suggestions of alternate
>>>> approaches to patching are welcome :)
>>> Since the kernel, as far as I understand, uses FineIBT without
>>> backwards control flow protection (in other words, I think we assume
>>> that the kernel stack is trusted?),
>> This is fun indeed.  Linux cannot use supervisor shadow stacks because
>> the mess around NMI re-entrancy (and IST more generally) requires ROP
>> gadgets in order to function safely.  Implementing this with shadow
>> stacks active, while not impossible, is deemed to be prohibitively
>> complicated.
>>
>> Linux's supervisor shadow stack support is waiting for FRED support,
>> which fixes both the NMI re-entrancy problem, and other exceptions
>> nesting within NMIs, as well as prohibiting the use of the SWAPGS
>> instruction as FRED tries to make sure that the correct GS is always in
>> context.
>>
>> But, FRED support is slated for PantherLake/DiamondRapids which haven't
>> shipped yet, so are no use to the problem right now.
>>
>>> could we build a cheaper
>>> check on that basis somehow? For example, maybe we could do something like:
>>>
>>> ```
>>> endbr64
>>> test rsp, rsp
>>> js slowpath
>>> swapgs
>>> ```
>> I presume it's been pointed out already, but there are 3 related
>> entrypoints here.  SYSCALL64 which is discussed, SYSCALL32 and SYSENTER
>> which are related.
>>
>> But, any other IDT entry is in a similar bucket.  If we're corrupting a
>> function pointer or return address to redirect here, then the check of
>> CS(%rsp) to control the conditional SWAPGS is an OoB read in the callers
>> stack frame.
>>
>> For IDT entries, checking %rsp is reasonable, because userspace can't
>> forge a kernel-like %rsp.  However, SYSCALL64 specifically leaves %rsp
>> entirely attacker controlled (and even potentially non-canonical), so
>> I'm wondering what you hand in mind for the slowpath to truly
>> distinguish kernel context from user context?
> Hm, yeah, that seems hard - maybe the best we could do is to make sure
> that the inactive gsbase has the correct value for our CPU's kernel
> gsbase? Kinda like a paranoid_entry, except more painful because we'd
> first have to figure out a place to spill registers to before we can
> start using stuff like rdmsr... Then a function pointer overwrite
> might still turn into returning to userspace with a sysret with GPRs
> full of kernel pointers, but at least we wouldn't run off of a bogus
> gsbase anymore?

Thinking about this some more, I think it's impossible to distinguish.

One of the many sharp edges of SYSCALL (and SYSENTER for that matter) is
that they're instructions expected to be only be used by userspace, but
that be executed in supervisor too[1].  They're asymmetric with their
SYSRET (and SYSEXIT) counterparts which are CPL0 instructions that
strictly transition into CPL3.

The SYSCALL behaviour TLDR is:

    %rcx = %rip
    %r11 = %eflags
    %cs = fixed attr
    %ss = fixed attr
    %rip = MSR_LSTAR

which means that %rcx (old rip) is the only piece of state which
userspace can't feasibly forge (and therefore could distinguish a
SYSCALL from user vs kernel mode), yet if we're talking about a JOP
chain to get here, then %rcx is under attacker control too.

There are a variety of solutions to this problem that involve not using
%gs for per-cpu data.  I also expect that to be wholly unpopular and
dismissed as an approach.

~Andrew

[1] No-one back then was brave enough to design CPL3-only instructions.
