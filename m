Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C221CA0D
	for <linux-hardening@vger.kernel.org>; Wed, 26 Nov 2025 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162773; cv=none; b=MstHpSPzj/1LIxScmuUPuctX316DPnSVYv10OL+mtYkS5B2bhcZClvX3X3N5CSACHbWnKUHzP9bEjnCz4I3ERb1beDmSs/kQw9T3KGgUSrd6xNEBvDtw1qekeyqq8JXOC+lOr9rN534C1Y41WcLdkWFSUsSdS9adzlMhxQeIK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162773; c=relaxed/simple;
	bh=Jo1hwBQ1OAKjPw3AJMr/P9Kbq4e9sCgCina51O06nNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=finB+m5AvrhPK93QVwXEehGxz1JtKFJvslV8S+Vs8wtwVZBfr2nEpc5Yw9qLIKf5r7utxJTBrEsoA223ym5J6YNB6pwUsjgE1FPVnMv12BUob7xmc2nVAGXiATaUBAYmYEnIFDDcJ5MXcfWJRplJbrp/B3w1GjDsrJEvxSf4SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0l/5TvTw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0l/5TvTw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2980343d9d1so158425ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Nov 2025 05:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764162771; x=1764767571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=0l/5TvTwMZVpkD0BWtEXg5dW5N9AUKyXKn2OXl7vYSfXG6M2yRr080jIEYwyfqPEAd
         wMne3IxRGt0ErWDHmNsGn+LmXZfG3rqsj6HwxmqzPKf7n+FLOE5HFn2X4l77O3MBtID7
         vxzpILnpr5BHrOJ8XTP74p5zo6lEEpNddTzRqW5Hl91ynh57gDKQUzAB/nt28L6UGsSc
         8VwkNrMdvHKhMj+OxH5o55l/r0P3RLOZAdClLg7x54zjjEMeqTfpkk20+lzJpOUOQ1ei
         tQ9ByWrlYY3io0pKAa4iAp1bTao94cm4S95Fi1Ta0s2+MgqcGmY6ZV+u6TQ3AT19Xpib
         TGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162771; x=1764767571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7j/p6bUr5Xuh7DTD99aQLTt37H/gN4j/r6C1+HVuuw=;
        b=nzDEZk5u5TzbWs/k2063VIRWzONfayhBSwyVt7UgyDYd6MkewsCLEnxBJLEo5vKsnr
         J0k6QbFnQK0oG51ispTGiltvHXQgZTioVZZe/+Vq+DO1W9m4n4oUyJ5pIgytq9Ti2G7P
         ZU1NUNSWMDp6+rxoMNbbOF2JNIV+vCsZOjC5H1JJFmk2JZ3C7KlNoJSWh/IMH0KOQ4y3
         K2VaZkTcvP3gIkzidCA3pH+iC+8yhtKH0gUuhgGiwAQaZTALSeTQIxcz8lXR0nM/7t4K
         bQsrzP2h1vNwXfGIpoY2yTfq/6CU2gTQfAqrGWlxCRmGFesa9jECilQ+PenL71RivFlf
         /3eA==
X-Forwarded-Encrypted: i=1; AJvYcCXyfS5nkhFQ/DgKL5zate9wfq/Ir4LtIeYDiRatfJ0f7AlLS6r44rLjwKy4yXBE1ASXVrog5ziLnWy/O1BgONY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4ZsXA6Ai4Hs1cVykiVaA5SlvUtr5jehTR+2LSWAnHKWMfLCE
	oRB4nbUbW/s7to/FCRqZL9YjKkoWekCIGA+8uLp9MExQ5rgxfQ84zTRJ2cKFq7HmVg==
