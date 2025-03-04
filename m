Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44118D65F
	for <linux-hardening@vger.kernel.org>; Tue,  4 Mar 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075287; cv=none; b=V6GFgzAmZNZH5VaqD8ao1LkOTcKNA4hzR0LWz09xWLulgmdCjYr00JoAuCUra1SQ0B9wYuhWb5iCZk8/0sC6Kf97sRSb/aj+WEzD75eHqbWnMuvm/0ipnxwRHU+Cfsxl5s0cIowl0Zzk3GmIGe4CMEv0GuibutPPu2MIR4uKYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075287; c=relaxed/simple;
	bh=yM6piAILnQk9xGq2GxzFHXReJiLNyLpTJqnfUjNN9hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieLm5WIazE7JamguxtXdB+Qt5fcfhOoA5f5VBosT0ebyvpwvzBFnWL4kZ4kt4WrmkY9faAqUGo3Es0qhcLC5ImtZoNsKoxhmI/1VQcAGCVFK/7Br8gIXRMGidZWQE5Ssh875T69AUi6Zr9DvNBngKia01WoOa4YaEubyVa0E+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPSb3OYt; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPSb3OYt"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fd80f30ba5so15058347b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 00:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075283; x=1741680083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM6piAILnQk9xGq2GxzFHXReJiLNyLpTJqnfUjNN9hk=;
        b=DPSb3OYtRAl9eJzUnDMymVpwekzT1bupKpE5lmtkv5Tk0bYTR75QwDtv4m0WJ0cQp1
         kXDLEnVrv8qle3rCgGK2GvD3+TgqX60D8iaYc6dgbMHKLvj3V5S6Zas8sm+0XbXFsHgp
         elMMgp57dpEPFjFrl7ky4G7jTQDLEANihg6IxRNkqohBl9ZbdYKy2qnPcf0IXpE42uwS
         4b9n58WjZJtkXp9RHE1QBPAorVei4m/VJp41rJ20EzXruBtPtMeX8suL4v5uJM1mz/3j
         CkBX7EU8vmnCceQAZm9jn8361NEcb+qm1psezma4hShPmoZt7VfenWXJGr75zgU+meR7
         q1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075283; x=1741680083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM6piAILnQk9xGq2GxzFHXReJiLNyLpTJqnfUjNN9hk=;
        b=RMe7c97o/LIBFcZufl/XSW1tYyBCpcqD904T9tTA+0mH5tY+tFpvWNJIPsLgs4H0/H
         6TR0Lv0S+mbdQUkjLUPjF5GfaVeeu7wOKAjeizJbzCmif8rkEvKVspBNHZNUAO131CW8
         0TookigFmL42B0nAbR96HlH/q+fYwhRBxkucS8Q+Zz9jccgbymhfCxKsCYwV7JY/+N7v
         40XcHJhqqXn1GEaBy1nMLPbW0gSuoWb00yuv9gwF4HMKbqJ7qDHZG7U+ndqjKpy99dCc
         69gnaHqBdg0b8+aDc5vMo9kgYUZhzES8LPc54/SHNBvsRs9JjDVdHIfYz1XAYJ749zem
         QG2g==
X-Forwarded-Encrypted: i=1; AJvYcCVT9SIVXKdPq78SEKA5Eln9h/kVfDRbjlAM5Rj619HFw475tIel9i2vseVi3N9Rf3o36/obe4587U7B/ChG3Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxFe0oSOJ+TPC+y/lxi/+S2gR+YQnM+Qxhl+C30GLU9XopNcb
	C1rl2l+YqgGnj6/8LxItvZeYjDQ8yJqrNZ1gtW6BpL6gfQ5c9SARmyhLZKM+7Cc/WUmQ42d35fK
	nxoWStMCWzo1D55Nd1nHGFsggCWg7sFB6Rvs84g==
X-Gm-Gg: ASbGnctD6HIRmVxocQ5MWGYxTY5NB7FN9MhHjSNN0vHUFOBH4MK8T9e8FX2vPYdSpi/
	bRi3hXdZV+RGGQJmo78n921qGGNawzZQIdZR0eV8PH+ENwjXZnZ2ruBWzQ3At3KoO6dIcoNS+pB
	qqaSBQVmuiKO6fuZvPo33+JFRgbg==
X-Google-Smtp-Source: AGHT+IGAv1QI6NxLx4aSutmM2eABQddCgvk11+0H2Td2ZN4KP/uMxodKgMJh5YrQ4faawCMRD4vowNlT+PD+ek3jkU4=
X-Received: by 2002:a05:690c:b8e:b0:6f9:41e3:ea4b with SMTP id
 00721157ae682-6fd4a059726mr195363417b3.9.1741075283608; Tue, 04 Mar 2025
 00:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org> <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
In-Reply-To: <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:01:06 +0100
X-Gm-Features: AQ5f1Jr4hfcQtwg_ZcA-Ydn_kIMJZb-DCuZHup-eBLnhS1CYHvK_yjDzqNv-Zg8
Message-ID: <CACRpkdYYpT1ut0EeP03p-UK4NZfYGb_ykc2CE4yo7jx+sF+Xig@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:25=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
