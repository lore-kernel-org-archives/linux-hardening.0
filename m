Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E3218AAF
	for <linux-hardening@vger.kernel.org>; Thu,  8 May 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725979; cv=none; b=rxqGxelApv+KGU8AFtooaD2muN7xjA5oxffL5YOS9LZWEUc+2Eh1BGPpVF+sMOJPo+nASJtUlq6dCU/cXm31S0vP1lAkc1p2r0vKE4zD+t8Ltl7qmjQ5xTzihjbMEZwh4PalXmpRJuO+6q3ZzO46HDozb75NU9teiYGhs+ct8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725979; c=relaxed/simple;
	bh=mjZDxInIt5/yOXLinpjaio+JMeN50GgToV9RTZA81sk=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=eInAbf3uJBxec602nuAyiQpFm95G3ynE5JsuWsww70OSXi12fx3ziM1P/JcNgrz/Ul4I9thbn3ai3ck/yegEr8IBOaSsLW42ZbxRJkZbEA/sgWnIQT4jNsexynouUGWPahmE9E2wUp40sUKYDnRLj1vWki8NrBBdgIHMKWOorlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=WbIENq0P; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="WbIENq0P"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22d95f0dda4so14883985ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 08 May 2025 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1746725976; x=1747330776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Q2vg1BTSM42eTHo3pl1hZh9V4Pj/emdMlH/CKlkCHs=;
        b=WbIENq0PfVm0C4dAXl6OD4C9a7PKZyzBuEiMB2ldBN5Zp5Mm/akyV9EESK7QDjBtqD
         6K9hnOPnsbx0up1+uoaPdtiHanoqrbUiLHVxSjLLA3WWTcwToks+DrMQXWQad8eGe5Jd
         zdCVnFGGi9Y7m5R5Hd73NzM4FVVfOKag08RUuzhyyowF+dl49HJ1ZUpVUpsdrL784kQ0
         Aj3qUbMGGiOeGhPLUMlI0sGtQjlSRu7Nvs0JGCC4ArGHhAli9XGNhZRQqniAlkdwuqY/
         /yuJ0XFXTXzS9HCdPO8db6FumfgnqkFcWw2urhqmA3aL3z5n+VeWr3bSckSwnAKg4yRF
         p8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746725976; x=1747330776;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q2vg1BTSM42eTHo3pl1hZh9V4Pj/emdMlH/CKlkCHs=;
        b=dZ97ZzYI+wbPdPcV7y1HCrkKA+ATpKIw6YDf/gH7xtTLQsd4PLhz3OzyUP2ABMDilt
         fyJHWivrKA8uoWGyM2Q8LU9tTfqfOL6ekpGwCHkCUM9udSCRgLTgqXB/IG2GN2+7TR6H
         +CLPO7KloIfktUS8WcEkxSAxAl5Ikx04bOeooJF7gg8RyF2ISy8W/vAeH1V2DJ0GCF28
         jr8CFc/cYiypZaa7Mv6xCuvPCqE+3814RZqFLhhhfx7uMK9hltY69ZgOfTd+UGW7GNCB
         rywoFgkARzmNBk6BTu1a4k+DwkR5V+D9woG+CHJJPTO9BrOY8i2k0lMybBOt5MmS497o
         Lj1g==
X-Forwarded-Encrypted: i=1; AJvYcCWiiAsWlh1dTrmPl1/gAc4LBTYTWXOqM0t9KowG97vPWnfdxndcCNfieasLPnzgSOPzb9BY4KcuumLfiVSX5B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4aAo+8BMkozNPKZibPY17VtMQaIyRldAbuaegvFY6Hizy1/m
	A0ttvLBc0iMhB+jXqyYtPTLVeZid2CocZUhsN3Hiipj4cK5dgbAUVJXDM50Qcoz1ZN3h2jiiYlt
	J
X-Gm-Gg: ASbGnctqAlRLBoJ32NkUnfakbJkfsqRhkzWrkymQCpJRTnHO8AmOVnmB/B2oXJGoueB
	XOc6N/Hr/GDToH45HlGfjjJOArc5QQUOAn2iLmiOUQ/II4D34rLf4kWbJNIWF7+T7oP34AUIu4s
	rY0PhCncjnNvZiejDGmuzjivt+VSvZw6S46L56040iaDizq2xYZulQzXZDjVclCDr+qqe+kswli
	vV1ZekI2/qVQDktRiT2yZIj0nYQS3idSkfnm0ppBnX3DJpd3FFedWxvWoiDYYDXswWj7UaFVOYR
	IyPYJGH28lt15/dIHexyHBFGF7FV6tT9oA==
X-Google-Smtp-Source: AGHT+IEmGJ9YfFR3Eyhf15Bqfj3jceFTb5e0DgSI0Pb7USDVv/AkviW/WYTgDJ7svFwBHzKizS+WBw==
X-Received: by 2002:a17:902:e949:b0:215:94eb:adb6 with SMTP id d9443c01a7336-22fc8e99d25mr3358715ad.40.1746725976096;
        Thu, 08 May 2025 10:39:36 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82745efsm1971375ad.134.2025.05.08.10.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:39:35 -0700 (PDT)