X-Gm-Gg: ASbGncvtOsPRu5NSChrhmJTqTU+9d+aAHjmbZytEaybfopT1cuo+x6vDKICDBVbvwEf
	W91o3eA2X1ELzwdiimVS02m25923MZXHzveOoipMtOuAEcmKz8E8N3/mxH28hsPWjvEOEIp51iA
	ttIagb1rYK0+4wxmCXG1IdwNiAJBggaa5SiB7PHOOcgUzEoq8EPvotcpan374KAv5N8XlM7cl8G
	3OxseswGywQvp8usKScbMTjrGuC165QgaZlmGy6SCJWyUf9I19FGdtK04r1/tscq3EFFH6oSwH4
	OEx4zA5HBVV74itblVDFRrXxOANTXw9C5l2jJERiDe0yIEbPrkB/aFr3cKR97AwZO523O9xg8xk
	TUqv67LvA48Fgk/3cnn9ZXhKc5+DCaNxE8JC9VU1Bet2fz/+waC6QDYhOL5R2JzEDOwC+1vlCCU
	J1QP2ZGVOa1s+Exj6VEoDWJWps4v8tWAbCv/zCA8MO/2r3DcN1
X-Google-Smtp-Source: AGHT+IHJIOBgKlL+CS0ZpKtYX5Djx07PEo4PrDI8k+TVBWbcqpi0p7MakMMReKQUlItaKRJKERuBaA==
X-Received: by 2002:a17:902:cf07:b0:26d:72f8:8cfa with SMTP id d9443c01a7336-29bba9e8a00mr1709325ad.13.1764162769984;
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105e4csm194769895ad.2.2025.11.26.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:12:49 -0800 (PST)
Date: Wed, 26 Nov 2025 13:12:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v9 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <aSb8yH6fSlwk1oZZ@google.com>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-6-d7f71607f371@nvidia.com>
 <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSZHO6otK0Heh+Qj@devgpu015.cco6.facebook.com>

On Tue, Nov 25, 2025 at 04:18:03PM -0800, Alex Mastro wrote:
> On Thu, Nov 20, 2025 at 11:28:25AM +0200, Leon Romanovsky wrote:
> > +static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
> > +					 dma_addr_t addr)
> > +{
> > +	unsigned int len, nents;
> > +	int i;
> > +
> > +	nents = DIV_ROUND_UP(length, UINT_MAX);
> > +	for (i = 0; i < nents; i++) {
> > +		len = min_t(size_t, length, UINT_MAX);
> > +		length -= len;
> > +		/*
> > +		 * DMABUF abuses scatterlist to create a scatterlist
> > +		 * that does not have any CPU list, only the DMA list.
> > +		 * Always set the page related values to NULL to ensure
> > +		 * importers can't use it. The phys_addr based DMA API
> > +		 * does not require the CPU list for mapping or unmapping.
> > +		 */
> > +		sg_set_page(sgl, NULL, 0, 0);
> > +		sg_dma_address(sgl) = addr + i * UINT_MAX;
> 
> (i * UINT_MAX) happens in 32-bit before being promoted to dma_addr_t for
> addition with addr. Overflows for i >=2 when length >= 8 GiB. Needs a cast:
> 
> 		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
> 
> Discovered this while debugging why dma-buf import was failing for
> an 8 GiB dma-buf using my earlier toy program [1]. It was surfaced by
> ib_umem_find_best_pgsz() returning 0 due to malformed scatterlist, which bubbles
> up as an EINVAL.
>

Thanks a lot for testing & reporting this!

However, I believe the casting approach is a little fragile (and
potentially prone to issues depending on how dma_addr_t is sized on
different platforms). Thus, approaching this with accumulation seems
better as it avoids the multiplication logic entirely, maybe something
like the following (untested) diff ?

--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -252,14 +252,14 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
 		len = min_t(size_t, length, UINT_MAX);
-		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
 		 * that does not have any CPU list, only the DMA list.
 		 * Always set the page related values to NULL to ensure
 		 * importers can't use it. The phys_addr based DMA API
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+
+		addr += len;
+		length -= len;
 		sgl = sg_next(sgl);
 	}

Thanks,
Praan
