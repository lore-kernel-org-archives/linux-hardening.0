Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869030DED4
	for <linux-hardening@vger.kernel.org>; Wed,  7 Jan 2026 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786578; cv=none; b=KEa5o+WBoPOvil8nS3rriVQeEySWYYFDQtFyAH3NEd3zUtexXNS4Iann/S1seOUZ86wcBMsbU5+THXINT6pQVkfpnIBIFObLs3kP/zcUXgLTd96s+2mZ9X/jtP8NNjGFV/2qguct13KtYQeLSvrLu0Gg44jQ0/QbuXYE9C/otGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786578; c=relaxed/simple;
	bh=HPH2guWiAa+jcLYFfZpcSb+e1N//ctcXTjzek0dZv4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5PZjaW/Y2NjYQ3SEHeI3Bzy0dDuieKPda/3cyE0+JhLRTH4AjeuYL6dtHZzNBJS/K4vi2uLs4tXVCqCoEBaZRKYCOxzp5zTtEnSe6On1u9nmIIhKC3r4wtBjbRTnEzb9noukpQO/D6KR08fYYD8ottWzngPc72sh1frWLocXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Piann2zX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Piann2zX"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b76b5afdf04so374164366b.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Jan 2026 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767786575; x=1768391375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPH2guWiAa+jcLYFfZpcSb+e1N//ctcXTjzek0dZv4s=;
        b=Piann2zXkPxDdBO4KS/75P+b8ziPKHKEuIaI0ck+tZW63rN6EIIYfnIiKHKR4SOdBy
         +taMTRz3rWqIqXFXzfVDXqNKVpVuYjiJBsC4G1nVn5CvvK37HfH0EHxq8U+Ok7+k62ZY
         zvDXchK6YhDEMM/l/Zf9VEkZbBwjMBVqi0Z/RPl5AZdLbpG3DI5Nryn4p/mDPuMA6PPz
         8zpHPRDJROqNmWfTp2lBOgV0Zke+AA8fu6Z3yg5Mqyad+yK4WT5uWs2CTSeAOcrCSSLl
         qN6RGcZoiHpueb6J+NTquRDnKOo6aHEmVRTVxYZfy3Z80HzHuFkE8DZ9KTgJwJn2br4X
         CXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767786575; x=1768391375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HPH2guWiAa+jcLYFfZpcSb+e1N//ctcXTjzek0dZv4s=;
        b=ZDzJsfN8QFuggymSGyy1vXACNPScncqJ5jPMMZi28mH4iKdLikZwz03mSnR718kwT+
         JXqPispqYcWwNgjk7lD/OijWOxuMpPsOXsudvw3yIiEM4yp4vZx0+gqr36qgdUOcufJu
         vS4rND2+2ditpskAISxtlzwvN52DqXeQninc507pZIPLae1YptYqgEemmsi4wWdfEEby
         yDABiUrXV7YmCB8dmpFtMGujY7XIJEh3IrYEf2haQm4nf/DeAh4CodSMo/E8fswB7ZnC
         MGVGi5IYlSStOWAxjyFjj80Bm6hzH2GSQ/QEqxEBilwMlZCa78dfXIGCUObq5x8DeHhZ
         18qg==
X-Forwarded-Encrypted: i=1; AJvYcCUJNKBjkxES9snQ04rxkR1EZjYelkpw+TJS2d6sYrLMVdua1SBXVK+2ocdgV54otLOr6T3olL2xz80foceS/CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc68jyDdnmgjCyLhKseVAe8eGTSTKUFv05gbUVHO8I+d80y6Nn
	71HwXcX2Q49CxWmTh9ytGdEkU+7SY55bMmkw9wOOg3lpWEej4aHD8IXkVgkJLxEA394B+jBWAue
	SLu33CpK1famZfYUuBCh5UJPe34TVk+s=
X-Gm-Gg: AY/fxX5zPbJdf/HGh8YrStRP3U1TDwBbuyWPJJNS2ShhurtnlHvRVa9voIks/MTX3Wx
	dCHUVXI5hHx80IvvK3jFdM0BNK1tGq3x67oCpzN8HT/Nh03Mao5xa8isJLtfkj00CogEBkGP0m4
	Q7acV0QFrgnVRu7WztMpN764+quHsFQpvGwBFP/njmhPrpwkFVAOJ7+Xr8HhCkjEQCo2DgcQvOa
	BqpY6AQ9mkN5z8MWo2Eg3eBLQSD4Jw78CqclcO0Q/nrhbfTrkDXaUWNbpggwwZRpUGYyGrc8SEQ
	d0i9x9e+k3o4rxkqwvjopjLPVs9piSB/HJ4F2Ya74w6xPERuQ1Anp9/Fg2wdNR90OXoi3yI=
X-Google-Smtp-Source: AGHT+IF0eTtEojjW317pKsViy7nHVgMW2wgHc/iJS9TlnBBJEpVv2fLQeCl2wFyqf1AwFn2vihQoXNdjYKby1QvzmuY=
X-Received: by 2002:a17:907:98d:b0:b77:1a42:d5c0 with SMTP id
 a640c23a62f3a-b844538b3e4mr237502766b.43.1767786574668; Wed, 07 Jan 2026
 03:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107023517.46840-1-jiangfeng@kylinos.cn> <20260107023517.46840-2-jiangfeng@kylinos.cn>
In-Reply-To: <20260107023517.46840-2-jiangfeng@kylinos.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Jan 2026 13:48:58 +0200
X-Gm-Features: AQt7F2omyxHUHHHa8EntYV0Gae54HsRPGifEgj5BFK566Dk5fjREMKueoWB4eVs
Message-ID: <CAHp75VfPTwhfzaE0j5oYGpfdYoojPxqQh0AANiW583RaoijqEQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib/string_kunit: add test case for strlen
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org, 
	martin.petersen@oracle.com, Jason@zx2c4.com, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, charlie@rivosinc.com, ajones@ventanamicro.com, 
	nathan@kernel.org, linus.walleij@linaro.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:35=E2=80=AFAM Feng Jiang <jiangfeng@kylinos.cn> wr=
ote:
>
> Add a KUnit test for strlen() to verify correctness across
> different string lengths and memory alignments.

I assume you also wanted the optimisation tests, i.e. something that
does random filling and measure two algorithms by execution time.

--=20
With Best Regards,
Andy Shevchenko
