Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14D1F3BA2
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822204; cv=none; b=P/PKpCkHBB96UyksFRyJun7FnJft+JFXMAgreUkzWIiRstBfJ3sPQZLsMCM876dPWU50m0LKBbmoiXvlUz8qwxGGvg60viy/8c3JOjGGOuweT4lUUSHnHYELHaLyzt42wZXd+YxePFEQubAoVQJuBAU0ZsdFpiBcWMjtlQBgvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822204; c=relaxed/simple;
	bh=xtGCELKG2VSoTGpGJxxtVIorL1o3aUsplhMbETRvi8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8ERty/02sixC4jW2I4+TF35fZZMc+EPoQAXHekus2K7OQfdZDZksIcI2mHDqv2Zi3ynt7n5PuseED16FJhyVsHLWenUNygNOSjsC2jacwTA8oNFecDZO/UQCnLoTzH10m+3I7hR9+XloTG8MXLj97vJ7Qtozd8u4I61aRA0GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d31cMpTX; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d31cMpTX"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-728a2736e7aso42256a34.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741822202; x=1742427002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2epRF2yIZ4WoKvdTuk66kXn9icmipQ0jsgIlyAwLUYE=;
        b=d31cMpTXmhEvFlbozeNsKyjJUuGDyC+FV3WYUrtqhI/uojKmitQzSLGiN5QdYbqdfP
         UrBk8QxkovK/5iEZSxoxi+PIv8seZ+5hAbEg39+uO7awlyPAyjDAusWf5uRhXiEFEkPd
         AJWFrnJ7wa/6jnOZ8fyG3bVjpmEesaMrMkKzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741822202; x=1742427002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2epRF2yIZ4WoKvdTuk66kXn9icmipQ0jsgIlyAwLUYE=;
        b=cC4NeQUjWMZhOc+yRtjCkIPiyqSVL7yb7h/XFAe33gR83SSo4HY+byFkkKzVLUDNsb
         fc7DoRnk070aW7/8uNpajHIwESrdeaTRZebHY+de5nFqxZ51tqTaObSVbF/x9nuL34v3
         bxu7FUmPxD7PHntDXnKBN131TREHFlH2YjutZ/lJQvi7pJr6x+a2knczH+XUWQRLJIO0
         04QfApp1q5TEd0ync8A74vstefBxKV4O2WyGdPnMksap6ESZ9egwKYBmjshwMDipV4DX
         qWcWDEMN4+N8b+QheXt5pz/Nf8vcvoe4F7GgSHlGQwAAfxXTBOXah692yDzIhBI3kdQL
         sO0A==
X-Forwarded-Encrypted: i=1; AJvYcCWK0c5ReD61N9luB7wAJpDiAli9W5k9MlOdnJkE0yPb80303L/lMYksJheq9uLmKkCvlv2XjwNE9bW+4Xbme9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx95xsQp08AcClcpxgWMUfYFFWxC0yn3Ur8Xs/RzF1dss5IA5F
	3/cS6ogVpEuD8IzURYc/OP9OqrmzPOOnAydQqdqvvpox90JUdank6fEhza8+9UEmNB9YnZ8JdZ2
	FcCadz959S671hFQuOU1QTSM2JCeDyU7HEexY
X-Gm-Gg: ASbGncu4uYgxirU3IF4eisviSOt4rv2GGA/K2roziaoXhy7VVZzb/2nXRCbKFC7ak0B
	ekzmei8bVWybnip+IktqLrVHM2f06u53FU99wj80Il2xPK+r2MhSnInZ/b0p7Y24xcMMHrVnmSt
	HPY3DxEfuQEU0o3zmTPYYL0wxI
X-Google-Smtp-Source: AGHT+IF3KK2zPAe3DQbz1LO5JCsOn/xBbba1NwUWwZbYJy3s2T7qPHVL8YcMfh75jIyOKbZ08RS1xlD+8DXPHeL6Fb8=
X-Received: by 2002:a4a:db95:0:b0:600:24f9:21fc with SMTP id
 006d021491bc7-601c24cff19mr1200447eaf.2.1741822201807; Wed, 12 Mar 2025
 16:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312002117.2556240-1-jeffxu@google.com> <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local> <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
 <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local> <202503120931.3BD7A36445@keescook>
In-Reply-To: <202503120931.3BD7A36445@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 12 Mar 2025 16:29:50 -0700
X-Gm-Features: AQ5f1JqOVPfwUnKOxqrdAsJKAmIgChV5YiCTfryTQdRd23HMgTcMUTwhsepcUGA
Message-ID: <CABi2SkUs3bXB2jw+1CUQPtWfZ6-kZDunQweOSSw6j_8JALUfAQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, broonie@kernel.org, skhan@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:45=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Mar 12, 2025 at 03:50:40PM +0000, Lorenzo Stoakes wrote:
> > What about madvise() with MADV_DONTNEED on a r/o VMA that's not faulted=
 in?
> > That's a no-op right? But it's not permitted.
>
Madvise's semantics are about behavior, while mprotect is about
attributes. To me:  madvise is like "make this VMA do that" while
mprotect is about "update this VMA's attributes to a new value".

It is more difficult to determine if a behavior is no-op, so I don't
intend to apply the same no-op concept to madvise().

> Hmm, yes, that's a good example. Thank you!
>
> > So now we have an inconsistency between the two calls.
>
> Yeah, I see your concern now.
>
> > I don't know what you mean by 'ergonomic'?
>
> I was thinking about idempotent-ness. Like, some library setting up a
> memory region, it can't call its setup routine twice if the second time
> through (where no changes are made) it gets rejected. But I think this
> is likely just a userspace problem: check for the VMAs before blindly
> trying to do it again. (This is strictly an imagined situation.)
>
Yes.

 We also don't have a system call to query the "mprotect" attributes,
so it is understandable that userspace can rely on idempotents of the
mprotect.

> > My reply seemed to get truncated at the end here :) So let me ask again=
 -
> > do you have a practical case in mind for this?
>
I noticed there were idempotent mprotects last year while working on
applying mseal on stack in Android. I assume this might not be the
only instance since mprotect gets called a lot in general.

Blocking this won't improve security, it could actually hinder the
adoption of mseal, i.e. force apps to make code change.

-Jeff

> Sorry, I didn't have any reply to that part, so I left it off. If Jeff
> has a specific case in mind, I'll let him answer that part. :)
>
> -Kees
>
> --
> Kees Cook
