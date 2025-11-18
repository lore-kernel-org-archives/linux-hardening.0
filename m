Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FD35BDCD
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476049; cv=none; b=hACTAcXo9zEgPHwLQMiiCwUXYA/Y9Z7hLVz/DOf8+bA1GKA1g7dcVcL0WQgIplhydDUip4Lsb0qFTZxgmFGmZkNsmINZcUJxDmTn+Kk8Uk4Ts4pmX/6Zm6eNNYuFcSIOXAKa9dWYNbYnqpj+fuGLy/XjDHAPMCK6/YYreHkfMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476049; c=relaxed/simple;
	bh=c0U3618Vo7lc2qFgsoEiXWsByZFvKNbdECSQiI33/JE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBG3zCfxwAnIB3Hh85oXp4gUmRXcofeSOf7WBo7ptPRSlDVgjXhbrDvGPb7+tPccNcCIqaotmivklCFj9uNdhzQr6zEvhvDm+YewTVYKvpw2IsxfZ2R58kShI66eUEO/yEkUKELwFZ2TCxig4jtlaMRqByCNr8UdlgQ7vBfRsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ivnqxogG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ivnqxogG"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37a875e3418so39656741fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 06:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763476046; x=1764080846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf2Cxv40+7yq8V71h6ANiFD+N1Zr8f5Q883U3V106Ak=;
        b=ivnqxogG2kUbMlCGpAvOQIqlDiSceg3l+eOwSgM0c602mu3MeTeCr0tZaPAcjA9P5d
         8GHywdC6yybQSJYXQqba9yRafiZJPTSSoxu78fW7PBelD782zc980PWdn7VrLSMqt3Ye
         QCETqTaEHFfvhs3q00nFFGdTfOY+u2yXQwwiJjJCDj21v9/wQpuTc1vBjfcSGS9bs5U7
         RBIBAu/02Pbg99TFqIEG2uEU/425lO67lUXC/++CpKiF7iMa3qgOa4r8litYKCaiaHuA
         VfC6v5X2WjdutAj3TlYtpleLldPSx/Xc/XYhThAy6D7j5hXHI1hiYIn8v8ONzmenlSkG
         JM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476046; x=1764080846;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf2Cxv40+7yq8V71h6ANiFD+N1Zr8f5Q883U3V106Ak=;
        b=mhNNAyiiC5g1SzbJsixEdhqHooUPrN/2JDrmaDndQ4PESSQoaON5kvwtQrSdvjMpON
         5UPUY59zpK2/4KCcwbNW/PltxawwHe/KefSuja5nbRNgtNxaKt0LreAemY8vQ0NzYbfI
         j0ISIJ2AUGPr9QJ5b3FHzxvIgUzj3/G9ZAmEdqbPsi8qJ9ojFz+wja3KXx2UvFGblYPx
         NvuiJNkWepdNUNXJecuAgCNzvCSs2BaUz+eMHU93ILOjVh5P+uSfu0QbiZeyZosq5xy8
         sxkPgh2U5jYd9JJOfzp9/cKDljxp7d9b2OYEDe39JmKwdvaApCRYIeiAo2qK/2jeLGkc
         FJBw==
X-Forwarded-Encrypted: i=1; AJvYcCXS3E69d3hwG/UtxGXROpVhKjfFI7vh8ikUeHVio6p1d+YP7zHlLTb1+6S+KGsjhY8oFmwL2LXIqUXkH0CBF7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/Wa3SMwGj8SfpGE3eOuKOp1HHhvREmHFooJUErifMaX0oOED
	CEB5VrJjPEt9AmDyyCsFPE3QQ3ANyEsy0lsUu1iXbYdHvhEUDjoHYtLODCd31UJSRb1WuecEUwq
	g+rN+3RjVMmj8I4CoYb6oRWtgsR7PkkRmQ4yYNPbFow==
X-Gm-Gg: ASbGncsxKOmFAFkPTIeb5Pi8tb0jOgqLW7T4e1uFyKwcHIAA0HY7Mm/LJFLjE9kZbm4
	H/Oe3mpZqyeKfyoWZhHzG1JGOq6a1ZxM5VLgxhV5pJnQPqyXDXwMjlr/4nT4xtI1JXSkKosIE8a
	XBjL97ar1UUjD4llEsmAwReUO8uiOYIizITd3JrwHWSlhwQTI2LXQd/elwUxSSjK/R9WzWSdsyV
	s/gKyBu5/btcV6+SHXhOEsa9oXaSJsSfZr7ip5l8xsioLLKBRLCdyrda7XJu6sOS48WWJpRahHN
	+UQpgtiHQR4LrE918q+Wf0qlHyN/PXd0QB3E
X-Google-Smtp-Source: AGHT+IGoA5UBOXsJ5cVSmQ6gsh1S9Dtt4hgxp5RrgYNaDgN6xDaSj9cgZ5HgZ64YpoGqqFZp56SXUGYxduiY1NHaHGU=
X-Received: by 2002:a2e:a00a:0:b0:37b:aaf7:f007 with SMTP id
 38308e7fff4ca-37babd6ddb6mr36053731fa.31.1763476045857; Tue, 18 Nov 2025
 06:27:25 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Nov 2025 06:27:23 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Nov 2025 06:27:23 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <ab0b2e6b-7d2a-43e6-b8e7-c97cb9763798@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <20251112-gpio-shared-v4-7-b51f97b1abd8@linaro.org> <dbe20642-9662-40af-a593-c1263baea73b@sirena.org.uk>
 <CAMRc=MesD5HchG_hfvN3H5ayu8gX_OvSsZQ4UO4f27gx1rRzSA@mail.gmail.com> <ab0b2e6b-7d2a-43e6-b8e7-c97cb9763798@sirena.org.uk>
Date: Tue, 18 Nov 2025 06:27:23 -0800
X-Gm-Features: AWmQ_bmvuv0kqhmAyv1afKHnQoK_7YeLlaSbUZcYwoK2sDVs4c1RAgiSNxeeuyE
Message-ID: <CAMRc=Mcafi6+kRX+9sVOLHCegdU33+omLg+aW4RqeiokymxPNQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Aishwarya.TCV@arm.com, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 15:20:47 +0100, Mark Brown <broonie@kernel.org> said:
> On Tue, Nov 18, 2025 at 03:13:49PM +0100, Bartosz Golaszewski wrote:
>
>> Thanks for the heads-up. I'll try to fix it ASAP to avoid a revert.
>
>> I can't open the link:
>
>> 500 Internal Server Error
>
>> FATAL: remaining connection slots are reserved for non-replication
>> superuser connections
>
>> Oops, something has gone wrong!
>
> Retry, it's AI scrapers so those 500 responses are just glitches.
>
>> Any chance you could get the offending line out of this stack trace?
>
>    https://builds.sirena.org.uk/187dac290bfd0741b9d7d5490af825c33fd9baa4/arm64/defconfig/vmlinux.xz
>
> /build/stage/linux/drivers/gpio/gpiolib-shared.c:87
>

Oh, of_root may be NULL...

Could you try the following change please?

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index c22eaf05eef23..4ce574a21850b 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -205,7 +205,10 @@ static int gpio_shared_of_traverse(struct
device_node *curr)

 static int gpio_shared_of_scan(void)
 {
-	return gpio_shared_of_traverse(of_root);
+	if (of_root)
+		return gpio_shared_of_traverse(of_root);
+
+	return 0;
 }
 #else
 static int gpio_shared_of_scan(void)

Bart
