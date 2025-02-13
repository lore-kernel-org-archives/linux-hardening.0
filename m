Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C30205E3B
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427312; cv=none; b=go/pu48O3Fu3Xdj1WMSlouzxcS84YgUOD65lH6eDA9WAxtPlRTtIAj/fM6pzl63zISvVdg84pfD8u655cAoECmQn061mUsg5vMzvGdeUyNzXahMARLeXoI+zy9J764GyAaGoirzh0Ab6iiir2lnwGpoFGksQxy+LwZAF1G2gWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427312; c=relaxed/simple;
	bh=lryOgHxrEqjvbzXvBVu4CYThrFm2z5P6W7EZnj9HWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUG/pVluTM7/iAsKvVIkZzXrg1XB1+acqRbDXQqdfbW580KBFz1d7xrtnT1aCETTz+up94KJkgbtuf9Mt2Je3u1HfgLWOb1iRKHurrZp5QLbEvKl82oe3fMC8rvhhUgw/mShJHGnXOQKaWE7i8PAkynMF4IhNXCxkmioGuvSLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=U+70MTw/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="U+70MTw/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d132f16dso6553055ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 22:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1739427310; x=1740032110; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z4VxL/zyepaWHZgmId6GZcp34gMB2D39WAfctzQKlLI=;
        b=U+70MTw/DT3O9JvCbXCbA2PqmEkHPEwvB2f65QmAMtPVKLU8lGPuasVL9wx/lJQx2N
         Ly1LOY5tk1xuiePnhPHeIHcMTpV1oroWXHCtmwgL3w/YqZLen9+CmIug2cTRF4R6vUxr
         4NjVnmgVJ+zMEUNaP4AK+LV2C06pChUKcyoIJe8M0d6wcI4cpNzUqQI5HCmJVlUzbrD3
         uaZzFBSPhywF/qf7u06B7qfZOMr4JpgvAWZwEAth831Wkk5YJW31PHBA0KjNCG36gscm
         tmKU3DudtZfrhgoX23gbzy3q33dLf4SKIba7qG6RvgwTT+LRRfikcPxmtEBbp/3v5974
         4ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739427310; x=1740032110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4VxL/zyepaWHZgmId6GZcp34gMB2D39WAfctzQKlLI=;
        b=lMVK0edhEiD9RzouX7F4ABNIc/OApL6YJUB4iG61zMN8L8s2yTV31ER6GIjY8ghfWS
         mfDzgGbtRZkFftq/KphdpH2Qy8WiRLMWv3VCmi9hg6UXlcNktfQvv2zIQ/k2pyz/rkNj
         B3gr/mWVUEWPcYohMs4VOYgRcBmFvFLd5neeMLu8SoC8dlV8nuouKDXm9yWZfqg2nXjN
         Z7O1kzGasg0dvLHJu0Zk4xwT1MwCl8lFe2zi3b7+dDELBeneGkBDq0pa/BA1TdOcQuVb
         iZNkIDdo1nd2lR6Ae42QTLDqMctdriD7tKXlCmEGpf+NMNvCjqP/Bn9+R0/+MD3y5WXk
         dWMA==
X-Forwarded-Encrypted: i=1; AJvYcCWP1dN9fxQ2Opw0X7oDZHBe3BrRj5K1/WbVQmnM7EFPJPSv7TkhE2JLLgYJJfSYpyzBCCkt4meuk2+MfhBWtWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjr7bmA14UhNW2JsRM+TG7RLLdeOswzCF7M5oV1jdR7qNIVMP
	KYadQ9mOOhIHhacZeFkxtLXng4vCp6QrEjUFxME8dttYLcY99UHi5U2pg63heg==
X-Gm-Gg: ASbGnctXWjmPUEHkxg+ZWTjAX9uRr/cdKxPa0ktcycBDm2cHMaaJBbC5r5PBcyXY0Iu
	sWD8iXs7nUu0EuunkW5KCxTr5+ZXt1q4lI0ss9hfCqJKYvQCBN0RtNC/1pH8JrgUgY00Z5Acw8d
	V5ykGKrSB4WxFeZXnVfj0+hXUH28FXlgAmhBB9NOX67blg+o0IEqZ6zfdxDpeXg89PUe+Fqn2qU
	u2WryF9kUPClzVxIcS/qyiP+qhNEB8isOMT718e8iZ0FpxJSAzCrxTqzxPuDyg/t/9U7qrh4DsA
	0g==
