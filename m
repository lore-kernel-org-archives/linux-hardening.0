Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323EC23957B
	for <linux-hardening@vger.kernel.org>; Thu,  6 Feb 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868510; cv=none; b=GDa8pDOijbUxUSqRzKuNxJEQyBJ01tZlynl5vSHUIBE4FTYUTVfM1vYDvKD4rBBcNwUpi5DhuVf+sdRoGX98daiMVyfoXTfU66Xlqb1k2xuniq7iMYwruAVmbSzcE64ztNvJlqATXk1yffalUxjsORzwEE413f4rvkAKoMFW/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868510; c=relaxed/simple;
	bh=H26hCa0BkZ3dMHTQ+5j05dxgsk8Xe5RdYR/UT/6FR1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJwMHfg9xIUEApyN+Jda35pzqyppZRJfXB7FYhvsZlMbBTH7iFK8XXAbaUAwte1TpQ1Z5kN2SeXLgZ0NbdrLNLDcQHIkmOlnZ+3cPoKnlWURoR40HOa/Kr6gIX0pbqVCT/tdycNyt2SfNHNpr5iFWoBsMhdccWJOCF/kA5817XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Df9zaj9+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Df9zaj9+"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54410d769f7so952233e87.3
        for <linux-hardening@vger.kernel.org>; Thu, 06 Feb 2025 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738868506; x=1739473306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H26hCa0BkZ3dMHTQ+5j05dxgsk8Xe5RdYR/UT/6FR1s=;
        b=Df9zaj9+9IC8fyTO+LAviJqdFOO+UMN+s8gst16NahaFc+p4lgpT4YEJq0CXNYBFzy
         OWfFYa0NN4RaQNZhnbj7LmZ9b/yueA6QhqKJbxYG/CyNm3eQEJrkMdOATr2cs8seI6tu
         /uXzKdrWzliPFuIeJKSo489feKxHv93RgA8bQikFHvosorOY7Zx5KPi5Ya129+AXBQHx
         rp1+RQ1bOEwiLhbTJAU3WxqVbocryHEAd3SI7dKALSTzaN+omfaOVF16ZAd3/wF1e27S
         LQ32TWqDJ9atsiS9nGSWVOgvbxWtLDudcUuNZLDmmhF7cabHFJncgHfubH8SMak93Rxk
         SoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738868506; x=1739473306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H26hCa0BkZ3dMHTQ+5j05dxgsk8Xe5RdYR/UT/6FR1s=;
        b=IQ8WbPy176INF5R1ZYWMuiBkdmo3PgdnR9plFC7vPFfpMUPUhxwD+vaBhHWvNLXU7u
         gq26pQ5rPmj/ecZv6jArLRV782tkl+h3OxCcRIdF9SJi+r0L7jzGyTLgI7FT2HKn7teQ
         H22IUgUIClZPXRc/1o+yBpsbyZZ/+LWCrNWhmc8/18tXlLDvaQKX+PhSdWlreDbnTCsK
         dvkw1W/XP0hBDWN5oAHi4xQ1rCm4bL2yOTlj61oU3TRqKuOzcgIQoPHS4P/PHvXIBnik
         QuaWWpgJxTp8b3Z5HASgUBGho5G2+su9kYy7s1dGBCF+UoB10Qr7wqvav3nlnhGr9W2j
         RSCA==
X-Gm-Message-State: AOJu0YxU5/pP96gMhU/jaXkIoLygwugjYUhBXTcspvFyli3sxSq5/FDY
	9Cqw6lodk1bNZKpptAkCpqkfUCv0IylpeX60LPYC66Ag/DhERNc8N/RX1PXNeDZlaaImcooIWcZ
	qqObGjrfIVuLBMCZakEodqrtyjvJjCMmxALZWjw==
X-Gm-Gg: ASbGncuFvYnHGYmHbrEX3WRYkHUGn9C2cqe7Ap3IcTByER1Qheyg0mZyZh752HOX1/s
	DSnOakGekK0limKcALZ+vwrKgCaepLBKxQR+z15o3SUwEpNEE/xw4ks9ThI/S3ozqxym+6Zk=
X-Google-Smtp-Source: AGHT+IGYbTW64WX7v4eRIud9aI7sO+r6eN6uxSXvFM2flvdaMCaTnXZkw1PV8dpsvo+PKiCDP3tZfZA6qctV7ZLyAak=
X-Received: by 2002:a2e:a10c:0:b0:302:3de5:b039 with SMTP id
 38308e7fff4ca-307e57bc6b9mr333711fa.8.1738868506188; Thu, 06 Feb 2025
 11:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203101839.1223008-1-kevin.brodsky@arm.com> <20250203101839.1223008-9-kevin.brodsky@arm.com>
In-Reply-To: <20250203101839.1223008-9-kevin.brodsky@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Feb 2025 20:01:34 +0100
X-Gm-Features: AWEUYZkf3utqCGGAYFw3Wd0K9HPUGk1pvzmcRu62yuHXXkM5758Qny3DAHNgUk4
Message-ID: <CACRpkdZ_eGsfZh2vkG8dtSyZDbStMfDUuj7s7TQ4FcDwThJVkg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/15] mm: Introduce kernel_pgtables_set_pkey()
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Pierre Langlois <pierre.langlois@arm.com>, 
	Quentin Perret <qperret@google.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

thanks for your patch!

On Mon, Feb 3, 2025 at 11:20=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:

> kernel_pgtables_set_pkey() allows setting the pkey of all page table
> pages in swapper_pg_dir, recursively. This will be needed by
> kpkeys_hardened_pgtables, as it relies on all PTPs being mapped with
> a non-default pkey. Those initial kernel page tables cannot
> practically be assigned a non-default pkey right when they are
> allocated, so mutating them during (early) boot is required.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

(...)

> +static int set_page_pkey(void *p, int pkey)
> +static int set_pkey_pte(pmd_t *pmd, int pkey)
> +static int set_pkey_pmd(pud_t *pud, int pkey)
> +static int set_pkey_pud(p4d_t *p4d, int pkey)
> +static int set_pkey_p4d(pgd_t *pgd, int pkey)
> +int kernel_pgtables_set_pkey(int pkey)

Aren't these all discardable after boot, so the whole set should
be tagged with __init?

Other than that it LGTM.

Yours,
Linus Walleij
