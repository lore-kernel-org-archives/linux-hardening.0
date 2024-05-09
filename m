Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08E23C9
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214209; cv=none; b=Obi8iqROYv54YmGxZqS9Xt+iQRxkLBqjfCaAQnyQ4U8ZOFymBZ8da6frrwE3m6NEPDP8ixXFU2RY1onWkgRuvTRC2+jjlXu/N7bwbktEzuc+i9y1ulbUMqYU6FHNIoX2MoPjSkAnCampPvXzGMfUmOhlWGy3Y6koyvLbDPcQynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214209; c=relaxed/simple;
	bh=DODW/4URxRbA9DuTjYXWV8p06cnOAPHfE8OhcWBuxFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fah6J19zJlKA5R/Y8qKBTFpiKrQ0o8jM3IlkOgf0w54YTncuYnLgave5GI380fgilHx++a+u9RSl9D07piAL/SWlTBt6J83C0u6jzEfMCEPMmElQBqxQ18S95mk1GanTzLoWeCZWr2oV5TcvpduSmDMl4J8V8DRr7/c/YIe9hE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FYhcqsw9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FYhcqsw9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f29e80800so208515e87.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 17:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715214206; x=1715819006; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUREf8Y8+BNsNPUONsk6UGY92nmezphsmslNvqS96no=;
        b=FYhcqsw90zspe3KaDauLmz8yRUyH2CSRV7IbGjObV9QRjkl61C4Fyfknf0V1jtTONs
         cmN8rp4A/zIpDhj8FcE5FYJAlYWqTVLw8LtMxPoC01N6lI3rclY6KT7S6vIPrnNKDsnn
         I7gqusJ9otZxR9soomgaudZ/7eQKh2v1NMqJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214206; x=1715819006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUREf8Y8+BNsNPUONsk6UGY92nmezphsmslNvqS96no=;
        b=VzQ/fbrCQR6OgVu46NYrGejDY6sAmIviF12QjytoYZ2rJRAGe6jFTVwl0pjXe4JP5K
         YjXgTtOdkX69TQCS+b0JBfsRvlz4VZNtqfo4+Cz7o/b/J62ji78SGvaamBvVkdaNXjAZ
         T32OlW78UxRLb6vdi3OP8XiBWjqSXW5KoofDJOrecey2ka+1Tij/FhSbD9vdrzCwSEnH
         MYeUAIxmvQ1JWCp/DKwNQYwxXatiSTIkghW/2OiRv8TGGlUAFtpPRTOzJzKzcR1QdaDX
         Xbkp+23GiyWzqh3TYAy+ObfRmXMaXcysOl8c+h9J/rYTPOIxDiV5m01YCoRUX6EVO53T
         lpfg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZR5lkFyW/HXl3Er1q/dC88tys43CF/TH1aa5S71PI2nOnD2cZe+unPJ9bNyo88UnA70pI/TE712opivtrELCUBnccj+2AiWro0hskgMR
X-Gm-Message-State: AOJu0Yw3NCF5t9b+fmp8fXsoxqysi8cILrgS9JrqoA2OSLBGCZYUWgi0
	EQ+3IaUK9bNiSD0teyi/1ik0eHEc2zh5sX7K7Kvo/01uBmQGsXDhkIW3tDh9BU252yBfWYaYemS
	QyfJBuw==
X-Google-Smtp-Source: AGHT+IHx7nxR1mWBNIhUs8kJy1AUMCWUryH3TFQRsxCSEmaupRrQQavMDpf/NWKUkCDXVXlQ91tqCA==
X-Received: by 2002:ac2:5f0c:0:b0:516:a6ff:2467 with SMTP id 2adb3069b0e04-5217b6a64d3mr2082160e87.0.1715214205707;
        Wed, 08 May 2024 17:23:25 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b017b1sm14629966b.181.2024.05.08.17.23.24
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:23:24 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4702457ccbso65901566b.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 17:23:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkBO8eziMeKqYDlVLWK0ca34N4cnCBhRPx4TUtMvZQxI1N4mvVUncKHPZkcaAbeFJcq9ixuRFcoVlD5qW2nZOm91g4Dsv+Gsx6m7Z8a/AX
X-Received: by 2002:a17:906:f6cd:b0:a59:a7b7:2b8f with SMTP id
 a640c23a62f3a-a59fb923241mr262394466b.9.1715214204485; Wed, 08 May 2024
 17:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 17:23:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgf5mpRT_Aiw9aebX_z0i49aUbUBEPr6jk_dUaCTuR6cw@mail.gmail.com>
Message-ID: <CAHk-=wgf5mpRT_Aiw9aebX_z0i49aUbUBEPr6jk_dUaCTuR6cw@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 16:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So *that* I feel could be something where you can warn without a ton
> of compiler smarts at all. If you see an *implicit* cast to unsigned
> and then the subsequent operations wraps around, it's probably worth
> being a lot more worried about.

Side note on this part: quite often, because of C promotion rules, you
have "int" as an "intermediate" type.

IOW, while I had that example of

        int a;
        ...
        a * sizeof(xyz);

being questionably not-UB (because "int a" gets promoted to unsigned
as part of C integer promotion, and thus you really had a signed value
that was involved in unsigned wrap-around), if you have

        unsigned short a;
        ...
        a * sizeof(xyz);

then technically that 'a' is first promoted to 'int' (because all
arithmetic on types smaller than int get promoted to int), and then it
gets promoted to size_t because the multiply gets done in the bigger
type.

So in one sense that unsigned multiply may actually have involved a
cast from a signed type, but at the same time it's not at all in that
kind of "accidentally not UB" class.

I suspect most compilers would have combined the two levels of
implicit casts into just one, so at no point outside of perhaps some
very intermediate stage will it show as a signed int cast to unsigned,
but I thought I'd mention it anyway. Implicit casts get nasty not just
in assignments, but also in these kinds of situations.

I still suspect the "implicit truncating cast at assignment" is likely
a much more common case of loss of information than actual arithmetic
wrap-around, but clearly the two have commonalities.

              Linus
