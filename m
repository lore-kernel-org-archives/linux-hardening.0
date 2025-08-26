Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974801A23A6
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206103; cv=none; b=J0GWvh5fUqJ4GD/gzBamUAnoSg4pvJbz7YawJ4fe4KkUOIi5EE0SIXjQ2zyDr+IwV8wN0ARdxQ/5qr3Rtl/fa60VPUzE9Sh3hRrAGKjmRFC2/YXVWwaQ/BGyYpoe3oHmf3WC1KU67/CGkEkq9HdOSUbinT1JBcOoS6zQRiXQrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206103; c=relaxed/simple;
	bh=z5bTM/LOu+8/2E/Nnxg7jTQwRbt0XEaEwT9F0rhrrwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBLDQHL0tkLmsxOEPUqwJx0qBcZDNiwfqH6hTB3FfPfJamIC7xvglJ1vYAsivMzM12k34ie4BzjIm3lLSAJ1LQ//CfzzT//dxt0c5EnhAjq0/pq7C74Mv6PAzxnuP7LvB3xRFXynM4hbBknxMVhIKh/dtZryrNONWR0HsSKixjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ze631f9J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ze631f9J"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445826fd9dso68324005ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756206101; x=1756810901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O7NeKTyWKueL+wvA2d/ehbUAGIe9IQuhF4UrqPvxaVg=;
        b=Ze631f9JH1sZ2pk9B3SjuJVIatfoJvUwW64fagd6CuecaYn3cOfW2c0sOP0EyVfdht
         6RAtFXiUbGnNaKZ9SVtrjLRRmLFz1gkqVyiwFqe35DCRrOkx7gPiXxW99zAHTZJNe9MN
         4nOLIbdvCZ+sar5Zx8n9TOrYYSaWQqg9MxE8CfrofDOFmhGeS3BG9rD5ylJZ0l7oc3CA
         K9LMwV1Af+VV22IEUukjHpuO5i4NRDrR6xNlmUrvvDnFR9txsr7flAgGApF0Ast96IQG
         iQwZocMeLfMbmvoDVujqInhHvO86lD6Ddj/1Gsv9uOXOxl9QAtpdR62uX94/RzOuDRYR
         /LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206101; x=1756810901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7NeKTyWKueL+wvA2d/ehbUAGIe9IQuhF4UrqPvxaVg=;
        b=IrCOlw/ZTaJYeKmIP8jpQA8iv+hMIaoa9nu7BfDLoTm0iOvZWROZoYEdgumBkSSKb1
         1aPiyb0ExdglhmxZg9+L2+Qgj+NEmUQrvFjZpdXJAH+OLY9ON/U4yZC3r51LK3qcgswJ
         zDUFiWgHjz4n/ZFVz0gaqbRV7iuUBZD8KT1XJkQUxLTDDNCUyn4yWeAO/NUbSk0ZJ9DX
         gWV3aTmnXCzl8FpBXWhMcZX774h5uvDU7b5QvSOFZPcG+FXaO8UNuMyrqXiWjUdVFH07
         4Hp90vSG9jsvRBfOVdj6mU16ub2n9autQLH6DVVBVScn2B3IxzpHBXfFEoIuHwvctHxS
         QQDg==
X-Forwarded-Encrypted: i=1; AJvYcCVBo3czmql5zGF7cKgPAolcxpGcgXRBS/RXkHqlBsLu0c2BwGkYqorugin9RV85nmnSO1xRVvdvB4Csc1QX4HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5V/Wn/TtdJHX3W7yMBKUDHjQRKY0ZWRdE7aZ7VzU2Cz8n0Zi
	IT/w/ARTXDWr9GIsccukR/QywexHxqUcDqGNnK5YHQO8LpPGfjlYw0WKy4d7ureL5Xx6LyVPbdn
	25JhudmPtiFFDrCjH+dwmy0BsftvgI+WuC4D6eqMG
