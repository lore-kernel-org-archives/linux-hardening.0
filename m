Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83E2550D4
	for <linux-hardening@vger.kernel.org>; Tue, 16 Dec 2025 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908846; cv=pass; b=l9k6LHsUG34sWzZy1sP0XPbLMozA4F4lNGzAr00jjDQRy7dFV7g02MdnRuXP/+mnTeHc0kThpjGSYxGYTUKik8cWik7b0PKkofFniNKHiq2ngD1kvJRFY81SmJIAWTNhJUoA0uOE7MUYoiWYBok5wF4n0akoX7/rpX/0YB7Pqok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908846; c=relaxed/simple;
	bh=gFBGcyeZZyvRdNE+PyGFWo3v7xUhsBT66MqPOaWfHbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWxSBrBQiIR095oQrEC1TwwozdNA/aCVmAPMx/tV66fL3FXmA2MxA/vHnWKKc4WI0E7/3h0Iqq3pmBVlArUNAMrd6GxZqhl9koqWnjLXYS/pz8e7O7l20n7QCKFJfmw7sXtdra/zI2gcqz5IC0wEDg9ZPnwOVUykb1TzN6It+U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5x6IoVW; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5x6IoVW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1462573caso9905ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 Dec 2025 10:14:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765908843; cv=none;
        d=google.com; s=arc-20240605;
        b=OCPUXc93qCi6yZDcCBJ8nxSsgdr5BP5ywvxYgozLLFOoiEcuanCtcUpwHIUf37sUf6
         xbbKuWyKrjYqkAvZ9tymB7AxG/YoNc+3XmsKbTkqDPVnm1OBvzaKQbq0Ukj1LbcQSJ/t
         nyCcjL21K5VY+jziDeRAb3+4oguzB2OBxULoA4uQNWCRK4P2O8ejvjbLy6NHoRN2mHKl
         EmxhW9aaDbWaVwmpAIj3gPLZhcIP8B5VfKsBzYeuM1coMdJNftOfwPB79HHICnySesua
         w+BLQ3RF7e7Qgqw4g/VXbbXrPzk7vFPfQq0WZwH7XCV/eDg+47Bmrd94sYnEXufb9lLd
         MoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7kcNR5wGVuWjMKxImEHU+F1cjyHO5MBFCkdLHhMDLn4=;
        fh=QsMUOylXivvJNLBlVDDHOALAiN4BRVItinSYJO+2hyE=;
        b=l0XK/JtQcSPC17Tjfbe1NQjQYvT/4DqFexVNBR71hKUSVfVPYWlf2ESM1BBQPywniT
         yrMnxtTGL/rFHZNvrA33PwiHs7yOBqinACyxrXlzw7R0Fu/H289TcdM6JNqn6gh9xo4Z
         ptDdlMt+WE/asMfZ+uvDhq23TQVwR0HhNSszB4dJ7LN34shSdcmukdLy2eIUi4DSuv2i
         eVFtXWWVxIk/yJSTb1xSxnvCmHRUaIOJF+yAi4U/DKgPy8cu9BtQhOFv+C3x8eZaQU6U
         /+4T8YhQmvULTAbeG1jDo3TXLIgK5ec1YqNooAVLKJiwpZCsRzanvVQFw1XjPBQ1RsEm
         Lb4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765908843; x=1766513643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kcNR5wGVuWjMKxImEHU+F1cjyHO5MBFCkdLHhMDLn4=;
        b=r5x6IoVWM7GJG6zG/jrHBrEgm9gzTDPWHIwFp0M0e2avGUvtvEve6Hnv336xqffwpQ
         smSlq8UA0N5qP+LxabJAZPwsImqtr8WXUYGox97n/39pgOPCBwVm7N59496fKUhxmMTy
         atNkC6iwVtfjKpNc4Z/bn/0dMYaJRnhXHTgxKvtt7xBl5qIlRaNoTbxHyyOb5vJT1+AB
         zSoM+sQHWFAJpIeg7BodDfeFKLPFdN+GxQRi1UpDX0OhmNmuCgT2irwo3FnxXanSUVrR
         iNdu4NlJJMnl/MPKMbMMFVQzC+FpHVZG/fPe508Y6VaTH+dStaw+w3e2L00Q+iu4UejS
         o3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765908843; x=1766513643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kcNR5wGVuWjMKxImEHU+F1cjyHO5MBFCkdLHhMDLn4=;
        b=DCM5+jnxbEGBsB7Jy+6lufXUhGq2kt9hcCA9eDPcsIsR2DkN+9wduAZ0+MALmNK2pW
         JsPzUvGUTtW5BZUrAcr5C0snMIYZofFATxp9kltDCj6pgQOe9hyY048RvRJVVxBpoOnA
         LU5wCG7pb0MZlrtdx6Idk3M5FsObIGpiRzZVJJZtH5dQPnLV7w0HnZANIKQD25uhAkpx
         LomCUx2UboOjzL58ECtcO+CcO/j+R2qW5A0iQUeHMA7eznIrApZBv3MhpC2OqzOzh1g2
         z4Fv8aBkw6/OereSxgK/IRct5kPhFNOwkFmZQs2ZubvwfvggNdsC1FbPZsrctT8ATK44
         eljA==