X-Google-Smtp-Source: AGHT+IG9vGAydq7Mx2WbSjnNhXx0ebFUv3OwPmdgmJrDHus0XcoOuUXBvHAazFQI/32udtjzZ80UJw==
X-Received: by 2002:a17:902:e948:b0:215:b058:289c with SMTP id d9443c01a7336-220bbab33e1mr82940335ad.8.1739427309788;
        Wed, 12 Feb 2025 22:15:09 -0800 (PST)
Received: from ubun ([2600:8800:1689:e500:5937:c524:3617:55d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9757365sm2465084a91.0.2025.02.12.22.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 22:15:09 -0800 (PST)
Date: Wed, 12 Feb 2025 23:15:05 -0700
From: Jennifer Miller <jmill@asu.edu>
To: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, linux-hardening@vger.kernel.org,
	kees@kernel.org, joao@overdrivepizza.com, samitolvanen@google.com,
	kernel list <linux-kernel@vger.kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <Z62N6cGmaN+OZfoY@ubun>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>

On Wed, Feb 12, 2025 at 11:29:02PM +0100, Jann Horn wrote:
> +Andy Lutomirski (X86 entry code maintainer)
> 
> On Wed, Feb 12, 2025 at 10:08 PM Jennifer Miller <jmill@asu.edu> wrote:
> > As part of a recently accepted paper we demonstrated that syscall
> > entrypoints can be misused on x86-64 systems to generically bypass
> > FineIBT/KERNEL_IBT from forwards-edge control flow hijacking. We
> > communicated this finding to s@k.o before submitting the paper and were
> > encouraged to bring the issue to hardening after the paper was accepted to
> > have a discussion on how to address the issue.
> >
> > The bypass takes advantage of the architectural requirement of entrypoints
> > to begin with the endbr64 instruction and the ability to control GS_BASE
> > from userspace via wrgsbase, from to the FSGSBASE extension, in order to
> > perform a stack pivot to a ROP-chain.
> 
> Oh, fun, that's a gnarly quirk.

yeag :)

> Since the kernel, as far as I understand, uses FineIBT without
> backwards control flow protection (in other words, I think we assume
> that the kernel stack is trusted?), could we build a cheaper
> check on that basis somehow? For example, maybe we could do something like:
> 
> ```
> endbr64
> test rsp, rsp
> js slowpath
> swapgs
> ```
> 
> So we'd have the fast normal case where RSP points to userspace
> (meaning we can't be coming from the kernel unless our stack has
> already been pivoted, in which case forward edge protection alone
> can't help anymore), and the slow case where RSP points to kernel
> memory - in that case we'd then have to do some slower checks to
> figure out whether weird userspace is making a syscall with RSP
> pointing to the kernel, or whether we're coming from hijacked kernel
> control flow.

I've been tinkering this idea a bit and came with something.

In short, we could have the slowpath branch as you suggested, in the 
slowpath permit the stack switch and preserving of the registers on the
stack, but then do a sanity check according to the __per_cpu_offset array
and decide from there whether we should continue executing the entrypoint
or die/attempt to recover.

Here is some napkin asm for this I wrote for the 64-bit syscall entrypoint, 
I think more or less the same could be done for the other entrypoints.

```
    endbr64
    test rsp, rsp
    js slowpath

    swapgs
    ~~fastpath continues~~

; path taken when rsp was a kernel address
; we have no choice really but to switch to the stack from the untrusted
; gsbase but after doing so we have to be careful about what we put on the
; stack
slowpath:
    swapgs

; swap stacks as normal
    mov    QWORD PTR gs:[rip+0x7f005f85],rsp       # 0x6014 <cpu_tss_rw+20>
    mov    rsp,QWORD PTR gs:[rip+0x7f02c56d]       # 0x2c618 <pcpu_hot+24>

    ~~normal push and clear GPRs sequence here~~

; we entered with an rsp in the kernel address range.
; we already did swapgs but we don't know if we can trust our gsbase yet.
; we should be able to trust the ro_after_init __per_cpu_offset array
; though.

; check that gsbase is the expected value for our current cpu
    rdtscp
    mov rax, QWORD PTR [8*ecx-0x7d7be460] <__per_cpu_offset>

    rdgsbase rbx

    cmp rbx, rax
    je fastpath_after_regs_preserved

    wrgsbase rax

; if we reach here we are being exploited and should explode or attempt
; to recover
```

The unfortunate part is that it would still result in the register state
being dumped on top of some attacker controlled address, so if the error
path is recoverable someone could still use entrypoints to convert control
flow hijacking into memory corruption via register dump. So it would kill
the ability to get ROP but it would still be possible to dump regs over
modprobe_path, core_pattern, etc.

Does this seem feasible and any better than the alternative of overwriting
and restoring KERNEL_GS_BASE?

~Jennifer
