Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920119BBA;
	Fri, 22 Nov 2024 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307613; cv=none; b=hfS7p0LAZsPo6K6BwhpAEMWLr7khYwyeL5UH1WdUd7hnzf+c628Usn1I9pdhm350umM3EOnKAExEVWr1+zM9vNS2On4VImtz5peFCPd+I9fFhAM6oaE1c0ql/G/wreCDpfOtbf/7SKoSVEkJl8Dye+JB3Hzcb91ve9fD2+cWd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307613; c=relaxed/simple;
	bh=LITRt5K4nbGCelcHjyhzVoroqeJ/9JP38P5L6NZbAWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKaIY+KNiwGDBo87nF5nOYqIoAygI3eaoNih0LNC5Qh/QVjRoffOmoY/GmI1FyVdIOLSzcqd/38rgNX8An9ZxjTd1fbIdVbov9kFv45KgqeXGnmS4fu51X6c2KXQES1TnzDUm0XHtaMYN4xKdq9pEzxYu1m/PEahrt3L75OqDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiU/Bqcc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiU/Bqcc"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa52edbcb63so37093466b.1;
        Fri, 22 Nov 2024 12:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307609; x=1732912409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdtIpBGI3WtRlHvfWANFY4rDk+3Kg9qCxLIyUfYO1ZA=;
        b=NiU/BqcclcpKDdUtnztBSe9y+xT8Yd/MtSNPMZr2SekeJq7wClOCohU76sQdE7VHmw
         HGIMypJsESYKhyw2WZ7S8J/5YpbosrXdQm/NZch0FK4kPBPyQ9uDFpmXdQagLIjH7rBz
         8qrZ5HKO+rdG5GM2GcgoFr2XYmQIiOFax9Xp6/gJ8D6w78rnqUC1ukqAvmsgNPMkG+y/
         C+6hWDsXdULtNnGzGC3DVdbwBeF4qsfmp/sJqUFeDALBvcrapJBdUqH5czrYDBemZgqS
         fykE8SVHMXPRB9ZpWShSoejju/vmNxLxvHVIg8u6wri+zw7WQFHQmKxtkQKk6EiXzVec
         dWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307609; x=1732912409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdtIpBGI3WtRlHvfWANFY4rDk+3Kg9qCxLIyUfYO1ZA=;
        b=fR3OoCvLf0pe551XbN5ka7kIXligg1eygN0Tu0F3GCqMiFQVmEIZCxLB9Pvwh0+QQx
         2qjFf2D8zm99X9s8VCTB5eoRwEgf8dcWULS1ru99r+l6C+PxoF/A2rpSg6BMoCLt2T8P
         wW8oODpBFhDT/GMjpXABRJDtx+x71v5hMZOxX8G2CmrM5+GR7kn5wC+4z4xkw8EPVCaf
         h2SsBqtnlOtbda9yXG0ZX6XwtUdrWEG/g/Lq9l688q5sQevZEBQEdIOXESjo0YsmI4ZH
         1snU5rdVxWO7OCgxTLEDZlXGwV216KfzObXWO7yUjp2EfPRK+VKd/OJf1ykTkC+NV20A
         VpPA==
X-Forwarded-Encrypted: i=1; AJvYcCUNKj1LCyJypQ3gAnigTjoWLpSxU7XiR6EbQs1Z0/U4EgQcjdbiRHW/fWLC1ND5w3NwpY7t1BbVnIPCZI/E@vger.kernel.org, AJvYcCWOj7Av6UBItvMcwZl/E02Q4xVLze193ktoLeIW8pasPv1zRttyWKdamKkVNGnjx2bi1ZD5VZ7fLoxmF0Konq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6utX9M4j8IcbROJ/KWo7eKAcU5IrbXNWkUTJoDS2WFtLZEsKq
	Iu9welE05OM7YGCcdQrj4tykp0CqrN+iYSbScujZfENLl9ANPFsYCZXwPdbGiUfACVRHZ0tjdvK
	EtssamPvax2+d2sIMw8YBFXPg/Sg=
X-Gm-Gg: ASbGncul4Ilx1fPRmLa8F8ZIhrbzvffGMTCpatGTz+6Dqu3pnDOyR2N+CiEaSnFiZl2
	asq8Y9jMOR+LKpTlD7v8DJftt99PHDXfy
