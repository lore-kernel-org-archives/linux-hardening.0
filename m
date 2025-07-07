Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAD21C9F9
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926691; cv=none; b=PiNAkGAtewoJ247ff730JQW/TKbFyHcIJGNOgZ7QQWbxcGB3sao9F/WEXlwEvdW6JWPXX94WrMrDg17mAgiUjug3Dq9uuXvWA0WDKgavJGNbeNkN+UCoQoBa21Z0KjkK3qhNJnXqdC2aMrcV1MpF/GeIiH3kctUWInVgeMKAJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926691; c=relaxed/simple;
	bh=0Sb8XwHi0O5Dk/ACiYkt00ghcPmpVUSe9q67/ppN0x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGKLZ5KLIQ/8Qwp9u9ExAsog9Jdglz7OqqUQ7MRne0p26hYzssIZOwLP0Pz4Z57G9LXKRIBLPrMpHC4/jsP8vjqguHA0uUE8GupnI2kcwnVNpXZvWVCItFPBsorVQhX/a10k9Hag2SrrLUBT8xV05noWKIphMQz9KRiWff3G2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZTTloREl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZTTloREl"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad572ba1347so568908466b.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751926687; x=1752531487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUqqsbRlIl+0KIYJcUROFT1sVqNppMFyhgNr/RPU0Ys=;
        b=ZTTloRElR9t/YxgaWFHG+dS/vDilHCzxR3nmjYv1dhtToLQBqX26znQWDh9A3uRVgQ
         Wb6znaaN+LTKORIpcvN1rx+xO3OTKSHk2Lda0JiyHZAgD3a4F5o8/UkOIgX9jJV3UD6e
         zu2KbQxc9BNgdYTRhBiRg2dOeYThLLl1kQskw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926687; x=1752531487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUqqsbRlIl+0KIYJcUROFT1sVqNppMFyhgNr/RPU0Ys=;
        b=MNzttk68fwPf64p/qoAfocYkF5gh+6Ze37HUcdUPFThtSiJxnNiKdpXwLU1+PpxBIH
         gICSSFbzj9CSQPbiot1XQJKsa67moXCtcPKr0/0wgxkyDjkuCd0ZoD3aFzm7JS9KXZ9e
         sIYqEo/1H++X8uvvdAXXhXIvPYpG+GgyeAwmSFxUHAJOkQERGpM/krsM2wQSiy5jA278
         gA6bzaDKq2Ue0y/6ttnpILBu9BRWIMs/xO1fgQIeYSzlqO4DM2S7GJqDkqvWra4Rq6SO
         vGm3jK+NcsXnl3e4Rop1B4laU+JYImU5RJmN/Gynk5pak648ORnlUCfLUkm8b0vecYRy
         P7bA==
X-Forwarded-Encrypted: i=1; AJvYcCUy3aq/vOTmeEVhJrdtlaDq9ofYfXfQUN3LgmEP5v3v0fc3c5rgR2tP8hUbhrK+gH7a8UVnkHhb7j4hrRGNMeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxa2wFkAC3orHSgSsejrURwBq6F/1hA/L8mokLUzJHA93kdU2Y
	d5E/btbdfRaG+eUYuusXUeJXn7nOcilnxJ858fSea2yYLFhljpCSZAKtsPVSlVtbbRmuEtcP/y/
	eCJX4vDlhBw==
X-Gm-Gg: ASbGncvVq5qMFZOnjw1fsQy1G0aLuM9QNCbrQSJx6rvRLPVM4xtZYfDpZPgyR6BxTNT
	6ZU1rKFVo+Mv9xPj3sYeP/GhIZkidBO/fptt9T11bmrYSNHio1AzD5U4KoT9JgVaBbXl7vJNS/n
	bHFS7+c9DF92dJ22AUzqUnhHxpz5J8Cw7CgT7xqLsGgcMWeC9PQIRNkaf0pQh3hg0ZkfBOOSRYQ
	Xwx1pvDpmsQw3yE4GqeqV44GPAAxrR+CIg9bA2kac0qLbM7+g2bD8maU79GrPefjvIs04qkMeJc
	rQWdYCVT47BoGKOYm9MiV3yKt91Hbpe2a5mDQy6BW5UqbypDNJndykjfIu/dd+d0IdKIF5BuZy4
	wg/4j7W3jE03jQJqwRMatCG0pzURabIwui8ox
