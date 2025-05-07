Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEDC28C2B4
	for <linux-hardening@vger.kernel.org>; Wed,  7 May 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634725; cv=none; b=Xfx+EkAiJfcJSFgxJF81A+HIybyTrrLaxyPqoiOD/IEHOrdSdK2d5q+NhlyCfi30JF7c8kWJ6ctJGfqZzCKbPa5iZcGW03QGVwTsg8rQKESV4VvyAvK/+Z/SH7M8eMxbphpc4hVMXxRDy5kvPhMyznAARlNW4guJ/x5UYKLkm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634725; c=relaxed/simple;
	bh=GAluGqfyPVe5W1Jb76fUKRLKd/fw8v+iz9cq2F95mDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnUXUQRFDo6mTfKM4mo/E6V1SQ9jOc1eXbH0kdJn14LZwn1sIyaw+ObIvltElGowRwJjfYx3J66imf1A76ZZzapkocEzjyS3/qvku9XEgDClUAnKWWbrUhGDvrzt8IanuffUv7H0Wt6oaOSvm49xQb9XjQJG3m19P4bJ+WZr6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=js9Sc0e7; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="js9Sc0e7"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c77ef933e5so14086fac.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 May 2025 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746634723; x=1747239523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upjViEFaEDV8pwi3bE89UDVAqHk4uCfII2dkKtqh7XQ=;
        b=js9Sc0e7Hf01XcLLk4uuEPT1dbyOKDXVmRwbgYV+XDauuuCgMMMGWwwtM3GyLd2Cxx
         uTGGn7SL88ATBe0poCyGefLuA17+1En+a/yIhFzo8d0TtX15EcrW64mqXEtIOFa4VroH
         2kwS0nEn3qyzj+WSoTW7CAYCi03VK/vzyrQto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634723; x=1747239523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upjViEFaEDV8pwi3bE89UDVAqHk4uCfII2dkKtqh7XQ=;
        b=FGrPcVXAIGQc6qSxeiMMfoeBsGMGaUyuavQsroaGp7zkhDUcnWfKszaPXtweslmBMD
         fCeKYzlSPgwsF00tKnIjIcxIlFvQDfh8tffEXhJtNX4Dx9mA15W92wA8Ga/ErxbasZBp
         2FRh99cQOW03FVtyfzKXN3Mvm8sjcVaduyN2F0snWi2LcrS9EcJjEg8YfJ/nSQRUzdyT
         gxETyGCvwyqRaSS++yPs3fXTq7wlEb69VHRzm26TBNsUH83sOmurb4yc2J2jHTgaJmr6
         Xc2IUYghXuzYX1nfXm0+HqNfOQYQS0DCVc0/RiibN81VdxwQuJIHVYZh9c3wFh8+jP2F
         9MlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnNkKnbKXvhCdU7xQJE5zC4wxxMPEnkmr2rTdQuBO/bS0xTQnMxeGBXquPgAOoVxlt/ekp4+VAyQwW7y72Bxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uwrbeXpk34UhMd1EqEHnoiPz2K7OnAZoxfgDAH33omaY4sxp
	liUDN2waWP92uPdXOLFTeBnb7MUwawP5lqu+kbklmdcOFYrlQjZpPNfVyO94dHQ09zykttn8CGJ
	ULawnvIpsdC+O5bcAL9lQcp9R1p0Nt2lZWBZU
X-Gm-Gg: ASbGnct3d+7vGwOwiViFVcG/z0JLcZqtRFPGRVB2ZS1p+ITrOifhCIQzTrLIa7+QDK2
	JM+NKqfvb44mRVjV14EKqvn7HYmeGGbcb5Y9P4agpyu3r93yS+Qj6sec8SmL6NfSCoYXJxnVRkW
	ZkS3kzJfi7WdSSuebDJWRGTUtGv3G+xoEISgv9HOaI14OIdQLxXEE=
X-Google-Smtp-Source: AGHT+IG06GO6NGnzHXdYuy9FYMZzPpX9XA6RRfNjedz05neS+lqG6xqVuI1NQA+Rq9jjZ9XV1xQ99xAxsvZLr21m4So=
X-Received: by 2002:a05:6870:891b:b0:2d5:d5f:3b0f with SMTP id
 586e51a60fabf-2db5c110bc3mr836147fac.12.1746634723111; Wed, 07 May 2025
 09:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426135954.5614-1-jszhang@kernel.org>
In-Reply-To: <20250426135954.5614-1-jszhang@kernel.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 7 May 2025 09:18:31 -0700
X-Gm-Features: ATxdqUEg19PZX8xAL4phcTTjEkVkJGWGNXEx6VSuIyaRIyEHgGAoYnTs8-k6z_o
Message-ID: <CABi2SkXJgeLLYQEp1c7EepYzpGU+d0TsOZ5ix6PUUmJLuHyvwQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: enable mseal sysmap for RV64
To: Jisheng Zhang <jszhang@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng

It seems mm maintainers might prefer arch change reviewed by arch
maintainer and goes to arch tree, according to discussion in [1], I
don't have an opinion on this,  adding mm maintainers as FYI.

On Sat, Apr 26, 2025 at 7:16=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS for RV64, covering the
> vdso, vvar.
>
> Passed sysmap_is_sealed and mseal_test self tests.
> Passed booting a buildroot rootfs image and a cli debian rootfs image.
>
mm maintainers like to get confirmation that the arch doesn't rely on
remapping the VDSO, VVAR, or any other special mappings, see
discussion in [2]

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Cc: Jeff Xu <jeffxu@chromium.org>
> ---
>  arch/riscv/Kconfig       | 1 +
>  arch/riscv/kernel/vdso.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Please consider updating document as part of your patch:
features/core/mseal_sys_mappings/arch-support.txt
Documentation/userspace-api/mseal.rst

Sample change in [3]

>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bbec87b79309..3cb0b05eef62 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -70,6 +70,7 @@ config RISCV
>         # LLD >=3D 14: https://github.com/llvm/llvm-project/issues/50505
>         select ARCH_SUPPORTS_LTO_CLANG if LLD_VERSION >=3D 140000
>         select ARCH_SUPPORTS_LTO_CLANG_THIN if LLD_VERSION >=3D 140000
> +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
The "if 64BIT && MMU" are not needed here.

MMU is not checked by MSEAL_SYSTEM_MAPPINGS, which we should,  this
can go to security/Kconfig separately. If you'd like, please submit a
fix to mm tree directly.

[1] https://lore.kernel.org/all/7EB087B72C4FBDD3+20250417132410.404043-1-wa=
ngyuli@uniontech.com/,
[2] https://lore.kernel.org/all/3de559d6-be19-44bc-ba8f-4c52d4bca684@lucife=
r.local/
[3] https://lore.kernel.org/all/648AB3031B5618C0+20250415153903.570662-1-wa=
ngyuli@uniontech.com/

Thanks
-Jeff

>         select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
>         select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
>         select ARCH_SUPPORTS_RT
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index cc2895d1fbc2..3a8e038b10a2 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -136,7 +136,7 @@ static int __setup_additional_pages(struct mm_struct =
*mm,
>
>         ret =3D
>            _install_special_mapping(mm, vdso_base, vdso_text_len,
> -               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXE=
C),
> +               (VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXE=
C | VM_SEALED_SYSMAP),
>                 vdso_info->cm);
>
>         if (IS_ERR(ret))
> --
> 2.47.2
>
