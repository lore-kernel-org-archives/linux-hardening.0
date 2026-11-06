Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984257;
	b=4NFwW9uJZmDRnjZvGFxwxAwHvWdJlUKcV1S+KEHzeFFolCC3I3fNedKKfPC79r6hMASL
	 4GG8r4SpIcchcMCpVcrnUFQBDFzKI4kdbxjriwT0ulWmbrkNeO1xkkpn0c/KTWUvds+8B
	 O6VQtg9zhw5kM9iCgBs43PpzLQ6+HJProjO07rqhNBc6DYQl8E3+/FKX9a59tDSMifYOd
	 5hFuWJSvD1TrbJoimKjMgZKt+Y+WtAIe64qYyL2yUWu8YwOeF1jvkhe/DZyDiUg2F3cXP
	 enOGfbpXFKPLTpPjH7MN5YU2ryZ35cfMWRBR6O+eHcjRH6NgEaF+OD2T1yxdEQUWrig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Dui2HnVpfjzkzxu9M35L+PlJD8C9n4WzI7XNWWzwiiw=;
	b=1m6bZDRAPnFTLVMnCVJJHnu2h8V+IJzN+fVdyOktS/nFEtqzDCgUh14evmdiBIZTnqFl
	 CZJ0lNplD6W0m7+1i7HvFA9Sl4lzYFsS9T/It/ybOPwPYQ140uob1YMLIpLAFbdovQSzH
	 5kpbLdsShYRj9sT+K4vrZShmvLGPE3aq65FX7ycKEy1/f8meoCfahWaEGfizl1Dp537MO
	 UYaHdCNdmSj2RyD8sOnR19EQAYE5nw7GXmwa+WTzzO5wBmO9TNomUrLsLqbMJIxoekm0j
	 NcxaqDi+wUREhUTUUaMXoU8vJtpcLmFxiW1uBJM9M45mk3wBGywWR3mj7zdutFYqGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JOFE8Euv;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DF606A33D
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4DF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JOFE8Euv
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so8399445e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793984255; x=1794589055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dui2HnVpfjzkzxu9M35L+PlJD8C9n4WzI7XNWWzwiiw=;
        b=JOFE8EuvP/aiaExAz3zhbWKSmdofbIo2gyAi15JmBQowqrHdneLciitNKgOd/Rc1MY
         TqlwQ0qZ6+zprLi8oRzpeZdfT9rm4Gk/2vmpzUyY+WYVrFq/4VnGWu0F92eSYknQ9eca
         irv+2yYK4tyLv49lJoGUX8YQNNFvczC/QXgxtd5OBkAnr7myUkbuqiIoV2K3p4F1obdH
         Hit0fyb+jSGiSyYi6k7b2PCp0Nplky8lQRcW62b9a1jHv9+1r6ph2IuIoqmuX0KV/xai
         49KfI4QeYxnwjMZnTkPOQWP+BsrShNRyaJdZxDrxjQM18awoxYdnpxd7/h6wjQeogqtO
         LtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793984255; x=1794589055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dui2HnVpfjzkzxu9M35L+PlJD8C9n4WzI7XNWWzwiiw=;
        b=KbMqf9BNDwBW2yj6twmzBu6TQNZFs6gE93WvzLVkbYQqIP0cQuUPlU/HjT635kRiY4
         KFKuk4V58SBGjlCHDesUisiJr0G/aYaa8Uqls5xv4/2Y59Twz2EKcX/QWEtvRYfTUFFJ
         kbgGfR/WXucD9Zlw1+sSOrsdAX40kVPT2uHX8mxGVfqjijOlSQTSGbGmrb1eDIsw5/qR
         a1PzzasvocY15JKjlbhe5Dhpy0hpyeAMjYAGQ4X0ehJDo/fvfbSlBM8IBw3dFl64xpH7
         YUza8yih/tXS/hcWKbn0Z9m3/fbSkpuL0QgTbD/vJHSl9oFZ1rJis0WpuV440mtKRIwj
         oh9g==