X-Forwarded-Encrypted: i=1; AJvYcCXt18nHH5fuzYqCaP4ax/YX6Pa7D5HISvWnfK3qBfZ64OoeNRwMfLXeJ9Gb/pT7/eg3zfUuSg4IhAxgTglickE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdIg7v2pTse611r82y0dNUIWaIkKg0GsqZVN2Dxgy4pad21qS
	p64o3TKFZc2q8TdGIbbXL9d40ABcpa1U0bRuirgmwCsy4NZ08AAvtmghpY6OEmSOps9iZxU79ui
	0G2bb8Ysa25DiRchMnEy2Tcn8fdPi0MQlO/Emj8mpuiiHi/UJFiFGUWwNKT8=
X-Gm-Gg: AY/fxX4HSEIjCU0+ii8vrKtKuHjp/6pM6kvDwnLao6V4GBlHyjkai4AqjGaNQUc6mFv
	j2ylfIgYJTNbXYN/NaIleL9YaOrao8BG4UqlotrfNZoFLninGoq93oUOiRxAj25CZfe5imXtdno
	2UxDKjucC/u+UlnSUsd6dxCoyv/gU50SJJB+T/uhHzv/NKcYBLhULgALMreqjgms9aAdLhLBl+b
	QQW8Qd9XW6QEJFgBqMA2q8LnOhIn613EDdcVel0AeRC/wEN7uOgbiMHn9jlRJNMSQ01v+n4/l/6
	wJlH8VY+gMsurUmDCyhDkLelQPk=
X-Google-Smtp-Source: AGHT+IFz9B92VX6sukrtIuHVb4LXaSaNzYcGWIckRzJ4If3SF7zpKb71wIV5qANCvXImX5qSEM4EWY8vj4XrfneDhvg=
X-Received: by 2002:a05:7022:428c:b0:11b:3bc:9ea0 with SMTP id
 a92af1059eb24-1205bc4365fmr4270c88.6.1765908842012; Tue, 16 Dec 2025 10:14:02
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211040935.1288349-2-ardb@kernel.org>
In-Reply-To: <20251211040935.1288349-2-ardb@kernel.org>
From: Seth Jenkins <sethjenkins@google.com>
Date: Tue, 16 Dec 2025 13:13:49 -0500
X-Gm-Features: AQt7F2r5U7ak827_4IL8EJxAnkohuSSPkBPxwYIQcx8SMuJ5ELLNxUxgU5JVPFU
Message-ID: <CALxfFW4gyv3gSc1JhkPNqk4LL6S6gZbDRJx2y21PFZ8-8_9s_A@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64: Bring back linear map randomization using
 PArange override
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, Liz Prucka <lizprucka@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This is posted as an RFC because there are obvious shortcomings to this
> approach. However, before I spend more time on this, I'd like to gauge
> if there is any consensus that bringing this back is a good idea.
I may be a minority, but I do think bringing this back is a good idea.
It has now been 9+ years since hardware side channels for bypassing
KASLR were discovered, and it still appears that real-world attackers
overwhelmingly prefer alternative strategies - such as this one.

I'm under no illusion that if we just do this one thing KASLR will be
secure again, but I think this patch would still have a meaningful
real-world impact in terms of making exploits significantly harder to
write.


