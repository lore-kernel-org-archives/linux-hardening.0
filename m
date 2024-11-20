Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2F1E4A4;
	Wed, 20 Nov 2024 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146416; cv=none; b=tx7Wlmw6i+djeBW4RQUu5TfR9H/bm8wk8bW7DPx8whNxnei/Ajvt6buQRdlt1X5ovdaOju+GU8X/7L5dRQ7A/f1R6ehwzLZ7FzTllRmDYqXVM7W31vi1Niuf4uXrYTBznmhJXSq8ggNH3CvTLPkxofvGkCFCzYgT0+6gnPOVkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146416; c=relaxed/simple;
	bh=OrlaZ8VnTHTr6wuAzTLHLrYRMcxnk8CCG52m+a1Go3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAeucL4m83AiJmDJpT3h85oj4DmUENqMMNXfLMEKcNMGHaIZLPc92F3aBUMk0OJ6yRzQfvo7pZ082Or1Y0y6elE0JO96WMne+SMGuIT7pNMtz6hcCOk2Q4xJTTx/+rEJYUX4lFZlZs5W5x0lltfhIiSvJeSMVMqWPuUTNAsmM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDYsGjPL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDYsGjPL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso355639a12.1;
        Wed, 20 Nov 2024 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732146413; x=1732751213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX6Gf+AddKQPYyrL3mtvV54D8Um1RsLjA/IT9zLDw0M=;
        b=CDYsGjPLSt+hNK6f18kJ0jKR7rydQ+d1HIgzAzGKSnPN0LffJzVvOBUESXw9j7EX/I
         ClvRRgRrAcNmf9WGpvkLUn1kpsCq6gOISAoIo06iwQ2jMUYI0E/yr7C33AQO0uwsTd6Z
         6vvO2rApqvbItVL3B9CkOZ05N9fgVz+nANG1riDYQHPLqj3/tI1admBEERCTDvGCGSan
         veBcEJvRHG24lAmO/cFpBOvIKyp7oTapX5x3uCRmsYbavhlLs7dtK4WupJIvbzzuzSFY
         7935sBpXaHuvG+/Ohhta3KhnNncxflyslIeBmlUO0VEsg32LYgQUAokq+oVyVjNmjFx1
         aPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732146413; x=1732751213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZX6Gf+AddKQPYyrL3mtvV54D8Um1RsLjA/IT9zLDw0M=;
        b=tzl59D4I7ynuNV9TK1OlSNzFzJh5u/t0gkxP8sJ0FMmQnMSwGIZkGqN6cjdkURh7FU
         I0zHnaSB3ywrdKJniys21nvCp0fy2k4C6GMLtg7XLsCDRrZyhjFXMPO7wlWXVi/+MDqG
         QolcUnsyfoto9UMonqKgPTO2BnCTAZOMka1JGw8WYj7JQXjArqKTdDdxoHEduVchdiit
         G7gTUH63iUL3NsNu92Lh0qC7j23bSKCkhUmEPYFlcyyBq2vUiHvD09JdBaPPEAfLOhm3
         oICyYRE24S7r22rr9EKmwpcc/5y/7pLZMFcCaXtqyYGdDupzG0GoKEq3/dHyhy5VYUec
         rvAw==
X-Forwarded-Encrypted: i=1; AJvYcCWSTBjILjVtsABGoth0xvcOHwG1uOje/pzjKm4JiMU1x9kP2495ge4VVbvZZfvLAlEIwVdg78Fz7HilZcBW@vger.kernel.org, AJvYcCXBDbIGIpbW5RKkHtgj/QdjQreG0fUMcMnWeZbDa9J/IWGaMIxntPX9oEIa9Gqf/F17WLZK+MhZcFc4EeHaaJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGGDbGI7azxNUFyjRSxifnpfvwMMOph/kOQuZF64pwWiUIUptf
	q/d5Td8vlm9uJR5KNZaPovmRMgjLdYMZV1VoA8tovlr1kl1NYUs03szo7kHlNX9L6Z1sEtvn2Z7
	dnN5e9ra/lIgJSvHTMojekarrU10=
