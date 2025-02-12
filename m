Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3B2045A0
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399383; cv=none; b=Z8CeDNT1EBzLOWnVxa3OZb4rQG6C5rS5X+vBjM2V4UONH0E3p7KzbEfFIeHDj7jy3hIYUIADK9UYCT6D8r5QJJYJ6Q2G63yivLk6c/PouW8KLeH88YGW0qhBaF3QhsnLQd5NyKeQ5eLyNY+bn9BkcJht5VPfkGqdFVJP3mndBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399383; c=relaxed/simple;
	bh=u14zXxZrddQhoA0EF3+RMm3AJtw1p+Ficzh3nHH3VMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIF9geindNJI6g5IF3mW0uiFORPnTSrhYf3Q39MHYo5yfRAkSGSgFWSnpPjmGaRETfsbPpF98Sd1nn1H1MijrwS8NHxh0CpIy+rgUWgIhmdCZwFBiJvaUf37u01m39/WHxtte7iRHP+5Zmem+bkHmio/Yy9sDVeIP7bKy5NEtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffT86Rw1; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffT86Rw1"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5debc731ed5so611a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739399379; x=1740004179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUZLDLgZSyS5H34w7s5tClGuFz4BSLuLlXhI0ftcVy8=;
        b=ffT86Rw1dmQifms8IKJCyee4WyVKnblG3yQRvj64Ept10HCvsYKtv3y4/Vm/LXUgkr
         ZHbA3jrQoEFvbnB3183xUS+lzoQziAGFFq63aLFf6Q5gdvjNIZR9HuGVwrCQQQG2lzsh
         gdx0tZEjNLjI8f1pVrzIrgVFH0fnLHfLnfb+ZOrT/+1C7GE25n/1IWrFGmfiQw88bv07
         zi6r0dv9OOiGwET192pVXTY7NFqKOt3zm44057Dn4kHjIFDGF9LnLhAGT9Xeb4k4CsPA
         qpkCOl0yWp2KD5AdbPB2W9Jy3wXUOcoXlEBE/5ZTPGWP9CVXXws+5ur8HKK62jZHtFbT
         pbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399379; x=1740004179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUZLDLgZSyS5H34w7s5tClGuFz4BSLuLlXhI0ftcVy8=;
        b=RFVTdPHOgj6ODp5yNNH5zaIglUmsM0Y+b3qQAVLCdzG+sP+WxYBxd25uNYpyUSDYOJ
         FCtr0xAeJA7ppx3NlHHiofK35W8zPeXCdpSQHHdYPVbtEbznM9ckKZgfUJ5DXGfG89OA
         tP2kB8sy5jiCuu+kZSZoJHZYYMvKnw2afo1VepVHDoh0oshU/eItS2oOvlfb94D59iDF
         OYaUaeViPbUbSWvxx0/Ym3zDyj/eY+pqzmZdtOQUxcwIbM6/rO0KYPgfUv3PMuX6M8+q
         oD+9ZUlSdW5Q0LnL7k7aRFx5NsJn7X22Y19aw5dPZLlwpPF2sGFiFIhFOC/bw2Blvjoq
         5OEA==
X-Gm-Message-State: AOJu0Yxc0eYTcqV85NhWdtQuVSKqptESN7JvpRIwDe4y0+rAjshRtm1z
	QwIqwWRTbg5BJqtP4qjInPmcCB4QKFg3ScXnYL+CtgWcUdEfXHpqxV4D9IhjBtvvZLux0HWlLxq
	sv2jOS+PptAhrq58tPHf+j4cqUnm+79+fKzGz
X-Gm-Gg: ASbGncuNc3zLZiBIRM2dNo5f9R6OlJrEc422XQZZGcdi1HsOjBHnQZSkKzxMdTzH4Jq
	BQUrSb0J3ESvt4p5mamlgO44vU9+2r3gbLKYZGd9R59CA10P9VRxCjeqaZixO14i3PpQg2HT/jd
	lwRYdY8pzhBnsm23EYRbj65aqa
X-Google-Smtp-Source: AGHT+IE9HzW/0D+0LIgvMWCag0CLnuKcLwFnxvKuowxF1S4IixZ/FWLJ1ICmLNzlfInlph3FMECG1Nph9nbuGCV9AYY=
X-Received: by 2002:aa7:d746:0:b0:5dc:d350:7561 with SMTP id
 4fb4d7f45d1cf-5dece2bdd44mr3637a12.5.1739399379127; Wed, 12 Feb 2025 14:29:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60NwR4w/28Z7XUa@ubun>