X-Google-Smtp-Source: AGHT+IETM9O9HSssquiq/42hR/1lGtNNI4BZqIYmPyKLfK2dsxTYDZg6JA+h2iTQDBGveNTqdzVDncZI23ek3LZoiGg=
X-Received: by 2002:a17:907:31c5:b0:a9a:e0b8:5bac with SMTP id
 a640c23a62f3a-aa4efe2a1f6mr775060566b.23.1732307608637; Fri, 22 Nov 2024
 12:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
In-Reply-To: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 22 Nov 2024 13:33:15 -0700
Message-ID: <CAOZ5it0Yj8taexnFJiAqJhPP_8z5Dv_OjonyGXMbA3Tiu=9ugQ@mail.gmail.com>
Subject: Re: [RFC 0/1] swiotlb: Mitigate potential DoS caused by BUG_ON()
To: Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Raphael Isemann <teemperor@gmail.com>, Cristiano Giuffrida <giuffrida@cs.vu.nl>, Herbert Bos <h.j.bos@vu.nl>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 12:13=E2=80=AFPM Brian Johannesmeyer
<bjohannesmeyer@gmail.com> wrote:
>
> We identified a security issue in the swiotlb unmapping operation, stemmi=
ng
> from the way some drivers save streaming DMA addresses. This issue can
> potentially be exploited by a malicious peripheral device to cause a
> denial-of-service (DoS) via a kernel panic.
>
> **Disclosure Context**
> We previously reported a similar issue to the Linux kernel security team.
> However, they advised submitting such cases directly to the relevant
> subsystem maintainers and the hardening mailing list, because Linux
> implicitly assumes hardware can be trusted.
>
> **Threat Model**
> While Linux drivers typically trust their hardware, there may be specific
> drivers that do not operate under this assumption. Hence, we consider a
> malicious peripheral device that corrupts DMA data to exploit the kernel.
> In this scenario, the device manipulates driver-initialized data (similar
> to the attack described in the Thunderclap paper [0]) to achieve a DoS.
>
> **Background**
> Streaming DMA is often used as follows:
> (1) A driver maps a buffer to DMA using dma_map_single(), which returns a
> DMA address. This address is then saved by the driver for later use.
> (2) When the buffer is no longer needed, the driver unmaps it using
> dma_unmap_single(), passing the previously saved DMA address.
> (3) Under certain conditions---such as the driver using direct mapping
> operations, and the mapped buffer requiring a swiotlb
> buffer---dma_unmap_single() calls swiotlb_release_slots(). Here, the save=
d
> DMA address is passed as its tlb_addr argument.
>
> **Vulnerability**
> It is common for drivers to store the DMA address returned by
> dma_map_single() into a coherent DMA region, which can be manipulated by =
a
> malicious device. For example, the E100 driver and RealTek 8139C+ driver
> map socket buffers into streaming DMA and save their DMA addresses to
> coherent DMA data. While these drivers might assume trusted hardware, thi=
s
> behavior is not necessarily unique to them.
>
> If an untrusted device corrupts the DMA address, it can influence the
> tlb_addr argument passed to swiotlb_release_slots(). Inside this function=
,
> tlb_addr is used to calculate aindex, which is validated via BUG_ON(ainde=
x
> >=3D mem->nareas). By manipulating the DMA address, an attacker can trigg=
er
> this assertion, resulting in a kernel panic and DoS.
>
> I have a PDF document that illustrates how these steps work. Please let m=
e
> know if you would like me to share it with you.
>
> **Proposed mitigation**
> To address this issue, two potential approaches are possible:
>
> (1) Mitigating the *initialization* of attacker data: Prevent drivers fro=
m
> saving critical data, such as DMA addresses, in attacker-controllable
> regions.
> (2) Mitigating the *use* of attacker data: Modify the handling of critica=
l
> data, such as in the BUG_ON() statement, to not result in catastrophic
> outcomes like kernel panics.
>
> While approach (1) is more complete, it is more challenging to deploy
> universally. Hence, we propose mitigating this issue with approach (2):
> i.e., replacing the BUG_ON() assertion with more graceful error handling.
> The attached patch implements this change, ensuring the kernel can handle
> the condition safely without triggering a panic.
>
> **Request for Feedback**
> I am not deeply familiar with the swiotlb internals, so I would appreciat=
e
> any feedback on the patch. In particular, is there a more graceful way to
> handle the error than returning?
>
> Thanks,
>
> Brian Johannesmeyer
>
> [0] Link: https://www.csl.sri.com/~neumann/ndss-iommu.pdf
>
> Brian Johannesmeyer (1):
>   swiotlb: Replace BUG_ON() with graceful error handling
>
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> --
> 2.34.1
>

Whoops -- didn't send to the hardening mailing list. Adding it now.

-Brian
