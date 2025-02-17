Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA521B190;
	Mon, 17 Feb 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797596; cv=none; b=kouMEOEArcuFPGDy6u3kXHcXnt0YQTQaCYjrssWPIMDei8GzHLVbN6YSFadDjfup3/C6k4gabw3Yc4jqnMeczIOZirxngq+WkhxEUMkCm4dwIOD4clXNqi+o2hxJVmD0K7g26401AkAXIIyYOPdTtHlXw0+gHHrr4T6OuYnhSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797596; c=relaxed/simple;
	bh=8JKPgMvVjhhbBQX213PuhyQc9AN9onP7Y3dxpwVfER8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2UbyBfauO1GLFF3WgB8+gNWK5qjsx8e6qvkDAGTMZ1byNkPLPkzsvANVRZEVZUOO4NKWzKdluYU+SkgzGgkROzh0zRMs6Ioxuh06EGt13a0kbF705l3HrpbWNbX42EnTPWAx+s7k00jxcPBcRbaX38dWVmKz2kQABS2Qkeg8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbbb96FI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbbb96FI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948021a45so45017345e9.1;
        Mon, 17 Feb 2025 05:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739797593; x=1740402393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dleVLraQT19U9EzclMh0U/9pumMz2cbBnfXmIiP1T8=;
        b=Wbbb96FIuyCB5oSOZUP3JGhAYXo6W+rUDS7CGrNVAgOVfERzbMXjPwYxR2RFDnAKdl
         oARg9SYKTOT5JApRHyFtLdqYI0hKfDBmuIIE1nLUW3b9SljiNg0nVtV/NMg5gH4svuLN
         45DN4zHmXBBcPwry5Fsyeh1LlL3jvdYxQl2ReQuO9KstUv+k3okUa4d2Ud2dHW6lPZyc
         tBYAf2UOVtTZXBg8Y1ptBlynfveKHZ5payrNTRo/Uke7JWCXSaxQHmo0ctxDkRrdRQna
         pBn5W3Gp+Ih59FDXrH00b37vuc+2l9r1bdtWlV39Vs5TYh/C9c/4sezHGb65S951+Iw9
         DDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797593; x=1740402393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dleVLraQT19U9EzclMh0U/9pumMz2cbBnfXmIiP1T8=;
        b=WBBkPHpjzFeqsxukF6O/KK2xkvLq5F+qKLU2bQEufUk1PPy8RoeH61iSqJrOkPPuxg
         hngd88MW09cCkYimKqj3sIQUbWjdtksmYCSjmLZqBoSiMZh5MIwOKgepbF5gMdSerZ8V
         uu0EbVTrTUrnhN87sxRUz+coiaM8B9HTHywRqPCECY8tH0bdi0+UzMSepFblLeY7f/T4
         HOILmUiGpYD/e63s9gaujmOQVxxk+/I9ENEkJWsxsAolavpj2XiysC7W7V1MFOg4J2WV
         DvrF3zkpbOHUDGA9HG7Ps7wm71UeIu2lwxbLFI3Bom8Egjpzw8gMaYyvDzIF4R8Ck7nB
         4OhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdC0KpNwFd4q1WRrcKcWJFtS+ngztvSRbfRWDV2JCr1HpyuHU8phP04X0SAh2kPm0/fMCqa/HovGIzBULJncU=@vger.kernel.org, AJvYcCV8PnY4MBDzuereicJEHJgND8jKJM8CGJ97ZmSnUiWMlXSaUhzM0Q8ycZUQQl1c295sGjunrUMjkEJJCO+T@vger.kernel.org
X-Gm-Message-State: AOJu0YykuN6080Sh7m4vl30UXaHSZW+z1FW4c7ZgusXhOdiJnI4rLb2O
	zBUrXe7a0jxYgyHcFrCG/DoRElTGlhGtXAS8YGkt3XDCflfB3ZO4
