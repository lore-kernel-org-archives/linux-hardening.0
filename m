Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6ED18593A;
	Fri, 22 Nov 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307677; cv=none; b=NujwqZLEzChh3GI/4Pv6uNb92wCyN+GgAYH3duX/58mntFRmBPBAxfqcUwgZgyNiUoCy2pw2D6Ge3SOyCctLP1xrTl7ujO9cSx/MoiOvJmex1PiRIm7jsDgci1rbELHySbxSxedh6i8SuWw2Dr7rhUvatPmYMHJjUvDHArF3Fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307677; c=relaxed/simple;
	bh=tyVliHYoWPxTSuVUMXN5P0bi34BX74mjEspyucHncgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLrm9mrzomkmL/gNsEK+UwmnQVkh4qM/1vi+17GdlXN7xuXpK35dJWi6ByjLC+mWWh7OMS1Lw46wCUe/qNzUHmyvXoxZlEIawbDv7cevNREwswXHKUuT+gN2w+t7MweVsk73wAhmXxuzlrgTun32abzbGu+80Oxt0l7xZF2hJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuRTD8nP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuRTD8nP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso2960334e87.3;
        Fri, 22 Nov 2024 12:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307674; x=1732912474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27/W48BXXkoR+L+LgIt1Vcffca5rx+DKUvYdFX1hBCs=;
        b=PuRTD8nP98yOmGyvIGKcnR8n6AHLbCAVyVVkBRalFKsdf43gPRAZFcAErLS9MeCEtq
         D+WaziEJAbyFI7YVuXJR/plnxMaohpFUFDhiY/8XrnneY8m5TDSdngzEoMKcpmTD2XuN
         JTlSwPp3/mrmytILGeKdSGUfxpsITmnq2ZkAuoTCaZp1bNhgRW5AQ5Qz8S+dZaqaH0CG
         lZWO9yHI/r95ZOZp4YqTaxzXYJkkPqIhSK1ViCw5V8MXhZKht5ykM+ZN3WtaDdxzI1yV
         0UlSspCYeoDSiIonl+LMSt9McEdcgNsbGfI9w7dz0fvfDW7Oa+gYj7OfhjflPoh7XWY7
         nAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307674; x=1732912474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27/W48BXXkoR+L+LgIt1Vcffca5rx+DKUvYdFX1hBCs=;
        b=VUxhvyQdGL13woMmIARV2AaHBtyM94gcCcumUTVL8T5hvfFuWHG21m9/6QpZ/loacn
         DpZgM7sVeEcKRT4tmDnM3Yu6zwoR0rjFRdSwurNmizjAbXB+eKQMEBIMssFZrXyVUhQ0
         KlJf81hyNFCycG1PzgXYZulhw7FHffkbm4ge40ItO90CUHYPcY/BDsXgGpAD2YxeEWmM
         lD12ugYACROKg9IFBNke/c67UaNwoLtai59CuUxCrUM0o+NuTCBQEBmUvKBSFkOtzMN+
         +H/awQrwJfqvgjQPmhlOCNtuhUGSSmpaXwo6m9oOFSMh/SYj2j3q1oe6swfo30wz/Cfi
         4pvA==
X-Forwarded-Encrypted: i=1; AJvYcCVzUqQs4dm7pd2OaxUOrZY+INzQp6oYK5/aiZboJnfalPGJ2tLfWIlPGzmPMyr3LZnyA9/QgUnLfAHUeJciORo=@vger.kernel.org, AJvYcCWsleRbtjhNlAJ5bzfvOSrJW3xobTDObSyhWtGy+ZWhyDpST+p6Ho7cc0TZyErps2Wol/ujNOUxDbMXy+y7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8f5p2FDRjqdbz9n3/r+8+NW1N5XZmM3ojy2USvFJ6YFvOEK/8
	ACZ7dEzOacXLQ/dgVlEY6Bjm+sGwDiVpw7zy64DFvpXxlxmcRm0+21zdvT+cS2nApKUpfTVjS4I
	BUdI1Ytssizqj0o2dITtNdf8pIrQ=
X-Gm-Gg: ASbGncv45yW/yqEBr2qMLeh9LdTHRQ7ktp0lyoLMRX1xwj5Q0y9Nvmu3kvQjL8+nqOX
	zMAEV8CIPMvIO12ZVSqSD7lG9KJ0WGn/p
X-Google-Smtp-Source: AGHT+IHgCi72nGTNGWZ1pUQriMQ3jhYTMfVH+ysIEbPbyi+hsGaA6LLZnk0LjVwQWBBdL43JWP5pFRZBbtpZN0Kb1R0=
X-Received: by 2002:a05:6512:e85:b0:53d:d605:f8cb with SMTP id
 2adb3069b0e04-53dd605f911mr2471603e87.45.1732307673713; Fri, 22 Nov 2024
 12:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com> <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
In-Reply-To: <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Fri, 22 Nov 2024 13:34:20 -0700
Message-ID: <CAOZ5it34Gk_MU-gYzL5iuiHCx6fohQFSJFDp2AKj7waUCNzLyA@mail.gmail.com>
Subject: Re: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
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
> Replace the BUG_ON() assertion in swiotlb_release_slots() with a
> conditional check and return. This change prevents a corrupted tlb_addr
> from causing a kernel panic.
>
> Co-developed-by: Raphael Isemann <teemperor@gmail.com>
> Signed-off-by: Raphael Isemann <teemperor@gmail.com>
> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> ---
>  kernel/dma/swiotlb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa0a4a220719..54b4f9665772 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -834,7 +834,11 @@ static void swiotlb_release_slots(struct device *dev=
, phys_addr_t tlb_addr)
>          * While returning the entries to the free list, we merge the ent=
ries
>          * with slots below and above the pool being returned.
>          */
> -       BUG_ON(aindex >=3D mem->nareas);
> +       if (unlikely(aindex >=3D mem->nareas)) {
> +               dev_err(dev, "%s: invalid area index (%d >=3D %d)\n", __f=
unc__,
> +                       aindex, mem->nareas);
> +               return;
> +       }
>
>         spin_lock_irqsave(&area->lock, flags);
>         if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
> --
> 2.34.1
>

Whoops -- didn't send to the hardening mailing list. Adding it now.

-Brian
