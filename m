Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7C2F0C71
	for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139959; cv=none; b=B2pmg9JPxwiFcqNBXP0Q4hlxT1iyJVC7skbcss98qHzWjE4A5RsGeQRosG+fWug3GfM7gErdzR9Mz4YsYRJ6tVaCdSi28MXVJZFDdX3tKUdlA5cKivuf5KU1Tt5qgAReI9mdtJ0dtY3wgOshk5LLIHPHv8TT5s+b7Qp3PtDs6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139959; c=relaxed/simple;
	bh=2KUdznDw5vZ05JufQlJyZkuSTNllnaQhlyyX0vFY+xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAVEWiodMe5Gayza8fNybFxJ808tEA/R15CdQSTP8EHFeELoyxppYA0Oz8bZA/vDe8x19nCkURiRAyxT+sxh51Cg5mAUYSoDzE6gcwJAj80o8l/UgnHs6YmGYFgkMKjiSht0C8KboPB4uZ/zAG69hv9exvJl074rPXf43UpLBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmVmRk8M; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmVmRk8M"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-633b45fad1aso3026319d50.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Sep 2025 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759139957; x=1759744757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2KUdznDw5vZ05JufQlJyZkuSTNllnaQhlyyX0vFY+xA=;
        b=HmVmRk8M2S2In+vPAyFQuEH0KPEsA7gftYVcwmCL6u0TexkZrTr6w4XB6SSOt6CrFk
         jzK15dZ/vSDaNZGI6OxWA0jeWiUrDWm2sme03NLcAunOfQSalUKBkCjOfOeVScM0B7Mb
         ilwAqFcyFziN3kDdAw/LsXRttOxXRem8wXSYA1EHX36ZG7jEgrEckroWfMzpmQNdxSVI
         5UPUzSXuReAUGDJwtTof+Vdng7+7eXac5jNPvb36ihG1qJowi6wcHzCDPHcvikORsNCf
         p2C8sNh5YF7wwhW587+/wrWaOG/sSE1p/+daSIsLuXlBkyZ+GA+e9OsbPqcfvQGvwVxv
         y6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759139957; x=1759744757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KUdznDw5vZ05JufQlJyZkuSTNllnaQhlyyX0vFY+xA=;
        b=lQedhzPSg4yBhYrpbkXsVXM26LzNrwpcZECk4MzeVDI71xn0F2Z2mLX5qzeps5wS8S
         ria0C8uWyHqF6UgQ0WRIXPNwHgo4pT6oqxIWL/iKOMWnz5fGAIYc21jM5J2hjPSqdWgM
         zq56w3Zcnejz9CzwC4TkzW3KLZs+jsEJhoYosljYye+wnuuN1IiWrw5kZnVjPb+OuQjw
         5/nWobRq/Wyuu0i8zjsc2h1322rLq1UEDn4HMKKgWWvnrGEl0tXep9isljT0huLM1C+4
         l5bhdDZoFs8XySPb9K7jl8OvBz4EgzcSxzthuP0Pe1YjsaHx/JXJQXfAc0Sudwviyhan
         FLhA==
X-Forwarded-Encrypted: i=1; AJvYcCViBNzNXbbJERFNmRIzwfytyMaN532N9SM4eGVRT9+ZwwBdAewUGC5t0wkqX/vRstJert8ewAly5/sEnQk0jxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+WQ+rL+hcif9uA0LGQEOW72+PAjg1cl0tOW6KbhQIP0CxRve
	mXMjb5zUqeAFZIYvlEJBpTJJ6k+dI1t+sFu3g6rhuCyqXIn5a03dRrUMdoBHhp2wuLI+jRr+Hlx
	OOzq6E2V8bE8iaBD5ll+yH919rDXRMvsPyquSHVvfsg==
X-Gm-Gg: ASbGncuGIzBv7pS1oHR59xRt8+hBnOI/oURgRaDqYWvJGrLKUfywxL/OiH23+f7IeFL
	xLweY1mY+vb0k/VmCGV95GXJCFBfoKNYXZOLap+JgU3QqueorUSuDBFUKjneDEExhJgiyXDPVT3
	L4n/KRbnnSEDAQQJmRESeB4xi1ccLi2hoCR0nyvq3BsCmdcNHOQZBmsOTe2O1qAJxmk+n5b1lyq
	2fux0Bx
X-Google-Smtp-Source: AGHT+IHKB6dZwmkkiRTmQMJ6qqV5u+Z5RUcKikaK+UuufgwTUJ8RoCQyTBvf2kQBGXi0WQ0jZXHoQTtqUIZWVWUBjSA=
X-Received: by 2002:a05:690e:1a4f:b0:636:f1d:e26 with SMTP id
 956f58d0204a3-6361a8734e7mr18613222d50.32.1759139956833; Mon, 29 Sep 2025
 02:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
 <20250923-mt8196-gpufreq-v4-8-6cd63ade73d6@collabora.com> <CAPDyKFpLNJRRxWPm2Eye+Fs8go-LNwWGzPUPPKmNVJkyK5N3Dw@mail.gmail.com>
 <2015216.PYKUYFuaPT@workhorse>
In-Reply-To: <2015216.PYKUYFuaPT@workhorse>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Sep 2025 11:58:40 +0200
X-Gm-Features: AS18NWDi6KooeuuBdFZYN2-L6gygoxiX5visVgVu6hIAQ09WtQulOO0qEvr47Zc
Message-ID: <CAPDyKFoCPkNsbq8s3d6cQXxfFhiYH1kjrocNdq8=v+g+LY8c6A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] pmdomain: mediatek: Add support for MFlexGraphics
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

>
> I actually have a question about a mystery that has been puzzling
> me as I work on v5: when unloading the driver that uses the PD
> (panthor) and my driver using `modprobe -r panthor mtk_mfg_pmdomain`,
> I see that sometimes detach_dev is called with the pd status
> reportedly being off, but according to my own power-on/power-off
> counting I hacked in, it actually being on. It then proceeds to

Yes, ->detach_dev() may be called for a device, when its corresponding
PM domain is both on or off.

> call my remove, which results in three splats from the regulator
> subsystem as the regulators weren't balanced with disables before
> they were freed, which isn't the main problem but more a symptom
> of the bigger problem that power_off and power_on calls don't
> appear to be balanced by the pmdomain subsystem when a driver is
> removed under certain circumstances.

If the callbacks aren't called in a properly balanced manner that
would be a bug in genpd. Certainly.

>
> Did I run into a core pmdomain bug here, or do I have to balance
> the power_on/off myself somehow in detach_dev? If the latter, I'm
> struggling to figure out how I can determine that the PD is still
> on without doing my own bookkeeping, as pmdomain core seems to clear
> these fields before my detach_dev gets to them :(

When genpd_dev_pm_detach() is called, the device is being detached
from its genpd and part of that procedure means calling the
->detach_dev() callback.

When the device has been detached, we may have the PM domain being
powered-on for no good reason. That's why we also punt a work to check
if we can turn it off (see the call to genpd_queue_power_off_work()).

Kind regards
Uffe
