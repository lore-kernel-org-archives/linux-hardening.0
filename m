Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E022571D7
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144406; cv=none; b=TrgVUpu0PT3w3c8MBFo82oMYBIhogxNj1kL1xK84j8WQLcB/GS/ZHdTBiBSangcpKuHNEEckBzy98FnXZrBRbp+GkAjv08bVkrPzfGJeGrpNHr0bfuGedWwEEkm0rTluchj5eeoZY9T+K3OVV1D0++jwJyILFSMYK804cfaYJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144406; c=relaxed/simple;
	bh=1HnK3HcFiLY8fBtrCSFjv5zVe3yaxICG9AUDneVAW6c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1ctaN3ALt+fnacY3zQZlNS/9SVYizneuE/0KYA1TiF+5enc2vhfU9q9u0DsVxSbSzBNbrZaCtYxUF499VpJbj28G90rX5NgcJobnNikBXigLItwL7vrPlLqCCU6Uvs6tqgCkjJv0QhHotvbf65vZsALVra3LwKQz8oxrf2j6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIhrxtlD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIhrxtlD"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39ee96f8047so18687281fa.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 02:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144403; x=1785749203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LY96VBCIVCWyS8BG6OUhwt1DEXbhg7+TrPUmrkQFJKM=;
        b=CIhrxtlDQ7R9dNBQG/ZrgJUnIH7fuvWPtX9hNigwWDE1L2UJ7vsN1by3O9cF/wUanj
         q2wLwcv+8QwKQZ+sRXH6DOvKSlzFNbzGqLlRNhJocOhJJtV+M8vjCd2ufLBWm6/nApMs
         u5U/cvnYHXw+248PqsUL5xS4EcOTgMnAx02Jc0B8nKDFo+QMvAMEbidAihfBRznaclp+
         BSEytgZZFMnoP6qgWVzbbQduZmZEzH81bfN3CnLYxMbw7gh/rkZMHrbJ+6z7HBIVSAlF
         ssz3qgTgVJtZEyNMUMbzVOMpCG52eCidoKbSv7inOF4lqQXBP+VW6kh8O1P+uu4dGgsN
         CLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144403; x=1785749203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LY96VBCIVCWyS8BG6OUhwt1DEXbhg7+TrPUmrkQFJKM=;
        b=XX3eHChGNRGEqV0SAHRbHqv8Dd3mXfsH4JYo3/wMxPpRc/2spAaKpNHcuKC6Z784J+
         x83iJvoyubpWmSH4ou3otyYVlmYcTGdcW6iQjJ0Zh8cxazXI7uQVZFx3e8gCojQ6kpr0
         LFjYsvw8MwkrXL+TmwPasRcEuloscJyagnGgISLE2EF7Jyp3+Rc5APIVJgy+BFBHk7xm
         nFIi68YSyBpfqty+e8KkbbZYRlIoic+3KIHpS1gUKjYdlQyldrJ5njWLinL+z1DsEUC5
         yUyUT7BVeY160D26OvPFMJGBuaAQCcal5g3XfQwFKcurAmXmet//h7puX3/rtyqyO/Af
         IhOg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6WrcasBVIYrAPOGHXiF6HB1scy20hYMwaOgtvaGS3vue/ZNlStE04bg/izBBKkfwS2rKQaKLGQzejoaSQVnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeqi5jWGlX3e0gYfTNtyNLxh1JCAOuVe3iNHsNYY6O7iwTNcI6
	WIPP/qeLIFt9ZS7o4lDOuvw/sV9DieahXkQT17Gxlr/K4kkT851Y3jy6
