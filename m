Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F31350E3
	for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216058; cv=none; b=O+Ctaw20N1d/I1/qL+cyHSF8ptzh+iQTG6NxFPdClifyqIB8PS80ZHCvZvQXWALSfRsK+Sc/wIIUlCWNoIJ0TP58AodnddWH0JS70E898YLX6HYW4GSa04igDNV56ItLVI0aL9b1mNZQRqHZ/UvzwsLJzcdX+k1JPyu+itgglqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216058; c=relaxed/simple;
	bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYA5j4I3P200HWW7lTkbgo6Fb3hQsm4rx3G/nS2F4Z8E81mXAApzjK8OWMdT9mUCQ5ji6xMiHvGjvnVO2OKSxEmH1r6qGyW+C0DRs/kci+NJCEgSkcxb5i6wSqMqZekuhzXXTDbiZhtEXkdsxoo3jpSKdE/Fq+NSbYpruZ5QAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7rNCS5Q; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7rNCS5Q"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so1010716276.0
        for <linux-hardening@vger.kernel.org>; Thu, 29 Feb 2024 06:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709216055; x=1709820855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
        b=U7rNCS5Q4Wm6KFwyDDzrg5qUX5k15bLbOzYxyKpo11u4DgwTEBLJB5E5A1DPSvUXIt
         9KyqSTSMWO+5JZ3wJa+L7U8ytSVOtniIDk04s2kLIS1oGrLO6wGdKpR6TX6sCX+YgTw/
         +feAuAoPMYppHzEdfhX/88mmAbrTf//8qxREx/pSnHwQu7lscGXrhORQ12/yvcaNfnMK
         /EQvPrx3GRFgOW2S5tyYbkdoCN+JcaVSDLCNrTTpRiyJ6AKGst3/Iz04AjBvlrZXOeop
         OF1foZGOdiJRrydRJps4wJhNi4z579QE1E3C81hcM6hlAiNhG/ZuB6xGhAz6/phBxIiK
         WJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709216055; x=1709820855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzlCXQZmFHhLJ1DjG6JRBVcR3tnpUJ4s13B8bN/dIdA=;
        b=rJ9997VpaiIqZG0MnYiNt29oTOR/YPAc6mTOKOctYsyGr9xrFWcQd4neJNyrNAi8Fq
         RJcB/jPoZ4x5w87PcXsoa0cVfPbRak1PQyocd0jmSfstgbpL0kUR/9TvkDMjWYgSisFJ
         G9ZoyMej7s1/RqNPSt8+P4W3/J0Tp9vcHN8rEASGflzprDO+epEVc1Dyd4XifR0na8zY
         /whrd2EyCZN2f6OQ/afe9XqZ1bv2HIDoSolzkqvJzDyJlBTGzJb4I6cd2I9vZsUtfs43
         LFJBNQ3M05OnrsUr3cT8I1xSbUPASY8lWEVGhuE8NAuZlwVtG6wKZw/WTroIqeayiUM0
         JKOw==
X-Forwarded-Encrypted: i=1; AJvYcCWxfsI6AafBTkeSNvQthcFU+28ccKCN3e4Tr7O7K4SEr+4bnNjzX17fraKxkErFLjZ8JdUwB6SwFcUuLj6pwEQ0AC0y1iDqeS9cgOnli6/D
X-Gm-Message-State: AOJu0Yw2l8Uxv9VQyroOGGosybv40+0YCEi49cotijxpVkgdWgAnHoSi
	uoUHWGsv4mqwvWrl3Gl97NPI69gpAlQxAtOtGPtc2O119t60hu9OD7OYiCE2HRkJvHw4XxgfSjp
	+B8XyZ2BGYddLbhVSUvj155BM77hLXmGyIKmJzA==
X-Google-Smtp-Source: AGHT+IEHu/G/RhbOGKUNEO2WjqaeGbfVkPM+qKPD0bGUq5f2BIYPRcqqhijch3RLX61Osl7GsvNx9tUYDJLBmHsC+NA=
X-Received: by 2002:a5b:f05:0:b0:dc2:2e01:4ff0 with SMTP id
 x5-20020a5b0f05000000b00dc22e014ff0mr2149084ybr.45.1709216055678; Thu, 29 Feb
 2024 06:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com> <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 15:14:03 +0100
Message-ID: <CACRpkdaEzexhCYFf-NKnbcagXc6Tqcn4J+sFWk94mbJG9LkpVw@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] dmaengine: ste_dma40: Use new helpers from overflow.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> We have two new helpers struct_size_with_data() and struct_data_pointer()
> that we can utilize in d40_hw_detect_init(). Do it so.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wow really neat! Much easier to read and understand the code like this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
