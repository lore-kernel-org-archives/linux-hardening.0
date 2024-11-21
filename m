Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8A1428F3;
	Thu, 21 Nov 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210287; cv=none; b=gjYsMmeqPsDHEMHgXH8riUBVItzLkIldCZ3E01zST8D1tb+Hy1NXxUDx9+uXwpdJUGHe5WKWrhbSAHImPmbkOZNuiIhIRtkRDo+hzbvIndvVCU8xtE4rvXjNqNur0cb38kbh7M+6qk9RtxnRWwTlFZCzZ0mAhGJsEL/HQgJLcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210287; c=relaxed/simple;
	bh=gWkFbuQhcFrLPoXAmYRoWDIpPlMZO4hJDf4QSAXnhe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3rtWSHV0VyqHIvBe2QBGwi6yinqrdBvIzR4RkXq0yT8UlbnzeMMGx1GBdEJPQsjnw3hHzjri++evX3p1omrPy2iCGpeeNDmGfv5pfUJoIg1jJIu8TuHkWCYKRwCeZ6F9NEduH4YP0DRqtpV4toxUYc7LFyDaaWw0GwKAbgFF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms0QCcPR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms0QCcPR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ed49edd41so217680066b.0;
        Thu, 21 Nov 2024 09:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732210284; x=1732815084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q0HSP14gsDRlQDPzMJwpcg2o9yYkTm2IHCEX1dby3U=;
        b=Ms0QCcPR+P5aXq7DZ0MBuy6tH9i81vkPUu63J9XDlvNUXvysE2MSA9bERusuygaGAo
         zteDPPzfqM6+LvFGEQw122kKSLs1II//4pXu3+8luYGBi/oApOdI6js9HXEt4H9qa2YW
         FQfOlQbRiizw4ORJ3WNOshFGPC+uvW1s8kJedi7pYXfxNSN1DmFUrxLKbZz2Ekl2tWfE
         RhazJcowPhZ4PUvOmyryG6Ua+klXOt2bLJLTKiph2mpb55gQk9SgPxMDLDmlrQD3Aq0Z
         fvQFgoSP8+/TUxtP4RUKmsfHOtPwGZCMEejbP2bvOfC9BN8vSJYSOnSVLgEVEd3ygDnt
         U5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732210284; x=1732815084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q0HSP14gsDRlQDPzMJwpcg2o9yYkTm2IHCEX1dby3U=;
        b=RfcO5n9yGXEpFteIZpDwgqnV6wBRo51gy+inPhwxhGywoyeI8NTdgAqGEZuaZcWhyA
         0W4dokxSy4PjKnr5I7tex1Rukcm6TxGqebGI7rEbTBgX58fFojClzV6eAFuY3Luilwuq
         64uBtnq/xKjrplNcsOqLn6FP2Sd4DvbhpoTELkDHGXtjrh57zuZklJ0uL9A2rFr63Bnc
         vMQYesENyFev3bo07KtTf3wPaEhHd6Re+pBorwbGvonMN3owszdx9jtuLbVeHY/32UBa
         j8kQI+gcvTACV9Y4WBtPpQzgTb/4y1hUlo337aUEwg3YIvUKmvQOLdExk/DOXxpzWOhp
         0QjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcbVeul8F1AM864oCcO1epCyMLw408JwZxXfGoBtZU+zdH0ZtWed7ncTI8Wb6J+hEZ2+Gs74DxqHa19c8c@vger.kernel.org, AJvYcCVOezOMvMZN2jKUUHm+DFB4+t8YIICSK4ReXoioLe1BJC8qUJP+CqPjVt8OE9OsyAncKOzwagmbIFd06WOOCL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVWCWazUe1d0JN5iMBBFuI+Ei0Ev6GIUBKEo12xoOFKPDs1/X
	7JRLR7kCwdgquNBci2YOs2ZAydV6rpMrVMjYcKicqbg51FFlC4cuV/+HpKbZKls1GW2hKGIRdoq
	hW0pRd96KepuLUWuhzPoFlt9wmMg=
