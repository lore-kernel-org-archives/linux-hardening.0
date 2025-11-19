Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898636998E
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580688; cv=none; b=AaQlgjl6Bi6Sz977eGAod7iKpbihSXxdEOZ67dGtKyc3+L7pEs0CIACd07lUPMyr1V7UGDiNrU/pgdiOnRyXkQT/PJ3lWdgGuhH/elcDc2RUXA0FjmrfRC9eUXnmb/GE2zmxIQalqMw/lhCZFZZ4W5RVFPbTmcmW1H6aZ0epqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580688; c=relaxed/simple;
	bh=31o43Jiq7+42iBKuCHD0EJijctYU11Xzmoh7F9+p7aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfDp8bMZ8jOkQhngyE+IAe9zRliocJ8y840qQRF60Xe0dJbtCCE1TEIo8+SvBLuVqWeOfl73L7lvDxxmgRfQoNWbZwyHknbJOy8o0SsnZQ+p2mKhGtFPWzsAC/XzsfexFTinYJkIMjg5PGeJU6VQUnACPHMlDTdk6YLXuFyRU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XdlJDak+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XdlJDak+"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee1e18fb37so1175581cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763580676; x=1764185476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7MnLKcAx1SQL4BtR2OdhLpsdZ14wJj1fNMBVXMaHpI=;
        b=XdlJDak+5BK913SU3JuefgTys0Pu3jagmK7yJRyg0hso6vBbEnNWrP/4T4ol0frYeQ
         v72slbgWiUzUkvc5J9nruxngr4U8bjd49BPaZVmvFk3nVkQeWMFAA9u86tKqv9X1hNhK
         MlqYYLa9OWUP32XsBcZxKrfLx3/P5R6PJ+h5hBO1AY350/0bZcNA4a3VB+Mm2EZq+tuy
         2zW8VsnOjICqJWrFFskAlkKYKVrHI+m3LVPh9ZWULCzK0B6ii9jOvGUvNr+rAbET5gKT
         aIqFqtGZMVR1/oWhdLlQH/aHK4RI3YFZ+ToY0lGX/NpOTOSRqsVtdilqIlqws45I3kGI
         vpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580676; x=1764185476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7MnLKcAx1SQL4BtR2OdhLpsdZ14wJj1fNMBVXMaHpI=;
        b=TNvJILFfd6ci+/F61jMQ9+mUd7JwaFmWCG6PSLLj/7bSBJetNCOZP0ju/QL5T9O9UZ
         Jg2Pv3wtXAQUgl+SNWtB1WjiLUiXFMMXCYH9scsANODzJPokjK6UciPzNaZtenHoKSS6
         UDZzDBY0PNQv7YDj3NoMyI8luQKl2La1nhSRSA3mxQaqIQMpMX1jKNK8Sk7rn0eZkBL5
         TSQ0UTBGE0A9rT3758OP3OivTCnCy6kKmuoM+X0X04RdQCErfpVxbPolXOZr2+W0Z6mo
         cz/aR1nzuJj4nzc6q32TQUsztrW9jEwOPiY9GOjtVxKa0CfSqCtduuvxIkDSBcsRfZ9W
         cFKA==
X-Forwarded-Encrypted: i=1; AJvYcCWTe+Vdyjpj/YFR4uyuJtr0YMsd7WNEPnZ3uNBxBK4usNEE+RF08wZHWAHVONMWLwVXWSHSkvEDRjqioahg/M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTmkQ8pxPCqSVLkG/e7NqL/GOSgsYkkpJ8XPGs33uuFmrSks/
	evFJRCWMwcUCyJ8QS7ohFbUUz/Gb/DZyi3OiEbYBqu98yQFUDJw6Iz+hkNmGUHwYIbA=
X-Gm-Gg: ASbGncsMvgOclGkRUo5fcuEuWLzSoPsANPpenvEA7ej3Cp7fACGqMUrhsg0dm2aKW5F
	F1+na8ngu6IgQXIp1UZSALVR5k19o8xgdrigKvGoAK3TI0sZ0XH7eoesnlVpT/yLZ7GYXY52Dyw
	kmXkkoKVP5pwHg8mNElkEK2bMWonbuc6t0BMrmx3D5Q/86gvW6x/TX7TpnYAJ2NV0C7vuQ0r6Jl
	mVTM+DCHNcVtjy+lKTITMxTxPyTEf6VzACSxVFYDg7/BY22tfl7pArlh6ImRfHjs9yx2ybUnSE4
	0tJXqjEVaCldXkkjyvsgOQEU1fnSnwxBokW0KWF75YlJyXYCAlWN0irGd43uUcpKbw38WvqHg/x
	MNWMJ7luNCH2MPUauddMuvPy/ygHU+w7O8NKBenENmyyv8MEificonCZMhyO8n8Q4HQrQsI4UZh
	MBjKqyHiTiz9llDc+BCLZtVIriAQHHoPtBkv8rYrfTtNx8UjbChIQB/lpEjKpdWXgRahQ=
X-Google-Smtp-Source: AGHT+IH0hpvR5twkqRmVGMRtAcrCxesRIOb4Xizv2z5I0TXHRJV8nSPA0Y9PLt873fJAl178vHWixw==
X-Received: by 2002:ac8:7e4c:0:b0:4ee:4a3a:bd18 with SMTP id d75a77b69052e-4ee4a3abe64mr1136891cf.76.1763580675980;
        Wed, 19 Nov 2025 11:31:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e46ed0sm2807721cf.20.2025.11.19.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:31:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLnta-00000000bWq-3r3x;
	Wed, 19 Nov 2025 15:31:14 -0400
Date: Wed, 19 Nov 2025 15:31:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
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
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [Linaro-mm-sig] [PATCH v8 06/11] dma-buf: provide phys_vec to
 scatter-gather mapping routine
Message-ID: <20251119193114.GP17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>

On Wed, Nov 19, 2025 at 02:42:18PM +0100, Christian König wrote:

> >>> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> >>> +		dma->state = kzalloc(sizeof(*dma->state), GFP_KERNEL);
> >>> +		if (!dma->state) {
> >>> +			ret = -ENOMEM;
> >>> +			goto err_free_dma;
> >>> +		}
> >>> +
> >>> +		dma_iova_try_alloc(attach->dev, dma->state, 0, size);
> >>
> >> Oh, that is a clear no-go for the core DMA-buf code.
> >>
> >> It's intentionally up to the exporter how to create the DMA
> >> addresses the importer can work with.
> > 
> > I can't fully understand this remark?
> 
> The exporter should be able to decide if it actually wants to use
> P2P when the transfer has to go through the host bridge (e.g. when
> IOMMU/bridge routing bits are enabled).

Sure, but this is a simplified helper for exporters that don't have
choices where the memory comes from.

I fully expet to see changes to this to support more use cases,
including the one above. We should do those changes along with users
making use of them so we can evaluate what works best.

> But only take that as Acked-by, I would need at least a day (or
> week) of free time to wrap my head around all the technical details
> again. And that is something I won't have before January or even
> later.

Sure, it is alot, and I think DRM community in general should come up
to speed on the new DMA API and how we are pushing to see P2P work
within Linux.

So thanks, we can take the Acked-by and progress here. Interested
parties can pick it up from this point when time allows.

We can also have a mini-community call to give a summary/etc on these
topics.

Thanks,
Jason
