Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72856328611
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949602; cv=pass; b=s7rtRiF4MAqnUjUPHd7TeNFzyIl9su3fifmBnZ2frxY4BjSc3jIm31pNS0DwrJsroxKYKShyVQboMUxBTGdpuJtNHVuUb5t10YbTcgvuX0nhiP/UzwOdjVXhJAr3z63XQjuwA5jQFkaPkoo0XdvzX9G1ta1vJj+DCdCbsjOSSxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949602; c=relaxed/simple;
	bh=9EUtHOwPZ+AhaBRS+tyPj8l9Ae1+JBLJrSOTEwuX73g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bb3BbBHpGbb7WsVr/HqbwlIfcwtv1hUoqPd00VfAgHZq4uNgd5HioJnXzKq2AQ0GaqHZnCojoXeizvyLnnGliNuy1kHmCimLtiRZNzt63gIOsz9nsLTrL3yJVjCRG1mAa9xHu+yg/1cEBJaCoQ9MyCXBh1pKpVsy7s8T3Gbboeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=gq3ljsuy; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="gq3ljsuy"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso4327284a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 07 Mar 2026 22:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772949600; cv=none;
        d=google.com; s=arc-20240605;
        b=C61k5+kNyPASbPOuQ7ClOr7nDG0+ErXJJzrCwgcDMM1sYQa1porPol4TfijgO+UnRm
         dTax49AF3rdF/YjoJ3zWAK6St9XaCeAYza/mOHxHrQQMDWPZrtqyHigOV5glUcO7bbTL
         g/X9olw3WIt+Zd3Ua5u9qTQa5YAD463EBXCZ1alRB/FF+YF1hXTnur9xQ8mb01l79WSw
         M2PIfSAn5TbkNhxihUZ7E+x/JbNsBdksWPwNdX/iAMZ64pIW0EsxrY5eU1G7Mi22Tzzn
         5RouF/GfHKAnikp4K4AXAPDA7yj/kh/OiqKy+aPCeYmlauIzkyhyby7gm+R98zU0XCti
         3Qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9EUtHOwPZ+AhaBRS+tyPj8l9Ae1+JBLJrSOTEwuX73g=;
        fh=fjOxtBmg8jNUdygaUE/Gq+aUE9B1sZAIXzGa54kUBOc=;
        b=d5rIZfSAdsfjYrOop+eKBdiTwjEaoY7pV9L7Hl+QeIMfbc7VAUDcatQhQnsTLcw4E4
         E03JApeLnXdyUoCWS6H46SHXR2zr9tLnHkUm+kG40w+59SQ3BTYwobO9F81c2Gijk5PZ
         AYnG5frvLIJII+LH2nSPqHJr0QqYoPJAM2OhVkTmt+x1wqjbS5Xn+EJTILRCV7/QZyQO
         Ab5i1hnLSQ1XPyW0/8+NuA0iV8tLvpsaKRT2P/7Q2/+jiqLftLBhRxNG2qmL6Gc4iqva
         v0H/LjqJDc54qZnHA/yzvWm534dg08Qhkchunug36QtdVI23Lv9Tb9e+4DeX8jJBtKom
         kUAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1772949600; x=1773554400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9EUtHOwPZ+AhaBRS+tyPj8l9Ae1+JBLJrSOTEwuX73g=;
        b=gq3ljsuyLAbqZJ01iY4HmTpHFzDT7RgCCZ18L/jRkneKA6+Lej9J4OskLJTXcbkSlQ
         Mwd+YzhQNqI5MGQnw6fOTtJeYEOwV95EudiUYaoGLI2TBQmLVpOBj38VF20ZX5WyNqJM
         lVpr+Y1cno+ALPnkZzBUOKvz6otjR3w2FVqS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772949600; x=1773554400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EUtHOwPZ+AhaBRS+tyPj8l9Ae1+JBLJrSOTEwuX73g=;
        b=F3OHgIIOvRSBran9nbPTzFKTToVAVC2pSCtRDvy8/bWVWcUeQULuFSQQkjfpiuUoMY
         oB3mzaNq9C/Gz0+968jIKLzszJORc4gKhkCCQw2F/JLXxiCIcWPiNUdMLnY6nK9uTZ5G
         TKOa2ldssN4hR+efqQ15Mxf5XOilzmcXvQ9GIxwFgpwOsqI3zcxfmRHUnKnCsoCWaeS6
         ZE3clwQvueeMAIqcwHVWFDp4EQ3IMgbXG47/iG4BUwEjQTB9OthlxAD+8DOR5a7gWx5M
         dnADkGWMl9El2w2Dy2ZKJyGXqDLWW4Nc2vXN5mlD1ytZZKKrMGtG32E5+ZA08ew0MYhM
         RTHg==
X-Forwarded-Encrypted: i=1; AJvYcCUbylz/PGGH5kqTyaShoue1WiHAeRzi50HCuMwMfrjr6+hsWi+Q5AeEpVc/8C62E0Kdo0GWZImU4DJJJ3TH7IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAm9Fc6IF7hmbp2IORvpea+5n+czjq6E2e7159UFtKohE63Rgz
	gmfx+cZ8bEMnHLSDBlH4Cf0beTjkdv/gVGwQ3zQi5acM20c4RDKztNWqXD9+l5G7NbI+YL+XkRw
	xzS6tg8v7LZL7SQItjiQWeXSicb8aYtOhTb9zDKj/HQ==
X-Gm-Gg: ATEYQzwKS8LbsQb1hTsaUuhlI+ptvsOKohxCAFWekmx9J1quVTK+sVfYQzyh06EXTxr
	WdFHbqmdsckWdLd4bfsyz0i/5LfOqKpWXLpt+U+61lwbcgINsbefIamrSsRFkLFEGS+GPMMgfsv
	dUimVgLjkIHhqBj7pEtiIcpFqwm4LtzqrTb0kpbGCGCWqPRKcjVQ794ZfBv/sNk6vLplv2k+BQn
	i93dFI/X7D+XOi88eLy5Mlq2jBsk3lGMBvaB23ZUmcKQzT+6uiuFFK4kC2ps72CcJb9hYWJwlZA
	3YxfzRJzwg==
X-Received: by 2002:a05:6a21:3b4a:b0:398:7796:ddb8 with SMTP id
 adf61e73a8af0-3987796e0a2mr2084371637.60.1772949599725; Sat, 07 Mar 2026
 21:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021535.48098-1-rosenp@gmail.com>
In-Reply-To: <20260308021535.48098-1-rosenp@gmail.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Sun, 8 Mar 2026 14:59:48 +0900
X-Gm-Features: AaiRm510gP8H23l1I4hc-O8_tv8pfmPKaxxv5LtBLQP8FXFHqw0aA7QhpFGe49M
Message-ID: <CAFr9PX=Aey-NJwKZkfsUKFWbQqj63eK68qAoLW_dXmPAnUw1KQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: msc313: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
	gustavoars@kernel.org, Romain Perier <romain.perier@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	"moderated list:ARM/MStar/Sigmastar Armv7 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rosen,

On Sun, 8 Mar 2026 at 11:15, Rosen Penev <rosenp@gmail.com> wrote:
>
> Use a flexible array member to combine kzalloc and kcalloc.

Thanks for the patch. This looks good to me. If I get time I will
build and test this but I can see why it shouldn't work.

Acked-by: Daniel Palmer <daniel@thingy.jp>