In-Reply-To: <Z60NwR4w/28Z7XUa@ubun>
From: Jann Horn <jannh@google.com>
Date: Wed, 12 Feb 2025 23:29:02 +0100
X-Gm-Features: AWEUYZn7yZRHb75Fmnqe4YNpN5CMiwlz9aa3Zu8opsFU9DczdBisz28r6Ufyx1w
Message-ID: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>, Andy Lutomirski <luto@kernel.org>
Cc: linux-hardening@vger.kernel.org, kees@kernel.org, joao@overdrivepizza.com, 
	samitolvanen@google.com, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Andy Lutomirski (X86 entry code maintainer)

On Wed, Feb 12, 2025 at 10:08=E2=80=AFPM Jennifer Miller <jmill@asu.edu> wr=
ote:
> As part of a recently accepted paper we demonstrated that syscall
> entrypoints can be misused on x86-64 systems to generically bypass
> FineIBT/KERNEL_IBT from forwards-edge control flow hijacking. We
> communicated this finding to s@k.o before submitting the paper and were
> encouraged to bring the issue to hardening after the paper was accepted t=
o
> have a discussion on how to address the issue.
>
> The bypass takes advantage of the architectural requirement of entrypoint=
s
> to begin with the endbr64 instruction and the ability to control GS_BASE
> from userspace via wrgsbase, from to the FSGSBASE extension, in order to
> perform a stack pivot to a ROP-chain.

Oh, fun, that's a gnarly quirk.

> Here is a snippet of the 64-bit entrypoint code:
> ```
> entry_SYSCALL_64:
> <+0>:     endbr64
> <+4>:     swapgs
> <+7>:     mov    QWORD PTR gs:0x6014,rsp
> <+16>:    jmp    <entry_SYSCALL_64+36>
> <+18>:    mov    rsp,cr3
> <+21>:    nop
> <+26>:    and    rsp,0xffffffffffffe7ff
> <+33>:    mov    cr3,rsp
> <+36>:    mov    rsp,QWORD PTR gs:0x32c98
> ```
>
> This is a valid target from any indirect callsite under FineIBT due to th=
e
> endbr64 instruction and the lack of a software CFI check. After hijacking
> control flow to the entrypoint, executing swapgs will swap to the user
> controlled GS_BASE, which will be used to set the stack pointer, leading =
to
> a stack pivot. The rest of the entrypoint will execute with a hijacked
> GS_BASE on a user controlled stack. The stack page we use is one mapped i=
n
> the user address space and from another thread we race overwriting return=
s
> addresses on the stack to pivot a second time to a ROP-chain. For this to
> succeed we required a large area of user-controlled kernel memory that ca=
n
> serve as the forged GS_BASE address, we did this by spraying 2MB
> Transparent Huge Pages to fill the kernel physical memory map with
> controlled 2MB allocations and guessing relative to the base address of t=
he
> area to hit a page we control.
>
> We evaluated an approach to patching the issue in the paper but it touche=
d
> the userspace API a bit, added an error code returned by syscalls if they
> are invoked with a kernel address in GS_BASE, which is not a great
> solution.
>
> Linus provided some thoughts on how to potentially address this issue
> in our communication with s@k.o, suggesting the kernel could make the
> KERNEL_GS_BASE match the GS_BASE value so both registers always contain a
> valid kernel address and a confusion induced by executing swapgs an extra
> time cannot occur, and restore the value of KERNEL_GS_BASE ahead of
> executing swapgs in the exit path.
>
> I started working on a patch based on the approach suggested by Linus but=
 I
> haven't been able to get it passing the relevant x86 selftests yet. It
> turned out that it's more than the entrypoint code that needs to be
> modified for it to work, we need to correctly save and restore the user's
> GS_BASE across task switches and ensure it is updated correctly when set
> via arch_prctl and ptrace. Unfortunately, I lack familiarity with those
> parts of the kernel, and my understanding is that the paper will be made
> public in a couple weeks so I didn't want to delay too long on bringing t=
he
> issue to this list.
>
> Assuming this is an issue you all feel is worth addressing, I will contin=
ue
> working on providing a patch. I'm concerned though that the overhead from
> adding a wrmsr on both syscall entry and exit to overwrite and restore th=
e
> KERNEL_GS_BASE MSR may be quite high, so any feedback in regards to the
> approach or suggestions of alternate approaches to patching are welcome :=
)

Since the kernel, as far as I understand, uses FineIBT without
backwards control flow protection (in other words, I think we assume
that the kernel stack is trusted?), could we build a cheaper
check on that basis somehow? For example, maybe we could do something like:

```
endbr64
test rsp, rsp
js slowpath
swapgs
```

So we'd have the fast normal case where RSP points to userspace
(meaning we can't be coming from the kernel unless our stack has
already been pivoted, in which case forward edge protection alone
can't help anymore), and the slow case where RSP points to kernel
memory - in that case we'd then have to do some slower checks to
figure out whether weird userspace is making a syscall with RSP
pointing to the kernel, or whether we're coming from hijacked kernel
control flow.
