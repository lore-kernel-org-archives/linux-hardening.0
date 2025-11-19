Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C15354AE1
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581516; cv=none; b=FoIVgs9bZl96+DZkzZajBSRbsCsw03B1jVq1eiX6BFbJb3wDzoFOSpwSWdFy4FtbzC6UOFVv7mqslgCX4Nu1CLoj4yBzuySnlHj0yhDcuh7AQb4P9ft0gR8/r1eB/mNFnxo9sShbXDzaGppbg9qwhkWItl1dujyazz3fl+fK21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581516; c=relaxed/simple;
	bh=ez/Kk64Qkn4faxtP6x8udD23BDfPOJ9+UM/Y/c2urgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa6nmdIEmAFeL/Y4DJwlRFOdTCULCUwsKifytzGmu7f21h4NZfMR6eY4+YoUG93pgcFTmWNOGn63n0A0T87EuXzQWZrpsldTqxQxB0x7i8bFnDfixGiOh3WLyKQamqxmM2Oq0g8w/vXxFTvjodimVMq6FaHUMy+sd0Q9hcLz4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L4UMvPAP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L4UMvPAP"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b21fc25ae1so11335285a.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763581508; x=1764186308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngigizqFoW1/n7l/UtYTJcb/TxX1OBEkHcoOUDKA/VA=;
        b=L4UMvPAPhzDYWioXgmQd8KhZiNE1H6762XCtFNAqx3wKKkmE3xDSf3bYqxSobinIuO
         ffuwmZf4NzL4SQmiwAjzsu/ZOlG/SbwHH1tHGDRnLj1H1TlRcyZMIZC/BRgq4dfjlO3U
         ESSlmjSDSIMhj9vvFDraaZfgHrBPSBuhAP5sEf0rU9NEWTaa/MMIeM9OGXcBCaJR6aCu
         5/d2TA8eKJeVFBWRihAEOITWaxSWulToVPH//ismSQUnwpXZ6weHPTMfogbiigG9Rd9l
         3feBMqmQlMibdreY9QRmN8pwc1fk5yAOrG6R8cYPL9V3odhMjgag3rVKkdIy2DY7Ob+f
         Ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763581508; x=1764186308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngigizqFoW1/n7l/UtYTJcb/TxX1OBEkHcoOUDKA/VA=;
        b=ufJsSe4waLBWR/DCwmI52xFmpVrDMyyKD03eu03erFFy2TvkwxGHL5qe0nKHLJSCVm
         u9I5phR4NZKq31GhbQ0s0+PR7P1Ko4VR+pJkojQeDuucwIgBtuWyVfGUdmQbIOKn4uS/
         GlYe2hTUmB4s++K1WNvSr9LnwT86LwK8tAP4WhzR173qAA4t+uOTgeG7XqbDlPFDAR/2
         gbXrwrEGmBR3evzh40B0zIOH5UjBKsj27Ygxotyj5g6iBo0I1Vf/McXru0ydvjzyat4U
         o2jVUxv99lScqQ2PaQpy0Uh0isQDA7ixFEcmlevKQ5Bm45MKbpQkY0tdOuInmzRVCk1m
         Ohfg==
X-Forwarded-Encrypted: i=1; AJvYcCVvDnxgQHcXrDuDezwJ4ibjJf+MdiHRCv3f2JlgImljyDCNplgcO0cgTde7kC47frW+CtWAPB9wrWtGX1B28jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ia8+YXP76xOzK1qOwD94DRRBH+5wCagUdVcWDfcW2o+oRFCp
	aWDVN4NpYi4nz/iWBZUcyiONOvVqaFBzkp0ITFqC3XEN+rOyn0lf+VGExKrPDrNRAPA=
