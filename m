Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14B1BC07C
	for <linux-hardening@vger.kernel.org>; Tue,  6 Aug 2024 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924758; cv=none; b=dUvP45uFtTXao2v2BZXqMmzy9p5ZynKo/5Bcu8yplS58hTA1N9QKou5myVkgoIpeyxzrBZMExxRGMoEB1ixn312SnKrYSatvLVaZP1lBrlxohR+PjcjxKpZTverZHl+MNCpuW9qfdx0WT+sSjFPMI2DgnFrqxyotOQX5iAxCs3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924758; c=relaxed/simple;
	bh=qce5mZJhtYvjVYZQfkajDelOTGZau1M3be6NRu3qZ8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvSZ5jtAze1BIcReo18MXsOLxC1dkzSM+37GB3oFdoMbs6ncrh5XCf75SRKSbgPBOrnwHxfOMdNnYpFZ+XYvUrAdjhoMZP5PBIE/V6qfHVEKivM2vbPffPZp7Op+YFkZpsCUoxuiBDbfYPQZn9ZfkWyW1HGnuSjHvoejf3iFYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjLjxX6H; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjLjxX6H"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a83a968ddso27598166b.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722924755; x=1723529555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oe/++WbT5JCTjuLcySOvVagtjG6ipC3Bj/V+9VSMeqM=;
        b=gjLjxX6HS2CUlQMw78qKMl32clI7aYRyBNLQMp8/cZvoIHJuwVvrzYxku/fD5yDVSW
         ixIOlHrA0t+jrvt+wAiRwSvBzNOJVWyiSAjz9brWU7ZAjFIDz9KHbUQXm79S3/zkYhb6
         /aFtGOWUeJ+i7ebR0eysiBptyKw54cz36WNP6SB5BLAHLz40myxp169jyhUhdRCwxhcx
         80kfExMduFrefk6P6jw0jIiGj20t7ZihFQ5IFL/uLOQfQTQ7KhTYLF5wt1/WPBTPvdI1
         wBXc+ERs95h6uFLcKcrodFzvG2HXbBgLx6wHoE+yjv4q+ALnclMZLvr27far8AdKLoJ0
         HMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722924755; x=1723529555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oe/++WbT5JCTjuLcySOvVagtjG6ipC3Bj/V+9VSMeqM=;
        b=pys6SVBY+cjr2bhClOT3igVshL4qb8iX0huBUqJ/VnPn+7rHUtrifFhCGyijCGNiEf
         +BbpOPpr8JMb8Qt2PxX84z+V1H98i3F/sJU/ePbQk4xiYFFHh+yGUlf943vhzuYZO5YS
         kNrttGC533+dukzNv5oSsHOMP3GK0N9IphIEpRESDqoYiTBozuR4gmxkmTecK1gn7Pkg
         d5AI8IUBz6/PIVHMVG09+UCtGOgMlqei6kdWci8gh1rxFAH4/3/dySzcgZX2+7gdNUpi
         EYrnQWdTGscWM7FtXQXxntt3MimueLBQz7N2FESDfcmUflE9AHakTW3rftGAuixgdIw2
         3o7A==
X-Gm-Message-State: AOJu0YxJSpYVWcCg1BHG8V7850Xakz8QqLxCw/jbzjFAXrwE5sMH5RN+
	WGnqumutrj2Y0TwHVRoRXhxBXene4dGXU1xdHohUKOapgLOsM68m+qnEAKu2FRyFKYJcvDXr4XB
	GsQX7WuVll33XSuu/nYHiNAGo9VazhJP5
X-Google-Smtp-Source: AGHT+IEijQcx44AqhYXmuwyxf8HLOaVXyIW6ANGWQR8bJr2ch/seab5LjYzXGkmnMLphze0cBzBTadfqzYFmF15WzbE=
X-Received: by 2002:a17:907:d92:b0:a77:dcda:1fe1 with SMTP id
 a640c23a62f3a-a7dc4fb01ddmr1083086466b.25.1722924755102; Mon, 05 Aug 2024
 23:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACBLJD=y-4aWa-7r-xhfYoTVEkQAGi2EmG3nA97rH2cz-KXmcw@mail.gmail.com>
 <202407300858.EC28E15@keescook>
