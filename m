Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794567420;
	b=TNXGjqw3ZpqJN3U3RMybD8ol+MB44+Eq7tIWFSANilEGmX5dDJz4XMVdthHzvBjeSeT4
	 FDfbzhbzBXY4MXhMjG/jA8Cz7TMyC1V7AtrdnGRg1sgJrWxMNCJrOp3nYkFkomS8IHcdD
	 r1BjJkAiniROM7i2XcTLx+IevN4M2aJgvhxT9Io9/JQpTQaaKuEX0Oe7upZbv9EAYYAOc
	 eaIpJCGAjYkphh3TMA7OJOblXvmW4ZCJ6JYjBRcomBvbNJkj/O0GfCUVEgFuXvu39cOIE
	 49h1r7QwkuybIKM89YSZBQ9iipeVKCgrN2P+799ZuobEq2zKs/IVJz5Lph4wkdL1ZGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=h148AzK7ulcLWc0NU3jZpboHW5vO/KJ9aeMyUmTns1k=;
	b=j8Ey1OeiOq2cOFJp544OPPa72xOtaa5G5OollEg2VmhbcT0ooefJVzxgei+AriSUyOwH
	 Pg2ubYQKh8z+OYsiouzIHYO9DQMwqE4cizYsu+1eXK3ZJdUboKBZEqDCTaFMtFmHSc17R
	 Tf7zcaPYsNtcWJpccgkxYSGZLapBV8BYvOalT4woqBdYbDQLmyuTnDXWekvCs3Atfw1gN
	 lFY7HvJE/MNcIahBzPenRZ8xPO9VwI73s6dpEU/iTxGj0fTS1SK7dQUC6EQknIdQD3FtK
	 kdfLg/OG8pK8NPZYU1YuTmK+YTSFPRfk1IUGwRdH7PLy6bEqegm4gZWl4sgg1FDhgFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBjXS9Y6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE05606A327
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 10:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE05606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fBjXS9Y6
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc758830601so1290800a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 02:57:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794567420; cv=none;
        d=google.com; s=arc-20260327;
        b=eTK5Jz+66jrEz1ccb6+p6NpyPRt9PEICS53WTU+uIyfSjCU4fQ+6czgjW6K02R0/oP
         z4S/uPBADXcR2R2sqjVExGc3Zz2m7jT5qZIIDGUMJpqHOuvwyJbtjzpk6nSxKSmK0KMs
         EXYTbAk0ztZR2hEaK5xx9YukgHgG9qbLSiStQ1A75wrUKsc12JGCzp06xxgmVocvWBbx
         spzwPOjtZBCF3BsqSmK+00jGlvFtUGAoLvyE3RTBpBWnKvNzjSGiL5Y9OY7wl8n4/ZWA
         YcUn08YwgE88MGHR1pja6BtlUtn8fdf7oJYFqN6nO3SzvbAwAsVK9IjaVUdTqGKbp3/5
         FynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h148AzK7ulcLWc0NU3jZpboHW5vO/KJ9aeMyUmTns1k=;
        fh=iKXdRMc4KAH3ezsbNv2Nycw2DjyiBBZtVeWxjHMhCg8=;
        b=UT5y7dQsRrywppNB8IfXDDYJ4j0QSiCsaLKqj9UB4qCTZqr5ddQUdVuJB4lLrTR2Zu
         MVyDrFY9MlJkrc2ulkStkKzxLF6lyMIHVZ4/Pm1Oteb/W/7oJaWavKOU65h4/NtT9Tz+
         i5ZkGrtTDJna44p9SOMAr39pZHhrnSmumHRzDiy6II232ByG2UPjiiKN20ltAztPbTXN
         IBEmpdVcfD7dVX7haIFb2jsqNAOmLNuP9xqJYYT7aSOucMq2jVYLaGl0PaRDIJDl1w0X
         NPiAN0sjydtC3ouV/Kv8Qe41JM7jyiz8R7hujufE23ZmfARpM0OajInJ2AQ0SaGFRMio
         fR7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794567420; x=1795172220; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h148AzK7ulcLWc0NU3jZpboHW5vO/KJ9aeMyUmTns1k=;
        b=fBjXS9Y6OJvtKZbQIYPc9iOLLBC4doN6CmEBFa4lCo62KGClJPhCpHTQaxCYPRF/d9
         fX86HG+xLqsBoeDgsDv58r51mxawjzBvgPCjSTUzIoXPSUgsCycOg0FmRnUovMAB1yOV
         HIZqbjjz94hxwOzxD6fDPR0h3exZ1PRDgW1Drlti5GfZHqBQviOSpJ5dV5/em2Zg/bOr
         f+Gsja09J7CudqboKVoj7v7kga5QxGLFN1qjsvwkJF8+9JCM8sb4oHLFflpKU3XaJpqR
         NnBUy61eVW7nY8OBHB594RJh9qyK9X3k/bMPNQXK88VF9cSXxXzNzAHRYZ56V4oDwjvu
         e6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567420; x=1795172220;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h148AzK7ulcLWc0NU3jZpboHW5vO/KJ9aeMyUmTns1k=;
        b=Q66hG3W3x56xSbzsJ6X4QQ0OKaHLUCJz2NbQBCOl4lh0zDnS8caH5Sr9AI4J6IBjg1
         kh9K6yNUT3bX25WsaXqMrZMOD+G9bjX/73TFWi7/n7SFqNdeRsxWYkqKmu9ku+bs4bYp
         MVfSixNEhTjAq5ZMZWuLv5c+Dcp49I4DdKtIPQDSTSx9eSHJjsKKqc7kt40uP/hOB5l+
         o03rFqhv7HSrE/nwebVScwTkdlimSELGA5ZZR2/n9TFXjTUqNBoEKqSYq8fSPcYyPscW
         kG0h7negEDyomNJPPCbfJg4Dz7vbhoJfzV0Swa6SdFRH56gDCt6D7900Fiz1di0aVqUx
         lNmw==
