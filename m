Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059C38D00E
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260124; cv=pass; b=UE9JQUpkzPBOwfG0qnCKTSjM/z2Lm79alQp9Y35MKU52qHDVQA9J0CvE0XB3meRO84NGWkDMFdthAIH7loQpY6CXRBYtwUKitlOyUDxLG3u/UdyqmXSySo66FPrEfviKdX35evFekfIxjWj520l5Jr7mhbH57+5DApo0ve9N8+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260124; c=relaxed/simple;
	bh=qCUYBGAUOheU0nTCcMZyCl5y4dtCdasyHwmyMVbOBCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6VCVD+SBKp3w3B0MYHeKuk3qzQYC/pP403690IkRO/h61XQCXQ245F+PXtx+BnmxIg1l3X2jHDqT14CuoeTiNRnSZXz9R0HYmfMjbCgVoDBPIQzJUJ9TvYbFisbbGQKqIG2H3zbjbLKDhMTSIW4mouS1yPFB1XsuPujFThYE9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWe/prAY; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWe/prAY"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so28275266b.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 13:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773260121; cv=none;
        d=google.com; s=arc-20240605;
        b=eg0U5VGT3OY5eV21c7uEUZ58PKytlR2cWLktPkrHxALaJoaD7ZfcaPVmyiaH+n1TRk
         zoqTn4uNXp0O5bsqP3Aqdy7BkKaTBpcqngeMxG1CpRG50vsiuJ3J+e/Rz+5shuplo3wu
         eoD2pOOqFA1S2BJocMmgQjEpaDqt7IoJywa7c6KTLNfpd0JNc5bH/6oSJXeWKMTmH40g
         jJcQ32/zIKSs7zJk66E+sAcjMPp+fBa1XucjIxv2ktsMLAhxigIUMaJKpa2JYGJiyKJq
         2m9HytOHn9Z2OwGi6o6lP4YXTIACXLAeY+IFkBx2fxvuS3HPVOJQvATe9+O5PEwyjL3/
         VswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i6F+UW8vpaPOSbe+aow4A6qQsDdfkrJCugB1bxi2H3M=;
        fh=lsTq7qxrLiAwMdxmy1clSV4SGTOpZz3A/TXcbUSSN/c=;
        b=anYQWHZrvBHDfRSb5mb3G06KcPUlEZXEH8d8vwT2hhDS+Ra+DJKn/g3SFQnCuvH6cz
         ZuaHHYvXsjrshsRuxEWeLYgd2Nyi9cmlddgpuHN8jPpRQE8HN8ln9+XSeeJ2RMFmKiT2
         MlflWxGDn77ZpM5fSpS332rrIPS80EkTYQxJ3Y1fU3lTQsytVy6rds+UWcBfMk5Vylqn
         SpObvCBBI9/0MSprqTXuXTkezc6LPSI0qQpVHMyx2vsb8zCVGx/GI2hs/BxEpG+YT4Oc
         ZeDx0JEFXOG/Odlyi/RL2qo99kYA0f+171HkhR75EwUYHz11Ih91c7ZnBD9fnBrGG9Z9
         aKWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773260121; x=1773864921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6F+UW8vpaPOSbe+aow4A6qQsDdfkrJCugB1bxi2H3M=;
        b=nWe/prAYzvBDiutVXiO6S+1K2vIf87NlcJjxfML+QuWQ2JitCchpJ0EET506sfrXvv
         yTqYq99l9QF3PfHVikdeebx8GwUPquPD9q449ZlwFS+Gmq4WtrvtfFwT3NRZxQL5R5Vd
         LmxYUDee4Gq/dzzYlZixAwza8lw7PWwWTa0XW8fQ13XWdwmB4OjH3rBvrsIz0DPh8/Vt
         opkVQQY1LGDxOUs5vestd7+UHQ24SjLdOTWKX1ix7I+rEA+8wEqUpk2vVsZ4FZCgoY7R
         k1FrYcNQAn/VR0SG2J+xoY64k5Hkt2owRDbGWJ29GCC34FAy65MIdVnhQhXTBbMWjhCg
         QFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773260121; x=1773864921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6F+UW8vpaPOSbe+aow4A6qQsDdfkrJCugB1bxi2H3M=;
        b=UHBmfFqPY0zJGmnxOjb8lA1KkpD3XyRmwbv9tnHrijThsXwHE0g2erK52N1E59nZ3C
         2VpRfGdSDeM9BqYmSRvMfTH/7Wz+c4AYzunfB7Q/2h2s26ZrJ8czD6OaNJrvIGK3cqKW
         3p4ySva2LSpkz2r8SrHTAJFffv1yhtIavLAYwub7Az65T8Lk5K5DljJeBM1D1cZ9+myH
         wpeoxr/iSi3dvDWv2EcpEO6+wYXDtjpXGIS64Z62xRrKuEWsPKX04HcVd09jisnYoXkS
         oIc8SNtUsBCCjLPvpdY1gwtQZ5E1cKMjFPZ8zTrFGoOmzqOawEDsJA6+6i7IzNLtjgB1
         glgg==
