Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1044CF3A
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768978930; cv=pass; b=o7jVJXhIJABKVP1xBtoAGDaGyVX3XTuYp9lAEdXxgFusMookigmfyEB4njZtOHlx+FgiM1fsEAeT+7j/sy7ubmss/GnNK8MAdiW5+nQ2D3WAajf6SvinfKKnBy5sg1wavbKb3ProuMR0937VrAPvDGWaONqyK/m87mDQ412d0Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768978930; c=relaxed/simple;
	bh=7wW0mW3XeymxGxMjkgjvRmRi+hcQ1GztZYlYehMfq1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrfXgxdV5XA9oDf0Kd8gXkjYoVtO28/GEJl+K38xwMLqf8CdISVL4VLkzhqeI7cVSgefyHyGEsixdrWUWe+kkDHKrqH4pyk9FQqdCxTI4M/YyDC5QfBRRQEQXlUfWSBIOFJzC01IJjOVA+5uLjonpNoNZIjjqmX+6KVMt5gpoQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxilZawZ; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxilZawZ"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b87693c981fso1014712866b.1
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jan 2026 23:02:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768978925; cv=none;
        d=google.com; s=arc-20240605;
        b=lHuiHG0S3vkY5wZBLRBOEfwYuaExyJItsFhurKB7qqx0PcdLYpJ9lWoPMwzcDp6q8n
         +Dq+g2W2qdsPDHkoCH+ofH1AhAm/7oPi8DY8ma6F2zwmEhH9jtFYhY/1w6GBFRJNc1M4
         88wPCzzJfLlxKgsv6OQBDG+k5LdVsAPcXzkS7sr0ZkIBSSmiFjVVYyTnCO7l3DkS/Ude
         vTVhaUbtToPZDB7J/LTE3jFTmaGMUZH1NofNRu9pFNqHWbIx8jdeRSxNMcuK+Tx/5EDw
         +UdaYymqqqQzN6grB8lFw3h9FBhlCLqDYHGCsdfBidvZ4FwAr8FTAWH+Y2t9eX/WywcI
         F1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3O/J2nA0SN6b+O4h+jjE++lw2feW9tn6sTNGeR94Dk=;
        fh=Yy+74CeNwzF+2Da+r/cwshv2vzJrkfel0JoCgzpn4JA=;
        b=Jh6ruzAUQCvEG/uWWb17MLLj1Y2WocRKqMoY2Fp8yWYhkQQueDieiIlrQwRhSC4Mfw
         1I8LULurp6+AliiW0kExd195p5aViZHMni2AeE4SxFBaWAH1ny4ewk42bjoa7CVVo9L0
         MNERv0HE2NVkSB8TI07eMNtrn3Jt7jx23DvcT5l4sb8J6uZqe+UnhXj7Q/BJF4MM3n33
         XXQr5Fb7R1PDbFG7ARsTmGhFeDTu+89w5yfJrBmEodYB79x7Xne0pYLXVLe+VvwEx10m
         ffPEknjhKOP+r7Fo5Mo1x4EcLZlhtpDbqQ+pFSHzpa/Yt+NBg0NZm6fuFfmzk1CHWzGR
         5ZyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768978925; x=1769583725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3O/J2nA0SN6b+O4h+jjE++lw2feW9tn6sTNGeR94Dk=;
        b=IxilZawZ4RclA5b9Pp1r20F4S3FfOmoeVEw6cs1nEZvoXl57vOsfVaq/mpkCkMTM9h
         rHv8sPIFUA7jeOwlwJnSLGXgJO+L15UYXrYAOYp1uYtxE3VQyCP7p5VYSh1IY3pv0FZ6
         RpeqQ+iz51Gr6hic/6+VXQOwogW38Xsv+NPwPhs17DuLkltO5OZeJVEDwM8wlVK0bJqq
         /mmrNxfTBvqWF4TOWaZLGkIC3hcMx8XvxkieansUwIxVHKh87t+v4LddPXqLPCYLiIHb
         Cxy97zaLPalUXvsfcjreUjxJCYqFxxg2h6F/8Mc7G/yddjsts3JMpn51TlsSJdKDlrF9
         wErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768978925; x=1769583725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3O/J2nA0SN6b+O4h+jjE++lw2feW9tn6sTNGeR94Dk=;
        b=GDsD7fIItZkbzGv1pIKiKW667Kpwpgs7u844grIwuG4icne+VB8m5zhMI2SoIfy/Wd
         XuWim4LIMZnVBbe6/XugThYAqog31szGBqLqSfeeG8MHgn1p0sOTMxqlqHAMQCF7/SdF
         uuSMmgAkhhiiGfUHjBCIxgo9fEktRO/QApha/iWsEUCIdfTITSIz8nv6ZKaP4FVPHIye
         6zjvDtkOYKEgwaz372E6lS+B45azMVNDTLao3dCHw7H4nbPk8vPs+LNq4ANP7BVJXXNs
         18fnLv/UQQlNqXLbqUBHo0Y2SqtyHIS29Gw2g+VZ5Tt9Ttrdp+F380tkb9xvG/vDR985
         JzXA==