X-Gm-Gg: ASbGncuCZLCPjKSXakYr9C+7KyUzpnMJCT6bTIn72mD675oLkJTJxladVZdU8swYi5z
	/AcDYjceHze+vjXcO90mnIrOBxa9I71DIQraTBbmbpVbBEPPpvgTyNfrrwDyuBcf/1JBDGHOM6B
	s5DjJHrFFkvzklo2qtH7Mjocuf8yju7cH6XSpaL34/NFCkSTnfOwGDLVq7p+gL/HESMYTpcBJlS
	SKy6sSwp9L/95BT
X-Google-Smtp-Source: AGHT+IEbRYts5Q2lruIn6/nB+O/HdMCkYF/AkmdpLyFbfgBNrhZYvvCShyGMbpT48VX2Q32imRPFKl5g6OIxfhSyNvg=
X-Received: by 2002:a17:903:240c:b0:246:cb50:f42f with SMTP id
 d9443c01a7336-246cb50fe74mr114988865ad.19.1756206100525; Tue, 26 Aug 2025
 04:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <97dca868-dc8a-422a-aa47-ce2bb739e640@huawei.com>
In-Reply-To: <97dca868-dc8a-422a-aa47-ce2bb739e640@huawei.com>
From: Marco Elver <elver@google.com>
Date: Tue, 26 Aug 2025 13:01:03 +0200
X-Gm-Features: Ac12FXxae71NaV6L-XhwcBeMdDL6EXr8UiNrPYGSHEYHL3QrAfVUO23SnPsEAGQ
Message-ID: <CANpmjNMkU1gaKEa_QAb0Zc+h3P=Yviwr7j0vSuZgv8NHfDbw_A@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: GONG Ruiqi <gongruiqi1@huawei.com>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, David Hildenbrand <david@redhat.com>, 
	David Rientjes <rientjes@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Florent Revest <revest@google.com>, Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Aug 2025 at 06:59, GONG Ruiqi <gongruiqi1@huawei.com> wrote:
> On 8/25/2025 11:44 PM, Marco Elver wrote:
> > ...
> >
> > Introduce a new mode, TYPED_KMALLOC_CACHES, which leverages Clang's
> > "allocation tokens" via __builtin_alloc_token_infer [1].
> >
> > This mechanism allows the compiler to pass a token ID derived from the
> > allocation's type to the allocator. The compiler performs best-effort
> > type inference, and recognizes idioms such as kmalloc(sizeof(T), ...).
> > Unlike RANDOM_KMALLOC_CACHES, this mode deterministically assigns a slab
> > cache to an allocation of type T, regardless of allocation site.
> >
> > Clang's default token ID calculation is described as [1]:
> >
> >    TypeHashPointerSplit: This mode assigns a token ID based on the hash
> >    of the allocated type's name, where the top half ID-space is reserved
> >    for types that contain pointers and the bottom half for types that do
> >    not contain pointers.
>
> Is a type's token id always the same across different builds? Or somehow
> predictable? If so, the attacker could probably find out all types that
> end up with the same id, and use some of them to exploit the buggy one.

Yes, it's meant to be deterministic and predictable. I guess this is
the same question regarding randomness, for which it's unclear if it
strengthens or weakens the mitigation. As I wrote elsewhere:

> Irrespective of the top/bottom split, one of the key properties to
> retain is that allocations of type T are predictably assigned a slab
> cache. This means that even if a pointer-containing object of type T
> is vulnerable, yet the pointer within T is useless for exploitation,
> the difficulty of getting to a sensitive object S is still increased
> by the fact that S is unlikely to be co-located. If we were to
> introduce more randomness, we increase the probability that S will be
> co-located with T, which is counter-intuitive to me.

I think we can reason either way, and I grant you this is rather ambiguous.

But the definitive point that was made to me from various security
researchers that inspired this technique is that the most useful thing
we can do is separate pointer-containing objects from
non-pointer-containing objects (in absence of slab per type, which is
likely too costly in the common case).