X-Gm-Gg: AR+sD13SEO1muwCvQ9jNglK3OwbCF68oLoK4rcjW0ubCp4/SCNOHj/nyFgQey8829dt
	tg2oAYdMJYjDqg+EwT+fqDh+G1dJCUz/jQETfDSFF3Eft1ng833N+aRBNUeUW27qgdMG+1/F0Ep
	laP7U9JBGb82094VyepMLwosTbnoI+4bgQP2ls9dI/Yqyk/mq9YNCD7ZFsSXmvpz1FXWERH/aPQ
	wlyTSAiyEmDAVEPJAgFmbSntUzs8lKUrTIUVQb86GYGMRD7o5Yioznkt9vQLjXElrKRRtWg+Ln6
	MvKCEUAJmwX11iGkrMP55KL4jnRuJD1KVVGB0lFim3+7n9D4y1w1VXo3luEaRg5L5aEIVC1VwkH
	ftMA4ik53t4WS5Oo3kBEbQYKwUATQLIzkX6/Hr5v0VR5BB2R/EMZVnQ==
X-Received: by 2002:a05:651c:b22:b0:39b:1776:6577 with SMTP id 38308e7fff4ca-39f2886d316mr12710311fa.40.1785144403210;
        Mon, 27 Jul 2026 02:26:43 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22173131sm12238271fa.2.2026.07.27.02.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:26:42 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 27 Jul 2026 11:26:41 +0200
To: Dev Jain <dev.jain@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, kees@kernel.org,
	akpm@linux-foundation.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
	anshuman.khandual@arm.com, david@kernel.org, urezki@gmail.com
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc
 allocations
Message-ID: <amckUdXO-7TtzhNg@milan>
References: <20260722142936.3287702-1-dev.jain@arm.com>
 <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
 <amXldUo3LfIGs-zs@casper.infradead.org>
 <0a312983-3d63-4d60-8ff4-d53dcfff7819@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a312983-3d63-4d60-8ff4-d53dcfff7819@arm.com>

On Mon, Jul 27, 2026 at 12:33:49PM +0530, Dev Jain wrote:
> 
> 
> On 26/07/26 4:16 pm, Matthew Wilcox wrote:
> > On Sun, Jul 26, 2026 at 02:23:20PM +0530, Dev Jain wrote:
> >> On 22/07/26 7:59 pm, Dev Jain wrote:
> >>> The vmalloc allocator stores the actual allocation size inside the
> >>> vm_struct structure. We can use this bound in usercopy instead of the
> >>> page-aligned va_end to catch usercopy beyond the actual allocation size.
> >>>
> >>> For vmap, the requested_size field is always page-aligned since it maps a
> >>> certain number of pages. Same for vm_map_ram (alongwith, not even having
> >>> a vm_struct). So the check is only relevant for vmalloc mappings.
> >>>
> >>> Because there are early vm areas registered even before vmalloc_init,
> >>> requested_size may be zero. So also check whether the requested_size
> >>> is set.
> >>>
> >>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> >>> ---
> >>
> >> Sashiko:
> >>
> >> 1. "Does this locklessly access area->vm after find_vmap_area() has dropped
> >> the busy tree lock?
> >>
> >> If an out-of-bounds pointer falls into an adjacent vmap_area, and that
> >> adjacent area is concurrently freed by another thread, its vm_struct
> >> is freed. Additionally, when the vmap_area is moved to the free tree,
> >> area->vm (which shares a union with subtree_max_size) is overwritten
> >> with an integer size.
> >>
> >> Would dereferencing vm->flags later in this function cause a use-after-free
> >> or a wild pointer dereference?"
> >>
> >>
> >> I don't get it. So usercopy is checking OOB for an object but shouldn't
> >> assume the existence of that object while using it?
> >>
> >> It is a bug in the caller if someone does vfree() while usercopy is operating
> >> on the vmalloc object. I don't think usercopy should handle it. For example
> >> we don't handle it for slabs currently.
> > 
> > I think the question Sashiko is getting to is how we handle:
> > 
> > 	char *p = vmalloc();
> > 	copy_to_user(p - 4);
> 
> Thanks Willy, I completely misread Sashiko's point.
> 
> I think this is an existing problem? We are using area->va_end currently,
> so we can access freed memory.
> 
It is a bit mess here since now we need also take into account a
requested_size due to vrealloc. We have requested_size, nr_pages
and size in the vm_struct.
 
--
Uladzislau Rezki
