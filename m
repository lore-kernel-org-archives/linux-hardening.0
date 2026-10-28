Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180883;
	b=10IARYqqrHg00HjbSFP0s7x0akhvXukz9Lt7oxf5zqWGUddxa/R6qZ6m7UojeOLe1RdA
	 1XzuHfL23GoifwRadRyhrqjzuIQ4etWjl8TOF+hdNhi5gZkdVqKTTOXSXHu7PzcSw8GfA
	 Tr5vDHHz9vP10KDjdAAX7ZLnZjNp0OAkIPa4Jl7laWtuW+juPAEdNYx6RVwjztXKwsk/1
	 3HXCfl3Vhl5V/7pqhID6hXylg7zy2eWlHhFMGOJ9kSJKiwg/YbK2JFUVaW5BhMgctf3WS
	 WkpJoaQQXmOpnOtV3mLBe5cREQsqWjeNDIF69cB5sPDW6IY+ekVdCljY3gPdjD15KxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
	b=LKqdJPeN4vaxFuMctMsY+e3VW39NGDJJl/o4Rv8FD9w7Kj/YFeWMS2q643DNaYFDD3UV
	 D2FabZLkvZCV+9bvIKLLrQkFyJrdqWJHPQUQkkKtaaALU/WrCb8VrYbMPZcm51+7kpBfM
	 CkJlpufr1S97VQRBov+8Nh9EL0kw2kYCEP2ArVN7qSQZmiGj3fgLqvXo38hWL2KXlwxKK
	 FpsbvroUBRgjBkP8beolDVLKMs3E16SaRyTRBN2TsvHIxN9EpLEckQeKU7ZK608jB1TOR
	 nuXEnevYq8RDobB2KtjLqu/KMufcGuJvSmqWTf7aEa0yBMXvOc7GvYuO/lFTmMM48dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJw6mAzl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0B606A323
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 09:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD0B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJw6mAzl
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c46bd7a7345so131530166b.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 02:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180881; cv=none;
        d=google.com; s=arc-20260327;
        b=mo1E9GcGadLt/kh94itVP4Pwge7Ook9Xj9/F/lUUGEJpqIcvMMg+xEF7ZHGbKYh+oy
         swNNx/jcPBAUH3sh6tI1VojqWSyC2Mj/DODgxivmZ4oybWkjuw0g0Wk79YQ4UJ4tGfH5
         8+L1phfa74DKms1OHN3CvOR94O2wpUUdQ3KcraMIX1nL1bryrPKybMdIxBECFmZalA4n
         IWhliXJg/y+aXod5NuBXUOfxkdzxibmvQbeDsC6GpMH6Q5qP2SIw9Ak+2a2RjcOmVlNu
         4D4uiWEPE39fxKbpm090jnkwJL8VwuSXBUClSEe+wXWciqIk2inH1mDhPO1t24bWX+oK
         1n1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        fh=q0aBTox9lVFcUmXkWpgWZ2vIalEmiSH6Dk9s3yHxz0g=;
        b=CjtpoMqU+ISIfgWFp4iNMw99WYXcbwy14KQep6o71OQz/A6zmqNKt1URobe4oCwVNT
         yTAwTjXYL6OfT0sLd0/ZjjvYTUrlLKt/lX0MamByx5Rb8Fe0/vrNrJrgdREVDtMkMQXW
         s09/2j3LFFesdJT4+f2sFKG9ZkGt5tOVdRsdO0eJBQbnErToBiqlss0nCHeZZzNYh+Fi
         Wm+6n5qQLHfLQAJIcY52ithJo3FUx1jxCE6qAAWNyqja32OqCHGLwV0HzEaunbHNMRs0
         oMQ6QO8KYS1+SHMEorItKkWBnHLMQbAmBMm457xhgCCVMYo+psXOm42eyO0rNUhF95SQ
         j2vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180881; x=1793785681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        b=zJw6mAzldYFqYZzdqrK5sVCjCWQPQmTep1dLeDCOodLgldWlrkclOGlwaZnjuK1Oum
         TPJIIs//JWN7qNyOHlCsUAdJNutM2b52i0HJOialjxTrWs4keZvZmw3BRcoJU4Awqzjr
         WT7ZIhJrd4c9JQzrTY2yU8wr3bsllD1F4CAiDQBfntXs5r47SzlK8X0ezxzisTf0fyLH
         V2m79FTBz5/Q8KkYGms7kGw/9UPrH+YveHnhAh0ujkqjlAJ55dCcMHh8t8hYyve2EZ4W
         CPhdOdeH9FP4wI1+y2tqcuYKKYhDPN/HKsHrz7f0EKP2g/ydwoE9hgBJKjkE88fNdPU0
         JRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180881; x=1793785681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gl/4Yc6JnTMakWEbHOettwInvSk+aSwCfPGu2bGV6uw=;
        b=ZHPjHwoObCYMUN0z9DMNdvCXEIQBxDimePQZqF2FCpKjfKSLoIhF+sBuQzKwZ08g6X
         TX3YgTPHI0ahvlyOby+XP5fpMQ71hHPtM2WBry9MQ503W998AIR3Ca1qOIGYxm7rvPr1
         ElTQmWoNqRM6wdx5BNVlduuPZoZkik191ktjVU+TR0ds1ru11Ms13LkPtSM9iwJkJ451
         vvxJ6DPPacIuLyrk2P9UBBJP7Ewc/srAxoHW393te1fapSr/WnC+eDslrhKucktNjkjQ
         QO16xgVDIA0cp+QYoIqnd1UGHtVX8VXshu8DhXQLIN0I1maalz8AbIoR+CHD2aMkmFB+
         rrwQ==
