Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3733469C
	for <linux-hardening@vger.kernel.org>; Wed, 26 Nov 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172822; cv=none; b=bNZKE8fJj8Z+HUJAmoZgNdCmY/G83L4msoG74PCFVeEXvP+FW+L0Lop/SOrGbud9GpBnql3K8imSg8m355ChjrFHlJUkPmfWXlJLyehuvGpFiPEu9cLM9SEW9b7s8AyZMrnArVIktK9aZ5bQr7JnM1BZJre3aJJqyD0ZkqhdBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172822; c=relaxed/simple;
	bh=9E4LZUqF4+RrmDwPg5Nf1aBB5ZvzocoQZTyPs+XXDOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6JlPTsi7LMaIzdiHRhtnXhuC62ToEmmS50BBTjCTtq6TWBn8zJ56Xb7ATCuTjEydBHbIAfqi3RAFNQS6aNVIh+iBmKPx9woUA+51ZU2Dh2bjLCUOjJnr1wmmDm3ulBS6NED7dVqWBkmrL52Gf9lCoJATHNtmlH5iKcuXVkVTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sX53AFUk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sX53AFUk"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so996262e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Nov 2025 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764172819; x=1764777619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKUmPojsBEaS1Fv5ikaphx/1DJX8hiMLHRzmJuvC1HY=;
        b=sX53AFUkPrebVr+JYqcYgOg9/tVZBJBdETXhbH8Qj7qZk2sNOlZ7GLA8Z2cJapL8yC
         WYTRzwAMStrt7FrW5Duq5Yd+lMmQ4t5LEp2QIF4Z4pu2P8f8aSIqjo5XJSGdNoWrXPT1
         +v9lfCK18ej2k53NTVO/YW+xr+KaRt01ifAGAGt5bGc9+S8/s//vsJOT8Jyv8ZIIVqZ4
         KmSNrHCLqM+DQEV3wtRCXx5uVIFd7EHnjUA8u4CnbgMehxX7g/E9tyzegkFQuBlGrQ97
         lYjpS/zubBOthFvs0NzPr0nmzJEGDFQVt15vBDgtqkG8cw7Ze7/TpwaO5+OoU3naNERz
         zT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172819; x=1764777619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CKUmPojsBEaS1Fv5ikaphx/1DJX8hiMLHRzmJuvC1HY=;
        b=F/ngyLAnoAdt3FdDXAVs/mYydkC3fJP+KDv0hpqPcT58znf2sGpGDUtau7GY3sYiZv
         kTQq/QhlZHxaa3ZqA42HAeOheVKNCyTZx0TQ8ZtThHGmvIJ6hwxyrBYhYne8gcXLbpDB
         6fw76dwkfcyKIJRmgftxSHBopkrP8uoTDP/Q4AAqqVbi7vnHV3/Ka3ALsGBZONnF0iju
         LZ25PoidT0qVCl3UCitWGpN89EcDObwt5UJmNfkQ8T6S187w1NyrS6PiP3vbo0mCk2u8
         eE11WZgTGBLIpiv70MpJdIwI1/uY9I5rMmoVgUdtIWva7mpT1icFsI9JCi7BfYwcVPAJ
         dW0A==
X-Forwarded-Encrypted: i=1; AJvYcCWxQJIeFfFxHtG85/C8D+rokRMfFgRG2SNCTD29ntftxEcNYTJfJT0ckuV/WM7ewf5ixUlQpD2UE1UZI9ENr8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYLWMUC+ADtNvfbQl/OmJylM0o/qipthvt+lxkNqL0J184ueB
	EqN0HVAr9E7ekpmRu55fH2Z+z3/jldwP5ISZ5x9JEi5+0bQS7w6CQzAGFN7flfOp63F/ruabMt/
	H0eFI/DozwZjrbmr8NMHrBGO9KiAYeyt8W/L1JJgaog==
X-Gm-Gg: ASbGncvzpjeJaCpeL0wo0aJ/XaVyOELXnAhnETmbvlvTjubPnwuKjdQFrvG02Vin1x5
	iQ0Lr4sPClIVKQXLl/C1nAxw3/bk3D66GSRmcLegI1GnqLqcx5aRqMElP8SCkfmQJuxCsGyb1Fu
	HRhHjOOijtDKpC3qvXrTOk7YJUEz3WWVQORlYIyFD70LwKrZl8KHed34A8QQ5Rkk1SsJTgWK99t
	wZlqRXLl2/AONDFwENa48bLHOH6UVX6QKKQe3wQMoy0LbF0hTq7bKggHJg1sOq6qoUbdvSVSzgJ
	fWRAG1ShYdLj82Noh4GadR+h/og=