X-Gm-Gg: ASbGnctxhG59fTF2oaiNfOx2c6xPlieCr0pvZbTAMhr/lsYPOYXRm9uIee1zF+0gL23
	0UbnaCzAwJza/C6SQaZuTebQj5s3DgOD9LcU/lFuDm2Jt1FwpexmjHJGNuRbuMxNSYZnOCDE/mz
	emsnxN0U+AQcXf7gRMqBXlRCvIJg69EQz/vhfzT2e/STIOMvWvACsh4Otr6P3s4yfmOaIW19M/i
	QxrZV59y8u81WvaOl83C6Hf4wKz1XZc8mrrfspNz4mNnlOuEEFB9473qVxESxMLOGZUOpPI9bl2
	juJV0KJT6xbYFAd3AZmDEmKugPWqbcjjtcAcZXAgGiPY1f+AW5u+0A==
X-Google-Smtp-Source: AGHT+IGKuoY3OoZtJuCmdAry/rLfCSNEhhjlj7+XV2BOJ6z9nzgAnYpt6zGv7VNPDJBPR0FfiLeTnw==
X-Received: by 2002:a05:600c:3591:b0:439:6548:e5ba with SMTP id 5b1f17b1804b1-4396e6a6a82mr80720515e9.8.1739797592430;
        Mon, 17 Feb 2025 05:06:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b824dsm151421545e9.34.2025.02.17.05.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 05:06:32 -0800 (PST)
Date: Mon, 17 Feb 2025 13:06:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 jannh@google.com, jmill@asu.edu, joao@overdrivepizza.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 luto@kernel.org, samitolvanen@google.com, scott.d.constable@intel.com,
 x86@kernel.org
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
Message-ID: <20250217130629.37f556b0@pumpkin>
In-Reply-To: <20250215210729.GA25168@noisy.programming.kicks-ass.net>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
	<c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
	<202502131224.D6F5A235@keescook>
	<6641d1e0-7151-4857-bb0e-db555d4cdf50@citrix.com>
	<202502131248.B6CC333@keescook>
	<20250214095751.GF21726@noisy.programming.kicks-ass.net>
	<20250215210729.GA25168@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 22:07:29 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Feb 14, 2025 at 10:57:51AM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 13, 2025 at 12:53:28PM -0800, Kees Cook wrote:
> >   
> > > Right, the "if they can control a function pointer" is the part I'm
> > > focusing on. This attack depends on making an indirect call with a
> > > controlled pointer. Non-FineIBT CFI will protect against that step,
> > > so I think this is only an issue for IBT-only and FineIBT, but not CFI
> > > nor CFI+IBT.  
> > 
> > Yes, the whole caller side validation should stop this.  
> 
> And I think we can retro-fit that in FineIBT. Notably the current call
> sites look like:
> 
> 0000000000000060 <fineibt_caller>:
>   60:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
>   66:   49 83 eb 10             sub    $0x10,%r11
>   6a:   0f 1f 40 00             nopl   0x0(%rax)
>   6e:   41 ff d3                call   *%r11
>   71:   0f 1f 00                nopl   (%rax)

I tried building a fineibt kernel (without LTO) and that isn't what I
see in the object files.
(I not trying to run it, just do some analysis.)
While the call targets have a 16 byte preamble it is all nops apart
from a final 'mov $hash,%rax'.
The call site loads $-hash and adds -4(target) and checks for zero.
It is too small to be patchable into the above.

There are far too many TLA (and ETLA) to follow all the options. 

I did notice that although objtool seems to have code to remove 'spare'
endbra, the 'mov %rax,$hash' was present on all external functions.
Some 1600 are void fn(void) - there are high counts of others.


> Of which the last 6 bytes are the retpoline site (starting at 0x6e). It
> is trivially possible to re-arrange things to have both nops next to one
> another, giving us 7 bytes to muck about with.
> 
> And I think we can just about manage to do a caller side hash validation
> in them bytes like:
> 
> 0000000000000080 <fineibt_paranoid>:
>   80:   41 ba 78 56 34 12       mov    $0x12345678,%r10d
>   86:   49 83 eb 10             sub    $0x10,%r11
>   8a:   45 3b 53 07             cmp    0x7(%r11),%r10d
>   8e:   74 01                   je     91 <fineibt_paranoid+0x11>
>   90:   ea                      (bad)
>   91:   41 ff d3                call   *%r11
> 
> And while this is somewhat daft, it would close the hole vs this entry
> point swizzle afaict, no?

Doesn't it have the problem that it includes the value of the hash?
So you can arrange to jump directly into the sequence itself.

	David