X-Forwarded-Encrypted: i=1; AJvYcCW8jWAI0mH0CFgS8NF1/0p+o185RPHxAHE1pk1ANJZQ62/C47QpZgxStp/TDdlxSBu51H2F4L1TQrot2SCf6bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+er7CLvZgCI0725h/ReB83gDSaiYffGovjIrN2WfZ2BiIWA6
	jTaUPuSQ3KteVINtTf6W/FHzQjwNCIkbSourdqEH7QgD1U0IQtgewx2C7RO8XjafJfvQ8vtwPNl
	d64rL1h2C8WtxqHG6PD74qW2FQOR1SXo=
X-Gm-Gg: ATEYQzwgGvtBNcm8nN7aWLnC3JhgmdWtBb/0Na+fgU41E7cOJkrKGcbOIHwv9tP/DyB
	3mQLBYXhKFsA2P+LYwT9R/U4hCTq/YPI+Kn2be9vPEXU355cvDRULK3zbfzWn+ndNuDV3JdeeJA
	sADDh2ILCokhJpt+FTjpqoeOJOy/4RHyc5LzDcg0vc9uPWnzx4lScYs59sZ/gs449nvvh1TKtcf
	mNm2SDHboqNU2T+TBQZ2JZbUAMTORW8v5ZncKS5B+c+wKQgP8T3BzxINjhy+z/ogTXObMUoWxEw
	ijdcL+V2LlwxxjRmHXxkqgknWYtfJ3++pJdAA9JANcd3mSpDJDVWykkuT4ITRjjq3wcXB+vLehD
	HT4LuYWHWbDBJGw2n7g==
X-Received: by 2002:a17:907:fd17:b0:b94:1df4:3525 with SMTP id
 a640c23a62f3a-b972e20f6c9mr213172366b.1.1773260120699; Wed, 11 Mar 2026
 13:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
 <20251112-gpio-shared-v4-3-b51f97b1abd8@linaro.org> <921ba8ce-b18e-4a99-966d-c763d22081e2@nvidia.com>
In-Reply-To: <921ba8ce-b18e-4a99-966d-c763d22081e2@nvidia.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Mar 2026 22:14:43 +0200
X-Gm-Features: AaiRm50gZlAiM-5_F_zUlx0D2HjCtugUtf3WuAOsTMIp9Wv8sMtNxrZngwvWk-o
Message-ID: <CAHp75VevThmDMm6VoVB9P0YbUGGGsmgnzr2gn9=1xtJZt-kuQw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] gpiolib: implement low-level, shared GPIO support
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
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

On Wed, Mar 11, 2026 at 8:38=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
> On 12/11/2025 13:55, Bartosz Golaszewski wrote:

...

> On Tegra234, the main gpio controller has a total of 164 GPIOs (see
> the tegra234_main_ports in drivers/gpio/gpio-tegra186.c). The GPIOs
> are assigned a index by the kernel from 0-163, but these GPIOs are
> not contiguous with respect to the device-tree specifier.

If I may ask...

Why? Is it sparse because there are pads that can't be used as GPIOs?

> For example, in device-tree, if I have a shared-gpio with the
> following specifier ...
>
>   gpios =3D <&gpio TEGRA234_MAIN_GPIO(AF, 1) GPIO_ACTIVE_LOW>;
>
> The macro TEGRA234_MAIN_GPIO(AF, 1) evaluates to (23 * 8) + 1 =3D 185.

To me it sounds like a bad design of the driver for this SoC/platform.

> This is greater than 164 and this is causing the above crash because
> 'entry->offset' in gpio_device_setup_shared() is greater than
> 'gdev->ngpio' and this causes us to access invalid memory.
>
> This is what I have been able to determine so far and wanted to get
> your inputs.


--=20
With Best Regards,
Andy Shevchenko
