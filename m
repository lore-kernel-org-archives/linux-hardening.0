Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5327F465
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282162; cv=none; b=ky7LJswGTaMYqsi2sq3koK14DMJY1l0xL+9rP57FWjRiFDs9WkXuZhP99NP6DsvfrrTmK5sGUhXwVfU6rsnx/YEPeJkMmdDuSsP/I1208g7Ox+RQLam7EZK4vb02ZPPMklf1DwOBNQPLRyno6eerO29+ZHZ8YYpOTwYh6DZTQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282162; c=relaxed/simple;
	bh=f5hTjmwtrBNmeRfEZwqwz3MoeEtUyLOcEt2AbxYcVbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfrCXtiESEpVHeBgpz4pWxkrcvPJmF0SUqYMqdSRGCGIXgky/SE0OmKMioNqj+3quVvFSMSnz+VzRXdNLfuK7FtiHTzai5PxwBIpIHTwwmE5lJC3e0j8CiIXAV7CcSeVKOf8GzmR0xxlnnvexd2jvVKQHuZ+EjcX6ELevXMYOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZBcnF8Ym; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZBcnF8Ym"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a934ad50so299774166b.1
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715282158; x=1715886958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9PPjpFCo1HBrR3dhTun969JD1naScZ8g1ToZzUTce0=;
        b=ZBcnF8YmhrjyvmPATrpxIJwnO/LAVDHVpKlE2c2K0TTYwfVyk9f3esVGbFrHqF70n7
         dlptd/NDbOgWA8FsY8w0ZecCKbH23DM236FhxJ9dY/rAXpG5bWE+9XnOs8dhTzPLfDvb
         uqR1LLMUB1GxE8mixDpUWggKypq9UmjV7DQkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715282158; x=1715886958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9PPjpFCo1HBrR3dhTun969JD1naScZ8g1ToZzUTce0=;
        b=o0i1hurANgV6kJtEAIwwI+WwdFEk0CoIqvd1dEf4qMFnwrE7EKNRn+1oXFd1yN0DVx
         XmC8zFza7qTZRFnBoH9xMWmgwcN25nU/G9OINTioS1lp99GpztSe5coyZuLDaCCtJtQW
         ddHA+ogVo4o08uBQu5IymiLZdxGfCzkgmaEADApE5iE4PjxphEqqvlejjm2jdfblrI0f
         oMi/SMxsPAvnaUeEIDCJaa0Q0PoRelYSQZPAaN2ajB2jCk8v9DSjpOVGzJ1dfgciyPZg
         FRx06PEpVD0p8XA2SnPyc3NKHcwXI+az0UKK+fSzmBv9ODlUzsJTVAXsgxndF/+WiSsL
         dRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWom95O44aSUY4SPU7roNv1/GRLrI4QOqD7ODoPb7fAaBAYcV0OoyZIGs2kzvD/QJB6aQP5RD+la5BhpL4tN3r/ByU6Nvzc2Y0EcLaVLn7q
X-Gm-Message-State: AOJu0Yz8GPrXzwY6wuBGenUHvPWKxpSoK99fCeBdq63ZJM6sNsToaC6a
	Dk6TXeBI/PVArz2hwoXWSuyNzB3+nOwLVuR0bOfULPwzb/4QBDorWX6kpvh+Vef3mDbHgRGgsDm
	HQH8E7Q==
X-Google-Smtp-Source: AGHT+IEMBDbs4oWT1MmFrbRqug8tutwp5Lp2UhST1HZ8aX4ZFVDboOJXtKpSy/FDPyvQZnT61fVHXQ==
X-Received: by 2002:a17:907:552:b0:a59:a6b2:b898 with SMTP id a640c23a62f3a-a5a2d57b00dmr34994366b.27.1715282158604;
        Thu, 09 May 2024 12:15:58 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b015besm104875566b.144.2024.05.09.12.15.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 12:15:58 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a9d66a51so285112566b.2
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 12:15:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZcz40CNxVMt1iZ+TzL2AAVGxN6DMd1MumGs/4EXJK2FL+hr6fTgXktdcf7szdLsAdDMAbjmb2nWXAgchxSTUyPnrsjDCUqzLaUE/Hoq8u
X-Received: by 2002:a17:906:f88c:b0:a59:c52b:9938 with SMTP id
 a640c23a62f3a-a5a2d6653bamr36083966b.55.1715282157122; Thu, 09 May 2024
 12:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com>
 <20240509175417.GR2118490@ZenIV> <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
 <CAHk-=wgBprh=8Us-MtwH9sVNELZK2hdOkFn3EoauwecYgtXOCQ@mail.gmail.com> <20240509184806.GS2118490@ZenIV>
In-Reply-To: <20240509184806.GS2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 12:15:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHA8Di-cpT0pKcScwcWNVYRFvmhBwMrug=Mj5WUwa2rw@mail.gmail.com>
Message-ID: <CAHk-=wjHA8Di-cpT0pKcScwcWNVYRFvmhBwMrug=Mj5WUwa2rw@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 11:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, the thing that somewhat worries me about having a helper along
> the lines of combine_to_u64(low, high) is that
>         foo->splat = combine_to_u64(something, something_else);
> would be inviting hard-to-catch brainos -
>         foo->splat = combine_to_u64(something_else, something);

Yeah, we'd have to be very clear about naming and ordering. So it
would probably have to be something like

        result = combine_to_u64_hi_lo(high, low);

to be easy to use.

The good news is that if you *do* get it wrong despite clear naming,
the resulting value will be so obviously wrong that it's generally a
"Duh!" thing if you do any testing what-so-ever.

Of course, I say that as somebody who always points out that I haven't
tested my own patches at all, and they are "something like this,
perhaps?".

But having "hi_lo" kind of naming would hopefully make it really
obvious even when just looking at the source code.

              Linus
