Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE87629C325
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559355; cv=none; b=rBv0NmjtmOnHpnjIgyNB3EBQV+QkgujE2cjYlozIJtJqSmasQQdJsg4jTHtw2baSj4qx9KltOZmGptffFozAyeVeJOAaVxQq9eMTe7HlOYhbAvzze55STj8L0NMG8u6BZca4+YMMyG25A8+yonarhM2fk/2ylFjxNLYORqhQAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559355; c=relaxed/simple;
	bh=U6Na6s2P5c1DqTdnoC6CkwOGk4v/Ph4Wt3KUWux1jLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY3qmHnHZ0Wudig2nTLVF6Qfetv2tBuqIl1w4N3apY2fK4DkgYjD3c5j5scK72HyyOixKPFSxYkNaCaK/rV60ID7DpaCBHfEGpG+G9qzzpOlrnsbB/ZpKc0WVWzTALuleUee4Zy50Pv1kCsCR9OP/Yq8bYdk+HUSWlYxpO5TV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8HBbj0L; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8HBbj0L"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32925727810so45606421fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749559351; x=1750164151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6Na6s2P5c1DqTdnoC6CkwOGk4v/Ph4Wt3KUWux1jLg=;
        b=m8HBbj0L7i1RABUFxPposqPNyroZKieLJZOGFjMx+TwBkab7hbA8C2H/psaZLeSOPi
         sRQxVNWVZCEDHv28JUEyncQJwmAmxXZz/w+wT32fhcwLdCQcBDQhj1HOKFkNFBxv92dH
         mdzzYZ1PSW+Hfe/Tb/IIHq+S1Tm0CITtJuRbT22xOkNzG0fFTzUeomoobToNpkz1w9LL
         YrMU3WGaEg5dkNjJrCMyA2JUkr36nIop6D+T3Uuh2RDjT1kA85uu4B4mSz6c31EuMmha
         /7qhSQR24VhkIlaY/TpC0W0rvx06Taew5/Q6WwUjArn6gxdRgYofKPwggLDX88FeIdKA
         jqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559351; x=1750164151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6Na6s2P5c1DqTdnoC6CkwOGk4v/Ph4Wt3KUWux1jLg=;
        b=oKxb8FvqkpLx2e7mTuR83EyWZ+6LH4XFUTj3aE5zQRDQgQsnpUybv00kXNiEa2InEM
         yN6bAQ3ux2IJbXyXHvG5BUWXJxH4Kepkp3TmwWiZINLMtFgsWoiBEbYMOc36kog59DYc
         xA8YeADUCQfrEkI9hJxGMU7iZ06w1PP+UPznijmAYxxk2QV+GOgWpzBj19uJldXmOi51
         7iurXpXBhvmcLLEUh0rtQHGaWRMOiyCi3C/TMR0rpzaBe4CzrxHGXhfSc4ROSowbmD7Q
         XbQGL6KHL/StgkkDBiZfs0UVoq0zCPNRfso2LbVScEL91Ugto4LDzc4IvOC6kkgH/VKj
         VONA==
X-Forwarded-Encrypted: i=1; AJvYcCV29YzRm7dHVlUNqs6mHqhjMDVZr+OnAQwaEHLKUULH5RSPS59TjFStRJLHQ7wQO6gsOhmE4OHcG12YkZcYaes=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRE12M5i3ODTAugyxJEqPMGLUmwDhPZFfq+sT6ZjvmDrKqlBs
	2hH5WasEskymGtRKlQUZ8VW3dTKNDrXgKL5lhd6U56Knq18S1lKsS4rMD+svSBgKOHA5N6+C239
	f4b95pppPNZ5DKeRXcEDElvxvX+/Ue8obl2zJJ8fCrw==
X-Gm-Gg: ASbGncv1een+Mx7+7xCqsIdA22BfiFNLiMmHofSGvreuGf77PD++V+tDFHi2YB8j/AA
	9cHiSTfJEsQfo42sHVmTCGo855IiVfJO4jnrOM4MTyBjIAnrl3N1mFCpn893Q/f7DCww5TL8rvj
	eyiGzDEY3iTU+kq1LTcnGSux37uCDmMmkcryyfMQTmbi1SNzp7LmR5Dg==
X-Google-Smtp-Source: AGHT+IGD5WXbHGGhhGRo5sVeUpYouurIwKWToxCb9XtYaZwZ9hBmk03t06DwUfTbDOn7DXb0nilwhoBbFz43CxKKxzc=
X-Received: by 2002:a2e:a78a:0:b0:32a:9a0b:4697 with SMTP id
 38308e7fff4ca-32b152d6ecdmr8013991fa.21.1749559350758; Tue, 10 Jun 2025
 05:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-aaeon-up-board-pinctrl-support-v7-0-1ab73ec0cb98@bootlin.com>
In-Reply-To: <20250609-aaeon-up-board-pinctrl-support-v7-0-1ab73ec0cb98@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Jun 2025 14:42:19 +0200
X-Gm-Features: AX0GCFvbZS-4AQxpsQip_StlBivPF4rBRcoZGRYX2DDCi0OTfFjKlqil2Mw3JNM
Message-ID: <CACRpkdZpn5xy+6yb-mQd6wDs05X0QqRCQo7QpL6=aEWtyU-zTg@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:51=E2=80=AFAM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> This is the seventh version of this series. Only few changes, the series =
has
> been rebased on v6.16-rc1, the pinctrl patches were dropped as they were
> already merged and a fix was added in upboard_pinctrl_dbg_show() to handl=
e
> the case upboard_pinctrl_pin_get_mode() returns an error.
>
> Best Regards,
>
> Thomas
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Looks good to me, some testbot was complaining about something
but certainly we can merge the majority?

Bartosz when you feel confidence in the patch set, will you queue an
immutable branch and I will pull it into pinctrl as well.

Yours,
Linus Walleij