On Wed, Dec 10, 2025 at 11:10=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> Commit
>
>   1db780bafa4ce ("arm64/mm: Remove randomization of the linear map")
>
> removed linear map randomization from the arm64 port, on the basis that
> a prior change to the logic rendered it non-functional on the majority
> of relevant CPU implementations.
>
> As has been reported numerous times now, the upshot of this is that the
> virtual addresses of statically allocated kernel data structures are
> highly predictable if the kernel is loaded at a known physical address.
> Any bootloader that still adheres to the original arm64 boot protocol,
> which stipulated that the kernel should be loaded at the lowest
> available physical address, is affected by this.
>
> So bring back the most recent version of linear map randomization, which
> is based on the CPU's physical address range, but this time, allow this
> PA range to be overridden on the kernel command line.
>
> E.g., by passing
>
>   id_aa64mmfr0.parange=3D1 # 36 bits
>   id_aa64mmfr0.parange=3D2 # 40 bits
>
> the CPU's supported physical range can be reduced to the point where
> linear map randomization becomes feasible again. It also means that
> nothing else is permitted to appear in that physical window, i.e.,
> hotplug memory but also non-memory peripherals, or stage-2 mappings on
> behalf of KVM guests.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Cc: Liz Prucka <lizprucka@google.com>
> Cc: Seth Jenkins <sethjenkins@google.com>
>
> This is posted as an RFC because there are obvious shortcomings to this
> approach. However, before I spend more time on this, I'd like to gauge
> if there is any consensus that bringing this back is a good idea.
>
>  arch/arm64/include/asm/cpufeature.h   | 13 +++++++++++++
>  arch/arm64/kernel/image-vars.h        |  1 +
>  arch/arm64/kernel/kaslr.c             |  2 ++
>  arch/arm64/kernel/pi/idreg-override.c |  1 +
>  arch/arm64/kernel/pi/kaslr_early.c    |  4 ++++
>  arch/arm64/mm/init.c                  | 16 ++++++++++++++++
>  6 files changed, 37 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm=
/cpufeature.h
> index 4de51f8d92cb..fdb1331c406d 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -1078,6 +1078,19 @@ static inline bool cpu_has_lpa2(void)
>  #endif
>  }
>
> +static inline u64 cpu_get_phys_range(void)
> +{
> +       u64 mmfr0 =3D read_sysreg(id_aa64mmfr0_el1);
> +
> +       mmfr0 &=3D ~id_aa64mmfr0_override.mask;
> +       mmfr0 |=3D id_aa64mmfr0_override.val;
> +
> +       int parange =3D cpuid_feature_extract_unsigned_field(mmfr0,
> +                                               ID_AA64MMFR0_EL1_PARANGE_=
SHIFT);
> +
> +       return BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
> +}
> +
>  #endif /* __ASSEMBLER__ */
>
>  #endif
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-var=
s.h
> index 85bc629270bd..263543ad6155 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -58,6 +58,7 @@ PI_EXPORT_SYM(id_aa64zfr0_override);
>  PI_EXPORT_SYM(arm64_sw_feature_override);
>  PI_EXPORT_SYM(arm64_use_ng_mappings);
>  PI_EXPORT_SYM(_ctype);
> +PI_EXPORT_SYM(memstart_offset_seed);
>
>  PI_EXPORT_SYM(swapper_pg_dir);
>
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index c9503ed45a6c..1da3e25f9d9e 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -10,6 +10,8 @@
>  #include <asm/cpufeature.h>
>  #include <asm/memory.h>
>
> +u16 __initdata memstart_offset_seed;
> +
>  bool __ro_after_init __kaslr_is_enabled =3D false;
>
>  void __init kaslr_init(void)
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi=
/idreg-override.c
> index bc57b290e5e7..a8351ba70300 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -43,6 +43,7 @@ static const struct ftr_set_desc mmfr0 __prel64_initcon=
st =3D {
>         .override       =3D &id_aa64mmfr0_override,
>         .fields         =3D {
>                 FIELD("ecv", ID_AA64MMFR0_EL1_ECV_SHIFT, NULL),
> +               FIELD("parange", ID_AA64MMFR0_EL1_PARANGE_SHIFT, NULL),
>                 {}
>         },
>  };
> diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/ka=
slr_early.c
> index e0e018046a46..0257b43819db 100644
> --- a/arch/arm64/kernel/pi/kaslr_early.c
> +++ b/arch/arm64/kernel/pi/kaslr_early.c
> @@ -18,6 +18,8 @@
>
>  #include "pi.h"
>
> +extern u16 memstart_offset_seed;
> +
>  static u64 __init get_kaslr_seed(void *fdt, int node)
>  {
>         static char const seed_str[] __initconst =3D "kaslr-seed";
> @@ -51,6 +53,8 @@ u64 __init kaslr_early_init(void *fdt, int chosen)
>                         return 0;
>         }
>
> +       memstart_offset_seed =3D seed & U16_MAX;
> +
>         /*
>          * OK, so we are proceeding with KASLR enabled. Calculate a suita=
ble
>          * kernel image offset from the seed. Let's place the kernel in t=
he
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 524d34a0e921..6c55eca6ccad 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -275,6 +275,22 @@ void __init arm64_memblock_init(void)
>                 }
>         }
>
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> +               extern u16 memstart_offset_seed;
> +               s64 range =3D linear_region_size - cpu_get_phys_range();
> +
> +               /*
> +                * If the size of the linear region exceeds, by a suffici=
ent
> +                * margin, the size of the region that the physical memor=
y can
> +                * span, randomize the linear region as well.
> +                */
> +               if (memstart_offset_seed > 0 && range >=3D (s64)ARM64_MEM=
START_ALIGN) {
> +                       range /=3D ARM64_MEMSTART_ALIGN;
> +                       memstart_addr -=3D ARM64_MEMSTART_ALIGN *
> +                                        ((range * memstart_offset_seed) =
>> 16);
> +               }
> +       }
> +
>         /*
>          * Register the kernel text, kernel data, initrd, and initial
>          * pagetables with memblock.
> --
> 2.47.3
>
