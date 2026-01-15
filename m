Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E223ABBF
	for <linux-hardening@vger.kernel.org>; Thu, 15 Jan 2026 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452234; cv=none; b=QfTJ73wcF/8f0dUoG50Ub3IpbOlDTdMlYWnhaJYxG+fHKxamunmmOwXNRBbmfGju8lCQqM/t2jjX1d0J9UPqmIJIisx+uYf6Z4nCZ72XraSgZdXKhhpFrpjuGZLTqTF5E/ZzefWwzjhxYKoEY9dTD70dhwbtHbYjjt3j3qLaw0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452234; c=relaxed/simple;
	bh=YKP2CZ3wzEHkWugF5eHJ0l3w6WM3TJ/wJevNxb3ZCQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNYUPsG0tcdJMkMic+gofrw7fUltML2QaukSuEu/hmlioTdRoOXdoxJ7JGohVP1PD/2UtfiuKK2SOivlp0EW7+KJpyPArs8TNvMYViSo4Ic+6Eq+sQCjWiEaqKtH/44CvE3JlCYCGGf8q69hefYqJUZ9ze5gF5GtnloA82T9nTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=dkFE+eb6; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dkFE+eb6"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64669a2ecb5so508671d50.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jan 2026 20:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1768452232; x=1769057032; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKP2CZ3wzEHkWugF5eHJ0l3w6WM3TJ/wJevNxb3ZCQk=;
        b=dkFE+eb6K8Vr9w34FdNnLgifhR4sQyUmjNTdW9doQwE1FvVZDjWfIZefg+qFh1Hs9t
         uBm1N6nGHWOhKGnnSwE9QZnBjemOOincWA7PpgNFEfu+UAfhnVVe4thYJUwonS70dNXl
         eB4xMSQTXR6dzJ6o62RocA5CB77bi0/fPjoQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768452232; x=1769057032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKP2CZ3wzEHkWugF5eHJ0l3w6WM3TJ/wJevNxb3ZCQk=;
        b=JqAqlAk+kH36WkgFu8tO1+Q5w2da2HeyLWmPaS8wDuWn7bd4IFMDEhy/9nd2FMuUgK
         beFExYrJ6nRtPr6jI95WVxWueU7KqFBxxbzvGZHDyTOa5f5Grx2c9BH3X0S3xsm8U8o+
         LP5n+waeO56ByDZe8LAKV9+k/bSNeqXpoWR8v8wzrjcdAwjsznx80u9l6DsP9ddEJMM6
         jK/l/UluMHVOaShRS05Kcy9PSCD5dmwdZyxAhxPUdAq38bKpXZDs085Tbo2EZdMzvPAu
         WLrTIV8F3XXaPd1pEEvTXSzfH5y0J6m0ydXdPtM7tR8sam4Xxr6iOlLsoaP8LbyhHyjQ
         oPuw==
X-Forwarded-Encrypted: i=1; AJvYcCVN0YgazWcqWddR22447Iiy6xfr40hM5dJ7TaNyD5RMre1h+VaOx4trrckjrQwtEV/fSA0CDEJoPfQc4kIXNTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7e2MrZgnwObCrwRIM9Q7iqyGE7UrDtIkFBmBIISjqU2k1Sydi
	WFblRmpY6m4XnSM5AWqm0TuMSWA9uoNbz0UYL6+oG7VH8bIady1vzjgPFWwpC92abxAjM4VuVlu
	O3mNop6kwYLsNEbKkdG8qCHbL/ou5bLc=
X-Gm-Gg: AY/fxX5Xf1omAwN94JpFFmiNb68m36KDlnW5mEylZbsML2AQMNd29XFZNCEypIEIgKA
	2IG7rcVV0zl3+maTnYPXU5jGB4JzyAxZt73WsGCM33FsSjJYDaMOjQ3skP8dBTJTh6cmvj8aT0N
	zvbMa9kowVBkyqTfsXbGe435aZYGo9Hf0CtDU/2Q3/ufxYGOFKVoNyrF6PmG0/DSG0OWkFm9Wrp
	fAohRkWJ7d7yXsePEEmA/yg1DetSm3beqhE7w7XWBxzbEfrb5dG+VmnyR3ye2d8sS02WdIDfNKZ
	npdaIa5iN8m1Ofj18lrhBngIZudKYiX34AyZuw3Z9wgAPlZIpQz3Cssa
X-Received: by 2002:a05:690e:128b:b0:644:60d9:7523 with SMTP id
 956f58d0204a3-6490a66cdfbmr1340966d50.48.1768452232029; Wed, 14 Jan 2026
 20:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113082748.250916-1-jiangfeng@kylinos.cn>
In-Reply-To: <20260113082748.250916-1-jiangfeng@kylinos.cn>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Jan 2026 15:13:40 +1030
X-Gm-Features: AZwV_QhRSZoPQL1K1c2MUsNo1Uz-3GL8JoVUdSP7701Va_qmB_GYFJWYR5xt3qQ
Message-ID: <CACPK8Xc2inE8=mbPFt+iTtgOqF_1U9m+76014aDaQxVyTYy2UQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] riscv: optimize string functions and add kunit tests
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	kees@kernel.org, andy@kernel.org, akpm@linux-foundation.org, 
	ebiggers@kernel.org, martin.petersen@oracle.com, ardb@kernel.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, linus.walleij@linaro.org, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	"dfustini@oss.tenstorrent.com" <dfustini@oss.tenstorrent.com>, Michael Ellerman <mpe@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 18:58, Feng Jiang <jiangfeng@kylinos.cn> wrote:
>
> This series introduces optimized assembly implementations for strnlen,
> strchr, and strrchr on the RISC-V architecture. To support a rigorous
> verification process, the series also significantly expands the
> string_kunit test suite with both functional correctness tests and
> performance benchmarks.

I ran the kunit tests on Ascalon, a RVA23 CPU, in emulation. The arch
optimised version showed significant improvements over the plain
version.

I didn't have time to investigate if the numbers made sense. As Andy
noted, the 'long' benchmark had a much higher ratio improvement than
the short and medium.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
