Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E711E885A
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999381; cv=none; b=DI9z4AL4k7kaCd51SAzHu3RXZdVKURh8cyKLPPbCKh9Rd5VvHOwg71skKg7LuXgwujLdSnbkvnmIssBqF860T1yL4WHVKQ4/pMeZxDkAxW9+ekLbfu/mtEoyTX+rRkv3K6vakWMujZ9xSx4EmuLm6OQ/8A+19316XldFuU3xypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999381; c=relaxed/simple;
	bh=gagF1+Z1gth1Gl0G1Urrz8XqqkbbSWEjhw+Zkns/Klo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYRQUvNpwLIdlQXqTYcPgloognSRqJp3iUoV3LiqUydBnWf2eS5kHbd7IpntaGxyUwII5urfalEYU4ZFxr5GidMl5CaZwUh/wCWKbBHNvL3dVcotmwD2zbRRtik1skMpFCr26jIG45SKXB+4c5HYXCsPdQwLizYCfv/8I2ZDKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QnI9E6uD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QnI9E6uD"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5499614d3d2so7403069e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745999378; x=1746604178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gagF1+Z1gth1Gl0G1Urrz8XqqkbbSWEjhw+Zkns/Klo=;
        b=QnI9E6uDkOC/qGzkyLrgvdJZYoPk2/B3lLMrJzCRjTjFhQ96OtGCJYPabeY0aDg74y
         vxsSkW7plPp50bKCZDKqLRg7+hDVFuM6oh0D1TKJnl1IYFy886As6D+sfMos1Kfxyld8
         16CaUXdM2s4WBpvsdxyJbjUV5u17RAPnbiGGh+aoFP4uvAJ+uW4EY9ev55abfrlmQTUQ
         7VSJ+QumrxAzI9SAy03dvByRHw7Xyh74Ml7Y1TWLD6kHn+HDqXO6c7WABvoMQ41W1zLc
         ZsUBckGLB7ozBGurfBp2UTZICcIkRd3FkKLQghE3Xi+ZNjIfAE/5/s4IXA5TxACqfyB3
         6SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745999378; x=1746604178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gagF1+Z1gth1Gl0G1Urrz8XqqkbbSWEjhw+Zkns/Klo=;
        b=JnLikAI030xZqITQwZ907L0lZ1yhqGSCArW4UTg4np1AqxYvtyWxQZsR2G1usiLVoS
         dgZCHtrskepaZQUbstY0H7g25lY39moi2WGM390tyEQf09WTzGb1RoyjrEHm3F+UC8pQ
         oZo5gY1ov2Dn3xVLZ9ZohpAyegWJM4R9FridiGFBARoGx1/0dNm+JFH7s8eraem0eJ+1
         liQfrWHR2Dhsgkij/R9bkqKu+JTQtEPQhJBwE7EA2VnNzCDeR7YiUMe34eCmK2v+LjjS
         OhOneF78kGZju3ZoHFWVWHFJzLLLpsdN0LUrpIXHLxJvsPer3AYWeru7sGDSQ0C786oG
         jgqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFvVghuK0hkNPSMS1A0BwIHTk7YQX2zxqezR56Ld1Ixt/0VJ4K6IlC09/Fo3IHIIUTDexoH7rLg3xdYtkK7EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFaKtS6nAirwBKvPl8SQa/LQy5mE5ZCJVoGQNBNdgocY+DlbT
	228BEFALABUjr47Asaz7rwOX3opOplxQQH+fJLqj52LpEpHoIOvyNTv5EuofWzDONmDAE0gjJyL
	ymF0YZZOI7Z2htUlOLX+KEI7g8kKjdNBl10h/aQ==
X-Gm-Gg: ASbGncue1du1/Z4Sr/PZRK6jHyKduK6RmB09/z4+XgWpDcTXWGNUJSxJOsCU0qgTJ7O
	TOeEUTO9ymsg4mSRW6GXI6J64DUNvvHPUGTBbKgu0I/+xipHPDLs4DjesKCZxyPq6nboH6QlyYg
	ymkZZuD2jAV+TkSWqBZVbEADM1h2fvjZPREK6TdWGL/oYhfab+ASNkD21vV9Tkk4if
X-Google-Smtp-Source: AGHT+IEFFDno7HEPLhjBoV2o9bzH/IPZXO1S6zS44ofx30EX4LqTfYUZRthTkCT4/OrxXPozicJw0AVWJA64RH08fOU=
X-Received: by 2002:a05:6512:e93:b0:545:c7d:1796 with SMTP id
 2adb3069b0e04-54ea33aea24mr689451e87.43.1745999377970; Wed, 30 Apr 2025
 00:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429-aaeon-up-board-pinctrl-support-v4-0-b3fffc11417d@bootlin.com>
 <CAMRc=MfpE6M28P6jxFgs6K6Tf84LRhmaw5U4s8WgciF815M7Bg@mail.gmail.com> <CAHp75VfkJAG6EKf94NFKVKRgKiRKxB7WER_UXcY7sGMOqA=YNg@mail.gmail.com>
In-Reply-To: <CAHp75VfkJAG6EKf94NFKVKRgKiRKxB7WER_UXcY7sGMOqA=YNg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Apr 2025 09:49:26 +0200
X-Gm-Features: ATxdqUHrPhxGGHoiNszruLYa_2Dtad5uG_qc02QAby_LYfy0erDTwo0gD6qZhok
Message-ID: <CAMRc=Mf78f6yJPUEZbB6UWQmv22gLaP+6xca7S7bk54Le85TwA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add pinctrl support for the AAEON UP board FPGA
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com, DanieleCleri@aaeon.eu, GaryWang@aaeon.com.tw, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:30=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 29, 2025 at 9:43=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> > On Tue, Apr 29, 2025 at 4:08=E2=80=AFPM Thomas Richard
> > <thomas.richard@bootlin.com> wrote:
>
> ...
>
> > This looks pretty good now. Who should take it - Linus or I?
>
> I agree, but it still has a few issues that need to be corrected.
> I believe the next version will be final.
>

No worries, I'm just thinking ahead.

Bart
