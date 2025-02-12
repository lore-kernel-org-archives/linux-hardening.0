Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA119202C51
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394508; cv=none; b=hVwD2GePS1AqWlqmicHfa2GnR+9dav9HoSdB8sE8YQzo0rU9UBFF+EXFKz3LhfY7XqUryfjre30IaTb3pLNzWH0z0cTkudIewa7kUegl6cqajkqj3H7lte7KxZCH6bUMLZW/mcCneErM1I/tFG+uDHFxphslaJG+ZfH/Szu+vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394508; c=relaxed/simple;
	bh=oBHEbyM0mwNAYOptBcysBCClj9cUynogRKeXY0X3cGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PaB+uOaUXE7IJSS0Nb5zypMztpYgsaDSgahdMtObXebIHBSW2NSYXwTl3UjKlRMOogIlHRQA9O2B6HmCRgaIvtWzpHWpELMm5QztTh/SWYoHkSk5oormzetSD9XLjqN0T8Py8+/ZuoN32N+WJGfc2Gkxhro4kgWbdmdiguC7ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Y1Xm1gqz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Y1Xm1gqz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46fa7678ef3so1251241cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 13:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1739394503; x=1739999303; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEpyqshrIsJMJUGQcpc8ds+dOQtSN2E0Dna6Yd5XjFg=;
        b=Y1Xm1gqzaudspDST6JNNKpK+oxT7Lnl6qui68DBoP79xvcOzMlrKrMudBRiQgeEcw4
         F/ngna3UMRMnt2+QzlE7/IA8Xgztcd9nXedWzmJmbvvZYSG3VNGxZDRQfhYlpQcWa6dh
         MXujWrlvWQhieUFwgDB4gz//7uThEsFugTj+h2KJQo8gNDKTv8XvkDZSUudSg00ZNxsJ
         2GLr3SmXyasWwPdMms4ZvM95lQX3mt8ANd6+4KpiRrkhXiSBZNRQdKHuIyenQzJCPapV
         t691lx+fSjCwoD7Y6S6ljJdElFv05iqO/F1Dv30NzkPrP0NYcidN8xQKZ6uaDzBo8gtb
         L9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739394503; x=1739999303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEpyqshrIsJMJUGQcpc8ds+dOQtSN2E0Dna6Yd5XjFg=;
        b=BKJX4L3RTl194YgulqOeNQrA1bUAVq52zX4Bcv7J+4WC9NrospO1/a6xE3poIl0WlX
         JsZDnFFgG7tJmDCMB7DSXS4OvLRcZmj5LsiGIFUFyK7FP2J6AdOnCd3eBYhvYvWB8G9J
         JobGJOcAN3SIA83q4XuuessOKBBtbMi1t5jdsNQ8tgPFFFfiPsqS6gkKcDaxVkcTK02b
         jLDHdgc4MGMun2NF5VVU9B7qvBuT3b5z9WEolXnKxs0t1BCZseqG4fvtzeWhx/C5ZdYM
         obszSomx+1FpThXjA84zuD/lGYCAc/pnHLHWvkr54slxoSozeZA8AJL/uXoRuwwEB34P
         2tIw==
X-Gm-Message-State: AOJu0YxDQo60RccV0uiRj8TNyVxjCK7V5+wZtzX8EkNKYcWrFIuQ2Xzi
	yAqKL6zsIDZw9Ot6tmvY71XGlbOdqYWJm4RE8NhNP/oJkcPLqO5jRkxPjidoJ1MmgtohgBmr6Nk
	=
X-Gm-Gg: ASbGnct1X6bquTagBtHL59uj+LupHxVPZw327ks/ek56WRtAGZNeowOETjSmsUH2Jhw
	U7A119ao8wX6jiQXxS6YNwtlLihhJeE57sZrQCkKFb8Ji5rMxKj1mnjjxxnjojcaOFnAM3VTBPS
	GwR4vw6iBh/NFR3KAc+/d9638K93JMYLUYlm+Qr7JjfTOod+J4EV+9nkZZ87//k5CKW2R24SVwt
	AXUecuTh4C3UmqTj4SlixgDTS6uLWIh8SC1qTZVybFgSYCLjMrhv3yTGzyT/gDlzgRpQyAc+jXp
	CwkZHMBV7Jv7YhdbJQrRtQ==