X-Google-Smtp-Source: AGHT+IHxcfthi1A3D9ujn2fAxpaofW5+bukINivpXFmWyT9+hamEemQhOI4b+abCDV00kQZ4CJ9RBEv2x9OE9Gh3udk=
X-Received: by 2002:a17:907:841:b0:a9e:b0a3:db75 with SMTP id
 a640c23a62f3a-aa4dd59f9c1mr391988666b.35.1732146412734; Wed, 20 Nov 2024
 15:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <20241119205529.3871048-2-bjohannesmeyer@gmail.com> <Zz2tzVqql2RMSFN4@infradead.org>
In-Reply-To: <Zz2tzVqql2RMSFN4@infradead.org>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Wed, 20 Nov 2024 16:46:40 -0700
Message-ID: <CAOZ5it2KXhBy0=ktgjAHMs8ut-Go2OXOt_vnWFiUBV7uBBH5HQ@mail.gmail.com>
Subject: Re: [RFC v2 1/2] dmapool: Move pool metadata into non-DMA memory
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Given that you now need an array of the blocks anyway, it might make
> sense to switch from a linked list to a bitmap for tracking free state,
> which would be a lot more efficient as you only need a bit per block
> as tracking overhead instead of a two pointers and a dma_addr_t.
>
> e.g. do a find_first_zero_bit() to find the =EF=AC=80ree slot, then calcu=
late
> the dma_addr and virt address by simple offseting into the dma_page
> ones with bitnr * pool->size.

Thank you for the suggestion. I hacked together a bitmap-based
approach as you proposed, and while it does improve memory efficiency
by reducing the per-block metadata overhead, it unfortunately appears
to significantly impact the runtime performance.

Here are the performance results, with DMAPOOL_DEBUG disabled. The
first two sets of numbers are the same as my latest response in the
other thread (i.e., [RFC v2 0/2]), and the last set of numbers is with
the bitmap approach applied:

**Without no patches applied:**
```
dmapool test: size:16   align:16   blocks:8192 time:11860
dmapool test: size:64   align:64   blocks:8192 time:11951
dmapool test: size:256  align:256  blocks:8192 time:12287
dmapool test: size:1024 align:1024 blocks:2048 time:3134
dmapool test: size:4096 align:4096 blocks:1024 time:1686
dmapool test: size:68   align:32   blocks:8192 time:12050
```

**With the submitted patches applied:**
```
dmapool test: size:16   align:16   blocks:8192 time:34432
dmapool test: size:64   align:64   blocks:8192 time:62262
dmapool test: size:256  align:256  blocks:8192 time:238137
dmapool test: size:1024 align:1024 blocks:2048 time:61386
dmapool test: size:4096 align:4096 blocks:1024 time:75342
dmapool test: size:68   align:32   blocks:8192 time:88243
```

**With the submitted patches applied AND using a bitmap approach:**
```
dmapool test: size:16   align:16   blocks:8192 time:82733
dmapool test: size:64   align:64   blocks:8192 time:198460
dmapool test: size:256  align:256  blocks:8192 time:710316
dmapool test: size:1024 align:1024 blocks:2048 time:177801
dmapool test: size:4096 align:4096 blocks:1024 time:192297
dmapool test: size:68   align:32   blocks:8192 time:274931
```

My guess as to why: The current linked list implementation allows us
to find the next free block in constant time (`O(1)`) by directly
dereferencing `pool->next_block`, and then following the `next_block`
pointers for subsequent free blocks. In contrast, the bitmap approach
requires iterating over all pages in `page->page_list` and, for each
page, iterating through its bitmap to find the first zero bit. This
results in a worst-case complexity of `O(n * b)`, where `n` is the
number of pages and `b` is the number of bits in each page's bitmap.

If you have ideas for mitigating this runtime overhead, I=E2=80=99d be happ=
y
to explore them further.

Thanks,

Brian Johannesmeyer
