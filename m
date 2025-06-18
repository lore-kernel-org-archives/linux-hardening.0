Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509B2857EF
	for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248248; cv=none; b=YPw45OKmj92IlCCFOF6SB4YqF/8/2y0dGHbn5NTU0EF/7tQH6M5nUk5WPnTbeUOKXxZ+TlW/olFFyfiPgWPfSR+FDMUqY3IfzVlUWYal2jBrO11m9VlBZmhCLuWd4HDlvwfGT0mUEfVLMgA0TUTXkK/hqUQZ+SeK8ulj2kHHnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248248; c=relaxed/simple;
	bh=PTmy0HiGv1t5sWFCZ17SXK1kqhYyZoQXdPJkkAc72Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0jsqxEFnPVha7dr+gMNq4RReAlpIvN5JJ1hzjSjEy9NpRti2vxfHyIwsJgyHyrQ0Ofn49BPlnynOo9vrH8PlsumbpTYehxsMHNbmAA/A+eu5RVCR2+LI7nXmsY9x2UW2C+pJHnDuYmF38EoT2FwkOl0/fCGzlXn5RRvkicZdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jidkm8EA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jidkm8EA"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54e7967cf67so6995115e87.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Jun 2025 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750248245; x=1750853045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw5lDMVe5PLgX2ttnQHBMbMYq8dC4LdNA8jYmEuyK2s=;
        b=Jidkm8EATPRg5VHH9TIMoiDnXjer4MuzmtdWCu8ovDjoAewYtg0zRrCaCnA7GwrbRo
         utF38UuVM8BP673WDjLNIhX4SsS6OPbZvCBNI5fpl4xUqmKh9yotim8urM6kosvGPgon
         a5npIovo9kYBfOynwlUzLAjJRehzQXiNWmWThS782P/qxdIiKZ1LCb0WnLE28oCRmaZI
         +Ue3+9zmBrW4cUKL7kgaitpg6VGu6gBU3BHjL8E0ghjbiHEbF38RLWIXUiDWiPYZMvce
         qyiZIpDOeQ3wKT2o4P7WmSWZ6oYe1ja3y9hclBcaztzb4c0krzIBBlf6JrXNr+HMXxyA
         0jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248245; x=1750853045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw5lDMVe5PLgX2ttnQHBMbMYq8dC4LdNA8jYmEuyK2s=;
        b=rBmqIw1L8y2Be3Vm81s3Ap63sZzflvD1RBcCizW+rMWQ7pg+Nn9OFz62mQiXD04+2H
         8hy4JOthfW746auEj13Pw8Hpku046vbRH8beSXJkiB0KR+CuN/H6iBDSCBAEVd0iaXI1
         AGtyOR5ThZ/lVem8bNi9Uc/0HesaUZ8OMC/srlZFq51OomWSlqxs6xnnKgh+lFduVeY4
         pvicl15XUSunK2B/BOgPDSKxHWymZcv/Quzof0L0GX4n2mHWO4rCsMzHx8TAeqYnvJtW
         zMOfn0kiVfCojGHFvtheJLV8FExaQh/B+yR2gMWOEt7rpIEeo1sSDWm0QGwOQjkVVhoL
         1ong==
X-Forwarded-Encrypted: i=1; AJvYcCUl5yT2MJ46Nld7UdF4LwaVStttp93qj2/vHRZ1X8Gi0S/6C5w8Hv/4hVOTuoIc7X+W8XKV8RMfwNT/H/oxOZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXrv5eI3IOwQp+0YkLpDlBmaSYKCnQDhMHld5SPxyGX0f7tWH
	kPvs7WATpADNv8EN864lfnVqHlQfKk/aOo+Wi//z2cbW4V0lybbfXG1gSUsGaDgAQgczJbvkQrw
	dK1dp7y7s1GWU6zhE4uiW9GyqFEsbkjyzZA6z0VSNMw==
X-Gm-Gg: ASbGncseg8fN/5xrIsQCyPlnFLtOZqbEfxZcNgMq9RW01dOKwu3o4Yet7kUUIYxGhzl
	TxVMO01ac0ThYlfFU2Le7lpIqXpOfI/7QLNWxX37Rx3I8x2HfvAQL6jwWXAtd7afvT5vnAdJmaW
	JlpxCPGroGg0HuJjpzeGZl3Ilfjx9FlbCTG2Br3sU7tw0=
X-Google-Smtp-Source: AGHT+IEU7+cVw8RWzajvpd9J/titbwGwZeEUiqB65UOF2F1fN9VnyfLkaqO2QVzTwOrXfsDFPTbPA6/Eswa3w/UmtNQ=
X-Received: by 2002:a05:6512:3e0d:b0:553:2375:c6d9 with SMTP id
 2adb3069b0e04-553b6f4ee07mr4818857e87.55.1750248244152; Wed, 18 Jun 2025
 05:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104539.2011-1-luyulin@eswincomputing.com>
In-Reply-To: <20250612104539.2011-1-luyulin@eswincomputing.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 14:03:53 +0200
X-Gm-Features: AX0GCFu7uLyX_FQipTQ9KLFWtnjX7fYjtMWgaWxutCWJs9ZMNam2b8u2qEvrRTQ
Message-ID: <CACRpkdYQBdkeJjAkTikxgQBHJLQUmgGSq45kGMGzJ9Hm9OAERQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ESWIN EIC7700 pinctrl driver
To: Yulin Lu <luyulin@eswincomputing.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	brgl@bgdev.pl, linux-hardening@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, zhengyu@eswincomputing.com, 
	huangyifeng@eswincomputing.com, fenglin@eswincomputing.com, 
	lianghujun@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:45=E2=80=AFPM Yulin Lu <luyulin@eswincomputing.c=
om> wrote:

>   Implements support for the Eswin eic7700 SoC pinctrl controller.
>   Provides API to manage pinctrl for the eic7700 SoC.
>   Integration with the Linux pinctrl subsystem for consistency and
>   scalability.
>
>   Supported chips:
>     Eswin eic7700 SoC.
>
>   Test:
>     Tested this patch on the Sifive HiFive Premier P550 (which uses
>     the EIC7700 SoC), including system boot, networking, EMMC, display,
>     and other peripherals. The drivers for these modules all use the
>     pinctrl module, so this verifies that this pinctrl driver
>     patch is working properly.

This v5 patch set applied, any further comments or snags can certainly
be addressed in-tree.

Yours,
Linus Walleij
