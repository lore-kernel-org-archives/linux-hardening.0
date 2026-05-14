Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6538D3FB
	for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799722; cv=pass; b=KfxGvwPoQ6JS7qRz5xoEVTJvmDkevS/ZV6fYWfPNpd78MVaDwOvQYUmrPaFMbj3QKxzmqxSTgNk2pfBLQ0L946pKGLSMpPEQCOyckH1GKE9Ss7LoZSxJ30K9HFzQnQzTZsS0FFMrulJ46v42koESFeVtPiqkvxfG9leQqvAj9S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799722; c=relaxed/simple;
	bh=7QFhaA6pSrhwd4uOqqlwxlj6dluPgywqjbPxOzXuY54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1nqRzalHPPD7l1ht73vchY9NS0quLb+JeevXYvZMhbQw9bsd07u8skKf9euj+oJySIet8cnltlBkO2ZH+Lza691Zf08eLMcnD0eXRD827yGPHDxmOwX7WJFGORA3DmHbfmoZCyM7fKmrvVIv5av+X0SpATs4kE6iFINH4wChnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hyh28DYq; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hyh28DYq"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1330d6bb78dso5394012c88.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 16:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778799720; cv=none;
        d=google.com; s=arc-20240605;
        b=Zfpqr4aBDyHUPKMzlu6P3GmoGkID3kkiAQwGn08EuTtkvIDv2j9awxviWreA38WPIj
         t5pipQF1TSofQHl6m0AMMlUp3MfaBBvrAOQpeZSmFN5GiNuwjOsPUwz4smlUJUczHHJD
         T0zsX36iZ+8CWP1udPHsrCsKPEMSdwVX2ZaYTqpqaiqZnqCFax3WTnVbqqwqJIG46srS
         T8usq36O5PpcGwVGvtqH0cYUGkGRxdZbLlIcgwVHaiQbZQevlQqQC56vyBjheDeBrqrF
         sY/4WcjKMy3XbgxRD+nuyGXs27mLRAV5TE7VXOBn353UZJLPCSOipx49oAX4leN/7z29
         /gSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X7wmE2rJCxinroXPaQBQ40WUqrEBuO0hmw6nHwl8iRM=;
        fh=qKo2rR8iRQeZtwZ8D/SkmmS5aSRp/kNQTZM8m6iX5mk=;
        b=gg1gzMKYBB2iBTE0zQ6IF7efHz54uiep1z0qXyifk8/7wnxL8oYi9pJRmWcvkquOG0
         E/h7JjJq3rw68NdJLKrtg1Q5Ac0uKq0T2sF6GavfJOrMYTBJi9F3XDj+MANpyQzEkSyk
         OanfNvgVcXmYxQMbZi4UXxZKTDzeMplTZ4Mf6ytHvbzpefpj+kzlJTH/e/rALlO9k5fW
         4qVqDnC3xs2/uPKbvGSCAEuHSxOM3qm+Rem+O4GZEwHZb3As69FiCDYD+nO4XmXBakur
         19E+AzfT9Cf0cF1fG1whySN3ByPCLSWEu4XiYMoxj9X5/umkFJjCiq0tQr3xOwgCykTl
         5obw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778799720; x=1779404520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X7wmE2rJCxinroXPaQBQ40WUqrEBuO0hmw6nHwl8iRM=;
        b=Hyh28DYq5WcP77k+1pOO93KYyF96IygU9K18DTRbAJ7zKEsNwuJMJu+JlIkmDVix76
         jSKEwVf4Hm8hTfZTHR8xkZnON/GmiVjN0svxLG6ufB3+OVm77yWJ+EXnVG+hWJO9NyN1
         oVqnY7w5gf/NgQZ38FFtH9Y+Znw0/B+qCrC7GymUg44Ajst3qehThjP0pYxIkQKcFupi
         s3QGJaOcD+AuE+P9W91a3T5knD/6/OkYxA01yVgbOKP5RgtfsOpfNWw6i8L8+uSd4TxE
         svUlOaaRxKEjnHYy9hzOFpf0L14UOETJVq9hm5FLw6DQ8SMrlAFtaEMOX/RXYYEaZv4V
         HaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778799720; x=1779404520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7wmE2rJCxinroXPaQBQ40WUqrEBuO0hmw6nHwl8iRM=;
        b=TQKhcVt3UvV01Uq1stwUYUO/dRg5a5JfKlNA5bCDM9IBdXYQfQovCvRRDKVw7+vnHD
         CXifcPU3qTOSEr4SgubHg8reCJGqliiLtZNxViDQ2gAj/DYOij690YMXRC+2LkuxoAUM
         VfhW3RawzQzzRoGUvYNim7c9dSL61HkdbImKl+l5u3dc3WXNkFwI8vJtvsgalQekFxIC
         eeu+BYoPq3Dy83SjWWxzyZjbxCehC7eDjRTF68yvYiAfAReM82Kjb6PPRI94Pi3o2tmh
         t79+csddm8dUHh3msoo+VgJFKOZ1nulyPJW5YCaJ7fGnAYk8YrdS7vcr1TRRDXpFd0Xi
         1d2A==
