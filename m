Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5834EF16
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857698; cv=none; b=uqY+67wHRYWRUdJfjyl5aNa01CuJENmOZLnGeb1qxxoAKbjGtVI+USMM4oYEkVf5sQJLWhQapmrcSknOztNTM9Ivzm1rGfqf/y/JPworSbpYMT4wC+BLF4F7keNKDVt/CpYEhOvvUtvGT8nfabryPwYw0QP/72idLQqFh9tCpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857698; c=relaxed/simple;
	bh=0cCxQ4zVWtY3CYLsY1wEHVW86S85uWrXzNYWN3lThqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PY2c3UVXN4o71f9eLsBUxpRgM2dRpA8TEhr+KDBfkZqCuedCMFcg3PxRk5BUKc4QJgTLm1oxCJKtXZkkTGPJlK0cUh4Xg1lez34VTa4RCJFnKYxfm6TOnevwcmXCjPOGsex6DSu2Y7COPUycBVgzHyO1aBClscLoOtBK8Ym539s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BsBzDYgd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsBzDYgd"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787f28f89faso18792357b3.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 02:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762857695; x=1763462495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cCxQ4zVWtY3CYLsY1wEHVW86S85uWrXzNYWN3lThqE=;
        b=BsBzDYgdLq5JYwIPqSNeLozEHIi9qdflkd/j+ui5ZkmusTeSLTraVh0m1pdGS7gOCV
         64pTgt6ji6t0/RlTTav+AJBDlWDXohuCpjSaYCqbZZMCQXwfYjDLgsAje2blEWsbDPza
         ZLkyEtyiLklNhaHYyqwFdzZrtH+Zp4Bbqerbkrwr7weYuMQmI1CQUNcfE9lrJSBzCuRy
         Sk6lKnxRtyVwNdW8vfFhBIVU71FHD+tbM4GY6sacppRZUjIG2NJuiwAkbcSiml8mD1ah
         eSJXv/ko8om9hSU1bk0k35hMHNajUUhmz8o8BDZozzGF1fXDgHO5xFoiTGcSjcqgd5Q4
         Lz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857695; x=1763462495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cCxQ4zVWtY3CYLsY1wEHVW86S85uWrXzNYWN3lThqE=;
        b=HmKr41SB8ZSZZDpkZR/IDy+MGFo0D8cBbiOnqlxiyTiMq0S21QKiwHQqv+NKK9T8ux
         21xUqBe6ClK/GGgHDoAj8TRst1bl7y5YWgnXoPG2iPFHPNo6ebfgI6WjMi6U/FFvQZV9
         5urxztcsrS+l/VjVDH1mUdVEf9B6O8rLrida9th3tyG4bWjruWWCQ38wXcw7Ja4/pJiC
         Y2hNRL0KuS6O9iL4jl/6yNQ7Y/3Ta+4f+QotKKhJBgAR4yvB7QelbTILIGJykGZW1Rrg
         NAoUKw/V58ievvOFVCvWgH20szyqvSClCFvAiPH2D5UqoaizfdRPzyZszw32xLudDLJR
         4czg==
X-Forwarded-Encrypted: i=1; AJvYcCUCWwOKrbDb4BMagYS2UruohNzli6ncQ1TlkFxaZMryW7KXT7gVgIxe4vYWm2u0UllJjuaYlC1RpcXNKVkfvG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUoM926R2YHsm+qXJrhx+0Dt1N8mh2xOcPfrx0oKo+kCpzrhSb
	ZIUYXuGvHhKXyON9X+Xj8RDj1lVh5bRFHCBv4cr1eslGvyR95kEK7oFbkYPumI08CkgrksmcOu7
	fvVu939c7qJ5A+fjpIibgJ/RpFQhnKKfWZ6Q3hEa+9A==
X-Gm-Gg: ASbGncuWziripi4hC5SgcfHdeczCKFqo7RKQY5LDkvo6bbp/zMR6AsN1TQCMUXM4ZS9
	TBA4btwdiargoLaSUTxBrlttx4C2rBHoB2uKxP32IBzv598p3xsldd03Zy1Tkz1J6iR5c8jwHV8
	wpgjLJwhJ5umSBactrWCodTiKBrbB6mEK5xhKNP4h18M36Yvsw63M8zuCyoboatih3bYj/ByLcF
	fBfH/GiqH04xHjpUD9HZdPQSsroyM58hGNyUrtAWDXLtfM7CtR+bnDqFJ1i
X-Google-Smtp-Source: AGHT+IHoTEqTIMeK7JCIYihCqYCVhAe4gzTa4C+3j+k47suT30AzzIQmG9wEWL0FkhepDKD6CvXqSafZZ1SR1+atEmQ=
X-Received: by 2002:a05:690c:8687:10b0:787:cab5:79a1 with SMTP id
 00721157ae682-787d543ce2dmr101353817b3.32.1762857694963; Tue, 11 Nov 2025
 02:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org> <20251029-gpio-shared-v3-3-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-3-71c568acf47c@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Nov 2025 11:41:17 +0100
X-Gm-Features: AWmQ_bn0WFQEeQmuj7iPjvAHMQKL1gkynLIxqjiJlR4NSYtZ2qnuSvoaANZDav4
Message-ID: <CACRpkdZwO8mXvjwS7xgVvHmcpF+_pgKYsj3c3QRUcYWPdCt5ng@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] gpiolib: implement low-level, shared GPIO support
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:21=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This module scans the device tree (for now only OF nodes are supported
> but care is taken to make other fwnode implementations easy to
> integrate) and determines which GPIO lines are shared by multiple users.
> It stores that information in memory. When the GPIO chip exposing shared
> lines is registered, the shared GPIO descriptors it exposes are marked
> as shared and virtual "proxy" devices that mediate access to the shared
> lines are created. When a consumer of a shared GPIO looks it up, its
> fwnode lookup is redirected to a just-in-time machine lookup that points
> to this proxy device.
>
> This code can be compiled out on platforms which don't use shared GPIOs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The concept is sound and we have to begin somewhere, optimizations
for code reuse and cleanups can be done in-tree.

So:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