X-Forwarded-Encrypted: i=1; AKwUvBws4ZEsufYOXYim0cDYkInIyQ0s2mKMx3GVHnuHhDbHXsh3XfNl/bQ7SEPe0Kt0a+6ubo70Yj08YtO++LLgrP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLitM29wf6Ml4Nm6ufSSw9LvUmJFh+ggdssxg7e60Q5EY0T3rn7
	xKg3/A6zVrXlq9k16DJ1dW0sjATvZgzFuMikdA0rzsCwUxQUGDD4feoECg3/d+bChmrjnlbKgSJ
	cMYXS7Cf5Kzq828JRR0aXXLffL3vCi+w=
X-Gm-Gg: AYBFou1TNt++b7DbuHMClfvABKQrRmZ27F+Q3KWa6AeHgDPsm8wgOKytEzGpJ7Mri90
	OxONufBUPFQdilpxE8nbz5UOrkRF4CgCsc8grENSAPylISMpUbRyoshP88AymD7V49+BHTexTEw
	eJG0qiEOl1zIZdxQlW0CRthlYqF93lwK3bMcE1Uj1iEfl31I8PG9Wqr0q3u0lPdzED1oidHZChL
	CMqlm8b1FlvoiR6yycp08re3sriolj+BC3GRyG7SQD3dyzOZ2MDZA4FQuOq6Bjx065b5gD9jsIw
	3KYBxXMGF/wcMEBno9ugdwhPvZAbciUUIXj7jPcZK35R608N956habN8yrMqh/TrTeg0GarjS3k
	W6o+ar5e8lC8gTOP5ZJPwuWFb1vp+I6BtTqdVpFqy5N/LZJC9xIuHRv1dP5F5p8HTe6KoIYnBVg
	yeUp+FZUkCiBAxQXh9gN4D7z1VbKYbV7P9b4Cq8MM5HDQ/iXmMdMuCc23MxFVhlZ7U20OUAQcOh
	dd3jUCzXHeovDVlsJLkVdVqfg==
X-Received: by 2002:a17:907:86a5:b0:c25:f7db:4bec with SMTP id
 a640c23a62f3a-c49c6357d34mr69949566b.18.1793180881026; Wed, 28 Oct 2026
 02:48:01 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <580fdfbe2eb6694438cbd8f5337bd2f1edac564b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:47:24 +0200
X-Gm-Features: AclHuK-8N84O0Y9k-BLOPVpeywTja7886uZe3ugxN4eM-96m__IvC7bzZgS0MkU
Message-ID: <CAHp75Vedr5J1WJMrAkBjRSLKA_zf1kt3GD6UhjzLcy9vowxnaA@mail.gmail.com>
Subject: Re: [PATCH 03/10] lib/list_sort: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.
>
> Add spaces after the commas in the __nonnull_args() argument list to
> follow the usual coding style (according to checkpatch).

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
