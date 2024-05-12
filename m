Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C92B9B4
	for <linux-hardening@vger.kernel.org>; Sun, 12 May 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530169; cv=none; b=hs4YWddu727dfEzB4Mxj+jC6Yz9lWxgYjaLSbr9lmM9+ffVqmFj+gEvbfhrL8krxMEPiVAYP8YTa0zTI9EWeXRxQ3rb/CQpfg339bpsfYfUgdXiJLRRwseUE+7gOnEQbnu+pCsreCD21bPY04CGcshbL7tNOzrGTTeRJ1BY2o1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530169; c=relaxed/simple;
	bh=yYPbKdVLK3KqBVezWJQgrH3PxS7gpCu36SsGnL1rAGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghzFHtE52pb081TUi/xhxi+Po68leWnEoRnm8jPqa9MGls+jxwh7Z/jUfEPSm5r+fOsDsaaUrPUsdQ1/qsZoz/ghb6OolVVVF6cL7UoW+KrmLcPPNuZfTfpJa6zjYwPhuaS1eylCtQoEq9s1NoAgEDGpXYN/WiHeaEhtx88YApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fh9xyVOl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fh9xyVOl"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a64db066so900063466b.3
        for <linux-hardening@vger.kernel.org>; Sun, 12 May 2024 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715530166; x=1716134966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbkMcvIOlR39VVMi6Mj2FfAAerh3AUWOCxZbcMMDx30=;
        b=Fh9xyVOlMFTkVhELbR36sonWrO28ZVXptf17h/D0rye1Vd1LHS5MoxZhXbQVQPwfdc
         t719a9yZIaSDvYAUKnvPYnyKq/QKKd+4IWHLLnHRgwrkxSEyxwKTbcqbpNAKcKGqQOL3
         uyPXHFCalRHM30IlAb+5sTl+J2be2HLBjJhsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715530166; x=1716134966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbkMcvIOlR39VVMi6Mj2FfAAerh3AUWOCxZbcMMDx30=;
        b=dkVDZhXi7D8/z4wlLPWyA2gPt/um4BfPiD3OqrRqT+bFW7en8RuYZ7/4fri7lfWbrt
         sKsOP4Sxz4YtP0v7vZeZXPTKYGgYcE+BT/O0KC4IaTyf1LgaoXGQLo10pECizW6c+5RH
         HT3Q9D53R3V2fv6g/PQZisew07FlEG7hbW3PC4NueezbMdFBu0zL874HeIvnedR0+I4u
         L1kJ5GTFE7lhXhTC0NBUufOXKzyHO1D5xAvz44mq/JRU5Ut8W/fbFTIOQ7MxfqiJrOz1
         jI6a5OlivTNLOi1ndHnntx1jQtePdb44i0UqhgZp8gX1AQnkaQ6f6Uwmh0kuk9ndH2++
         c0pw==
X-Forwarded-Encrypted: i=1; AJvYcCUGjhLSUyf/3M3avs1wB6c7+F1WPkYVZWUS7+uyQu9GQwHVYXR/qrf+xwnGmAxIFFBwIgVtYEOLeOcmAkfvZEe5hBKCAzo6BunSR0Oq1RJk
X-Gm-Message-State: AOJu0Yzdom2XMxFjOlDBTGFxK+mB4J5+axesCis7y5decmuyPw93jbFm
	CbIsKetwmYoAxH43S0DBVwmMNtCZzVXUOZ0sjlh5q0+cl5tcEiN4nrbWAIxp04bW4CE7hkxKBd0
	woAA=
X-Google-Smtp-Source: AGHT+IHHoPAZPNA2qknIX4jqAn1ZsHlZxAsK7VvCb7vPZYuVQHgVeNaM8t5xOSe0AsQ8gCKCdyi1nA==
X-Received: by 2002:a17:907:3203:b0:a59:ca7e:e1f with SMTP id a640c23a62f3a-a5a2d53b76amr684204366b.15.1715530165710;
        Sun, 12 May 2024 09:09:25 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a29d5f14bsm417609666b.213.2024.05.12.09.09.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 09:09:25 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a934ad50so838446966b.1
        for <linux-hardening@vger.kernel.org>; Sun, 12 May 2024 09:09:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+DeNfTU0gfqvl7AcN1u91TGJ8uvtxH6/+ofdNSOxYIKpf9h+xj60cnpAO1NmbHYn8If21mkrPhEiCARZS5NKtrxVAd3psIjLeCO+N5BjZ
X-Received: by 2002:a17:906:7192:b0:a59:cdc9:6fe1 with SMTP id
 a640c23a62f3a-a5a2d55ef06mr502053766b.19.1715530164768; Sun, 12 May 2024
 09:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
In-Reply-To: <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 May 2024 09:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Message-ID: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Martin Uecker <uecker@tugraz.at>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 01:03, Martin Uecker <uecker@tugraz.at> wrote:
>
> But I guess it still could be smarter. Or does it have to be a
> sanitizer because compile-time will always have too many false
> positives?

Yes, there will be way too many false positives.

I'm pretty sure there will be a ton of "intentional positives" too,
where we do drop bits, but it's very much intentional. I think
somebody already mentioned the "store little endian" kind of things
where code like

        unsigned chat *p;
        u32 val;

        p[0] = val;
        p[1] = val >> 8;
        p[2] = val >> 16;
        p[3] = val >> 24;

kind of code is both traditional and correct, but obviously drops bits
very much intentionally on each of those assignments.

Now, obviously, in a perfect world the compiler would see the above as
"not really dropping bits", but that's not the world we live in.

So the whole "cast drops bits" is not easy to deal with.

In the case of the above kind of byte-wise behavior, I do think that
we could easily make the byte masking explicit, and so in *some* cases
it might actually be a good thing to just make these things more
explicit, and write it as

        p[0] = val & 0xff;
        p[1] = (val >> 8) & 0xff;
        ...

and the above doesn't make the source code worse: it arguably just
makes things more explicit both for humans and for the compiler, with
that explicit bitwise 'and' operation making it very clear that we're
just picking a particular set of bits out of the value.

But I do suspect the "implicit cast truncates value" is _so_ common
that it might be very very painful. Even with a run-time sanitizer
check.

And statically I think it's entirely a lost cause - it's literally
impossible to avoid in C. Why? Because there are no bitfield
variables, only fields in structures/unions, so if you pass a value
around as an argument, and then end up finally assigning it to a
bitfield, there was literally no way to pass that value around as the
"right type" originally. The final assignment *will* drop bits from a
static compiler standpoint.

                Linus
