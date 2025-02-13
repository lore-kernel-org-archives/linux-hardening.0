Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5223A9AC
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481863; cv=none; b=CAKDYbvgSyNT2GP6vyt63mhxRRXG7AaSzYSZ2wCArRofHLvlRoQtdgX9z1Pi5LvvL+vYedFmiLU6Tzc0Oso1jFygVS/Yh8ODP2+i814jKZmNkj32D0SpsnhD1lQ+W52AAYvAIzmkDDpWoTsISw+8VbdKgx1xwK0+FnD7xPFANW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481863; c=relaxed/simple;
	bh=iI6C26wleg084gzew4BdYNTkld9u5dqIEvcyFmn5298=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTTC4z9k9n01y6HwUdgK+iCLbFN+pIhkoufNLLTabsbtMhjRUcafISL0tRfInkrVd/UmkPnYUKwjz4VF33WDBzu8qyBziojJgIjqe4HfKYACIZ7mkl56L7IbwBpHIrHCKuoPvdBpRCFrBJ6tMIlOhyFCgwXQG1kYQYKdECT19QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=OQs/72NF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OQs/72NF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f2cb1ba55so46996f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739481860; x=1740086660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4C1/ZT8Zanwnf3nw3IJ3sq2VeuwdAnAJQZPxh7FXkd0=;
        b=OQs/72NFdpmMjvoppiojGeUI/D8+llYBR57dcNOiAA9f4iFQqoIDsu26DLlwU9j6dR
         UPmW9R2aBeNkek+MaCQHAE614nwaarPK9zCEZW3r4nKbzyyUVOQgOd58jodpaFCRwQq1
         Pdn3bgQEy6WjUZW52BdMShkaKicVrmuaVVXMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739481860; x=1740086660;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C1/ZT8Zanwnf3nw3IJ3sq2VeuwdAnAJQZPxh7FXkd0=;
        b=QiKBhu5NNUiEEz7nGrbncsGu/gxqoe4MI9o4SpuyP+6FPqvCRmOBm4FnihJhXl1izB
         RelXnoaSy5peKF74UOh1ME6yH/0AhJBfSpdJVXwfmo8X7DZcgNxNMFh4lJn0Am6FvdkL
         33/z7LEwWMQP5Dz602sb245yaX8Phpt7VoZCv1Nnbc2wXm1mjkEYB2fPivtqKHdVITfe
         74v5t6+E8wILWdPIhIlhTCHgOkhJqX2En5ZXbGk+LoIgJw/Co6LQqruG4Y/B1j3P9mFu
         ym/WgjG3LPdAFVuxxNHebYYzMzXy6bAWUc3GrtVH1FNFzNwJs/pjWhTC6D26g47NuL9R
         Q6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVyQ1BfbgsB5vlvkjZQybfJkrKgw+bF6NMzJftc/CDNTMO8Y/pD+9ZEm7+kXkJee3U+b1Auh3WXNgkLIufmNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnA3aY5BSB+uh8G4kyNl0rnBJJDpaECrmjr5eSXiHiEwhoUmu
	zGUER+/aP3CN8zkmCnFCsDFJVvWvRJ0avSkRNCNtKo9B9mXoveMESJHZXfDP1Qo=
X-Gm-Gg: ASbGncsqofQ4VaZkhqQkACWnU4+LbU5UGY7jC4nxX7Qe6sfwe/Lk4HwCHXLVd4TkxHl
	PUfGrkVWLgJXet9STaZMOjRSRzupicGyCn8f+P6N+iec+KxsMQcsRZWjnpTlDYLNfTq8MSYX8Zl
	m46Z/PlRYW7g/Qt3qOFfDhD8dftpjsCqjSL8ArAiOOmiQGmrJR6aFqLDVT0tBHxN7dOlnI0Ny6r
	CcC3KtjoEDlt6NSxAHkdvGhCMh7y8OZlSn9acHIEAx/PhJwPiodKD76E4rkUeOs1XzgHIRldbEG
	ooim8aCuN/F+y3UKyEdYxjgoGoAwt7uzxBVSEaRhaxis4Nw+7RyE2C0=
X-Google-Smtp-Source: AGHT+IGBwzS/MNNlCwwPViJa+G8sfp4cLDzei/u3HwkccifrQNRaX0goflwqcbI5RnVxIh6MLHOibw==
X-Received: by 2002:a05:6000:186b:b0:38f:268c:75d6 with SMTP id ffacd0b85a97d-38f268c772fmr3639761f8f.26.1739481860227;
        Thu, 13 Feb 2025 13:24:20 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44b2sm2827090f8f.20.2025.02.13.13.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 13:24:19 -0800 (PST)