X-Google-Smtp-Source: AGHT+IG/dq5r5WmQcoWn78HBF8tifFKLQkNqXoHsJ8uu05KTdYoqo/JzkNcCqS3q8x6xdOxAcwscTDG+CXZmPir3agk=
X-Received: by 2002:a05:6512:33cc:b0:595:9929:c8a4 with SMTP id
 2adb3069b0e04-5969ea35615mr7886071e87.22.1764172818843; Wed, 26 Nov 2025
 08:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <20251112-gpio-shared-v4-7-b51f97b1abd8@linaro.org> <0829a21c-f97d-41b6-90bc-2acaec42caab@nvidia.com>
 <CAMRc=MdPvF+okfnRuwvAFG9UfyZ-araDsaaKMxKASEbc3rhyjQ@mail.gmail.com>
 <705186a9-a9db-46f0-bf2b-b499def050dd@nvidia.com> <CAMRc=MdQ8QgbdAd2sudZLgcDZu9DxBRJh5sfLeXwcTDEE0F7Uw@mail.gmail.com>
 <c4081961-0875-4a2d-ac84-40df128534e7@nvidia.com> <CAMRc=McSrKgL=q8xfH_Vndg7rCfy1TVgRh+dFRqFCiBwT_J2yw@mail.gmail.com>
 <b166f160-e4e2-43a2-866a-3341cc91a13e@nvidia.com>
In-Reply-To: <b166f160-e4e2-43a2-866a-3341cc91a13e@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Nov 2025 17:00:05 +0100
X-Gm-Features: AWmQ_blfhwNoOC_5q4Y6Ua8mUZE4gIa1ItGMpnk3IeLNBCFsJ0ovvbGWZGIVjOo
Message-ID: <CAMRc=MfWi=cU1tK_AXW18A0X7K2TGp_u9Dwg4uSfW7Te83HvqQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:47=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
>
> On 26/11/2025 15:33, Bartosz Golaszewski wrote:
> > On Wed, Nov 26, 2025 at 4:29=E2=80=AFPM Jon Hunter <jonathanh@nvidia.co=
m> wrote:
> >>
> >>>>
> >>>
> >>> Is the device-tree used here upstream? Can you enable DEBUG_GPIO in
> >>> Kconfig and post the entire kernel log on pastebin?
> >>
> >> The kernel log is here: https://pastebin.com/7rBh3T3T
> >
> > This is not telling me much, can you try again with the printk() I
> > posted earlier, please?
>
> Yes, sorry I missed that before kicking off the last test. With
> this print I see ...
>
> [    0.120432] gpio_shared_of_traverse: /bus@0/ethernet@2490000 phy-reset=
-gpios
> [    0.121407] gpio_shared_of_traverse: /bus@0/mmc@3400000 cd-gpios
> [    0.121891] gpio_shared_of_traverse: /bus@0/host1x@13e00000/sor@15b800=
00 nvidia,hpd-gpio
> [    0.122035] gpio_shared_of_traverse: /bus@0/pcie-ep@141a0000 reset-gpi=
os
> [    0.122075] gpio_shared_of_traverse: /bus@0/pcie-ep@141a0000 nvidia,re=
fclk-select-gpios
> [    0.122342] gpio_shared_of_traverse: /regulator-vdd-hdmi gpio
> [    0.122381] gpio_shared_of_traverse: /regulator-vdd-3v3-pcie gpio
> [    0.122420] gpio_shared_of_traverse: /regulator-vdd-12v-pcie gpio
> [    0.122453] gpio_shared_of_traverse: /regulator-vdd-5v0-sata gpio
> [    0.122486] gpio_shared_of_traverse: /gpio-keys/key-force-recovery gpi=
os
> [    0.122551] gpio_shared_of_traverse: /gpio-keys/key-power gpios
> [    0.122615] gpio_shared_of_traverse: /__symbols__ gpio

So I have no idea why the special __symbols__ node has a "gpio"
property but as this is a special case, I think we should just
explicitly ignore it.

Let me send a patch.

Bart

> [    0.122672] OF: /__symbols__: could not find phandle 794981747
> [    0.122701] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc=
7-next-20251126-00002-g1cd98992c487-dirty #21 PREEMPT
> [    0.122739] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
> [    0.122747] Call trace:
> [    0.122753]  show_stack+0x18/0x24 (C)
> [    0.122772]  dump_stack_lvl+0x74/0x8c
> [    0.122788]  dump_stack+0x18/0x24
> [    0.122801]  of_phandle_iterator_next+0x18c/0x1c4
> [    0.122819]  of_count_phandle_with_args+0xa0/0xc8
> [    0.122832]  gpio_shared_of_traverse+0xd4/0x4c8
> [    0.122848]  gpio_shared_of_traverse+0x178/0x4c8
> [    0.122860]  gpio_shared_init+0x11c/0x1f8
> [    0.122878]  do_one_initcall+0x7c/0x1c0
> [    0.122892]  kernel_init_freeable+0x204/0x2e0
> [    0.122908]  kernel_init+0x20/0x1d8
> [    0.122923]  ret_from_fork+0x10/0x20
> [    0.123055] gpiolib_shared: Finished scanning firmware nodes for share=
d GPIOs
>
