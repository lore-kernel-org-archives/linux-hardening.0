Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADB20C48D
	for <linux-hardening@vger.kernel.org>; Wed, 25 Jun 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839988; cv=none; b=m+i0VYkx69ywl2+a0fawJ0gRjyDbDWgwxei00ZAiDJdri9PeAwxXpNOuQFIb3PcQcjlGQZq2d6sTOw/zLGk6KnWdpVZF+xqVpPbb0IZaSAhNgLb4m8wBDHewbwl0SnNhn1eK4ZthCrG0VqDp1kTUDiZmqMapNyjH14Q/yzOVjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839988; c=relaxed/simple;
	bh=HS4wAnVjCQeW1rVCh4eHK2uX9ZfsLA1faWghmR3VJxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIylIqa4jHKElNEF9559GqtK3XyD+D2PfcwoRhe3W7FbFxu+BS5AtRhUtXZOzDti41/lTZJ/waG4/556xbN1PeZnYaBlUy98TfhQ09EumWNRx4do+S+x6ULVXSbd6172QwrQyQpSp8c48KOkolkDOAel5bkvDdhpp37ogj3Zl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0BLatIBb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0BLatIBb"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553dceb345eso6887390e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Jun 2025 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750839985; x=1751444785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS4wAnVjCQeW1rVCh4eHK2uX9ZfsLA1faWghmR3VJxs=;
        b=0BLatIBbTusvOWQOSK2PRieumkTqt50JsgYQ2iR6BvfU+C8OIp3zErrUw7Dwzwzkpr
         +Kc5ucHXVpkO38Pfg158KUcESXu9+NKloZaLAmr49eyvV+Ux4t9CpD7QmbdQlM2c0bws
         Luytt4puuoQbSU7UNjmYPxBUD11LCXRUTiyHuyjAW7UT5nn8a/poqCm6qtCZoNMRzW1O
         hNTGT8iYxq67IYUyhjm9O8ejiT8lTsZoXQQ+Pb2j1NfpELfsv7mVhG88tG9GoGniAFDS
         RUJ+eqOPyTD3zdcYb/XFZCNjn4tc6HRSy+5rN8VZzvQEalc/e2YGSPVrqd9EA19cCUFF
         VKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750839985; x=1751444785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HS4wAnVjCQeW1rVCh4eHK2uX9ZfsLA1faWghmR3VJxs=;
        b=EOHy83+xNaE7/ESNz7ETZgsUdyANbWjkXSHjNVWEblEPo/LSdnI3mrNXhI9tmrQPrE
         QaBhthRgdO9bcz64Rcro1Mf5wxYAPaDAYYZeU9TG4TJdmWoRf6mENwzk0uJTrTFBXgO+
         kBWzdwXsNg19tHfCNCgwkWhdPGziKGx9M3JApoTojxgLUbQLxa+F4eFXdF2RAeHrKi+z
         l3a9gPXlIMaD3rGgEcnMKNFGEqpwBA66I43VsJtZJeXnsLytFUVd7crvI9p6rLPN1MCo
         Nl/x/JMfCYB3HRAw4XlBjIX0CZThHj0Vdw2p0fNoG8C+VNmIKzLvfddFYBKvukigtUE5
         jcHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPl8WVoKgRq6lFftEV5lbB+VSsU0GVLS98UF4pIr4DZGCfTtzEmxPsN2epONeqgFMTotb4a8rAVWJtu+aGidQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJF+YRsgUpI/SKxiVFsuCLZy1L0NFGJ9XgaFe+J8D0hIBizDpy
	osqcfKl7MGFKXFpnQnHmf6s/nSmw4OLj6KYPvnxVz6XyfOFXuGfqZz+9ht6t0/KIypjFZdcGV2u
	jT1zO7WnXY03HdwXAouZi96N7Z8dzpahSzeN5QSGsWg==
X-Gm-Gg: ASbGncuaAH5rJp7h3wHJlCRe9beFvSSGbbpxDd4emY0JDVILGKc9j58/US0hVekpnD6
	Xe9FMROqd1VvurdjRj+l6v0mxTp3EOBdFHmUWP7bbg8f2T+TlhVAFBfHSedHLMJ/oS+bJaxcrqb
	oG6prXn6NYGwpBApKUCgNzpwbOViB/FFjuTdk2+eDOMtnJ1BSvjAS6C8Vw0OIzszC7Ecm1cCZYX
	/E=
X-Google-Smtp-Source: AGHT+IGpMxg8o/chcnQe5MhULiua6yOTHYM+kv1EqdYOqZzH7FhLx1vYLQZI7NUn33/FILfroU1k/T45xBu991cKMZg=
X-Received: by 2002:a05:6512:3055:b0:553:2868:6361 with SMTP id
 2adb3069b0e04-554fdcf5558mr547065e87.18.1750839985044; Wed, 25 Jun 2025
 01:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
In-Reply-To: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Jun 2025 10:26:14 +0200
X-Gm-Features: AX0GCFt4ItqCrsm7oeOr_Iat7x8NjoEMSLW9yiH4e8zUF9RBY6CHWLkj4pkFCt8
Message-ID: <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Add pinctrl support for the AAEON UP board FPGA
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> This is the eighth version of this series. I just added a missing header
> file in gpio-aggregator driver to fix a build warning reported by a kerne=
l
> test robot [1].
>
> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@intel=
.com/
>
> Best Regards,
>
> Thomas
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---

This series looks pretty good now, any objections to picking it up? As
usual - I can take the GPIO patches and provide an immutable branch
for Linus to pull.

Bartosz