Date: Thu, 08 May 2025 10:39:35 -0700 (PDT)
X-Google-Original-Date: Thu, 08 May 2025 10:39:33 PDT (-0700)
Subject:     Re: [PATCH] riscv: enable mseal sysmap for RV64
In-Reply-To: <5e7f2acd-2eef-4e69-9c11-ba8d1ec0bbc5@lucifer.local>
CC: jeffxu@chromium.org, jszhang@kernel.org, akpm@linux-foundation.org,
  Liam.Howlett@oracle.com, kees@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  linux-mm@kvack.org, linux-hardening@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: lorenzo.stoakes@oracle.com
Message-ID: <mhng-db41d38d-d3ec-4515-99f9-7368c82d46ca@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 07 May 2025 09:22:09 PDT (-0700), lorenzo.stoakes@oracle.com wrote:
> On Wed, May 07, 2025 at 09:18:31AM -0700, Jeff Xu wrote:
>> Hi Jisheng
>>
>> It seems mm maintainers might prefer arch change reviewed by arch
>> maintainer and goes to arch tree, according to discussion in [1], I
>> don't have an opinion on this,  adding mm maintainers as FYI.
>
> Thanks Jeff, appreciate the ping!
>
> Jisheng - the main point here is to ensure that the arch doesn't rely in any way
> on, within the arch code itself, relocating any of these mappings. It's pretty
> easy to eyeball it and get a sense.
>
> Because if this is the case, the arch will be broken by this change should a
> user enable it, and obviously we'd rather avoid that! :)
>
> It's really likely that you're fine, as it'd be unusual for an arch to do this,
> but I strongly suggest you do so.
>
> And yes, I think these should really go through arch trees as explicitly arch
> code.
>
> Thanks, Lorenzo
>
>>
>> On Sat, Apr 26, 2025 at 7:16 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>> >
>> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS for RV64, covering the
>> > vdso, vvar.
>> >
>> > Passed sysmap_is_sealed and mseal_test self tests.
>> > Passed booting a buildroot rootfs image and a cli debian rootfs image.
>> >
>> mm maintainers like to get confirmation that the arch doesn't rely on
>> remapping the VDSO, VVAR, or any other special mappings, see
>> discussion in [2]

Do you have some description of what remapping is disallowed here?  
There's not a ton in that referenced thread.

We play a few tricks with remapping, including some aliasing to handle 
different VA widths and text patching (via poke pages).  IIRC those are 
similar in spirit to what's going on in x86/arm64 land, though sometimes 
the exact flavor of the trick matters.  If you've got something I can 
look at it might save me from having to read though the mm code...

and ya, we'll pick it up through the arch tree once one of us can be 
convinced this works ;)

>>
>> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> > Cc: Jeff Xu <jeffxu@chromium.org>
>> > ---
>> >  arch/riscv/Kconfig       | 1 +
>> >  arch/riscv/kernel/vdso.c | 2 +-
>> >  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> Please consider updating document as part of your patch:
>> features/core/mseal_sys_mappings/arch-support.txt
>> Documentation/userspace-api/mseal.rst
>>
>> Sample change in [3]
>>
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index bbec87b79309..3cb0b05eef62 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -70,6 +70,7 @@ config RISCV
>> >         # LLD >= 14: https://github.com/llvm/llvm-project/issues/50505
>> >         select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >= 140000
>> >         select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >= 140000
>> > +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
>> The "if 64BIT && MMU" are not needed here.
>>
>> MMU is not checked by MSEAL_SYSTEM_MAPPINGS, which we should,  this
>> can go to security/Kconfig separately. If you'd like, please submit a
>> fix to mm tree directly.
>>
>> [1] https://lore.kernel.org/all/7EB087B72C4FBDD3+20250417132410.404043-1-wangyuli@uniontech.com/,
>> [2] https://lore.kernel.org/all/3de559d6-be19-44bc-ba8f-4c52d4bca684@lucifer.local/
>> [3] https://lore.kernel.org/all/648AB3031B5618C0+20250415153903.570662-1-wangyuli@uniontech.com/
>>
>> Thanks
>> -Jeff
>>
>> >         select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
>> >         select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
>> >         select ARCH_SUPPORTS_RT
>> > diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>> > index cc2895d1fbc2..3a8e038b10a2 100644
>> > --- a/arch/riscv/kernel/vdso.c
>> > +++ b/arch/riscv/kernel/vdso.c
>> > @@ -136,7 +136,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
>> >
>> >         ret =
>> >            _install_special_mapping(mm, vdso_base, vdso_text_len,
>> > -               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
>> > +               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC | VM_SEALED_SYSMAP),
>> >                 vdso_info->cm);
>> >
>> >         if (IS_ERR(ret))
>> > --
>> > 2.47.2
>> >