In-Reply-To: <202407300858.EC28E15@keescook>
From: "Prithivi Raj.S" <prithivi.s017@gmail.com>
Date: Tue, 6 Aug 2024 11:42:23 +0530
Message-ID: <CACBLJD=_sk_Uhhvc6kwJyCA_YSFG-Bz9nAYKpUvWWLRh9ViP3w@mail.gmail.com>
Subject: Re: Unexpected Heap Randomization Behavior in Kernel Version 5.10.216
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the hint about the text randomization part. My previous
doubts have been resolved. Additionally, I used Debian 11.7 as my base
OS for testing, and it seems that the PIE build is enabled by default
in the distribution.

On Tue, 30 Jul 2024 at 21:47, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Jul 30, 2024 at 04:45:29PM +0530, Prithivi Raj.S wrote:
> > I have been testing Address Space Layout Randomization (ASLR)
> > functionalities with the kernel.randomize_va_space sysctl parameter.
> > According to the kernel documentation:
> >
> > 0 disables randomization.
> > 1 randomizes the address of mmap base, stack, and VDSO page.
> > 2 randomizes the heap address.
> >
> > However, I have observed that in kernel version 5.10.216, the heap
> > base address is being randomized even when kernel.randomize_va_space
> > is set to 1. This behavior is not the same as described for this
> > parameter.
> >
> > I tested this on an older kernel version (3.10.0) from the CentOS 7.9
> > distribution, where the feature worked as documented.
> >
> > Test Code:
> >
> > int main() {
> >     // Get the current end of the heap
> >     void *heap_addr = sbrk(0);
> >
> >     printf("Current end of heap (base address): %p\n", heap_addr);
> >
> >     return 0;
> > }
> >
> > I would like to know if this behavior indicates a kernel bug or if the
> > heap address randomization is being influenced by other factors. This
> > is my first communication with the Linux community, so please let me
> > know if there is anything inappropriate or missing in my report. I am
> > happy to provide any additional information if needed.
>
> Ignoring randomize_va_space=2 is not intended, but I suspect it may be
> related to PIE randomization (text base randomization), as the brk area
> is in a fixed position relative to the text address when not separately
> randomized, but this has the appearance of a random brk address (which
> is really showing the text address randomization).
>
> What was your base OS for the v5.10 test? I know at least Ubuntu does
> PIE builds (-pie -fPIE) by default in their compiler, and other distros
> are finally starting to catch up to them.
>
> Try this:
>
> int main() {
>         // Get the current end of the heap
>         void *heap_addr = sbrk(0);
>         void *main_addr = main;
>
>         printf("main: %p\n", main_addr);
>         printf("brk:  %p\n", heap_addr);
>         printf("main/brk offset: %lu\n",
>                 (unsigned long)heap_addr -
>                 (unsigned long)main_addr);
>
>         return 0;
> }
>
> Here's what I see:
>
> # sysctl -w kernel/randomize_va_space=2
> kernel.randomize_va_space = 2
>
> # ./test
> main: 0x5efc40341169
> brk:  0x5efc41999000
> main/brk offset: 23428759
>
> # ./test
> main: 0x5bd8d1283169
> brk:  0x5bd8d2cd8000
> main/brk offset: 27610775
>
> # sysctl -w kernel/randomize_va_space=1
> kernel.randomize_va_space = 1
>
> # ./test
> main: 0x64452def3169
> brk:  0x64452def7000
> main/brk offset: 16023
>
> # ./test
> main: 0x5dc1e726d169
> brk:  0x5dc1e7271000
> main/brk offset: 16023
>
> With randomize_va_space=2, the first 2 runs of "test" show differing
> "main" addresses, and differing main/brk offsets.
>
> With randomize_va_space=1, the next 2 runs of "test" still show the
> randomized "main" address, but unchanged main/brk offsets. (But the
> literal brk address is different between the two runs.)
>
> To turn off PIE builds, use "-no-pie":
>
> # gcc test.c -no-pie -o test
>
> # sysctl -w kernel/randomize_va_space=2
> kernel.randomize_va_space = 2
>
> # ./test
> main: 0x401156
> brk:  0x1cb6000
> main/brk offset: 25906858
>
> # ./test
> main: 0x401156
> brk:  0xe1f000
> main/brk offset: 10608298
>
> # sysctl -w kernel/randomize_va_space=1
> kernel.randomize_va_space = 1
>
> # ./test
> main: 0x401156
> brk:  0x405000
> main/brk offset: 16042
>
> # ./test
> main: 0x401156
> brk:  0x405000
> main/brk offset: 16042
>
> Without text randomization, under randomize_va_space=2, the brk
> offset (and address) are randomized. And under randomize_va_space=1,
> the brk offset (and the resulting address) are NOT randomized.
>
> Perhaps the docs for randomize_va_space need some clarification... :)
>
> -Kees
>
> --
> Kees Cook
