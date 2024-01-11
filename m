Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEFF58132
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DYyV9AVQ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e62979feeso8912955e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 15:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705017522; x=1705622322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsr6PFlZr2msZU50SITFyVGPFm+oEax+N/q9E6uP/As=;
        b=DYyV9AVQydERZeSEYr2aUBf0HOdug7/MGPUMX0nhGBEq9vWPVkwEV8BfrQpI1hoRRB
         vQA2tKUmrFEaUD06Wr8Pn/bgqRZmRQACgeClukpS7VRNpBVlMKWU4hWNT9lXGfyanV6z
         FV5N+3AfJJLXoSSKkgZmoKUX7NoQU4CfyWGQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705017522; x=1705622322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nsr6PFlZr2msZU50SITFyVGPFm+oEax+N/q9E6uP/As=;
        b=jx48NGLrLwCJtN52a0hKO3gJN3z3hFMJzPYPbSV8EAwRxyKe0di4ixgF5KnRAKxV1T
         1IJA0UL9IhMqvO5aac88FGisvS8WsiDS2hCxw+A+IuIQbpNEkiKjNrvX/NMRuX1Z8W0+
         x7Gh+Qs5gsKYPjF5YwVCfzxhu4Rfrqk5MobFg2yQaeKI9nRiiHJzyv3lNrT+DNTTAv2G
         MNEUq4E1x5a+sG6o1xZqqcR7O4F4GSTroIvEXT2mrKUI6eU2pXQ+kOxGfWTdM8jxaAMT
         ealx292lz8TuOO45U2fx6/B/xKFzdbsIEHpROOfs6mtzVDinEU02w43J37NNA0MHAErd
         kiLw==
X-Gm-Message-State: AOJu0Yz29L9gRuXaGH7ajCZ2aNHnozDbQ1rPN5WydJ+xRtSviT4X3jxb
	F0gP3pBYf58OBWR++xqCuCvVHi/YnIQVtNc24gjpeVGgK3OtKsIm
X-Google-Smtp-Source: AGHT+IGcsYqFLaoncG0I0smyGNBHPy3X2XtAiF7q31aWDe1APcFrZwvnR5fpBmtSXQJU/yK/p0WgMQ==
X-Received: by 2002:a05:600c:4683:b0:40d:91b9:436b with SMTP id p3-20020a05600c468300b0040d91b9436bmr343260wmo.183.1705017522437;
        Thu, 11 Jan 2024 15:58:42 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id q21-20020a1709066b1500b00a2990007447sm1119626ejr.122.2024.01.11.15.58.41
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 15:58:41 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28b0207c1dso465975466b.3
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 15:58:41 -0800 (PST)
X-Received: by 2002:a17:907:a609:b0:a2b:d242:8d35 with SMTP id
 vt9-20020a170907a60900b00a2bd2428d35mr295990ejc.40.1705017520730; Thu, 11 Jan
 2024 15:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook> <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook> <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
 <ZaByTq3uy0NfYuQs@casper.infradead.org> <202401111534.859084884C@keescook>
In-Reply-To: <202401111534.859084884C@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 15:58:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWHj83=NnpT5mo9M7r=s7GmCdNczRfmN87thLFxA+pqQ@mail.gmail.com>
Message-ID: <CAHk-=wiWHj83=NnpT5mo9M7r=s7GmCdNczRfmN87thLFxA+pqQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 15:42, Kees Cook <keescook@chromium.org> wrote:
>
> Another ugly idea would be to do a treewide replacement of "func" to
> "func_deprecated", and make "func" just a wrapper for it that is marked
> with __deprecated.

That's probably not a horrible idea, at least when we're talking a
reasonable number of users (ie when we're talking "tens of users" like
strlcpy is now).

We should probably generally rename functions much more aggressively
any time the "signature" changes.

We've had situations where the semantics changed but not enough to
necessarily trigger type warnings, and then renaming things is just a
good thing just to avoid mistakes. Even if it's temporary and you plan
on renaming things back.

And with a coccinelle script (that should be documented in the patch)
it's not necessarily all that painful to do.

                Linus
