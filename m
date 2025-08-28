Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C830F81A
	for <linux-hardening@vger.kernel.org>; Thu, 28 Aug 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382936; cv=none; b=Y6ZmtnX1VjGaGQSB8BI2XFlGHS5BiMiT8Cwc+y4j/3wCQT8AyYf4Ku/35bpVGUH/NIJ+CsjrSr75cGN9GI0joVgQ8Tqbv65Zvt2c03ZcBuXqWFhrGpPKYKO6pfJp5hcw9SXv4JNO4vlgdsaWldWLSLp0BIs0gWD152XeA5IYeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382936; c=relaxed/simple;
	bh=6sywg8iRUIcC+LFpPdVUH7AYVGdElA+Lmuu0M26yEpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnSoOytTzUvYE2QMyeJrsfhN/nLWIGyoHYFBRERPBY6KJ2ItOWnfAbWF6MfA8C4Asoepwklxh0wYBkG1KBwsYG/ZyHRC4FcmdMis11xMVUMFlqNxKPNA87x3km0/IDRzImXFi2PamixEvqyW5x9SExN5OQ1flYz+VkS2ibmMN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNgl824L; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNgl824L"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f46ec2e00so589761e87.3
        for <linux-hardening@vger.kernel.org>; Thu, 28 Aug 2025 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756382933; x=1756987733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sywg8iRUIcC+LFpPdVUH7AYVGdElA+Lmuu0M26yEpI=;
        b=oNgl824L+fC2moaJSL5/4UkdvCTWCcmZGxmMXiFhw15Nk4MO1i+znJi5GoZmPkjPdH
         vV+qsgN4MHSjVwuL05hPonCM+KCuc3ltbN+pE0w3GTgSyAbUEipqSGvqelFmc4lmI5WK
         gqxPx1T+vhr1w4hYkPiMIJ441sO3Fryo/L8pmtvDSBUbqIEcNRO72GZqtLzbuWMeKjMY
         yOabpuU2TqX7Bi31pvfjDby/oCTRGhVnKhITNdAylRHg7IGLa1oknJAvglS5yZbMz8e4
         i/z1vNqo6asC05PbHeW4Hi2209ndvK4hBH+S8lI3JA1vTbXV44oJe4r9G6T0tw73dQDh
         qfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756382933; x=1756987733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sywg8iRUIcC+LFpPdVUH7AYVGdElA+Lmuu0M26yEpI=;
        b=RHhOgxuIl7nLhQTCdOPIxEl89qYk1PzE2GhP+y0gNWPIP5GNw4oobWRdULWgT7E7E5
         m/6kUxQN9x8etR8k5Rw3CgGmwR4GWVgXZ0FU6TWNdfgRgnJ7ADPsoBt3p9m4sEQ5RLa5
         +zTNcouF8ZceK7feNC9P+0ebeKBNVNYI/9m75xXUkx9acW1rW0vW9AcuqfOCCWxqyteT
         I0QRoB7v/4me5RgNiZhyMYCKoY1tUbF4pCZ4ZY82rG+VPE28QPSK8C5yG4r+faKccRPw
         FX53f/4CiIZKgZMyS1wSFNkpUggqmkJ+CWyTCFEKINyf6GNZZqoDPijKRtNzIC6tvU+2
         Blvg==
X-Forwarded-Encrypted: i=1; AJvYcCU7jjQRZi79cFZ+/xoOZXSukwdh3xGiGx7V1kiFt1L+Rs/yXAWnp+NvUJIcF71ywaKc+YL/JMZukdFJPMPjVio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGSk7snxJubncJ1bLRE7w1qhaPGBICYz1bFllRFr4JpD13AhA
	1qxlv17kFTIvDUMlzkRH7CZ2KrlInBmdcU8cxsokLCuw/Pdz66OOCHKOBWvljWWOHnuFVOeLq4b
	FInIAnEjWqKSomLIYQ48zUV1USutVcmo77XT4vKdVhA==
X-Gm-Gg: ASbGncvphDcmNONNfgNmoT+IOZn95jSzGzsADfs/ftfdobLxN2b6k1ztsSE8dQadEXX
	cQp9FlVTcjt2KPxV8+KOdfgBjQvHqKlfSmo3iK7Zc4aX2Z1BRUtY0tJS/skOkgoGe6xBegYrgNl
	Bd0mVgcVT7atygXZbevwNuQrKo8fy2cdbtbQ363Nl2yPZFwoBTN7JhGmMhNll5QoNHq3d3idt8D
	YUOSw/FZ2cTWtF8Fw==
X-Google-Smtp-Source: AGHT+IFg3M1giQrPALPiOG52C1JhN5PlRo7Xbw3xLek1Xu/lN9fGos88k4kc0ylKwurf0xKqLRcKUK5Mrc5xQ4s7/mM=
X-Received: by 2002:a05:6512:6509:b0:55f:53bd:b137 with SMTP id
 2adb3069b0e04-55f53bdb50bmr2129835e87.31.1756382933088; Thu, 28 Aug 2025
 05:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825141316.work.967-kees@kernel.org> <20250825142603.1907143-5-kees@kernel.org>
In-Reply-To: <20250825142603.1907143-5-kees@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 14:08:42 +0200
X-Gm-Features: Ac12FXys7kn8v1WW0NYPHPp9t-_9fYAtRAX-1QlGxBAnqlbjxr2PgRu8yVVv_Ow
Message-ID: <CACRpkdYnM98n3JLBwVnVD3BRf4qrg4g9aBDqL_2Qb_cao6f5yA@mail.gmail.com>
Subject: Re: [PATCH 5/5] kcfi: Rename CONFIG_CFI_CLANG to CONFIG_CFI
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@outflux.net>, 
	Sami Tolvanen <samitolvanen@google.com>, Mark Rutland <mark.rutland@arm.com>, 
	Puranjay Mohan <puranjay@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 4:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:

> From: Kees Cook <kees@outflux.net>
>
> The kernel's CFI implementation uses the KCFI ABI specifically, and is
> not strictly tied to a particular compiler. In preparation for GCC
> supporting KCFI[1], rename CONFIG_CFI_CLANG to CONFIG_CFI (along with
> associated options).
>
> Link: https://lore.kernel.org/linux-hardening/20250821064202.work.893-kee=
s@kernel.org [1]
> Signed-off-by: Kees Cook <kees@outflux.net>
> ---
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Puranjay Mohan <puranjay@kernel.org>

Yeah that was not a good neutral name to begin with.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I don't know about all that fuzz with providing the old symbol.
Seems complex. Folks anyway have to go over their config
symbols with every new kernel. But if people insist. I'm fine
either way.

Yours,
Linus Walleij