X-Forwarded-Encrypted: i=1; AKwUvBwjoSec/2M4OGnvA2OZWnsgiEi14Yn27SrAQtqbvbwRc4i0QzfrE4UdwaGU00vOJ6Rh+QJRH4iyCEnDN7A4+hQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2QU6wZ4B56uiIbuH4P1ChdWNKNDcix4V5ad9fH0wf40It3o7B
	BYLDu6lNiGqnn3o7OinzLB0aGcLitYp8aFPrOSWymyivLBHqJ81H9RN/c4b4c+B1iJg=
X-Gm-Gg: AYBFou0ko4ytQC9HpsjbCFMi5zdkmj+t0AjBZRSGuCXpezbTy1/QRBeCAL6ymMvU4rs
	YlVwKTlc7Yl7tGIGlXcV3JRUBarg38PzGg2NlnGrWnc0I638dat+8dyk4XV5VImDaKrTxvb2i4h
	DFuwwXQWcYvDwwGvRSKjTQMvJay38mVi+c6242JBlmuHwejLqL5VnLxxzGepZEUc/f0sjZoWdy/
	14Ca/0dojBRSaq5uagnPanpSdQyaT2B4KV2thVPZg1RH0fp2BkDo6+XGvHMKyOsTkP+f8x24j7B
	WuYqoBZwkHUXKEcqfxAfjpPYa+KVRohcjKplrcaRSnvuk5GVOLgL60s681XC1nbUjb1rbvRHxoF
	YnWOsBf2OWoTx76o3pyGGRhE5z5tH/hJEMc8Ssa9KgWqcLALggPdx7ygbyQwKWX014Qhnl2081l
	LJwU2JQDR79ueclHH5zjaDfRkI2XRQHIEU4bAYB4U8xu96UfGrL5JvNx6i/BWtu0fXJQDUVLNdT
	5f6WMa7yriWUjvaswB7rdolcJL6+oL/cLDz7+HQiOfdzT6IkbTIy2xJwzpNxRB8QSbcfoYuBOlK
	qAODf4Ue9a1F4joPnwcrF6xoe6N8smRB
X-Received: by 2002:a05:600c:a013:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4b6df5eabebmr51738615e9.19.1793984254955;
        Fri, 06 Nov 2026 08:57:34 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4b571f46538sm144730095e9.5.2026.11.06.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:57:34 -0800 (PST)
Date: Fri, 6 Nov 2026 17:57:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, 
	Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Message-ID: <au4GkvPTXmcvReoj@monoceros>
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
 <20261103022202.2139674-3-shanchun1218@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgc4symavcbtq745"
Content-Disposition: inline
In-Reply-To: <20261103022202.2139674-3-shanchun1218@gmail.com>


--xgc4symavcbtq745
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
MIME-Version: 1.0

Hello,

On Tue, Nov 03, 2026 at 10:22:02AM +0800, Shan-Chun Hung wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please don't use <linux/mod_devicetable.h>. <linux/platform_device.h> is
good enough to provide of_device_id already. If you insist on full iwyu,
please use <linux/device-id/of.h> instead.

Best regards
Uwe

--xgc4symavcbtq745
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmruBvIACgkQj4D7WH0S
/k7itAf+LYAMF4hi693tZ3vEcl9qdHQIjdqKde20tlG9djgG8wsFu0VZ/opYIUir
Ba2Ft+nXyZ+omHvukP/oarePmgmCz7dlRmpi6tKOAV+werJYpdagvT2ZHxjF2/eU
SRq3hKVqHZVh/RS7hfRwxcPjy41xhU8PPT9ijH9syFoVtOUYbKKLjzdGTFdq0VNm
TeXK1teYk1wcOc1zWnVsLIdMk2DtMOGpFMisNxIvSXPHr8CPqfQh3ZhDwVLC6WpK
Jo3OwmvckiCe8ewY1FX7j/uIvM0c69sIBKKFnHgagXSTXFfhUgxYs4I/UgegsndF
7ViQI0kKjp36E6n5RxerITZ5eDHGng==
=zoc2
-----END PGP SIGNATURE-----

--xgc4symavcbtq745--