Message-ID: <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com>
Date: Thu, 13 Feb 2025 21:24:18 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jann Horn <jannh@google.com>, Jennifer Miller <jmill@asu.edu>
Cc: Andy Lutomirski <luto@kernel.org>, linux-hardening@vger.kernel.org,
 kees@kernel.org, joao@overdrivepizza.com, samitolvanen@google.com,
 kernel list <linux-kernel@vger.kernel.org>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2025 7:23 pm, Jann Horn wrote:
> On Thu, Feb 13, 2025 at 7:15 AM Jennifer Miller <jmill@asu.edu> wrote:
>> Here is some napkin asm for this I wrote for the 64-bit syscall entrypoint,
>> I think more or less the same could be done for the other entrypoints.
>>
>> ```
>>     endbr64
>>     test rsp, rsp
>>     js slowpath
>>
>>     swapgs
>>     ~~fastpath continues~~
>>
>> ; path taken when rsp was a kernel address
>> ; we have no choice really but to switch to the stack from the untrusted
>> ; gsbase but after doing so we have to be careful about what we put on the
>> ; stack
>> slowpath:
>>     swapgs

I'm afraid I don't follow.  By this point, both basic blocks are the
same (a single swapgs).

Malicious userspace can get onto the slowpath by loading a kernel
pointer into %rsp.  Furthermore, if the origin of this really was in the
kernel, then ...

>>
>> ; swap stacks as normal
>>     mov    QWORD PTR gs:[rip+0x7f005f85],rsp       # 0x6014 <cpu_tss_rw+20>
>>     mov    rsp,QWORD PTR gs:[rip+0x7f02c56d]       # 0x2c618 <pcpu_hot+24>

... these are memory accesses using the user %gs.  As you note a few
lines lower, %gs isn't safe at this point.

A cunning attacker can make gs:[rip+0x7f02c56d] be a read-only mapping,
at point we'll have loaded an attacker controlled %rsp, then take #PF
trying to spill %rsp into pcpu_hot, and now we're running the pagefault
handler on an attacker controlled stack and gsbase.

>>     ~~normal push and clear GPRs sequence here~~
>>
>> ; we entered with an rsp in the kernel address range.
>> ; we already did swapgs but we don't know if we can trust our gsbase yet.
>> ; we should be able to trust the ro_after_init __per_cpu_offset array
>> ; though.
>>
>> ; check that gsbase is the expected value for our current cpu
>>     rdtscp
>>     mov rax, QWORD PTR [8*ecx-0x7d7be460] <__per_cpu_offset>
>>
>>     rdgsbase rbx
>>
>>     cmp rbx, rax
>>     je fastpath_after_regs_preserved
>>
>>     wrgsbase rax

Irrespective of other things, you'll need some compatibility strategy
for the fact that RDTSCP and {RD,WR}{FS,GS}BASE cannot be used
unconditionally in 64bit mode.  It might be as simple as making FineIBT
depend on their presence to activate, but taking a #UD exception in this
path is also a priv-esc vulnerability.

While all CET-IBT capable CPUs ought to have RDTSCP/*BASE, there are
virt environments where this implication does not hold.

>>
>> ; if we reach here we are being exploited and should explode or attempt
>> ; to recover
>> ```
>>
>> The unfortunate part is that it would still result in the register state
>> being dumped on top of some attacker controlled address, so if the error
>> path is recoverable someone could still use entrypoints to convert control
>> flow hijacking into memory corruption via register dump. So it would kill
>> the ability to get ROP but it would still be possible to dump regs over
>> modprobe_path, core_pattern, etc.
> It is annoying that we (as far as I know) don't have a nice clear
> security model for what exactly CFI in the kernel is supposed to
> achieve - though I guess that's partly because in its current version,
> it only happens to protect against cases where an attacker gets a
> function pointer overwrite, but not the probably more common cases
> where the attacker (also?) gets an object pointer overwrite...
>
>> Does this seem feasible and any better than the alternative of overwriting
>> and restoring KERNEL_GS_BASE?
> The syscall entry point is a hot path; my main reason for suggesting
> the RSP check is that I'm worried about the performance impact of the
> gsbase-overwriting approach, but I don't actually have numbers on
> that. I figure a test + conditional jump is about the cheapest we can
> do...

Yeah, this is the cheapest I can think of too.  TEST+JS has been able to
macrofuse since the Core2 era.

> Do we know how many cycles wrgsbase takes, and how serializing
> is it? Sadly Agner Fog's tables don't seem to list it...

Not (architecturally) serialising, and pretty quick IIRC.  It is
microcoded, but the segment registers are renamed so it can execute
speculatively.

~Andrew

>
> How would we actually do that overwriting and restoring of
> KERNEL_GS_BASE? Would we need a scratch register for that?

