Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F57D2F6936
	for <linux-hardening@vger.kernel.org>; Mon, 20 Oct 2025 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953331; cv=none; b=AnALmHlwqAkFg4pUHYT4vjai7b2wdnLrh57847C2ALt5utvYJfPfSeZPp4YxjUS+ka+56ktT/oIoforN4mgDBdxG5UGqwgmnxvLXGsyFwXUPw393PsxH+DkfNzhvQNZEIZMBt9zLd0wGflGuC50XXrF4/FCtwWBcjTQ6/0/6xUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953331; c=relaxed/simple;
	bh=sjEUaWPd/Jj2ElIhymJE8eOmk6i+S46mwSJsA8AQ+EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIDwcWjhbX1uzgPcmB6FZi7MJ87M9AI1/N7yCgVLHwmTPaGvTQ/otkxpjJv/W4dm3zKvj/WqOy2uSCkrevPamheozShfxeNtk7u27KLslXHaUXOgxy/RWoZNW1IEzME9MGZy5HtqAqX5tM7umL0QOlvwq+Jj3p9lTBR+aRgCvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IcO943AZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IcO943AZ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57e36125e8aso4074251e87.2
        for <linux-hardening@vger.kernel.org>; Mon, 20 Oct 2025 02:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760953326; x=1761558126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjEUaWPd/Jj2ElIhymJE8eOmk6i+S46mwSJsA8AQ+EQ=;
        b=IcO943AZ4slbeY23j1wnDAiVcwPBPLOz6p7nwR3LnKZ0EWyuxZ1NV7vh4gmJ/DIdyO
         6NBnVnJLgA6olIiUyrFMdxASrH1QtEFiA7r/E1llGQVLoET/fsgSRnAyAnwR8NcWStjO
         FuT2KFRZGMEzwuOaEhqAI6OZQRNQgcs9YKKrdrTKxlFK2oJm2XQIc6nDLunQhkol1mbb
         d70GOBwY51A3Hb51gRUwQxAzlPvGos30Z0gp/Sy15aqIdUTTrOReoH1dy+wfcjOsfgCW
         7aj159DIeTlPLFh0St4Zk1tpfonVqFPLXNmWZp8b1j/WnRZHVRVzd4hwU/lmZADNgoht
         oLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953326; x=1761558126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjEUaWPd/Jj2ElIhymJE8eOmk6i+S46mwSJsA8AQ+EQ=;
        b=W/SW2D70FgMM6LEmMAjHzM6pcKyP/Dgniar+ekPBNA+xXhiKH/wvMuSCbZZjPB9CKx
         GBpYux5fzh3q7AsThBe8bpzREqnH8kV/3jPaqsgUY9WEhP9ljqbj3ApKI7qdHUBTOLH9
         FjQrim3gm9LvyeoGRsAnRDQkQz3iU+oy22TSVGCKrrtGmO4W7tOJpLd3to5NIDzkH0v8
         h1ZhiA2rN8jAjLy9uLukOynJAXKqLYBQIp/BmOlHvdGlS9mpn1/b1GKlXb1H+IKWf41l
         OnTol6mN/i3UYa0YSPZ3ZGvwrev17pn0IC8FsQQ+YZZA8Ps9v+OyiuPg9Z2ZGvrGROY2
         cz+Q==
X-Gm-Message-State: AOJu0YxXCv5coj6G8RBgG7LwwYncUTQ4ngrZfin+tWCvFUUDABkWTF/o
	dKUwNHBel3RbQ/a3dwBYdQXdKLd333SrcJ4JTj/Emoiw3D5U+UceNhA2NwwVumoYv/q+94m56Of
	rd+Yxj8WsP4DATRWFVWNKZVbcPnKN4KsbviktLRJgqQ==
X-Gm-Gg: ASbGncvY2IK+5eksm2VUflgoddUAkDhN4syb2FTktaPAojMVECFuQOC7ClHHYL/uUDS
	2xNPa81AU2l7TqVKMMzcoOjWqyjrknXLSE42Tnr8NN5gFJhIQ7GAc0OXna9R6+tCG+LlZ+bH66Z
	/jVl6UXuMr6MxcNitICMAnD5GG3+6UTrL/XkXzR6OMmEUnis2UCuB3+IccvuA/kwJK7WPsil8Ee
	T7VEatzk3hr8qn1KC7zvURULIxegFG/jPe79HsQ2qmRn1oOVjozwx7PRwbpmmj451/a1pLIFY8k
	3HTYmv+5pstwbEQS
X-Google-Smtp-Source: AGHT+IHY1EdCIXYngUyFFwGvzEW0znpDl77em9pEnOCmJRoroDyoIZB7DiA520ogK1u8lsISe3niq2HVycioLER4ci8=
X-Received: by 2002:a05:6512:1052:b0:578:ed03:7b70 with SMTP id
 2adb3069b0e04-591d8589aedmr3757333e87.28.1760953326040; Mon, 20 Oct 2025
 02:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
 <CAMRc=Me4Fh5pDOF8Z2XY4MG_DYqPRN+UJh_BzKvmULL96wciYw@mail.gmail.com> <81bda56c-f18b-4bd9-abf9-9da7c2251f42@sirena.org.uk>
In-Reply-To: <81bda56c-f18b-4bd9-abf9-9da7c2251f42@sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 20 Oct 2025 11:41:52 +0200
X-Gm-Features: AS18NWCTv8z2cF08OaIclAyR6BuSf6xIu18qyroHsfySyW-sq8vo6xUHsWKQB4s
Message-ID: <CAMRc=MdOCHJEyPxN+-g71ux68=Mt_Q5P9611QO7Q8J9e8UJv_A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, 
	Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Catalin Marinas <catalin.marinas@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:32=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Oct 17, 2025 at 07:26:51PM +0200, Bartosz Golaszewski wrote:
>
> > Upon a closer inspection it turns out that this is not the case - the
> > ENABLE/DISABLE events are emitted when the *logical* regulator is
> > enabled/disabled even if this does not involve a change in the state
> > of the shared pin.
>
> It really should be the actual physical state change that triggers the
> event.

I guess so, but this would require some non-trivial rework of the
regulator core. We'd need some list of deferred notifications stored
in memory for when the physical state actually changes.

Bartosz