X-Forwarded-Encrypted: i=1; AL+hErH3ei4F4ZVAyRCR/0HtMSyd4fkxrWID3AyxnWhSoRB1L7WUqEJXNFhB+JAb2JZoGqxjo2kKJP9Pq4PFVwHyRZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QP71EY4ZdG3tOUigs8i6A3LQ3JoUsh5NiibV3KGTL7pTuUAHa
	BmBKoB+rWOjaNKkxhLyBOTZ5b68hHsb1j+fFz3yw57tEkjsdSyb08pzQqto800tMijSUyG4qxsP
	1OVN0YEq7mSgZroE6aBBL7kApiDkGjjnvbmb6Kiyp
X-Gm-Gg: AYBFou3nVucvzUvnaWjhtZNpQ4sJIEKMXxiwg+8wO7XmEh/ZkWGP5TIlZNBIjoTyiJ/
	oSuU4vuun1+aVfzr0LLnJuRpAmQqn9pgwaHddOUc4fjZF8d7b33Pfcc+gbFN8Y/83jUTG/9pRMz
	CO6lyh3InjK6Nbp8G9HueBzUqrcNjq2a9lAWDyHCe3ITJ1+vPtGar48nr9wo8QAmAmW4hfIf9mj
	RyJArbdcHXq7evBdtxYqFZPf7tx+yF7onbwJ5K0zAQ7POUV8Sz4pBuRgjGUP95Wor4nW9jUuz6z
	JngOtm3Cs1A5pu3r3WcxVnTD5pOB7V/vDM3UBnlbP+e6mGWxQoPwa+uMoFQmJF3Hg7JgPerreFj
	wpLl5navJIaQRgBHyY6bQ0etRjAwPZl1MZMp+HbR+kQKlRhN7qx8477GMaw2BfT/EaKL4
X-Received: by 2002:a05:701b:2810:b0:1af:2ba7:e44b with SMTP id
 a92af1059eb24-1b503068de7mr2114022c88.3.1794567418689; Fri, 13 Nov 2026
 02:56:58 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794506262.git.chris@chrisdown.name>
In-Reply-To: <cover.1794506262.git.chris@chrisdown.name>
From: Marco Elver <elver@google.com>
Date: Fri, 13 Nov 2026 11:56:20 +0100
X-Gm-Features: AclHuK8EymS8R4ke35k_Ts4zDwGVpBzqd0W1daXPPjdA8aiWj2M9LBxfbR3z3Fk
Message-ID: <CANpmjNP0cWB_670hYj7p+Dd=do1qEu4XHeW+c7sTv-MXi0UBTg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mm/slab: Support selecting slab hardening features
 at boot
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 09:51, Chris Down <chris@chrisdown.name> wrote:
>
> Slab hardening settings are currently all build time choices. This means
> that, unfortunately, hosts with different requirements end up needing
> separate kernel images. At Meta, for example, some hosts are built with
> these options and the rest of the fleet isn't, and that's one of the
> things that keeps those kernels apart.
>
> This series does two things:
>
> - SLAB_FREELIST_HARDENED and SLAB_FREELIST_RANDOM are cheap enough with
>   sheaves that it makes more sense to just enable them by default than
>   to make them switchable. With both on, system level benchmarks didn't
>   change measurably, only slowpath heavy microbenchmarks did [1].
>
> - SLAB_BUCKETS and KMALLOC_PARTITION_CACHES cost memory (Harry measured
>   about 1 MiB and 18 MiB respectively after boot on a 64 CPU VM [2]), so
>   they get slab_buckets= and kmalloc_partition= boot parameters, which
>   default to on when the option is built in.
>
> Whether those two should be folded into a single slab_hardening= is
> still open [3].

A coarse slab_hardening= option can easily be replaced by
documentation. While less knobs is better, an intransparent coarse
variant of slab_hardening= just makes the admin wonder "what does that
actually to, and do I want it?". They still have to go and look up
what it actually does, and at that point it doesn't add much value
(alternative suggestion below).

> > > light: "I'm willying to sacrifice _some_ memory and CPU for security"
> > > full: "I'm willying to sacrifice more overhead for security

Who will decide what is light and full? I think there just won't be
any consensus reached.

One thing that users may want is an "all off" option, similar to
mitigations=off, should they wish to get max performance back with a
single option. So you could consider slab_hardening=off. But at that
point it may be more consistent to drop slab_buckets= and
kmalloc_partition= in favor of arguments to slab_hardening=, such as
slab_hardening=nobuckets,partition. This would mirror mitigations=,
and should cater to the usecase of slab_hardening=off to get max
performance with a single option.

But I would not add options such as 'light', 'full'.

Thanks,
-- Marco
