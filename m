Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3E2FE57F
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476208; cv=none; b=NiNsLN5muKV41hmwASsKV3JETXTISkw/XdDxAJjUpukLuhOMEjbvoN1bFbeheErMuABwkJmJlqh59nu/0jjMoRAUR3j1AS9VIDvlTot1k7bvf1drpI5MuW4V4EnchrjJsK09EMtA9ETsaBg+v6kUvzVJd+HH1W8hi7NO3g/yJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476208; c=relaxed/simple;
	bh=Vzm9kAK03gjq3/EFXB7Lf/qLfrswTurpUBT72P7Q9wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9b7qx6IZdZONdAUCJJ2DHH1LmDDEtJI9NhWDLF0tOUVfHCc+8oDJqjWxz78/yXTwHdB25+gXQxdtf58Dhm5qZ7dKC4eC4rFQfE3SsauUuca64KsY+HusH+84hPufWRLyS0woFAoCIrDqbRTm8Pd2PDuzPSnqz1EqoQZTbISb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B/WGySyv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B/WGySyv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed9c19248bso52002751cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763476205; x=1764081005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gAj/lhLwXUkQIe838UyunLw5D1V/iLtJCJGMnOEEnt8=;
        b=B/WGySyvLaU8JIymArDTv5WHkDz63O8yjgtHNuDkhXoWlTVVEPwduRMKJRIl0VF0pt
         8TX3wC2CbRl78X8YvI6a76RvnNUvSap8sF82eEalnIXUMlSH6IQZ2lf/EfXMaqK3D0ge
         X5WIamr7y8ESnWfA/FuSzY5Ur6gzM7VRfSLkcWXG5ZJT1jx/WSECD5qqvvLR/jW4FtK5
         lXAqbLAS2gBp1REviCoz1CfM4ZfT1CkwTYXQnaa+Q+f0AhzEUqD9RCYPP7bMY70mYbIq
         d0nSRxqUw+WlBG8E/FBiGUk4abSaitO3o2hlCXsKqA/G/VWD92vKkCqNV5klizdv4fJN
         4ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476205; x=1764081005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAj/lhLwXUkQIe838UyunLw5D1V/iLtJCJGMnOEEnt8=;
        b=SyGm+fk591ctaIkbrIbLBCi1x1eMzlfmGkjTU1sgPdCg6zRGm6RBOVY3dHlFYNTgUC
         fBL2KAmX5bP7+duA50/KN5chgl0GbShPqBXwmt7AuudmPxuPCTZmgnzFnB4nwwJJ3ej/
         HChvp9QLL76b1KaNFfbYwtJA809EXEYU95OGX+AiiednU5KH1srH+u9zrJbvkbykzNwz
         442/pbPNVFsQIHHbiymjRnw6NY1k9wDAApxlNMdNw1CXteOwlnIlUzfsIJ7DorYmDuJT
         hxHyvhEZ7gitZ/pz8QLB5cAzDxT6vwMk8WcHaYaW+SrblzF1tQZ0x30kgvOEcxJXV8Cr
         NurA==
X-Forwarded-Encrypted: i=1; AJvYcCWbQS//wR7YmnrfeWLA8THDUdLLgipjHQvaxk7vNL5gFGJoYZuY1Op+Cx/ucZZEX5AftxQwLporuIZh/xqYcdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+LeuVbb5/5WV0aUWvBDuKuK/G10h0rKkytpnMotTChf1ezqI
	LmNMZBGGdC83jwEnzfKymC/dUELUwnsGbz5wKgRcTn8NAcqX1bgpt+Gdm2CnL1IGiH8=
X-Gm-Gg: ASbGncsWeky+x4aDi1vwfbnFS3cqgGMtf/LO6b+To2FlO/+YvFRI3PTGg2/XiO/PDjc
	u0wtBMHmJGIIUL6MGyl/z/jZDis73Bk1ylLV3H0lToEwhWXif+tg56iMzj4jx36nWLTe6/A+x3K
	DPS0CPjL7lCCv/O2u3T+QQPZrPUTT2pZC9b+JDnGn+tQVe7ezeK8lNABz2tFTEAmYDeTgNU8c8u
	zoyMSsIpPLGugYYe617Z/7eo5Nxg2mSkMN4DWi7UaBC0LljJ9NnFppquz8/ekWvDBly8q/m/I1I
	HqCOzOZN0d8zMDKSY4Ykzg/xQ/hGg8lrBZnGhoZZ3yVJA1NG3wMMdNgH+CRdm0e/e5wCZ0hF0lh
	38SSbmMNgSSCK7k0ahnn6Vryx+6UzttWAjAbbpGRqGGnJtt2b8L6vyxZcONviFFQdZkt2RIkMwJ
	IIzj5ijcgtKOUvvD93QxPJifpLX7XUxh1bPKH/HxKVIxNsFg6u9BNbUAeFGLNc4PXed88=
X-Google-Smtp-Source: AGHT+IGl2QxjkDkgi5jKGR6lwtLy9hLDUjSd3xhjzd2vh/OGWRtCENW0fUVdt2sQ45uUuO7DIyidjQ==
X-Received: by 2002:a05:622a:4a15:b0:4ed:df82:ca30 with SMTP id d75a77b69052e-4edfc875136mr206770331cf.13.1763476204719;
        Tue, 18 Nov 2025 06:30:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862d0944sm115395396d6.9.2025.11.18.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:30:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLMiZ-00000000NFZ-1yj6;
	Tue, 18 Nov 2025 10:30:03 -0400
Date: Tue, 18 Nov 2025 10:30:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v8 11/11] vfio/nvgrace: Support get_dmabuf_phys
Message-ID: <20251118143003.GH17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-11-fd9aa5df478f@nvidia.com>
 <SA1PR12MB7199A8A0D17CDC980F819CC6B0D6A@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB7199A8A0D17CDC980F819CC6B0D6A@SA1PR12MB7199.namprd12.prod.outlook.com>

On Tue, Nov 18, 2025 at 07:59:20AM +0000, Ankit Agrawal wrote:
> +       if (nvdev->resmem.memlength && region_index == RESMEM_REGION_INDEX) {
> +               /*
> +                * The P2P properties of the non-BAR memory is the same as the
> +                * BAR memory, so just use the provider for index 0. Someday
> +                * when CXL gets P2P support we could create CXLish providers
> +                * for the non-BAR memory.
> +                */
> +               mem_region = &nvdev->resmem;
> +       } else if (region_index == USEMEM_REGION_INDEX) {
> +               /*
> +                * This is actually cachable memory and isn't treated as P2P in
> +                * the chip. For now we have no way to push cachable memory
> +                * through everything and the Grace HW doesn't care what caching
> +                * attribute is programmed into the SMMU. So use BAR 0.
> +                */
> +               mem_region = &nvdev->usemem;
> +       }
> +
> 
> Can we replace this with nvgrace_gpu_memregion()?

Yes, looks like

But we need to preserve the comments above as well somehow.

Jason
