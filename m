Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A61F4630
	for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904760; cv=none; b=dkwUxXbz/XmZV6DcXON/eRCw+iy0QTYHt55iaRaUUd0xSBK2ykTdfb9/HT/Q2tHjVZHboXBw2ondOUAHL/wgu96/oV48yseTnVRES2xhuoatOCkcbekRVTDeHxnOoXedmYrpa6IbHAEFJ5bwPwCz3QO9egURVbwo60PfEmNqkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904760; c=relaxed/simple;
	bh=QZV2NTgEg7k+1XHNq5HE27b9f2LssIVk3RUzMP/R1r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGn8gZEgbaIniOaPfs0ZM9GJSfiJHLcCQwFkIHdU+1ZvR7fyWk2xT+xC7Rx7Ixx2zi0OEnI5ttatijeYSWMWwXCe4Ei792hZu+Y4noBYlZFDIlJx1wkUeGJj6t6n6yHiYWyO6XsU6hw3ApvlEkOce7qQkg1Cdwr0TeOrbn7vVn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lPQcFsDm; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPQcFsDm"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c2bc6acd74so201059fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 13 Mar 2025 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741904758; x=1742509558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO0VpTSFVmDIRg6D2iUyymvRyONg1pufELLgkVchWVM=;
        b=lPQcFsDmbZy6AEqIflKhd9RqVMEAaX/V3CmrKtK+/ehEXw4UlsUl0Zws0QlR/IlV1X
         VX6iRbMJzUxxvi5tW2J/EBjQ+HaG2QEMleLlE50U4ZC05e26SNkMixHWajrQo/edHZQI
         YSuwXegy7cgYyyUHqWbY+iZA38i8ox4dkYskQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741904758; x=1742509558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO0VpTSFVmDIRg6D2iUyymvRyONg1pufELLgkVchWVM=;
        b=iwaHr7fW5tFTwsss1onxZ+ncJmLs1yaJvPWT0HBXJYn7aH+xAhX6h7z7CgD61/QOCx
         X/6BtOEuoTPWQd6qy95xi92xXJHT1FuMJaX3FDDEcQUOqGjdAYPRzG4PjhuOooUWG5bW
         tA4+WA/UZ9oAv/91Ic1w6AqzkN51cbVWO1hs0fmdyJ2dlAYIgQ18WARfBvV9OE5bPqH2
         uPxsxC8w5QE2a2XJdokLRESzWlFHGHNLQUkVgdLb/100T55BlzWSKni3sDqszk5N6WXq
         MxNHXG9Gs7ROzlE24u35rKyWi1aQ2Fzhl1VY2B9MSfdPqVeWJplnnDuiOPuRp+fGLYvp
         /f3w==
X-Forwarded-Encrypted: i=1; AJvYcCXEUm/ul4Md74ikNe38iNrA597nbkiNoA+HabRSMBy5hdAMe8irlZOP3xKRaMAUMV8sVb1omiT5yKaeUe34Gx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqkv7YrF+tHNq7VvlndvyN5shsglWF1DlBbIKE7VOxR9OcxUXa
	F55nKyxEYHq1a0vi0YefA4BQWjY7rLEc9KnwKep9G2HIdLUpMy4kKCU03NCk8jo7QrmbcYqLbv9
	5WNiT4PMIXaBJ/EUJPO9od37QaLa9xQOTtIz5
X-Gm-Gg: ASbGncuhd/8P/DmkCAs01JcA1Ba0S9NoaQNV80IcTD+g2vU01DxXU71csELuAwvhUKI
	LxTeHLNqGuFVxvvOCjrpPP1GZFWw1SmS9jOzJ8RqfcijgD+f6t8/upcvPP9+LldDV0y1mfkGh6n
	IfNg0z7+moHSK8cxfu04y8YlOiDcqS1wPikSM=
X-Google-Smtp-Source: AGHT+IFGFOX+JdCKJ5EW0lljriIIgVcYBIERJmy8IRbYMG52NjTsVEcHPVx2F0p10iZ15QufBCgqhdZZ/AQ7u3A452s=
X-Received: by 2002:a05:6870:41cd:b0:29e:723c:8e9d with SMTP id
 586e51a60fabf-2c690f385c8mr57268fac.4.1741904757815; Thu, 13 Mar 2025
 15:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
In-Reply-To: <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Mar 2025 15:25:46 -0700
X-Gm-Features: AQ5f1Jp2EPkBExs0LgI3wECuDDPaXmKkN-4wE1NQSGw_NG7eEjTDTsm1Ivwa46c
Message-ID: <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	kees@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, svens@linux.ibm.com, 
	thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/features/core/mseal_sys_mappings/arch=
-support.txt
> >
> > diff --git a/Documentation/features/core/mseal_sys_mappings/arch-suppor=
t.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > new file mode 100644
> > index 000000000000..8db637254de9
> > --- /dev/null
> > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > @@ -0,0 +1,30 @@
> > +#
> > +# Feature name:          mseal-system-mappings
> > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +#         description:   arch supports mseal system mappings
> > +#
> > +    -----------------------
> > +    |         arch |status|
> > +    -----------------------
> > +    |       alpha: | TODO |
> > +    |         arc: | TODO |
> > +    |         arm: |  N/A |
> > +    |       arm64: |  ok  |
> > +    |        csky: | TODO |
> > +    |     hexagon: | TODO |
> > +    |   loongarch: | TODO |
> > +    |        m68k: | TODO |
> > +    |  microblaze: | TODO |
> > +    |        mips: | TODO |
> > +    |       nios2: | TODO |
> > +    |    openrisc: | TODO |
> > +    |      parisc: | TODO |
> > +    |     powerpc: | TODO |
> > +    |       riscv: | TODO |
> > +    |        s390: |  ok  |
> > +    |          sh: | TODO |
> > +    |       sparc: | TODO |
> > +    |          um: | TODO |
> > +    |         x86: |  ok  |
> > +    |      xtensa: | TODO |
> > +    -----------------------
> > --
> > 2.49.0.rc0.332.g42c0ae87b1-goog
> >
>
> I mean fine, but why not in the existing mseal documentation file where y=
ou
> already document system mappings?
>
you mean adding s390 in the mseal.rst ? I thought Heiko was going to
add that ? [1], maybe not ?

From the example given by Heiko [1] , arch-support.txt is the official
way of documenting arch specific support. But adding these info in
mseal.rst won't hurt.

> Plus I feel this need expansion a bit 'N/A' is because of being non-64 bi=
t
> right?
>
Below is the definition of N/A in Documentation/features/arch-support.txt
   | N/A|  # feature doesn't apply to the architecture

It fits the arm case because mseal is not supported in 32 bit.

> Actually this will change soon btw, based on Matthew's idea I plan to dro=
p the
> 32-bit vma flags limit.
>
Okay, we can update this section to TODO when 32-bit vma flags are
expanded. Based on past comments, I gather we want the document to
reflect the current state of the kernel, not future features.

> Anyway yeah, let's move that over there please.

I'm looking at Heiko's direction first to see if mseal.rst will be
updated as part of the s390 patch, technically that belongs to Heiko's
patch series. I can also add that if Heiko doesn't care :-)

Thanks
-Jeff

[1]https://lore.kernel.org/all/20250312153946.10610B02-hca@linux.ibm.com/
