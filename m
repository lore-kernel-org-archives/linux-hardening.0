Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E98219A68
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828095; cv=none; b=ZT/6dRlckYoAxX+CwikonrBzFswTMlrVkagGBTZRpAPDgCM4CJHbabRNkAQJqsDmdaE6yNW7hOeAWlf77HFGv/B6elzRLZOCVxgcI7uNFe0T/KuGfa/Ghd+H6DVMYNgciRA4apborfsgXopquPHUOLkuDE8iq68Kd+z0r6v9VOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828095; c=relaxed/simple;
	bh=bUBb5mFoJb9G5BgJnxotUeKRdbd+vsxPnYgjdZX4OYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVbtUgHM3aX5fx552Jow6JeAoC5sIVuUGaiUdT54VDEg7DbETcOjWE803ykzj+yC00qIS1F6qBR3HYMVXitocAV5M6IGBaTZs9eXYvshkBL/sG4glEH8xpcaaXRKWvLHNOrfLWhQXeJRRZNyHYSZNmTs8aWjLwEJDe91G/DDKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/jKgODi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/jKgODi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744828092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqpDy6pI/eQq6luBbGPAlrOSVzuf9WMRWlny/FPlhAY=;
	b=N/jKgODiMfC3vcx8z2fi3OkMZvH6OKmjaXhJ8990sU4cBUhu3QhkhaF+0ymz+aymWfN077
	2pNGDXKteyA8s5Xs30JTXIM0eBo/e63ffK0zTZ4hUaN8pfjUb3VKqIgL5UKYCzpkvwnvuD
	9jpR8YySGDuNvRKyql2NC50eP/Cf7XY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-_t4_xbggNLqykm0mQ2elIA-1; Wed, 16 Apr 2025 14:28:11 -0400
X-MC-Unique: _t4_xbggNLqykm0mQ2elIA-1
X-Mimecast-MFC-AGG-ID: _t4_xbggNLqykm0mQ2elIA_1744828090
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3e0c13278so633321466b.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 11:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744828090; x=1745432890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqpDy6pI/eQq6luBbGPAlrOSVzuf9WMRWlny/FPlhAY=;
        b=dG9xqNqseVTyoJNEVMti4rfhhxn8mTJ5jK6vtFjkAbV56btoaAwwuYt7fo8uRQu0KA
         CQis7UPheGWKYw5T7UiuDVS3/Q9x0bsww7xVQaKy84T9G/ues78yqU7vkwiQAwkQZ/ci
         6lYRbgTM48Gtv24Lhre4DsmT5TQHO0hQiMf9boxeFXW+E7iZWXFwtSCQ+Cml9A/biJ6g
         VDEMLIluSEyDvzl7BYLcChqPqcCe+3LBEbs2Lx9NBwS+OhGUW8l/amNrhdKoKV9a8O7B
         JvsKRZWoaSveBE9U67xiEIIYyVTQdfdo41qpuMEA2EARnWsjq9+Cf9SGWkxRg7DiWF7Z
         L/LA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Dt7jlV/UXQrWBjZHNPttVv3BwvWTByTX8p/0kKhoSY0kejpQwXyIw7q9hIizqwIFDBfxNOSxlLBW1Shk4UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZnso8wpFQQbBia1SCAgtPDYTBbCEXtuY3A/bKtf475kA5IKQ
	Vdu6GFdEd/Sjnn5sxYXVSXRAey8ApdQ7ybhvZo/gw7QgdGYNncn2PcZbQO4hgt7toEM3UDS24Y2
	N+kb1KVmZ4tGdJ4f/rDcapddFHglu1R972Ovex7MpeQAmJK1JILMBFRNWQUUieBTbbtELY3jtyI
	8VqA91wxkmNpyuWLiQZx3vtvgyib1jC6zZ857g+aSs
X-Gm-Gg: ASbGncsBeVMM4Qvgeva5RcvVJopGxaC+c7p3dekjLanvmZIl1vS6+gL+1MZMGEfjsfh
	NgP5hs4+QhzH/FHkSggeW0yTPnuQpjbPdHlyrMfZWqLnR5ZoCXT9pJBHIAcxHoPpzfaDB+4doHR
	HBv+kL8bVPGzURx5Bs/H1KbRM=
X-Received: by 2002:a17:907:dab:b0:acb:35e6:eacf with SMTP id a640c23a62f3a-acb42870b74mr259874666b.4.1744828090403;
        Wed, 16 Apr 2025 11:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSoF42j4ymXh4k2DWlxZNaW5OkZRSSUqi4pxp1gEEVEvZ1VJluzXf3BKzOlO4E7zUkwC3XtYHE9JkFfyjbrOY=
X-Received: by 2002:a17:907:dab:b0:acb:35e6:eacf with SMTP id
 a640c23a62f3a-acb42870b74mr259872766b.4.1744828090052; Wed, 16 Apr 2025
 11:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416162144.670760-1-ivecera@redhat.com> <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
In-Reply-To: <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
From: Ivan Vecera <ivecera@redhat.com>
Date: Wed, 16 Apr 2025 20:27:46 +0200
X-Gm-Features: ATxdqUE-ky5T4DA1oVeKdaFaD--po_j_TkYXO-lqG89DNt53ozs0tBAdouq5muw
Message-ID: <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MX2C2Vxy03H79vlzx64MD-LRxU6pEUmtvLJknSUi29w_1744828090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +/**
> > + * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
> > + * @zldev: pointer to device structure
> > + * @index: DPLL index
> > + *
> > + * Reads configuration of given DPLL into DPLL mailbox.
> > + *
> > + * Context: Process context. Expects zldev->regmap_lock to be held by =
caller.
> > + * Return: 0 on success, <0 on error
> > + */
> > +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index)
> > +{
> > +     int rc;
>
> lockdep_assert_held(zldev->regmap_lock) is stronger than having a
> comment. When talking about i2c and spi devices, it costs nothing, and
> catches bugs early.

Makes sense to put the assert here...

Will add.

>
> > +/*
> > + * Mailbox operations
> > + */
> > +int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
> > +int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
>
> I assume these are the only valid ways to access a mailbox?
>
> If so:
>
> > +static inline __maybe_unused int
> > +zl3073x_mb_read_ref_mb_mask(struct zl3073x_dev *zldev, u16 *value)
> > +{
> > +     __be16 temp;
> > +     int rc;
> > +
> > +     lockdep_assert_held(&zldev->mailbox_lock);
> > +     rc =3D regmap_bulk_read(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
> > +                           sizeof(temp));
> > +     if (rc)
> > +             return rc;
> > +
> > +     *value =3D be16_to_cpu(temp);
> > +     return rc;
> > +}
>
> These helpers can be made local to the core. You can then drop the
> lockdep_assert_held() from here, since the only way to access them is
> via the API you defined above, and add the checks in those API
> functions.

This cannot be done this way... the above API just simplifies the
operation of read and write latch registers from/to mailbox.

Whole operation is described in the commit description.

E.g. read something about DPLL1
1. Call zl3073x_mb_dpll_read(..., 1)
   This selects DPLL1 in the DPLL mailbox and performs read operation
and waits for finish
2. Call zl3073x_mb_read_dpll_mode()
   This reads dpll_mode latch register

write:
1. Call zl3073x_mb_write_dpll_mode(...)
   This writes mode to dpll_mode latch register
2. Call zl3073x_mb_dpll_read(..., 1)
   This writes all info from latch registers to DPLL1

The point is that between step 1 and 2 nobody else cannot touch
latch_registers or mailbox select register and op semaphore.

Thanks,
Ivan

