Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B926139C
	for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730174; cv=none; b=qJjlDCKqseEJxyhUJPUUQzgsMAQLoOj12n5iD7PFnJA39v8kww/21gh1Lmsh1G8dbrGq7mX+cYYk7w9Ek5HiY24SKeidPQ/BPnr4knRHHKubAvP4Ky192O1+8H5GzWwNjAJsxDGf2eu68aJFif99cpF2TR6wcEtRHunpb/iOsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730174; c=relaxed/simple;
	bh=E2Ss5NU0spuwxknqZWemIH5Bil/LpOahITbGiXOzgGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKzM6RNpxJzhK+kqGNNeGaN4ZtBzcc5NN+/Pjb+1RuTWEPuxS4G5fSuPHSD8AzfWyN6YZzAutQ5XmJqnQUNEYkE0ZZA3p26luZYYap/SsAGymBFNTx4QvkhFbFwweGQtRu6hai7oE1f7+MOdU0e4wT0bn2Ma1uia1Pb4j1DNHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Su3t1zwB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Su3t1zwB"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c1dbe1bc13so179660fac.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Mar 2025 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741730172; x=1742334972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yId3DOG2e6LlUiE4YXCj07p8IPr1qnG+3GuI1v19BNE=;
        b=Su3t1zwBwl2UWJU46+OS2HMWcYyDBRGoV+EmccnNU1OoGAl7hzv7mEDikYgBn2o8eB
         GM4Ij6ne19mBECYUBmbzJFeeMF0lcYM3S0gbzysV0FbvUKZbrx4Cip2Sh8GdzJ1XpkhW
         IJRB1xUJQt9pES1FhO9kE5HcFZZ/qYDMaYxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730172; x=1742334972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yId3DOG2e6LlUiE4YXCj07p8IPr1qnG+3GuI1v19BNE=;
        b=G0Js/nd4beLFa+2D86TlJHDVMqoow0pr2VTSh8uawWuMjaqcXEJJsSrsrC23/iZnIn
         E5jSbE5Aguf0bAVZCUXPNkU3oy3is+DMa/DtxYXsIWUyF+7LMr2rvFL5Oh2kb6XF90s8
         v/jRei8KAADQSXaz9dFHLSRQKcP/cUEmMrlmjoD7jlyWXbTXZjpcHSFu0ODPHJRFDqlD
         y1MgHTpHO6rU4iuCr6CgOvuuobh3ObmepLbRc6TziD6pl759Hb6ES5wf1yDxx8uzFrkL
         e5qi+WLdYWMpVcJPdUWQxWF+jGvPhbyTwj2sVIm9A/Z/kZt4TquYgB8LzurHKaK3RIA/
         3+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWEX19wn6mrl/MBvgjOte820Y2tWoUspHRL1ZAuX4ZGEvZJBBt3xf9NTDGOYHryOHVplnLbr39PyvZ5n9eNbqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jyxcJSsEN6J/AMqs3RBFmL7SxTLs6uFHmNQ0jsQoa8aWv6Cd
	Vl59BD6s5x/gItAsb3YIPpjznRkLmYIvD9WcWB+okPFDfeR4EwPhE3bhlmreDbOr3OJcNEmg8ge
	gJaZEud79saJdtxwDAGe1D7XuEjV9FtSFZ2Se
X-Gm-Gg: ASbGnctAfI1ddQU729kzJZuKmv1aSgR3/HY8RsYZQ8GT7QQsEeeAyoExJMNOWCFjClP
	uvBBVwrF+L/oQf/g2xIgitEAMA5f3BqCE9kiK3Qo74Gf/sHJsjwgMq50akVsgL9qMs+LDzmmSHg
	/Ktosm50J2knBPzUhwHyAPMVj9
X-Google-Smtp-Source: AGHT+IHlIOjzVU3TM4dAFFXmY4mVFxixVLDQO7jLvUUapi5nUmtI8Bm/xq9NCtalUP4/G3pEnLRKtNTRMz4I9D16xZw=
X-Received: by 2002:a05:6870:e40c:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-2c2867c0110mr2804325fac.3.1741730171998; Tue, 11 Mar 2025
 14:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311123326.2686682-1-hca@linux.ibm.com> <20250311123326.2686682-3-hca@linux.ibm.com>
In-Reply-To: <20250311123326.2686682-3-hca@linux.ibm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Mar 2025 14:55:59 -0700
X-Gm-Features: AQ5f1JproEjPKIxAE30A0OuywGTTestqZJn0ft9KPznI_k8qhCvO_e_XSZ-aYQc
Message-ID: <CABi2SkXWD4Pg7Y7TG9fMV9eat_1fOGwHjvEUKHXREN+pRe18NA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 2/2] mseal sysmap: enable s390
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:33=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on s390, covering the
> vdso.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig       | 1 +
>  arch/s390/kernel/vdso.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 608a965e2344..93b880992596 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -141,6 +141,7 @@ config S390
>         select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>         select ARCH_SUPPORTS_HUGETLBFS
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
> +       select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
>         select ARCH_SUPPORTS_NUMA_BALANCING
>         select ARCH_SUPPORTS_PER_VMA_LOCK
>         select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
> index 70c8f9ad13cd..430feb1a5013 100644
> --- a/arch/s390/kernel/vdso.c
> +++ b/arch/s390/kernel/vdso.c
> @@ -80,7 +80,7 @@ static int map_vdso(unsigned long addr, unsigned long v=
dso_mapping_len)
>         vdso_text_start =3D vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
>         /* VM_MAYWRITE for COW so gdb can set breakpoints */
>         vma =3D _install_special_mapping(mm, vdso_text_start, vdso_text_l=
en,
> -                                      VM_READ|VM_EXEC|
> +                                      VM_READ|VM_EXEC|VM_SEALED_SYSMAP|
>                                        VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>                                        vdso_mapping);
>         if (IS_ERR(vma)) {
> --
> 2.45.2
>
Great ! one more architecture uses this feature.

Reviewed-by: Jeff Xu <jeffxu@chromium.org>