X-Forwarded-Encrypted: i=1; AJvYcCVwpGvXhVvNfbe7y8jdlz6qqa1NYoHwrlR2oBWtGWLlWpERF6Lp29qUvkCRmNuwGCAlJvATfcKSJOjxewaF+T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8grLgk0M7TOo7c8syMsPynk9r0Zy6yybw4GXloJzmU+JpoHT6
	2LSwdUuQRpXRn3T/JhuzUiTY2FgoiPAFcpVyDSoaNsCV1MPsaFUeFjqDXxi9FccOZu8ANZSuv3H
	7LezkvE6ZsWFsCW0ttRlZarD/mhUJhPo=
X-Gm-Gg: AZuq6aKSeygOb229E40sOyycA0CsjXl4TBjigeAT/rf1GiV0MRO/XPz+VZZdSmXLo06
	4Z47Ajl/AqjYxhBxwBX2zdIgQ7yMXT/lUWSnuWaiLw0VCt9fDpzYmuwdLGPdAoEUI+Y3Fxue/nn
	ergpN1JLZk99Tel729egp4la1h3GxYoMJiBkUTw5h58qh0vkYQaS8Q31+uo0ECC+HWxuGIaUGjT
	exQtkmYkhO5/xqBBuaM6OY6nIRTHeoTg5d7i20+cTjYBuwfuI8ncONyVE2wy+aD0kPJ2wNxr9mk
	npSloXcNIs/NxyDSkV6Cn1hSXilSJ33E7o40g4KYmqD41/p002VDo3TfjNANuN/aDtlcrd7Y659
	Ljc2rK3kE89FaE83Mxg==
X-Received: by 2002:a17:907:da16:b0:b87:6:3727 with SMTP id
 a640c23a62f3a-b8792fc4039mr1645039266b.48.1768978925222; Tue, 20 Jan 2026
 23:02:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120065852.166857-1-jiangfeng@kylinos.cn> <aW8whGcAR0x6FSRJ@smile.fi.intel.com>
 <691a0183-6f41-4956-82da-abb69a449919@kylinos.cn>
In-Reply-To: <691a0183-6f41-4956-82da-abb69a449919@kylinos.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Jan 2026 09:01:29 +0200
X-Gm-Features: AZwV_Qj-gl6KU_wQTKIZD06mimAL52HHE9k8M9Cv2RjPGuQJhzCJn0zfBmXFHnU
Message-ID: <CAHp75Ve_pyVm430FL=aEAw1Cnf-92T3Y23qh7pEOaMYMp9iyvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] riscv: optimize string functions and add kunit tests
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org, 
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org, 
	martin.petersen@oracle.com, ardb@kernel.org, charlie@rivosinc.com, 
	conor.dooley@microchip.com, ajones@ventanamicro.com, linus.walleij@linaro.org, 
	nathan@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 8:44=E2=80=AFAM Feng Jiang <jiangfeng@kylinos.cn> w=
rote:
> On 2026/1/20 15:36, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 02:58:44PM +0800, Feng Jiang wrote:

...

