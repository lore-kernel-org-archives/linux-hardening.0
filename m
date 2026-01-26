Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB147315D51
	for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419771; cv=pass; b=dGImi9iHJ7GH3f8Htt0GMkwbSM6EunGdgm8SeMleOsECug6g762lFqX55PSE9ecNmHrpnBvJ4A5oMAzExYU+1B/gAvDr7IT1LfN0xdscqufWzX9oSxne23ljQVqBk28rGfG/gdNoE5f86THck5OaSQ2o8I4FKG2l6IBd/tgfx38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419771; c=relaxed/simple;
	bh=7sknilJR7WE7S32qXVodV4jXv+/MeP/qmPlNhb+kWnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlPBuFBoW6nsnEDolVR5z7vag+G6NUzPfpefBw3HgBgkU+cR+f+uIN+6mRUjqWKrQ46AFacpYWNO4E5m7+ZaOCcq42SHSo9TwfYEa2fzonfoNzKOikowL6Ud6+OAFmm/vx2anDjG4cQPrdLvrJBR+hJAaVkcF5+QSK0B6MjT4U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHqU9jfj; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHqU9jfj"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8845cb580bso724270666b.3
        for <linux-hardening@vger.kernel.org>; Mon, 26 Jan 2026 01:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769419765; cv=none;
        d=google.com; s=arc-20240605;
        b=PXKEgRF8gLkhlCG0X80lVeepTU1cjYxvCPlUEcN07lB84/ndG0PkKATeDupTQAVldi
         OnAzHpZwJeHWThOfMeSyCp9xNWx9sjbxNNPvS/LgrR4Owp0SOF2M+aEG1GUehilDUB8E
         Wvxe5aEGB7th+kG2ubDMmGei5loy7sPOqHQB84Sar2W0HL/DAn1J4wOgEsErNwg7OpjQ
         YhG7R8PQ7whVq2N1GNBwCdZ1XwNegLff1dvmZIJRYtdRmLHKW0SNwNAiSL5QuQRbO8J7
         XsdWydXTqJDLc8irg2V6D6pkAf6J4/pVQDB4e/idzJUgkbVLFX5tlCm+wFdiWo7p0mnK
         zrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o/rbdOtgxtjX3LqxxdCWOOuHLMHWGXHyGw+40grPbZA=;
        fh=aDdC6zxBMa2EMpIDjmA19YXEudebz1qBWrhVu3Sj+9w=;
        b=GHj0rYRTwH9FvrbQ766v/RH5y34GNuMtAMcjKRgGS6mez1dMISP9Rvb2mOpjI5oUr1
         CnQkSblCGiPDb317AJNKhklqk/v5IW6QVncn/GwuQdDBtU/ELdrklRZ9mKKQE/cdLYiJ
         uCn3XAh/T/0xjq/svE5wF6J8WpWDnICbcHXUNoDVq7jGT5yAaoBqctbIXx5jj8m/YNWB
         p65bq2Fgn8NLl0/SQrbEeGUYy62TXYeIOB0JDiDKKGh9ddCT6uFopy9CJrcqEbfCNcRg
         oRlmQRrMVmHlrx/XOv+7pQUmDL85glwm37pKIaoOGdT/TuZxhyaZCqTqsQOjY2ZQZ6B8
         emzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769419765; x=1770024565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/rbdOtgxtjX3LqxxdCWOOuHLMHWGXHyGw+40grPbZA=;
        b=KHqU9jfj6T2g4VL57HEbSIenDvOxPKpwRqo62tztj7HUtAoMXRcncZ6/UUi+b3nKmr
         stcI+7LAMLaDvmMtcjD22va5jeHVFO0PnEpfXXxR0SKWwF7EBZq8zyxfZdZA5uvHuqeT
         bd8fI8rwQRUhB6IX/KU70j/eVvRwnJbT+7TtK1WIlLK/8DTbKN3AxUUFOdxXXygpA01Q
         rCLX/QoxUj/JERf4In0PjHVh1D2lvxgm7Wd/MeJEGfB2BBJnBBaDK8ipyGDSnMQqxL3D
         os6e7sX/Zdm+CJbypmOdUTKzEFWTOAWnrCBj2phn1WJc+Py1J9nIYVCDi0nUhbhZxwSZ
         xmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769419765; x=1770024565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/rbdOtgxtjX3LqxxdCWOOuHLMHWGXHyGw+40grPbZA=;
        b=PKcAl3PjlXHDOems3zHyQHgebJl9tROlOQvRdQeqxIaxnTYt3lO2F7cjqdVQeQHX0k
         uTphbwOesY/7xrHrDOm0O0kRH0Uo0h4ycM9Y5uHgbpImJCL1rVNUsomRG9p1hxDtLvnL
         jSrUmpgU2vYoFh8BMvv/3ED0grq/1KEcEPxYbJt1MVNMEDq5efQkn29Z4y2Qw3HW8a6R
         07mQp6UtMNy8uIRmU5jfchlfgaqKId7ISJ5S8bLaFYQTFKo45BvKxMQP3fd4w09taFWJ
         2akepXDFpQlmzmnT6cX4QoJ5nBEmjmKQydFXALpDZpybJGup8zW04Z3xcDDm4iP997kE
         6IAw==