X-Forwarded-Encrypted: i=1; AFNElJ/4f5WZR/UQy7nvMd9cbfeoBqNn9wEdTvxp+IzTdfXmO1wjmZf6x+P/DSVXHydLsJfejgZSDNV9gJTSE7tKwLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8y4t6ObU58HrCj7HNDMdCDZv37q9lrQxiQFHOijmLLEASKlS
	ytvmWK18K7vZtZfChMA82dg7cEm50RucuQRXu7G55zZoH3apDbQ3Jxu24HY2nCUodbAH4wxYCS1
	ECdoTrK4wlAhRBOfErCdTIXJFd7cMHI9qNy4bTyfe
X-Gm-Gg: Acq92OGq1oHHOzdfNtagRkCYMb0doYgXySX4HfxZ5FeWcyml69OzpM25y82YCp2q+Qv
	+z6CE075j2+5OUp49jkQoAVBZR7/VQeM+UP+fvAxwgGuVddZpAPnrR5/Gi7US6Hnqz5e+Tiz/tc
	NczKv62WKl/1pD8sjWSWT7N3h1myZnuWR73S6uotB419A7AaQnOQ4obyOh3bKxXPmS+qMII5Nmt
	biAI9LIrbqGjhA9l0NiRI9TTtURIxIhWMzZlnC1ynM2xItfjcumZdxPm9lpi5HmtRxzJ0AGnKy4
	ik92WsovUdIw+XTz9YhUrPGwppM/pWcH61iHAkkTTVmvztnmWtoIJbmMuMeb
X-Received: by 2002:a05:7022:6627:b0:128:bae0:e043 with SMTP id
 a92af1059eb24-13504943020mr671741c88.31.1778799719313; Thu, 14 May 2026
 16:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511200136.3201646-1-elver@google.com> <20260511200136.3201646-2-elver@google.com>
 <20260514092246.12b7d1ee@pumpkin>
In-Reply-To: <20260514092246.12b7d1ee@pumpkin>
From: Marco Elver <elver@google.com>
Date: Fri, 15 May 2026 01:01:21 +0200
X-Gm-Features: AVHnY4L7Nz8QfeqrI3wCl3GtxJUpEhFvuQuDcZR7x-mFmRFeRPBj-Sj8PlxOnt0
Message-ID: <CANpmjNP96_pOrH1SPTL105e9ObXY2q7V8KwFM3sKqvX9ZWYH9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] slab: improve KMALLOC_PARTITION_RANDOM randomness
To: David Laight <david.laight.linux@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Bill Wendling <morbo@google.com>, 
	David Hildenbrand <david@kernel.org>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, linux-hardening@vger.kernel.org, 
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Liam R. Howlett" <liam@infradead.org>, Alexander Potapenko <glider@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 May 2026 at 10:22, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Mon, 11 May 2026 22:00:49 +0200
> Marco Elver <elver@google.com> wrote:
>
> > When using CONFIG_KMALLOC_PARTITION_RANDOM, _RET_IP_ was previously used
> > to identify the allocation site. _RET_IP_, however, evaluates to the
> > caller's parent's instruction pointer rather than the actual allocation
> > site; this would lead to collisions where a function performs multiple
> > allocations.
> >
> > With the generalization to kmalloc_token_t, we now generate the token at
> > the outermost macro, and using _THIS_IP_ would fix this for all cases.
> >
> > Unfortunately, the generic implementation of _THIS_IP_ relies on taking
> > the address of a local label, which is considered broken by both GCC [1]
> > and Clang [2] because label addresses are only expected to be used with
> > computed gotos. While the generic version more or less works today, it
> > is known to be brittle. For example, Clang -O2 always returns 1 when
> > this function is inlined:
> >
> >         static inline unsigned long get_ip(void)
> >         { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }
> >
> > To provide a reliable unique identifier without breaking architectures
> > relying on the generic _THIS_IP_, introduce _CODE_LOCATION_: it resolves
> > to _THIS_IP_ where architectures provide a safe implementation, and
> > falls back to a zero-cost static marker where _THIS_IP_ is broken.
>
> Doesn't that mean that all the other uses of _THIS_IP_ (which seem to mostly
> be tracking lock requests) are basically broken on everything except x86-64.

It seems to mostly work, but yeah, it's probably broken in some places.

> Would it be better to actually fit that?
> It isn't as though it is hard asm, you just need to look at how gcc generates
> PIC references to static data.

Yeah, I have patches waiting to be sent - I sent one for arm64:
https://lore.kernel.org/all/20260511201711.3249121-2-elver@google.com/

The rest of my patches are to-be-sent, when I get around to testing -
which I didn't yet for most of them since setting up test environments
for all of them is a PITA. Though I can send and let arch maintainers
review them - this would be the tentative list:
https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=alloc-token