X-Google-Smtp-Source: AGHT+IGvMps75NHY56mOEudwO+xLzvIJufFKEl1lwpSTCciGhoj6RmCXX3nZaNv+yKpBUHwb0mqpTw==
X-Received: by 2002:a17:907:728f:b0:ae0:c8f9:4529 with SMTP id a640c23a62f3a-ae3fe7fcce3mr1491512966b.49.1751926687131;
        Mon, 07 Jul 2025 15:18:07 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03247sm781242766b.130.2025.07.07.15.18.06
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 15:18:07 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5673537a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 15:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkQWmjzRWZTFJ1yLKxjK+V/qyZ9cK32FmlIGM4n4VhE6dIbVmW9wYoJBmtp4AFKTPnwohVJIrYpiGt3V3o//c=@vger.kernel.org
X-Received: by 2002:a05:6402:2356:b0:60c:461e:71c0 with SMTP id
 4fb4d7f45d1cf-60fd6e04c9emr12735823a12.30.1751926686474; Mon, 07 Jul 2025
 15:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
 <ugf4pu7qrojegz7arkcpa4cyde6hoyh73h66oc4f6ncc7jg23t@bklkbbotyzvp>
 <CAHk-=whQ_0qFvg3cugt84+iKXi_eebNGY4so+PSnyyVNGVde1A@mail.gmail.com>
 <gjxc2cxjlsnccopdghektco2oulmhyhonigy7lwsaqqcbn62wj@wa3tidbvpyvk> <r43lulact3247k23clhbqnp3ms75vykf7yxa526agenq2b4osk@q6qp7hk7efo2>
In-Reply-To: <r43lulact3247k23clhbqnp3ms75vykf7yxa526agenq2b4osk@q6qp7hk7efo2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 15:17:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6gEmYih1VfYZu9FiYtOJYSFQ0f45CQZtDLrJpzF47Bg@mail.gmail.com>
X-Gm-Features: Ac12FXx7EVbwgcu_kwWLSiLwlTlYjfwq5vvQwKm9O0uZQ7guWOwdxI-MvQMXh0I
Message-ID: <CAHk-=wj6gEmYih1VfYZu9FiYtOJYSFQ0f45CQZtDLrJpzF47Bg@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 14:27, Alejandro Colomar <alx@kernel.org> wrote:
>
> If the name is your main concern, we can discuss a more explicit name in
> the kernel.

So as they say: "There are only two hard problems in computer science:
cache invalidation, naming and off-by-one errors".

And the *worst* model for naming is the "add random characters" (ok, I
still remember when people believed the insane "Hungarian Notation"
BS, *that* particular braindamage seems to thankfully have faded away
and was probably even worse, because it was both pointless, unreadable
_and_ caused long identifiers).

Now, we obviously tend to have the usual bike-shedding discussions
that come from naming, but my *personal* preference is to avoid the
myriad of random "does almost the same thing with different
parameters" by using generics.

This is actually something that the kernel has done for decades, with
various odd macro games - things like "get_user()" just automatically
doing the RightThing(tm) based on the size of the argument, rather
than having N different versions for different types.

So we actually have a fair number of "generics" in the kernel, and
while admittedly the header file contortions to implement them can
often be horrendous - the *use* cases tend to be fairly readable.

It's not just get_user() and friends, it's things like our
type-checking min/max macros etc. Lots of small helpers that

And while the traditional C model for this is indeed macro games with
sizeof() and other oddities, these days at least we have _Generic() to
help.

So my personal preference would actually be to not make up new names
at all, but just have the normal names DoTheRightThing(tm)
automatically.

But honestly, that works best when you have good data structure
abstraction - *not* when you pass just random "char *" pointers
around.  It tends to help those kinds of _Generic() users, but even
without the use of _Generic() and friends, it helps static type
checking and makes things much less ambiguous even in general.

IOW, there's never any question about "is this string the source or
the destination?" or "is this the start or the end of the buffer", if
you just have a struct with clear naming that contains the arguments.

And while C doesn't have named arguments, it *does* have named
structure initializers, and we use them pretty religiously in the
kernel. Exactly because it helps so much both for readability and for
stability (ie it catches things when you intentionally rename members
because the semantics changed).

                Linus
