Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6B369D45
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188882; cv=pass; b=H7+kyk/s2HwB2uctLplYDc2FoNcPNLQfqoKkai4unQYU6anP3dk2bpKYjsxsiJO02/YbdZaVQxmpoItKQRvIFxxqmltg3CPlKzbaSev5JnHxGIga++GvENmlQ6G699bESYjLWZyjqQ3koQ2PbQNlGzuZxYPt/4lcHfR5IoKVPOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188882; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJx5MlhHfBSkXLWTKL7ijyMk0UCVz0wXrZhLAdoS5GvW96IM8hwpNRp/yloWdxYYVNxq2ksSQ5daxuGt+MJL5Z2IR5zemuz3IsB6101k31Q39pFxVqT4UJNG91Q+z/fDmxRhMau7OUWxqCDbmtbXL5Z09chLOtDkyhdhoL188P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f24905306dso284654eec.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=NitfHxsWnRTv7ZgiqbCBv+ms2cmDpKHCosgo5niTKcULwuT6InZH6zcO7UylFntoa5
         81EvU1JzB2Vw9YJHN3779DEZWkDijtZKJxHChwc6sWOupm593qGX4Fo6+6DSdXPxWsvi
         o2xtZgy+eTeZi4691UxXQpIz2ON4UH3SvTrzf9e9o6POn2F+jY/WMX39v05v6vb2HAbW
         ugkDDmtpven7XTO5HIekFcWqM5cUQSp++eeuUxqfFuC6tYhRil+5DCbFyhLLwOlaBRUM
         sZeqpU7xyQ0TIZ3RpAU9+pEYD4S4btl4kxe7TC+gMlnq1zPeeZ5gq5uRkRPnkOR7ehbj
         00OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=2qQmkEiFU1jlYB0MEXZ/92zXgbs8KiPcqWQPiGIcgRM=;
        b=iPK4g8jSj6fWpihIzKaoeYVqD4kSvQJRZi6p8EWX7c2oH/JyJk1l0Nzs1BBGoGs039
         fIuu1dTEN+alZ/V8FiZlqM7+QpxmnpQE817uiipGoZnqzapAbFUkYweUPgQ0TY/qmmc4
         nVwfgdL8eDADRTKSdIu/xI2DvBP9V6aqb6G6itbA+scRLNFvvE1TE1HacSe/XeNDwyZS
         bZgj+yBgRWb8hQHhIfXvM/eTmgdSbsNEUFhE2Mh0GbR3l8PVRQNSktkWstoTMIrC/lBB
         zjjiVVgJjHWtUJqYLJhy4ZcKT74Wz3qjx6qgMc0IsUYshw8OgofwupQEnHfkOU9SD8ys
         HsdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=K5In9oxEtGTDfrLZjTumzqUqLUEUVYNpc8e5F4OUAj+LQOIUjuDmcq7HIs0TYbza74
         A65iEnC+IxuU24Wgv0o+pDEM3GoBgYX9+mIA+lJ2dstTFznFMVD7ncxlrtEdISc31EIL
         LYte8HdJVoUtN3OmpUkzoHsWuz7J/RecBdKsB/8TvwvNFU6sXk7FPt9IeBbJyMXX2W06
         EmYb5Uo1may1mg4l+DoP10N2IBrlVSdlauqHRp2e+fx4gdcAfTaqYCfeTMzbrxqC2InR
         XXOnTnEoDeLBSDPJwZI+QHCUX+YxFhd1DLTW6J5xXv/Eb6GwzfRnMsMuvRsw0wD8ihKA
         nlIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rs/Nehs+dZ6wGt3ozvtZFziX8n6pDkeF8ETNKgIHRyXJ2cRwRwJc5CNCFQjO7Tm3MjCUCpjbbRDyl/x0R8vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjlnaQvFyS+91kbowOWnVKz6xSngjprpdQ1FAFx0FfjEVI3pSg
	15fF0PfyS8sS6s+flbscPouoQ+wL8lMcZx9uaxUnuA6uB4W92rkDEYTjFdRVMzjWIVtF1mJ0lRa
	tqY4W+1ranyheI5UgrDbxS4Si3oRbtXQ=
X-Gm-Gg: Acq92OGMxoVVbEHv2psLTE9jGW/b4Bat5p3FWqEG/efny4oiz0t2CuWUjCnMcjVCsYu
	ac8sxErHUZjUH6EPnE8O0NLCKBznNbrYaDrrWM5w6bKVhlaqLtHByCpAz9l07vV/SaMprwjL9HM
	J0M6od52V0iUAqBgMpyuaY/GWTfAf5M859KUNdJ0gW+5fh3iQIW9CpdvSomX6EWJBZXGjTT7sUe
	xfGTbr3VHU5IIhdNZuhgUmQqJyaVvDsNROybBfeQ6GKX4OYIKWX2lPEDe2CIpf0dnfCBW87eDTB
	OyvZMIR3tsqSGlGUd++F0cHVdtDzEH0X6JJ6NerWrY92WaDggJHKx59pnOeLitPq16CISHCszm8
	41GO4MMWI8K/8VdpBwh2tRz8=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel
