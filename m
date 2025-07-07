Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9529528A1D2
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874412; cv=none; b=HxAFdMmjroa/wgwqPotGwhDFhZvzOGcLKtb6u0F3/124OeSpNxpT8dxS6W1W2W6zD8aECBGRHXZS3XnlZaw2beXkJ4T8RQk88E9cPtl4bGDL3v/wafEO0iQpOxJ6LPwoc1dkrAotZCiRo0sIk/EluwJBobHh6jg7a5kHSnIfn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874412; c=relaxed/simple;
	bh=wgirFmFyQOVRX7pwQ81LfLbwnMDKABb03D/FH3MjlU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCAjvfcICVBQqZSwBHt6Hv142KE1+4o+vkX1NUqR0qK4xxnn8fY/sQCD2dCkDz8i1f77Ss08XVkgjlzGA/iCyIPJxoHse4N0XWTjL99ZLljBgI84ze3ZVw/WCPkyHo+RqktSmw0AqmBj/LhB++yIDIB69KVWrZWODvlhaqkxiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+r1gjNG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+r1gjNG"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31c978688dso1283563a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751874410; x=1752479210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9fNW/ipNPp9E7WVydECVXrddec24Up9r1hPRynNq8M0=;
        b=x+r1gjNGxw5g6G4kRYli/oyr4WXcCKQlzS3l8Q/oGyj1ZNPUWinqAJwheRFDZw+nOG
         Bmob8DrWWS/E1T5zbiKh3t+eJkhaeAfRu4cIrUrHF6WWAyLXZhD787eoMQ0EojqGDoob
         SzGiRxvA5YnxvufcLIEn011zKa3rg/WNdJq9fxylJCBn5OzrZ1hirNeTUZ1FdoyMAGlK
         QIwHTwDw1wGm0qE8YB/UAf7yU25Wh61ytuJGRV6CpYT3GsOi1lZMZc9jxZDgchablKJc
         QwNjSM2YVwjiFbZMeUB3xFirh34yGfkAJtvkjLmd7CSqGaLWaUSUjvlhb2aiL/Zzjplu
         mUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751874410; x=1752479210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fNW/ipNPp9E7WVydECVXrddec24Up9r1hPRynNq8M0=;
        b=BeF8cC/Z+5jQeG8OCZYDz6y/Q+wosfo1UAfRgXGq3m2oce0jY60iBgN0dr+xLOHMF0
         +h3I0gFBntCAcx2LzOoFGs0KY9Se/yDglfIj7LHIdZor583bk6tRznge9enodKUSKdfp
         8OI3rwJntNSYKz64e/+O/yIl4u1dU+Xph8Bb8ryfjB6hI9G6RpRHzNCJC5iuh0NB0RpL
         lzomrwQJH0gtY23n8cB7GqTtCwCLoLEEpJe9sPfJQCj5JtjMy7eiuYV509v/AqTqPyni
         cbkYxyWONZQiIu1eKVOn8yZoT0yTLF2etqkrv0HgL42KUwh+v5GmBjNs8Qu41VAVRi6s
         JlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRVRNk/1VAk1TUELAtgQJJJofCPWAsHBhSWBAd3VihEUBr3eL53ns9jH0KHcmDh9ukK2RfojY9c1P6swCiq7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyssgOlhvFe4HADOEpJj/d2Wzjr4q58870aNl32hBM041bxdr34
	44yd7x5q+eyU7dLD5DgdTmXQOcQG65dDlQrUP8F4OaE5qBiNEtvP55XvfKwoNiW2XTLkJbNcwnp
	uq7KMHXOcQImT0fFEGihnqMe46jWrcF5Gci4+LlKX
X-Gm-Gg: ASbGnctUNDd5hLy43OYfoonFxWCe6lwPfs+pGmZLaTuCKLl9vahRjoDyRtDEwly+GU4
	pk6iasmuweaO92b1ZGpkMhhVTi2iYx48s2GzDmb1B7Ov272CevyhlqWpr/7Ias99kG5ePAts09C
	Xd+YceDKeBnoxf/c4KKSOPmjPHZR3Pv5HGEVfR2E0LPbDpJiROJgAn+czQiX9sQFcf3/64aki4G
	w==
X-Google-Smtp-Source: AGHT+IGqO9oM46vaRZElMnGr6n15joXe3K7RM5q8sFYWV7Px+OQQzqoIe4GGrFaVhxXnxZxDnFNqlZsOgY72zLirvzc=
X-Received: by 2002:a17:90b:57d0:b0:30e:5c7f:5d26 with SMTP id
 98e67ed59e1d1-31aba8d28a3mr10983089a91.24.1751874409534; Mon, 07 Jul 2025
 00:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
In-Reply-To: <740755c1a888ae27de3f127c27bf925a91e9b264.1751862634.git.alx@kernel.org>
From: Marco Elver <elver@google.com>
Date: Mon, 7 Jul 2025 09:46:12 +0200
X-Gm-Features: Ac12FXwJB9HCD4i8JLB6RoA7PkR95ZBhaAJktuICujVit91FZfsr8G443fGUagE
Message-ID: <CANpmjNNQaAExO-E3-Z83MKfgavX4kb2C5GmefRZ0pXc5FPBazw@mail.gmail.com>
Subject: Re: [RFC v3 5/7] mm: Fix benign off-by-one bugs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 07:06, Alejandro Colomar <alx@kernel.org> wrote:
>
> We were wasting a byte due to an off-by-one bug.  s[c]nprintf()
> doesn't write more than $2 bytes including the null byte, so trying to
> pass 'size-1' there is wasting one byte.  Now that we use seprintf(),
> the situation isn't different: seprintf() will stop writing *before*
> 'end' --that is, at most the terminating null byte will be written at
> 'end-1'--.
>
> Fixes: bc8fbc5f305a (2021-02-26; "kfence: add test suite")
> Fixes: 8ed691b02ade (2022-10-03; "kmsan: add tests for KMSAN")

Not sure about the Fixes - this means it's likely going to be
backported to stable kernels, which is not appropriate. There's no
functional problem, and these are tests only, so not worth the churn.

Did you run the tests?

Otherwise:

Acked-by: Marco Elver <elver@google.com>

> Cc: Kees Cook <kees@kernel.org>
> Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  mm/kfence/kfence_test.c | 4 ++--
>  mm/kmsan/kmsan_test.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
> index ff734c514c03..f02c3e23638a 100644
> --- a/mm/kfence/kfence_test.c
> +++ b/mm/kfence/kfence_test.c
> @@ -110,7 +110,7 @@ static bool report_matches(const struct expect_report *r)
>
>         /* Title */
>         cur = expect[0];
> -       end = &expect[0][sizeof(expect[0]) - 1];
> +       end = ENDOF(expect[0]);
>         switch (r->type) {
>         case KFENCE_ERROR_OOB:
>                 cur = seprintf(cur, end, "BUG: KFENCE: out-of-bounds %s",
> @@ -140,7 +140,7 @@ static bool report_matches(const struct expect_report *r)
>
>         /* Access information */
>         cur = expect[1];
> -       end = &expect[1][sizeof(expect[1]) - 1];
> +       end = ENDOF(expect[1]);
>
>         switch (r->type) {
>         case KFENCE_ERROR_OOB:
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index a062a46b2d24..882500807db8 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -105,7 +105,7 @@ static bool report_matches(const struct expect_report *r)
>
>         /* Title */
>         cur = expected_header;
> -       end = &expected_header[sizeof(expected_header) - 1];
> +       end = ENDOF(expected_header);
>
>         cur = seprintf(cur, end, "BUG: KMSAN: %s", r->error_type);
>
> --
> 2.50.0
>
