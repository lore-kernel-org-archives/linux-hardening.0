Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478835A129
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559433; cv=none; b=Ps35+W/JrN/SxBUGBeBTYfeu39CzUgIAJK0roqQDHa5r95aOOtHC1oHupUuBH2oHxGpjPD2R2tQeeh2QZs+iGXbM/cj4rELOtJ1ngN0+Vu1fX1rQD8rFQPjo8HYA395PECWhsR9n911MbxGpbjngAB0aH21U4u5mphi9wEppm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559433; c=relaxed/simple;
	bh=xHij0HoeROljwYVIzlugVWfpQyDCueEmuef+LW2XwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4i6WpQHIRB2HnyCkiEnyV6CixFXDeGagvkymxXpFBQ6X9K07Q0nO13/pS/lbYLHAQrwLrSsmQ5XPmGAYsUSuwoz+wPSRwzA0Df9G0hdV+xrbbTLggDo5QGWBZleWgh/5N2mXWqCElZvHIb+I1ZeCKQRdfo8Ys0+uE08hSt0syw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fbXe4Vjx; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fbXe4Vjx"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8804650ca32so61216806d6.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763559430; x=1764164230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=fbXe4VjxC23iYkeLY6whMHNkkabBkvJIbJP5uWEZ9VyfGmzFQGzB51LkWHp8IJDAfy
         bc+eLn4USPmSpsqj3w8yzTCbSWrINyQaCzhx2fEyFsGqHQot9GoulHgvevmJK/p+6YJe
         uuqgBjlYy9SZ2oFV1DyKPu/HDjlNaS7AdAB3/WXAttezKn3TRJQih2HNbzrWUBTHOeu0
         UJ2OeI0gafI/ERIzGOe9pXUqUOsEzFQpKb1VF8JKgbox0izii7oPTuI8eo/HdU9yTM8m
         sWOXfMhDn1cdFkJBrCL78GFZ1KRdezr14MAtsv1TRUBQrZyIN8Rm6LRdR8ltbAsYsTUe
         42Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559430; x=1764164230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEA8ekCp1nrcWXcrdpDKlGp67cbKmmAmKoKYvVWnAsI=;
        b=Ug9dwANW7MH69KgHy86DfCvL7WQa6vd2WHGB5FrK3/yXV+CWXFh/Qge6FHOrcQ1COa
         VOhkbm02OLuuiJJwQv6KpwEqf83mrrZEzlRYxUDqHMpvEOj5yWI6pZHUjXDY4uisodFD
         Xlxg24/8ebhKXAqwPb6h4gTST8W4YO8JhpDUMB8KLIu8q7tmYjAxJzMAtfn11W530r+M
         7QfPmt0Wod53O2bKkYi7rLJTW9VE8UxFf+HH5X2lEoNtMBUAo2qY23T3eU3hlezXvFWf
         0KGp4Aw7NTyToTQY/9h20WLwJ11owOm1X0cqKlK87OYQa6lEKq/GXl3NMqzVpkmWpdh8
         TT4g==
X-Forwarded-Encrypted: i=1; AJvYcCXC5So2aDbhCCGwE2tOQMIjL9qI/+0+lKELMiSrcAIjUlWLBxj2RRWtFWF2tEbOPJM/xhkvR6itgVKyuTU7tOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9Z6xzfROmdEczSH3tTokaSCl04fiO9lhP0E8lxAJEyE750Sa
	tbfhspPW2aJ4dhePC1Wyk1peJxsDlixZkT2iIyDs5LjfoAy9yksv/Xz7PVWkkqnXZKk=
X-Gm-Gg: ASbGncsg0qgyb7H/qpHxWHGzSkuYBm22by76lXN0ObADVskz86Tod5yVik9gaNoay1l
	3I+MX0u9aPPynxt2RH7CI9X6HLid9pzlkvATTpy6TNBp2yAb1VlswWG+R+qDXhGmYAZS//dLU6/
	VtXXg8cNP52qTd3hRGgsyU0uR75sBA+74jTm57+gpB5x8lsUwbOsB4BDOHyXPrUl9lSeaCKcmXr
	GogDUSfo4xKXbXXGB2Xue+DAfKG2XK6J1bZ86J4uyLnPdzlv16DQqHd8MmZRoVo6NEKk1cY+Uml
	0v3f2OalMnCVNTlU5sRUNw8+Gad1YadN6rTODqeYDWXwfmVBkGJKXGfBu8uuvYgYe7bCrDHYJYg
	CA56I5d6Az2chsIy75vjYHoi6CiQ4k17jbUYm5a9TV7fSUBYUqlWwAz1X3M2UZ6xOr3zTzYSTWb
	8lw0MAsuof9qYfwAnhYkV2Kh6L0+fQmenjYQX89eFMUCiRdFRYjDL2OjcZmZCdtO2z7wc=
X-Google-Smtp-Source: AGHT+IGopBrMkEkq4/9KDO3x1qdzFmkcFO+Cz6Is5DlvxN8PyWRrz38DMZOLki2k1pBf80D+Z8AYkg==
X-Received: by 2002:a05:6214:419f:b0:880:22f3:3376 with SMTP id 6a1803df08f44-8845fc3e0f0mr26190076d6.10.1763559429603;
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm135128356d6.0.2025.11.19.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:37:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLiMu-00000000ZAY-2EdI;
	Wed, 19 Nov 2025 09:37:08 -0400
Date: Wed, 19 Nov 2025 09:37:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Alex Mastro <amastro@fb.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v8 06/11] dma-buf: provide phys_vec to scatter-gather
 mapping routine
Message-ID: <20251119133708.GM17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <BN9PR11MB5276BC3C0BDA85F0259A35058CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20251119133000.GB18335@unreal>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119133000.GB18335@unreal>

On Wed, Nov 19, 2025 at 03:30:00PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 19, 2025 at 05:54:55AM +0000, Tian, Kevin wrote:
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Tuesday, November 11, 2025 5:58 PM
> > > +
> > > +	if (dma->state && dma_use_iova(dma->state)) {
> > > +		WARN_ON_ONCE(mapped_len != size);
> > 
> > then "goto err_unmap_dma".
> 
> It never should happen, there is no need to provide error unwind to
> something that you won't get.

It is expected that WARN_ON has recovery code, if it is possible and
not burdensome.

Jason
