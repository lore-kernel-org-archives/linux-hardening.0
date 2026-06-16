Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29EF3B27D2
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602408; cv=none; b=hKlFg8Ubzyt9Xx0oHTXS3JKPT35DQ3Bb6/cc0HE0XTOk7vZ/ko6yBg5EWZT0cXOrlcFo+45rsfJbkF5JhP4c1bpN0wUgpAAKvzK0r4nj4jyxfDHzIKIh9Bjc8h7UKpc01LRujNuYKHQtPiFnwoLuPJ6xIG6yGXhtRLXzPafLYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602408; c=relaxed/simple;
	bh=zcSczsjl+oUTupPg0K9goQ+v/ljMWZqjCyJlP2xDGRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJltJVOjOoEvi9m9Kb12gwuTKS6z+Ft67Bv6DTdM6p5FbK3fWXmN0IEf+296D0iyEdWvUKq5ipscXNsr1boZ5pykvFsN1bhnRTjuKYDh7mnH+JG3yybjXF6YzwnoiK1eexCRqCZ5SLwCu/q4Yv3fI7kLp1Djp3KHisDHOdAWWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5FQ/phW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5FQ/phW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eec22fab7so1882002f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jun 2026 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602405; x=1782207205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwhTbpSf3S7rURBKa5GxlH2Q5fxRXSJEjfD06CTwETQ=;
        b=E5FQ/phWhY5vmLKA6S4Qj945+TwjCqMTeU7AHc5bI6EGUS1ss1ixzB3XLt0r0tvYEQ
         WgZOWMn16j0PXgtK0UdF6h9/WM6cVk5Bk/ZVQBK2KsvlVFupdAfnyji4+qokW5W+G1T7
         AxMfcyXqYVPzac+YsnbMljhIa7l9dPzadgn5e7wzG6gy5JJC08UXRf9clfbKMSAhVBk1
         TSkOQyHMC+S8rfHxYh13+Tg8cW7g+pwt8roiU0IASTiFi689DjGCx9hC7zDviZuTpSM5
         hqGlJqf8PDVGmTtXWI4M/FOP4AErkjiISY+CTCHWs5abkLJeZ0VRFDkXAgwdu+7eLmRo
         BUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602405; x=1782207205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwhTbpSf3S7rURBKa5GxlH2Q5fxRXSJEjfD06CTwETQ=;
        b=KUHxqKP3QmxsNRSDr6zqHC6Ju//qG0VUkpYIuv3158400DfWdwso20iJa1qLBAGKAm
         5b+gb1O9W1YDyoKItMGkVokqJhfdIJG7T/uLaFp8LhWNNAWWn8sEl62Fcx//y+lBd1Fe
         tHmoim5OFk1NTvR+ul8I+jRvOsK9CripOReCABB7DrN30z5vaKTLXoQHSqIVs/qQ08OW
         b8ul0b0TapXckI6y9sSuOmw9znJED3V4qurZc08q2JLi94FwnPzYYMBxm2AFhoGaYrTp
         62MBLRTBCx6UW2huxIbUfkKlhfQ5nmw+/QE9Wj5J4aEGa5EIpMtWZLUHAjesxlxUTYmM
         5Haw==
X-Forwarded-Encrypted: i=1; AFNElJ/is/qSR8JOIL4ggF7D7XmkdnaNCaIztuPx4Opn1TFsE4x45RzIETW+mPYaI8HEBZtWdQLWg5MFvCayQD/IKg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7U9IDMv26IJfUYIRjry8KFhh98/eQ8rIEigfGzKiDqMVJopM
	cuAHgqopXUSl21OPZMYJlq/uv+Ke089MXWuoINcI2Jj8VaIEUfNXm6j8
X-Gm-Gg: Acq92OEgkcVOa98UvfqzqhE6FSMxP9cquG5cM3y59fV4Fi3YsQkRrCClNiJdzxuufLD
	jkGnzlGrfT4vyyDCwZuhIiTzg2VJbpvUPB++P0W6wSs4OWpY5tJgNka5HyKjMT11HR7ydN41SgW
	2+vPmO574U+oN9pWO4FwBYmR/FDHthM/gxqTa2/7qp4CxyeFlZpr0e7f4IPd1xfPHgXT0auw+ez
	ZJBtK51xgebs538jkNZayZLerLmql5VuRoLW6lABGF/Lm9IPv53XCHgzChgc2pR+eskno/qyGG2
	Phnt+zKkHGVhL529sdUGqCDgDatBuwvzkd8qHw0wd2knILR2Yt9t+Kf1ezUdawfL8CMsNGZfAn2
	EEzUg8RJmsh0vpbRFRXN5S64eHRJrYdbYt07RMhTn1IfRkuFLCZnjwRGspu1eutylfx4zufrUrY
	KarE54wUPabSqAHSWKq1lSQNbNHsHYAL4kG03jLO1jnnr0wNl79lYik6xKk4G4Rq6zGq2gjDrGP
	YeAMTiEfJFhiBCiujWTXgzluKg2Udn5w1VknubndLXuCrzY/onyPMrvWez/LDLtQi0qM0FGtTKc
	oS4gilycX7tzRCvHNlvnsOZ+SZ5Ipn2ffvsl1MSlxFe9Sagpk6qqMgH2ZTdsqBnM7g==
X-Received: by 2002:a05:6000:136e:b0:45a:e3dd:5865 with SMTP id ffacd0b85a97d-4619f3871d5mr4200728f8f.13.1781602405394;
        Tue, 16 Jun 2026 02:33:25 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d9becsm40724271f8f.34.2026.06.16.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:33:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:33:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 05/12] iio: dac: ad5686: add support for missing
 power supplies
Message-ID: <20260616113322.00005273@gmail.com>
In-Reply-To: <20260616-ad5686-new-features-v3-5-f829fb7e9262@analog.com>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
	<20260616-ad5686-new-features-v3-5-f829fb7e9262@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 09:21:11 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>  	st->use_internal_vref = ret == -ENODEV;
>  	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;

I'd use a macro from <linux/units.h> instead of just doing / 1000.

> +	if (!st->vref_mv)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid or not provided vref voltage\n");
> +
> +	fsleep(5); /* power-up time */

I'd recommend using a macro to define the sleep time, removing
the need for a comment.

>  	/* Initialize masks to all ones */
>  	st->pwr_down_mask = ~0;
> 

Otherwise LGTM!

-- 
Kind regards

CJD
