Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE471586D5
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662635; cv=none; b=o/Bym7cxikIq4TsRUDEM1n5LRNA8IM/nPRceQ694543ZGRTnXTqW2e3wd/qYytbFfaWmmVd7HBAGnLRyYt87+X34WILdYVsQYhIBC6xkwtyQQjwTLDFhNpZVUE71fkRsOQRygLyemytcuknp90ddTzksHOBQPdCPHDNpH9CglSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662635; c=relaxed/simple;
	bh=Syf2VkK9OhG0FGm9QolyXfqpQVipkFzlmRdO+Bf9ENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kea0a3YBspJaYYpNf3TYpfNaR8oGfb5J0rAGuUzbn0turJRuhBYGK6JQeJv0et6Jrwr/K8mfAacWv18v1ishN4YI4CSD9ArNTvjpQEhl3BL79CFgqeoT8avhUdZpE0tKaC3QKMsHmeu0vtWFn2dbKXdoonu9VChLwnzX3no1v80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h2Eqjfjz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h2Eqjfjz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f44390e328so362573b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714662633; x=1715267433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXVdsaSQZG3q3BjeEnlUXi15uZTx4OzcFDhBo6L16Js=;
        b=h2EqjfjzYM3XOGhILe6haVIG3Yi6d6XW1bPfW9ScggCVjhapfmiIYyQmgB3c82WuHT
         Clsa8rm5TZ7A94hMlTBzdXIT/nrV4ehH9omp7EAvXBlNgNIr/71Rm9DZDK90DtH/fFji
         w2ExWKQW4tTfC83C/XBY0DVR5p24sWm4TsiOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662633; x=1715267433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXVdsaSQZG3q3BjeEnlUXi15uZTx4OzcFDhBo6L16Js=;
        b=JTkc/IME2b852+85UkDaxIPZolz+CUfDNkGRfuD6ZF3byV1BHm9oUdp1KothoXvLwt
         Wzo/mQ5gqTzM8gFckuZJt7MQ7bgGt/8CVD5da/NUQGyGLr3uMQQLkx9LnKP6KCAYsIGU
         o1uvbhoyFFs7jSw+VW7LAq/sJqAgl8znT3o1F8VsRbCJtKH8wduyMsk1zIJxyx/Nwecz
         yE4i/HF9uqYRhtGFzpj6Loykj1KF3ITIVpdZ8geaQHXvdR8qHLK6ZosWbvA5CUuaqgiW
         TJnFPtsE3kl7Gc46xwRF6jy+gYmpWTSYj2V+j0CBvcnk1RxNCFnfSmj0ROnKQ10Vb8/D
         EMRw==
X-Forwarded-Encrypted: i=1; AJvYcCWauLLm30ZkBtu731cZ/t3vnnWKlwRxPrsMKMzX+xAtSHBW1aC03yk5rkDd6aRIJIXZwqr95trNEIlmfKzWFP6XHzjrUPgE0WsSqRCNfzrZ
X-Gm-Message-State: AOJu0Yy7xvHWiptIGbhbHp1XaXpUIdSDd0kF0Tl1coCuU+1+RI+iAPIt
	K695R6XUfBDL/BlT0JOeMoElbo2M+i+aWJhSp2LVTd7VmtWyCVhb9sKSSXBI/qjWA6UT5QaIUs8
	=
X-Google-Smtp-Source: AGHT+IEDevyNghnvP0FJS9e6/4jOvzu/SE7p8PlLOxCCPwL7t0qLUaejFyjl7i0fpqziyW0FaHiZcA==
X-Received: by 2002:a05:6a00:4646:b0:6e7:29dd:84db with SMTP id kp6-20020a056a00464600b006e729dd84dbmr3422934pfb.31.1714662633150;
        Thu, 02 May 2024 08:10:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y63-20020a633242000000b005f806498270sm1340442pgy.9.2024.05.02.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:10:32 -0700 (PDT)
Date: Thu, 2 May 2024 08:10:32 -0700
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Hsin-Yu.Chen" <harry021633@gmail.com>, andy@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] string: improve strlen performance
Message-ID: <202405020809.C8973634BF@keescook>
References: <20240502141359.89567-1-harry021633@gmail.com>
 <CAHp75Vd9PibrQA=tgZLHuv-kDXana9rGcu5s_aPqyxW6tDBYGw@mail.gmail.com>
 <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve4BV7+C+XsNmmjCSupcL6PXe_9ZNMGAQXg9nqdMBFrqg@mail.gmail.com>

On Thu, May 02, 2024 at 06:03:04PM +0300, Andy Shevchenko wrote:
> On Thu, May 2, 2024 at 5:59 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, May 2, 2024 at 5:14 PM Hsin-Yu.Chen <harry021633@gmail.com> wrote:
> 
> And on top of that, check what this code will do on the architectures
> that do not support unaligned access. If everything is fine, mention
> this in the commit message. Btw, your commit message needs
> elaboration, e.g., pointing to the test case (which is absent in this
> patch, I assume it's already in the kernel?) and step-by-step
> instructions on how you got the mentioned results with details of the
> hardware you used for that.

I might be worth looking at the implementation of strscpy(), which is
doing similar multi-byte steps and handles unaligned access.

-- 
Kees Cook