X-Gm-Gg: ASbGnctqkCCJCbMEKzdNkzq4NxTRW/X96tLobAhmArEGmXiM7haNKVzQ839rEcUQTjb
	1t/NVEucrz92IgsVLdS/BIj0lh7ZVATQw
X-Google-Smtp-Source: AGHT+IEAuXYouPzIxNe16bNiBXRZIrAokIEtDRgIVHICyfbrOcySGz2sZoUZttoPy6RQM8tiJGfABgF8q6ET0f019cA=
X-Received: by 2002:a17:906:328f:b0:a9a:1e4d:856d with SMTP id
 a640c23a62f3a-aa5099c0886mr1492966b.22.1732210284086; Thu, 21 Nov 2024
 09:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119205529.3871048-1-bjohannesmeyer@gmail.com>
 <Zz2r73CFtfuRmjup@infradead.org> <Zz4vzSRcdjvWNIgK@kbusch-mbp>
 <CAOZ5it1v3zxiavxctm-d32bT9aO701Os1-EnEeG0KCUhBPLMnw@mail.gmail.com> <Zz6q85eMTko7P-Y3@kbusch-mbp>
In-Reply-To: <Zz6q85eMTko7P-Y3@kbusch-mbp>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Thu, 21 Nov 2024 10:31:11 -0700
Message-ID: <CAOZ5it3xiMwD4_HsgXR_7-ERTzoS+FG3W5Og4sKtgthFA7HsVQ@mail.gmail.com>
Subject: Re: [RFC v2 0/2] dmapool: Mitigate device-controllable mem. corruption
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Here's my quick thoughts at this late hour, though I might have
> something else tomorrow. If the links are external to the dma addr
> being freed, then I think you need to change the entire alloc/free API
> to replace the dma_addr_t handle with a new type, like a tuple of
>
>   { dma_addr_t, priv_list_link }
>
> That should make it possible to preserve the low constant time to alloc
> and free in the critical section, which I think is a good thing to have.
> I found 170 uses of dma_pool_alloc, and 360 dma_pool_free in the kernel,
> so changing the API is no small task. :(

Indeed, an API change like this might be the only way to move metadata
out of the DMA blocks while maintaining its current performance.

Regarding the performance hit of the submitted patches:
- *Allocations* remain constant time (`O(1)`), as they simply check
the `pool->next_block` pointer.
- *Frees* are no longer constant time. Previously, `dma_pool_free()`
converted a `vaddr` to its corresponding `block` by type casting, but
now it calls `pool_find_block()`, which iterates over all pages
(`O(n)`).

Therefore, optimizing `dma_pool_free()` is key. While restructuring
the API is the "best" solution, I implemented a compromise:
introducing a `struct maple_tree block_map` field in `struct dma_pool`
to save mappings of a `vaddr` to its corresponding `block`. A maple
tree isn=E2=80=99t constant time, but it offers `O(log n)` performance, whi=
ch
is a significant improvement over the current `O(n)` iteration.

Here are the performance results. I've already reported the first two
sets of numbers, but I'll repeat them here:

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

**With the submitted patches applied AND using a maple tree to improve
the performance of vaddr-to-block translations:**
```
dmapool test: size:16   align:16   blocks:8192 time:43668
dmapool test: size:64   align:64   blocks:8192 time:44746
dmapool test: size:256  align:256  blocks:8192 time:45434
dmapool test: size:1024 align:1024 blocks:2048 time:11013
dmapool test: size:4096 align:4096 blocks:1024 time:5250
dmapool test: size:68   align:32   blocks:8192 time:45900
```

The maple tree optimization reduces the performance hit for most block
sizes, especially for larger blocks. While the performance is not
fully back to baseline, it gives a reasonable trade-off between
protection, runtime performance, and ease of deployment (i.e., not
requiring an API change).

If this approach looks acceptable, I can submit it as a V3 patch
series for further review and discussion.

Thanks,

Brian Johannesmeyer
