Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B23451C9
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834921; cv=none; b=ay6KJbj1G9imEUHdTmK9t49+UVNDXPBPGPQeXwuMcDb6eGtNBxNpuIgVPLXwwEfb8GhAgTfV2t9TLNCxiDKSPnJBC8WKJicestolsjR8kvpKX6m9s2KRqsxjzyOO0QtBDnLICYSOZkrTOfmqt8JJ3w/aJm2w+Ck/1zi6VZR3a8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834921; c=relaxed/simple;
	bh=HY/P1wmmQ5CXIAhE0M3q1QG3EUDBLGeGAVW5/TOHSa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWz0qFDReJk4O6kvHn2VlwkaqVYV0eImEPGOMlo1FRVQp+evFbUM1WEfnoj8fzQ19NzL43C6b9A9/8IlXrMDiYXszt5Ci3xJKvog4IeIGpeiWhshhirGWUODv8iFPkf02MHaujJ47UXo2bitJ9JH2tT/NsgiMeSpo4yqlCufzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=052kC5kU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="052kC5kU"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso4036827e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756834918; x=1757439718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY/P1wmmQ5CXIAhE0M3q1QG3EUDBLGeGAVW5/TOHSa0=;
        b=052kC5kUrN2lLVVfPRcbxYKEvakX+9A7x5MhmKE0Sz4C2+uxx/jOoim6DZIaHQKMPa
         GDhtrl9dcFVs2lFsgyiQjtkd4kWLa+6WSAuYDQsio8916UO4NufV8PSWtwEJ51+Hdnbj
         3JhkLhMfCXXgxHB4oInFKhJrj++PmB4AV+7DG4z5K1gPaMP8fY80gfK9nfh9cXGU+AVt
         KKEEkuMiGE9OJpwCucHwtfwNRXTKx+ajjAoS8K2zzgar0WltDFY2AwoTvVg+9UFNzy7w
         HawcpobEx2ZR9nvorl9w92hMY5uxtwzxDeb+Omby/7oUXO5VS5pnht7wpxzaJFTDjeVG
         vT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834918; x=1757439718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY/P1wmmQ5CXIAhE0M3q1QG3EUDBLGeGAVW5/TOHSa0=;
        b=AY8BWCBNDcCaOYOXxdB3SShgYBkfN1slsUvQ7OeB8ZlpfETP/4rj0z5dUL6T9+f0xT
         78VRPf+uXJvChJfyIbvsZqw1byhTkYzmH6LY0naVbEZbMWhWIcAu00BRAwYctfQXgnB1
         RuOBD6/aUNRRjMwbMaYQAcA/tyfGWPwWpGD/QUtRikSppkkxNEGpuVhjp3It43dMG7y7
         CBxh9ZH3QJMA+gVUgqw2zZtgia75cHVjkuMISobyYx+5dTNNY1WTAS9dWBxqg3h3JaKr
         yXVlXnVYCbej+2IWCA3IEhb8AE9QMdD/PBJeBeECppZqjvsf7o1aUgorP99U4VWN7+m6
         5Qzg==
X-Forwarded-Encrypted: i=1; AJvYcCWqnbxoDCsT3gKW9vzdBZs3CHzsu1+5kw/uo8G0ATqmW5cwwYv2YlcVbdi5kG3MGjUKEqD9HhTLXD7iKyrQkpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmlW9HE9LqdkZTmBUDxJlIDqB3g4KP8WZN1PPR4kxATJqXHYA
	j2I1hEqq2Gvaw3ltCyzDDis4XUe3zkZjzLmUh/Vfsm9laXoL1jgF5voYfI3J+T7C2qgTeEcUSQD
	e5E+/bZMHtsYkfJf5bYUbojdLn8Pv7xwOE+JtLtxKwA==
X-Gm-Gg: ASbGncsC2nwGTKx4aaIHi9YpdIxCZSGKWhSucT8PjNXiJSwr4f27u67adeOz8Tbuxwt
	sK9AT8a/ES3obK+hGuTKHYSVnQs+PuUJtsNAnhvF7zGscjG37CHBQnL26KK6xhQBs/o9dMsfn9u
	61VWii13lBOQrrdNElN/91Z0sYaqkFlKLYK5/UFfXp11oLpdOWZM2lN5R7XJavCAhvTalV9c2Ni
	HNN9ipqwR9GzWkGOP9rh6YRivTvHrVHFX/kENK0YYtKdNtw1g==
X-Google-Smtp-Source: AGHT+IEj8d7P3cFn9WHSMlcQJco2rutroHWRWEZV/BsdBzW10JlelDxpX/d5bcqoiRzS4+dxD5+bg22V2Ltijnn3kOg=
X-Received: by 2002:a05:6512:61d5:20b0:55f:727d:408c with SMTP id
 2adb3069b0e04-55f727d46c3mr3142298e87.50.1756834918139; Tue, 02 Sep 2025
 10:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
 <20250902-pinctrl-gpio-pinfuncs-v7-16-bb091daedc52@linaro.org> <aLcBcjvMbrxoDYoC@smile.fi.intel.com>
In-Reply-To: <aLcBcjvMbrxoDYoC@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Sep 2025 19:41:47 +0200
X-Gm-Features: Ac12FXz-Ict8QGMZawDnah9byaE6SYSj17yQF92en6o4smsRWpZmv8sya_ULoRc
Message-ID: <CAMRc=MfcFMgkNqWNZV5o0NxkAvxBTjC3vv56Cr98n0R2CkxuPw@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] pinctrl: qcom: make the pinmuxing strict
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 02, 2025 at 01:59:25PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The strict flag in struct pinmux_ops disallows the usage of the same pi=
n
> > as a GPIO and for another function. Without it, a rouge user-space
> > process with enough privileges (or even a buggy driver) can request a
> > used pin as GPIO and drive it, potentially confusing devices or even
> > crashing the system. Set it globally for all pinctrl-msm users.
>
> How does this keep (or allow) I=E6=B6=8E generic recovery mechanism to wo=
rk?
>

What even is the "generic recovery mechanism"? That's the first time
I'm hearing this name.

Bartosz