X-Forwarded-Encrypted: i=1; AJvYcCURdKsgZ0Bfek97BxfiT5Ryr3Sm8wc1A6PewrmdJaYYUintzqUuIxUweLP1BlQTOJhRSJ/fHGIPkk2zvelkAcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGERa233t5foKT+tVPYxCxAre5F1bkskV8hMiTCXMsS6gdX2p
	KnXolggGmW8eLVtMInGnVEorEdZweqpyjhu6Vb3KjHfubqGtU/u9v4+nZ2pt1KEay3QkF515qpg
	mMrnMgeIVkwN/HEVp4qpFUE1i+/gnga8=
X-Gm-Gg: AZuq6aJ8ObU0fqa0vLLF9Z3yY9TrN7oXHoalQCxg4hA6b8wxRCj6v/tq2Jfc79yvTIA
	2ZMpxCJKgSpNdoMFKjmaFCsB9rPz4aWNQg2FAqJDMDuEho+UcCS/2EBihL9MlhF4ojsrJOX9PTS
	qVd2AZl5OY88xASGZwN8wwrjue2DhT2uhAL7riXrjRSvc2zfEH5XCnsO7WdrWUdSipatV8T5b0f
	Zk2OZaPdsiot+QU+UxtVA2yTQnlY472yTWuUSbcXPXxkQQW65ptqH0cue9K4O6x2BUBS/pCkKxa
	A0qkkmjNUeaFo1s8IZ2eRByVyetJLrNbp1t8KU8Li4CuyHZqRLBQqopO9+1Nlq7pDukms24=
X-Received: by 2002:a17:907:9484:b0:b87:c13:f334 with SMTP id
 a640c23a62f3a-b8d2e6f25bcmr276729466b.53.1769419764840; Mon, 26 Jan 2026
 01:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123085841.212468-1-jiangfeng@kylinos.cn> <20260123085841.212468-5-jiangfeng@kylinos.cn>
 <aXNVL318XTTQ3tsU@smile.fi.intel.com> <b637ecfb-e852-4864-a80e-fdcd34d93cbd@kylinos.cn>
In-Reply-To: <b637ecfb-e852-4864-a80e-fdcd34d93cbd@kylinos.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Jan 2026 11:28:47 +0200
X-Gm-Features: AZwV_Qhx6wRZPCb1Klqjlj9JkvGS4ujtYHhVZw9cTAQek8bSSg_qHZMEWwb3vDY
Message-ID: <CAHp75Vd0w0P6xFH1KvGon=cTzNVPJXex33=Tv+vpmNKJXKG2sQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] lib/string_kunit: add performance benchmark for strlen()
To: Feng Jiang <jiangfeng@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org, 
	kees@kernel.org, andy@kernel.org, ebiggers@kernel.org, 
	martin.petersen@oracle.com, mingo@kernel.org, charlie@rivosinc.com, 
	conor.dooley@microchip.com, samuel.holland@sifive.com, 
	linus.walleij@linaro.org, nathan@kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 8:14=E2=80=AFAM Feng Jiang <jiangfeng@kylinos.cn> w=
rote:
> On 2026/1/23 19:02, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 04:58:37PM +0800, Feng Jiang wrote:

...

> >> +                    _bn_mbps =3D (u64)(buf_size) * _bn_iters * 1000; =
 \
> >
> > "KILO"? Or "(MEGA/KILO)"? I'm puzzled with this 1000 multiplier.
>
> The 1000 factor converts bytes/ns to MB/s=EF=BC=9A
>   (bytes/ns) * (10^9 ns/s) / (10^6 bytes/MB)
> In v5, I will replace it with (NSEC_PER_SEC / MEGA) to make the unit
> conversion explicit and avoid confusion.

Or NSEC_PER_USEC. Whatever, choose the one you think fits best.

--=20
With Best Regards,
Andy Shevchenko