X-Gm-Gg: ASbGncvoeMk0jmtZnOZG+SzObDfLrBAUXgT/yj4LmM4tAjbjoU6pieI3mUXn72dtbSo
	Xw0IqJOq3LYBjnHsdJEA2uHfPJGAPmK89EQLrmEyWimqVkGm3WHzv8mPgjQL7Rb2DoYpHLUj7Is
	N8T68fnQweUzeRgGSWxEiJdYDtYgx+xCdN9OF69iePKrP8kCjq5xBPABOpa7VR7Rnz9Sjy/NCnf
	PbP7PIm7La1tOpI7VGOP+3bwFb/asN3Kcs9/AoY3BpMdqa5rUab/uKO/zGUURjPkwde4dsimcqf
	z16mibJXF73Nf6BvGYeD5YROdUHvWUGKgGGEMkIqlmG/ERoZJHGGH9AaNttij4xGB46O15QG6Of
	gK1xepnMLR/a6B3VxvZKHfnzb5eAl/GvpZRjZbF8X0jSIbn5PTYIqi8Oe/lBt79FmKwNt9dqDt8
	PnYJAECF5cOUYSDSIGE09CBwg02pwCZt9Rpr4stL1am/xh849ieqLDPxwk
X-Google-Smtp-Source: AGHT+IHM2All3T5KCtKB0YCjHC7VAw8938Pjcsqc0YyXScERh5oSqA8kZNdUfx1RTYUHZ+fIhtYAoA==
X-Received: by 2002:a05:620a:44d4:b0:893:31da:1028 with SMTP id af79cd13be357-8b3274b5313mr86654885a.90.1763581507903;
        Wed, 19 Nov 2025 11:45:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e447272sm1944186d6.5.2025.11.19.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:45:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vLo70-00000000bcb-3TE0;
	Wed, 19 Nov 2025 15:45:06 -0400
Date: Wed, 19 Nov 2025 15:45:06 -0400
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
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 05/11] PCI/P2PDMA: Document DMABUF model
Message-ID: <20251119194506.GS17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-5-fd9aa5df478f@nvidia.com>
 <9798b34c-618b-4e89-82b0-803bc655c82b@amd.com>
 <20251119133529.GL17968@ziepe.ca>
 <ad36ef4e-a485-4bbf-aaa9-67cd517ca018@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad36ef4e-a485-4bbf-aaa9-67cd517ca018@amd.com>

On Wed, Nov 19, 2025 at 03:06:18PM +0100, Christian König wrote:
> On 11/19/25 14:35, Jason Gunthorpe wrote:
> > On Wed, Nov 19, 2025 at 10:18:08AM +0100, Christian König wrote:
> >>> +As this is not well-defined or well-supported in real HW the kernel defaults to
> >>> +blocking such routing. There is an allow list to allow detecting known-good HW,
> >>> +in which case P2P between any two PCIe devices will be permitted.
> >>
> >> That section sounds not correct to me. 
> > 
> > It is correct in that it describes what the kernel does right now.
> > 
> > See calc_map_type_and_dist(), host_bridge_whitelist(), cpu_supports_p2pdma().
> 
> Well I'm the one who originally suggested that whitelist and the description still doesn't sound correct to me.
> 
> I would write something like "The PCIe specification doesn't define the forwarding of transactions between hierarchy domains...."

Ok

> The previous text was actually much better than this summary since
> now it leaves out the important information where all of this is
> comes from.

Well, IMHO, it doesn't "come from" anywhere, this is all
implementation specific behaviors..

> > ARM SOCs are frequently not supporting even on server CPUs.
>
> IIRC ARM actually has a validation program for this, but I've forgotten the name of it again.

I suspect you mean SBSA, and I know at least one new SBSA approved
chip that doesn't have working P2P through the host bridge.. :(
 
> Randy should know the name of it and I think mentioning the status
> of the vendors here would be a good idea.

I think refer to the kernel code is best for what is currently permitted..

> The documentation makes it sound like DMA-buf is limited to not
> using struct pages and direct I/O, but that is not true.

Okay, I see what you mean, the intention was to be very strong and say
if you are not using struct pages then you must using DMABUF or
something like it to control lifetime. Not to say that was the only
way how DMABUF can be used.

Leon let's try to clarify that a bit more

Jason
