Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9343E097
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420882; cv=none; b=CVM3SxGm7iUZgNNx3QCdLghUgqAuHpJzwMXqpvBOB1LoOL8bStW1BNi7O0VVh+SHdgzvzWIpBQxgiDGY0upbUMbyrX/i4USIJbQJMrNYfD7KKKsf5QRlQgwmXkWQtxAM3Z/6zhFsRjvgqYToW5xnFNplj8mEI/hhtPdmaL3sKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420882; c=relaxed/simple;
	bh=/l6JX8YBTmoCZTLLtgy1e68Fr9FYHc9ZC8YUU9QDQk8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkhNYP02POsQF4N5oNFHl3okpVCoMGg2+OD6UmG8GO/f1oPOJPA5I9v7myPI4z/SFG8U0FUmz1tVpXuhCxlOlgMmgvVvQjnDpIhUnpOybpxyCqwf47Pqt/PC5qrrAXbb9kg1RCkQVRmMzNLAKxedjufdWawUnH6Vn4Hd0jJLEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FooMBr9d; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FooMBr9d"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c167aa9500dso288760566b.3
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785420878; x=1786025678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ak6SYqcwxupBqQSY0jHSI19b9OizZFsFl8QcJo9jk7w=;
        b=FooMBr9dLIUq4GUrtmYLMj3ydO1GVvITrcuHzcciXYyNvTdvci2OGpxHaBiFfmsQXb
         ktR7uWlKTFmN9p3skH2y8KLNVATUFPTMZehSevBkc6/ZqEHh0AwJ/L/Jqz6XFJHl/YxD
         bw4TaNK4LEgnI2sDCxf5OlEJv+UAD12L2+m3+HqQPTjBsw6BauJy+XKZK7AAmRuf8hqg
         +vEpr8kGo/wa0zZvuO0FP/Tdt6iW9dNB4/YodlC1t9nSJCEuz7fbZtp3PaI57kGFZ80p
         APgPjFlnwuIW5B3b7c/tLxLI1Nb0H00x1l8r23ednJ69roLw4yjATRtNPU+ub11Ipz80
         BCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420878; x=1786025678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ak6SYqcwxupBqQSY0jHSI19b9OizZFsFl8QcJo9jk7w=;
        b=SjcSZsafnnaaVob7xppckG40oOdliETt+GKUdp1uB8mbPDHJroMTlSDTzOVZV6u8G8
         P/NdEYbmW/tQZXd0OMHw2Y6MJkEnUWmY+b6eo6YJwdFS4ILuPw6PIshZrC3ITT2tsVAi
         gRF3Ts0Zju6+LYKLHUumKADmihkSkoFeUQQ3ge5u8IeMBnKn7F0iPPwpkt7b5iHwyhHM
         MKnnVijketR2XJxoZdoS5ZzH8lQVjrCp9AU3abU6/sTb8Sa0W8e99KfDgJXAXBJb0YyT
         vaya6+ccMcpKavDtbca3euE8QgvzHOgpMq9avINW8DNl8huy0en8iSohUBZDjElWdtlY
         N+xw==
X-Forwarded-Encrypted: i=1; AHgh+RpCzRX8d3yRcNC6J7w6rzqUkHgu8mBMhPgHeyqWATtM2LRuNr3n7bVZ/B4IUuPUOWHXMBwnQTI6o7OxUC1KR00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye5ofLDbev418hyvmRjyaI+nc3dU9Udyp1Y+WNWj8cfkWi/ILA
	+tImV0vwbwCT4fQtf8dqA2naPlXWYRUfbgfg2dXeHVru0PWia4EfuDG4
X-Gm-Gg: AR+sD13L0cQ66lBZBBla6h5jdxJ+JWxGJGUhAGYxrcMPrUNd9mQlvageGBerQhHcpIe
	ge9WzLtksBW5IdeKvjF+L2vDIvhanoDkdp1q8K9430YwPDUXiyr9VYXH3VQ8Fe7Nd9b5zX6Ekeq
	BWfjbX9BQdL8754ukIrEK1Bb6qxXhEG57BZCpuZi/a58a0mHTYwydL8z6ohFu9bfnntDPB8LWog
	aQftXYaIOYcu3c8IQ3yvaSqikhP1s3gzGO8YD656tGNcHUFLLWJC+IVRBhlgp5jdhmxyJJikB0g
	MwxAyEeJOiKAdcUogWVqn4iUE34UKYLe4efBi0qdLFq+0fqbprB9sJB+vtyxtZ9IGH1O4YAAryJ
	rlnEJok1Zd8NYAQeFBPfuRFkj9vMVxU5U/ZNFQajdwRHKI7TCXuAHYS0GjpXamjsszGRnPro3kJ
	UizjPM9yHu97DbkyikLTggkj0pCQ==