> >> Performance Summary (Improvement %):
> >> ---------------------------------------------------------------
> >> Function  |  16 B (Short) |  512 B (Mid) |  4096 B (Long)
> >> ---------------------------------------------------------------
> >> strnlen   |    +64.0%     |   +346.2%    |    +410.7%
> >
> > This is still suspicious.
>
> Regarding the +410% gain, it becomes clearer when looking at the inner lo=
op of the
> Zbb implementation (https://docs.riscv.org/reference/isa/unpriv/b-st-ext.=
html#zbb).
> For a 64-bit system, the core loop uses only 5 instructions to process 8 =
bytes.
> Note that t3 is pre-loaded with -1 (0xFFFFFFFFFFFFFFFF):
>
> 1:
>     REG_L   t1, SZREG(t0)      /* Load 8 bytes */
>     addi    t0, t0, SZREG      /* Advance pointer */
>     orc.b   t1, t1             /* Bitwise OR-Combine: 0x00 becomes 0x00, =
others 0xFF */
>     bgeu    t0, t4, 4f         /* Boundary check (max_len) */
>     beq     t1, t3, 1b         /* If t1 =3D=3D 0xFFFFFFFFFFFFFFFF (no NUL=
), loop */
>
> In contrast, the generic C implementation performs byte-by-byte compariso=
ns, which involves
> significantly more loads and branches for every single byte processed. Th=
e Zbb approach is
> much leaner: the orc.b instruction collapses the NUL-check for an entire =
8-byte word into a
> single step. By shifting from a byte-oriented loop to this hardware-accel=
erated word-at-a-time
> logic, we drastically reduce the instruction count and branch overhead, w=
hich explains the
> massive jump in TCG throughput for long strings.
>
> Beyond the main loop, the Zbb implementation also utilizes ctz (Count Tra=
iling Zeros)
> to handle the tail and alignment. Once orc.b identifies a NUL byte within=
 a register,
> we can precisely locate its position in just two instructions:
>
>     not     t1, t1             /* Flip bits: NUL byte (0x00) becomes 0xFF=
 */
>     ctz     t1, t1             /* Count bits before the first NUL byte */
>     srli    t1, t1, 3          /* Divide by 8 to get byte offset */
>
> In a generic C implementation, calculating this byte offset typically req=
uires a series
> of shifts, masks, or a sub-loop, which adds significant overhead. By comb=
ining orc.b and
> ctz, we eliminate all branching and lookup tables for the tail-end calcul=
ation, further
> contributing to the performance gains observed in the benchmarks.
>
> >> strchr    |    +4.0%      |   +6.4%      |    +1.5%
> >> strrchr   |    +6.6%      |   +2.8%      |    +0.0%
>
> As for strchr() and strrchr(), the relatively modest improvements are bec=
ause the current
> versions in this series are implemented using simple byte-by-byte assembl=
y. These primarily
> gain performance by reducing function call overhead and eliminating stack=
 frame management
> compared to the generic C version.
>
> Unlike strnlen(), they do not yet utilize Zbb extensions. I plan to intro=
duce Zbb-optimized
> versions for these functions in a future patch set, which I expect will b=
ring performance
> gains similar to what we now see with strnlen().

Thanks for the details regarding the assembly native implementation.

> >> word-at-a-time logic, showing significant gains as the string length
> >> increases.
> >
> > Hmm... Have you tried to optimise the generic implementation to use
> > word-at-a-time logic and compare?
>
> Regarding the generic implementation, even if we were to optimize the C c=
ode
> to use word-at-a-time logic (the has_zero() style bit-manipulation), it s=
till
> wouldn't match the Zbb version's efficiency.
>
> The traditional C-based word-level detection requires a sequence of arith=
metic
> operations to identify NUL bytes. In contrast, the RISC-V orc.b instructi=
on
> collapses this entire check into a single hardware cycle. I've focused on=
 this
> architectural approach to fully leverage these specific Zbb features, whi=
ch
> provides a level of instruction density that generic C math cannot achiev=
e.

I understand that. My point is if we move the generic implementation
to use word-at-a-time technique the difference should not go 4x,
right? Perhaps 1.5x or so. I believe this will be a very useful
exercise.

--=20
With Best Regards,
Andy Shevchenko
