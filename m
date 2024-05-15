Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39F63A5
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715733868; cv=none; b=BkaLHUB9hBI7OmN5p+5fkYfYFl3buh27ffHALw3xLvvxPluxtveoBodTNxGNT/HCYq67EErn0X8xqeYbtxyixXVWrBij9HPy9FjMxswvzi8k4FLhkxLAw1t+yEso+B1il0Gb8FHUtpvnjfk9uH+EehpJjfnryp1QzHmy+IWHVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715733868; c=relaxed/simple;
	bh=iyxC/dRXIM6KYxQfRCHr8g+kv1gexJCsm8khro+Q+uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRaKI8RFKP1OWKYUc3o/BI4b40HQYB1ZPP6JfY/HZHkGYU9Dj2oIRXgYOQ8OR2fuVr+iV1O/oD9JEX27T5dbdhF9ujAviKGd6oDdl3VOxbut9Q8JKueowu4+O36ZeyrJh+d1cwmfyPxb8QFJ0lTvCzyXpuXEySqO/6wNZ+Wm1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZPSeucki; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZPSeucki"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so1247139a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715733865; x=1716338665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OZvAiAEdwWZe22j4pRu5oxfNYFobcCpcqXbwXMC6CU=;
        b=ZPSeucki84KEBg5XYLiNN+MzQ53lspncxROIvnTAK8eOn62f6DBjv1UTKAluHYy4Bc
         aKR3RkXTFpX9LQ1JEzaViMO+jlmld77Dc1T4kVSCjKcIQCTsjS9e3SqwWsvvA6pnpJ6u
         QrItccftCfLSpHNBrHnI6RTiA6FklTBkmSdP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715733865; x=1716338665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OZvAiAEdwWZe22j4pRu5oxfNYFobcCpcqXbwXMC6CU=;
        b=bYOQ8ey+VQWdO4Uxf94Kx8ORMKXELCnds2GSSeJgjJrxRWfsAWR+7Jz5ESRvXv4A/r
         YP52rak77xFSlI/TkNVn8btQsyBQ0jRhXeV6gW8NN0uow8NYI9sfiTg7TAIz6HAdB1pu
         v46hkVw2ylzNdHbPafqnVHrW/9sWx3oidtFaj2ctj7fnNTdFEpwcM2l29Go3n+EvkJJM
         AzuKi31bFjq4n00x94QhtoGDi+j321Gu4Zpn7wRtxvjOgGUzsJn3iq/K1u0/NkKf4zPi
         AJSwKCBw8J9cbR0yW6FVxO/hTmQyRgFgwNXsRGdZ5MtkX5pUuEFiX/J+8XSnM6Q+Kylv
         o3bw==
X-Forwarded-Encrypted: i=1; AJvYcCXHt0hlsTaUhaDHhrdARCtJx3QK5SQeVLVSNzctEyM6yxJqkVtGAVcCsqv3uYUJJ8KFwb/2qVpoHuJpAj1AaBsLVPWsXJalZuBr4lgyJH5P
X-Gm-Message-State: AOJu0YzUubbRkmJe+xogXUePY4r+WtfExMQLDU7Zwh945Fjc1jSJb694
	nzl+7BKtjYYkKjWKFJxLLzYG/iyPIZNmF8VUEaK2ndogTBC6tbQwqTpcsha8/HHijgo2C62ZtK8
	mETGGYw==
X-Google-Smtp-Source: AGHT+IFLATIf4Y1Lz3pBiczVRmYYLIhJIH+Dc7p1AfvBQlxS06Vgenvz0TnyiVrMAawyvmRH0y9DUA==
X-Received: by 2002:a50:f60d:0:b0:572:7c13:c7d8 with SMTP id 4fb4d7f45d1cf-5734d6effa0mr12986143a12.34.1715733865175;
        Tue, 14 May 2024 17:44:25 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb6csm8475625a12.43.2024.05.14.17.44.24
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 17:44:24 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so69764866b.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 17:44:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW68XNw0G4RE5NhLp+9Z8KvIOjC/yOu0KGra0mP0rM5hg5M9kyi+aUyFg98sFgQbzJWURRrfLhuErwo4ujLOUpUgN8UMklOxi1+sHpsHm+P
X-Received: by 2002:a17:906:a010:b0:a59:a9c0:57e6 with SMTP id
 a640c23a62f3a-a5a2d675dafmr1290775966b.75.1715733843947; Tue, 14 May 2024
 17:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org>
In-Reply-To: <56001.1715726927@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 17:43:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Message-ID: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 15:48, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> and can't imagine it affecting a single application

Honestly, that's the reason for not caring.

You have to do actively wrong things for this to matter AT ALL.

So no, we're not making gratuitous changes for stupid reasons.

> I worry that the non-atomicity will one day be used by an attacker.

Blah blah blah. That's a made-up scare tactic if I ever heard one.
It's unworthy of you.

Anybody who does mprotect/mmap/munmap/whatever over multiple
independent memory mappings had better know exactly what mappings they
are touching. Otherwise they are *already* just doing random crap.

In other words: nobody actually does that. Yes, you have people who
first carve out one big area with an mmap(), and then do their own
memory management within that area. But the point is, they are very
much in control and if they do something inconsistent, they absolutely
only have themselves to blame.

And if you have some app that randomly does mprotect etc over multipl
memory mappings that it doesn't know what the f*^% they are, then
there is no saving such a piece of unbelievable garbahe.

So stop the pointless fear-mongering. Linux does the smart thing,
which is to not waste a single cycle on something that cannot possibly
be relevant.

             Linus