X-Received: by 2002:a17:907:9729:b0:c16:8799:fcb4 with SMTP id a640c23a62f3a-c1fbca57f27mr39736666b.19.1785420878014;
        Thu, 30 Jul 2026 07:14:38 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa857800asm74494366b.16.2026.07.30.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:14:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 30 Jul 2026 16:14:35 +0200
To: Barry Song <21cnbao@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Matthew Wilcox <willy@infradead.org>, kees@kernel.org,
	akpm@linux-foundation.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, david@kernel.org
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
Message-ID: <amtcS9NiXJj_eIl5@milan>
References: <20260722142936.3287702-1-dev.jain@arm.com>
 <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
 <amXldUo3LfIGs-zs@casper.infradead.org>
 <0a312983-3d63-4d60-8ff4-d53dcfff7819@arm.com>
 <amckUdXO-7TtzhNg@milan>
 <CAGsJ_4wGGSf2mhwykH137aA5enhgLGj=-asKe0B09tAOVP8qvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4wGGSf2mhwykH137aA5enhgLGj=-asKe0B09tAOVP8qvg@mail.gmail.com>

On Tue, Jul 28, 2026 at 06:22:57AM +0800, Barry Song wrote:
> On Mon, Jul 27, 2026 at 5:32 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 12:33:49PM +0530, Dev Jain wrote:
> > >
> > >
> > > On 26/07/26 4:16 pm, Matthew Wilcox wrote:
> > > > On Sun, Jul 26, 2026 at 02:23:20PM +0530, Dev Jain wrote:
> > > >> On 22/07/26 7:59 pm, Dev Jain wrote:
> > > >>> The vmalloc allocator stores the actual allocation size inside the
> > > >>> vm_struct structure. We can use this bound in usercopy instead of the
> > > >>> page-aligned va_end to catch usercopy beyond the actual allocation size.
> > > >>>
> > > >>> For vmap, the requested_size field is always page-aligned since it maps a
> > > >>> certain number of pages. Same for vm_map_ram (alongwith, not even having
> > > >>> a vm_struct). So the check is only relevant for vmalloc mappings.
> > > >>>
> > > >>> Because there are early vm areas registered even before vmalloc_init,
> > > >>> requested_size may be zero. So also check whether the requested_size
> > > >>> is set.
> > > >>>
> > > >>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> > > >>> ---
> > > >>
> > > >> Sashiko:
> > > >>
> > > >> 1. "Does this locklessly access area->vm after find_vmap_area() has dropped
> > > >> the busy tree lock?
> > > >>
> > > >> If an out-of-bounds pointer falls into an adjacent vmap_area, and that
> > > >> adjacent area is concurrently freed by another thread, its vm_struct
> > > >> is freed. Additionally, when the vmap_area is moved to the free tree,
> > > >> area->vm (which shares a union with subtree_max_size) is overwritten
> > > >> with an integer size.
> > > >>
> > > >> Would dereferencing vm->flags later in this function cause a use-after-free
> > > >> or a wild pointer dereference?"
> > > >>
> > > >>
> > > >> I don't get it. So usercopy is checking OOB for an object but shouldn't
> > > >> assume the existence of that object while using it?
> > > >>
> > > >> It is a bug in the caller if someone does vfree() while usercopy is operating
> > > >> on the vmalloc object. I don't think usercopy should handle it. For example
> > > >> we don't handle it for slabs currently.
> > > >
> > > > I think the question Sashiko is getting to is how we handle:
> > > >
> > > >     char *p = vmalloc();
> > > >     copy_to_user(p - 4);
> > >
> > > Thanks Willy, I completely misread Sashiko's point.
> > >
> > > I think this is an existing problem? We are using area->va_end currently,
> > > so we can access freed memory.
> > >
> > It is a bit mess here since now we need also take into account a
> > requested_size due to vrealloc. We have requested_size, nr_pages
> > and size in the vm_struct.
> 
> 
> I see that vrealloc() always updates vm->requested_size to the new size.
> So we could always use requested_size? no?
> 
Probably :) But i am not sure what the patch fixes. There is a race anyway?

You check VA on CPU_1 successfully, after that CPU_2 unmaps the pages by
calling vrealloc() and CPU_1 is about to read unmapped pages.

--
Uladzislau Rezki
