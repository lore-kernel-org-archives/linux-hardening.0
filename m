Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169D482D1
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961432; cv=none; b=P/q05sXsbicStaZb7+1KCynzsYXdNQWzkv34rEA12Nd6XKCJJ8d4weXCwXo+O/4jeIAT/BZbJQikTc1u75XZBVHHGqvmRXjR4DHD5daM2fNLm2uvfS3e8KVF+YbDXLO3bBU/FhDRY6CDU2+g5F/XA5c+Gn7Rn733MlAPuqKwDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961432; c=relaxed/simple;
	bh=MzQ7DHr1+FpuZdH9Hb5BTp+Mv2zN/eGZ0T2pyoGMqW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVsogyYjthAUtoTVArBFIXfPyIboERxQRx54cg5Fr9fcM46Vbc4thfd42VAQs1TNyZ5JHa96syLM5PjF5a9S/5R0jzbI0JQFJ50kNLslJtXRXWmK89KT/PJy0PVcdvGXPEhKnYWIaORDXeHuD1zVwpCLqV5mDFfrwCDV3xrFO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TLsKLlRe; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TLsKLlRe"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-204235d0913so2095414fac.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 14:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705961429; x=1706566229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1De09a1ONpOwX9iKnxbH9ncVw4V2gLmkFQIVKMLMpk=;
        b=TLsKLlRenqShOF79JLnkpgQgzRZ/atrdOwMGa9o6fzzWbl5aRipvxhHOMtmbf7mlyT
         MkFduhJHUHvvj0wJ7QzVnL3QpMnUo4KQ9NLV1MJLQd3p0fYx1YUvpH48VktR6QYAlF5+
         OLZ7uGPeVenkSZEYMbpZFf01WlJy8tWmQr8+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705961429; x=1706566229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1De09a1ONpOwX9iKnxbH9ncVw4V2gLmkFQIVKMLMpk=;
        b=jbi29Tp0pZPisdws/MkaignzRQZXZLl/ziGDLNb4veXunNN1DOZmMgPogWSbwKLxIf
         StkMcIQ5InpOPnjEk+Dya7tnYL7tAhsBz6wY1EpttJWO8g2K/BuBuQD/j9ndtuuZJqGl
         muFwjleOIfJKZouuqyO03W+qGdhv99ESDgoE/hpvVI6OuNm8P3mBsLvNbme2kVSuX/CQ
         924N/AapcWiQvLTCgGRbM3+jWxQdW9Yy10t3VYlMc6pV6yZ/lF83Vc5Kj2R15aUGyF2j
         LCt6XJ4ElyEnC80vpqe9ZAg/ceY61V3U+8rl9L9ki3QlvzRh0VcWn9WutmUVyDrkh6rZ
         +P/Q==
X-Gm-Message-State: AOJu0Yz67rLloT54xuOi6udQ1XtWLGFADxIIsUUabHfbyb0tbwtON420
	0aif3rgkxPysI57XV0CjwWBdhPMbVzmLneHUXOB617jfUXRnWK1ohqH6YIwkPufkcu2WqzOzGiq
	6w9jaETjsDiCc+CgPhr0AP/8fp+SdZod86Pca
X-Google-Smtp-Source: AGHT+IHcyg299dW8RhR+Matblnlc5rb+jBuh+9Itmq6kqEedZQWTv9HU9MSIZbsIZt9nIEh+qA7ZWFl0NFfvqIFhDM8=
X-Received: by 2002:a05:6870:e40d:b0:214:807e:8a05 with SMTP id
 n13-20020a056870e40d00b00214807e8a05mr474569oag.2.1705961429485; Mon, 22 Jan
 2024 14:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122152905.2220849-1-jeffxu@chromium.org> <726.1705938579@cvs.openbsd.org>
In-Reply-To: <726.1705938579@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 22 Jan 2024 14:10:17 -0800
Message-ID: <CABi2SkXrnUZsWvpqS61mHw-SqDBOodqpcfjdoTTyeeYG9tRJGA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce mseal()
To: Theo de Raadt <deraadt@openbsd.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 7:49=E2=80=AFAM Theo de Raadt <deraadt@openbsd.org>=
 wrote:
>
> Regarding these pieces
>
> > The PROT_SEAL bit in prot field of mmap(). When present, it marks
> > the map sealed since creation.
>
> OpenBSD won't be doing this.  I had PROT_IMMUTABLE as a draft.  In my
> research I found basically zero circumstances when you userland does
> that.  The most common circumstance is you create a RW mapping, fill it,
> and then change to a more restrictve mapping, and lock it.
>
> There are a few regions in the addressspace that can be locked while RW.
> For instance, the stack.  But the kernel does that, not userland.  I
> found regions where the kernel wants to do this to the address space,
> but there is no need to export useless functionality to userland.
>
I have a feeling that most apps that need to use mmap() in their code
are likely using RW mappings. Adding sealing to mmap() could stop
those mappings from being executable. Of course, those apps would
need to change their code. We can't do it for them.

Also, I believe adding this to mmap() has no downsides, only
performance gain, as Pedro Falcato pointed out in [1].

[1] https://lore.kernel.org/lkml/CAKbZUD2A+=3Dbp_sd+Q0Yif7NJqMu8p__eb4yguq0=
agEcmLH8SDQ@mail.gmail.com/

> OpenBSD now uses this for a high percent of the address space.  It might
> be worth re-reading a description of the split of responsibility regardin=
g
> who locks different types of memory in a process;
> - kernel (the majority, based upon what ELF layout tell us),
> - shared library linker (the next majority, dealing with shared
>   library mappings and left-overs not determinable at kernel time),
> - libc (a small minority, mostly regarding forced mutable objects)
> - and the applications themselves (only 1 application today)
>
>     https://lwn.net/Articles/915662/
>
> > The MAP_SEALABLE bit in the flags field of mmap(). When present, it mar=
ks
> > the map as sealable. A map created without MAP_SEALABLE will not suppor=
t
> > sealing, i.e. mseal() will fail.
>
> We definately won't be doing this.  We allow a process to lock any and al=
l
> it's memory that isn't locked already, even if it means it is shooting
> itself in the foot.
>
> I think you are going to severely hurt the power of this mechanism,
> because you won't be able to lock memory that has been allocated by a
> different callsite not under your source-code control which lacks the
> MAP_SEALABLE flag.  (Which is extremely common with the system-parts of
> a process, meaning not just libc but kernel allocated objects).
>
MAP_SEALABLE was an open discussion item called out on V3 [2] and V4 [3].

I acknowledge that additional coordination would be required if
mapping were to be allocated by one software component and sealed in
another. However, this is feasible.

Considering the side effect of not having this flag (as discussed in
V3/V4) and the significant implications of altering the lifetime of
the mapping (since unmapping would not be possible), I believe it is
reasonable to expect developers to exercise additional care and
caution when utilizing memory sealing.

[2] https://lore.kernel.org/linux-mm/20231212231706.2680890-2-jeffxu@chromi=
um.org/
[3] https://lore.kernel.org/all/20240104185138.169307-1-jeffxu@chromium.org=
/

> It may be fine inside a program like chrome, but I expect that flag to ma=
ke
> it harder to use in libc, and it will hinder adoption.
>
In the case of glibc and linux, as stated in the cover letter, Stephen
is working on a change to glibc to add sealing support to the dynamic
linker,  also I plan to make necessary code changes in the linux kernel.
