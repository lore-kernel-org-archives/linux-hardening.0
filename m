Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281B33A707
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644850; cv=none; b=D/Ez9ZU7Pf4shL56qSS9ch7dGPUR4V8kSVkAu7psPhZth02EZCcBCy/NAfdZ03WcyiGlcH4QI4DHb8LIOF/xQlmVFVfArfgGLcdFHBWxO9efXWvdaSYZI/34C+qZq2vZw8gWNUr0VaIpte3JHzZBWpfATA+2pEF1WnkE+LsVgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644850; c=relaxed/simple;
	bh=FAIy2u4gJscDNGUshiInImCPqOKl3iOKQJH6e6Bc4JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j73Is1L1y/hYZPTLGyM2b1FX5oE11NPoP8+GHXxjSWSqBJH27j8ZTcBuYQpTPxx8s89sj6hK9gFFbTcg/VLnnJyL8Sm+PsBYyh31534V6ZvDQGhhe6Qsa3um+YLkIJDjJAjQLj+dnsHS2VnMEcHVUFzESOclAKx5+ex52iYODVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jMJVlNB8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jMJVlNB8"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2627269d5so76733785a.2
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763644847; x=1764249647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=jMJVlNB8LyM4AYZyl088cBiSIlJ90Q1dm2hb+qOJix1EHdJs4siUbnVhSfjdoo+d8b
         CpJ6KfO7u7JniZDhdoBs1zVrqavLhdwn31rKFf/kVN8vkyxieUH5wcPJTih/9lZw+PEX
         fzdm1aYuxKCanV8/aYUVsuP51mR3HV9FaHggDK4qYX5m3Eht6ufYvvO9vptn0SOijTOl
         cfmQgVoxaFFQaCv0MtR3VFkL7VdP7LsWZJMB5e2tkAY+4CqMtLl57rP2UzUjo5ld0ad3
         Ew7cnRVtQJOT76Gc3wbQzgtVC/yQSTJ4MullMwUuBOCRwifmwR9JypsEhj+RRVt4akF1
         VX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644847; x=1764249647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaI8T1P9V7HUSR5GC1P83jhUObFww+4fRanAKkUJgJM=;
        b=MqHF93aveM+sKCNWIJMG0zqhMQRc+h9nUEGONgItIAMN5utHjml5SPEY5i5vkxUAJy
         uY9L4ZDh8OL/gZXmwLGFHM735UcZbGwG0Ujodak/SHVpmehuksOBPXvKGHQpJiRrwMAA
         mc/d9Frm3wrLIT4k3qbKohXOuudBQu5gXftU3gdDjEAQmKmyqUwwkfIj7bLAVMmuL1En
         L+FQsPKVJXk0Ue+Dg9wH5sbQBwx4EbK3HE5gG3gznFwkL8iKiH3kar406Avf+BcceTNI
         rnHACvMkY3dRE+Vi8IZbVMLkVF0gmRRwS0oii7MndHkYqRdrBdlNq8ZWkQCgc4zs9Kq8
         cbMw==
X-Forwarded-Encrypted: i=1; AJvYcCX71kDXTA5wfxKE7KehjxRBYK86u/hQGdmFV1s7l4SPmohtjVKQjCTUI3qYhJdH4u/yPaSeCBQagVMh8fACwLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnwXY+W91O8nJkJSsBXXNvZW26rTUSn6HarWQBLohU1iVEtZsR
	9ULh10lQLQtY/GDsL1o2J6ET/O66ibDhAkwQ0b36Q3u+W+c/oslVBLgbwIXqN9DOq1k=
X-Gm-Gg: ASbGncseUHwAUNFTHOIw0hBMNSBCyaDiAo6JmZAp8Qr46y7qhgqp0xI9vQ1jNB64D/y
	GY5oHBLk5RJi6Ae+F3jgNplFmCfZH2ntFkaXSDxIJm5Bbfv0OPKFvVjuVntIgNS/SbA6OYsnlFo
	H27frRCF/pRx5doJyuATmqa4L4Opy41LWDkata2CP6z0llOQB4fO5cfQcHZofb6If5JRY+PzXqf
	lfZektEaX1srqM+w7dGsxPk9tE+bs0hGBIycr9bHJsL+DCL54oFLNdn5GyaOrQlVaIVZg1SphkL
	3cryQ8Pgc2eTaID7gk4skUw4gD2XwtCMcZsQZ3f7aMlZk5HpkPd5APInWu+z8aQPXR41EuFCZ6g
	0iwpXhK2B6Dav9FRQqLYkWWjIr2Ipsus9QNwCACZoLzJDFP3OOUykxOWcf6bBg1UUd2jqQMElAY
	ZYcsjTKFiI70PCituTKnwros6oLIhc3XhVVSTyredbx461eFj6V5CzPk4I
X-Google-Smtp-Source: AGHT+IHQ4fmxCAI4/D2tK1B8sYqUFbudidu6PckWMercsX/iRS90WBjHNHkg95yPWC8b179KW1QKQA==
X-Received: by 2002:a05:620a:318a:b0:89f:27dc:6536 with SMTP id af79cd13be357-8b32a193b85mr303322785a.54.1763644847316;
        Thu, 20 Nov 2025 05:20:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c13ccsm148498285a.26.2025.11.20.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:20:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM4ac-00000000gLM-0tBz;
	Thu, 20 Nov 2025 09:20:46 -0400
Date: Thu, 20 Nov 2025 09:20:46 -0400
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
Message-ID: <20251120132046.GU17968@ziepe.ca>
References: <20251111-dmabuf-vfio-v8-0-fd9aa5df478f@nvidia.com>
 <20251111-dmabuf-vfio-v8-6-fd9aa5df478f@nvidia.com>
 <8a11b605-6ac7-48ac-8f27-22df7072e4ad@amd.com>
 <20251119132511.GK17968@ziepe.ca>
 <69436b2a-108d-4a5a-8025-c94348b74db6@amd.com>
 <20251119193114.GP17968@ziepe.ca>
 <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c115432c-b63d-4b99-be18-0bf96398e153@amd.com>

On Thu, Nov 20, 2025 at 08:08:27AM +0100, Christian König wrote:
> >> The exporter should be able to decide if it actually wants to use
> >> P2P when the transfer has to go through the host bridge (e.g. when
> >> IOMMU/bridge routing bits are enabled).
> > 
> > Sure, but this is a simplified helper for exporters that don't have
> > choices where the memory comes from.
> 
> That is extremely questionable as justification to put that in common DMA-buf code.

FWIW we already have patches for a RDMA exporter lined up to use it as
well. That's two users already...

Jason