X-Google-Smtp-Source: AGHT+IFmdjS6GIy63+k7lQeUx6x2X2vC/Fy6E68V8Z2o8om+8llHTfi6d2z/fbvh8bycRovtgEGaBg==
X-Received: by 2002:a05:622a:1e18:b0:471:bb6f:5799 with SMTP id d75a77b69052e-471bb6f5e49mr37272941cf.35.1739394502115;
        Wed, 12 Feb 2025 13:08:22 -0800 (PST)
Received: from ubun (129-219-8-228.nat.asu.edu. [129.219.8.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4714928d5dbsm80936621cf.24.2025.02.12.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:08:20 -0800 (PST)
Date: Wed, 12 Feb 2025 14:08:17 -0700
From: Jennifer Miller <jmill@asu.edu>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org, joao@overdrivepizza.com, samitolvanen@google.com
Subject: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <Z60NwR4w/28Z7XUa@ubun>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

As part of a recently accepted paper we demonstrated that syscall
entrypoints can be misused on x86-64 systems to generically bypass
FineIBT/KERNEL_IBT from forwards-edge control flow hijacking. We
communicated this finding to s@k.o before submitting the paper and were
encouraged to bring the issue to hardening after the paper was accepted to
have a discussion on how to address the issue.

The bypass takes advantage of the architectural requirement of entrypoints
to begin with the endbr64 instruction and the ability to control GS_BASE
from userspace via wrgsbase, from to the FSGSBASE extension, in order to
perform a stack pivot to a ROP-chain.

Here is a snippet of the 64-bit entrypoint code:
```
entry_SYSCALL_64:
<+0>:     endbr64
<+4>:     swapgs
<+7>:     mov    QWORD PTR gs:0x6014,rsp
<+16>:    jmp    <entry_SYSCALL_64+36>
<+18>:    mov    rsp,cr3
<+21>:    nop
<+26>:    and    rsp,0xffffffffffffe7ff
<+33>:    mov    cr3,rsp
<+36>:    mov    rsp,QWORD PTR gs:0x32c98
```

This is a valid target from any indirect callsite under FineIBT due to the
endbr64 instruction and the lack of a software CFI check. After hijacking
control flow to the entrypoint, executing swapgs will swap to the user
controlled GS_BASE, which will be used to set the stack pointer, leading to
a stack pivot. The rest of the entrypoint will execute with a hijacked
GS_BASE on a user controlled stack. The stack page we use is one mapped in
the user address space and from another thread we race overwriting returns
addresses on the stack to pivot a second time to a ROP-chain. For this to
succeed we required a large area of user-controlled kernel memory that can
serve as the forged GS_BASE address, we did this by spraying 2MB
Transparent Huge Pages to fill the kernel physical memory map with
controlled 2MB allocations and guessing relative to the base address of the
area to hit a page we control.

We evaluated an approach to patching the issue in the paper but it touched
the userspace API a bit, added an error code returned by syscalls if they
are invoked with a kernel address in GS_BASE, which is not a great 
solution.

Linus provided some thoughts on how to potentially address this issue
in our communication with s@k.o, suggesting the kernel could make the
KERNEL_GS_BASE match the GS_BASE value so both registers always contain a
valid kernel address and a confusion induced by executing swapgs an extra
time cannot occur, and restore the value of KERNEL_GS_BASE ahead of 
executing swapgs in the exit path.

I started working on a patch based on the approach suggested by Linus but I
haven't been able to get it passing the relevant x86 selftests yet. It 
turned out that it's more than the entrypoint code that needs to be 
modified for it to work, we need to correctly save and restore the user's 
GS_BASE across task switches and ensure it is updated correctly when set 
via arch_prctl and ptrace. Unfortunately, I lack familiarity with those 
parts of the kernel, and my understanding is that the paper will be made 
public in a couple weeks so I didn't want to delay too long on bringing the 
issue to this list.

Assuming this is an issue you all feel is worth addressing, I will continue
working on providing a patch. I'm concerned though that the overhead from 
adding a wrmsr on both syscall entry and exit to overwrite and restore the 
KERNEL_GS_BASE MSR may be quite high, so any feedback in regards to the
approach or suggestions of alternate approaches to patching are welcome :)

~Jennifer
