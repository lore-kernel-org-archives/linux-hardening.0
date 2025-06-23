Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769E1CD0C
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750653460; cv=none; b=iRLjYpuv11LKtkgTGVQuyd2LJUmXwLSg/BUpMYuYStaFfHsGeRTS0b7lrS23CMtKacqjSJdP/UV+0PkmGrYwlBpTAGVYwSLNEPHTbvSVzPrdseq5x4JGRoiH3FFfuMX8tn7P8b38LF5O4l4POBegrS/yathyn+I08xQDlxqkH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750653460; c=relaxed/simple;
	bh=cOgznIXCgLqysLpet9MFHyoHFN7Avabq0Wy0lJFm8mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWiyYJWW8owdnIRNXAKKpp6rMP7CGBGuaYUDY6KWvnFrh3dz8YdcL+zMT6+MXPXwpP+f1RZYmgAW5H2Qkk4nMzVwJ0lWjaYgBq+eLNbU8y5BOaVv18oi21KOWYKSXH7wbas5usdzN4yqQvy+wcjVQg+YPj7PW6Iv4s7t7L0TweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sa27DMsR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sa27DMsR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313f68bc519so2586192a91.0
        for <linux-hardening@vger.kernel.org>; Sun, 22 Jun 2025 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750653458; x=1751258258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KP8Igk+q7fY8VDRXUq4VehJo2gUDi58j+pU+41ri3k=;
        b=Sa27DMsRPM+MEYt6f6XAGRf4jHJsa2u9ZSsXVswfw0P50mYDPXmvdQuRYX8ip73fLj
         AbleuZhXTFBmYU4VajRU3viAw5uDoXqEcmoe1Fir3xjkALSWsCSI0S0ByDPxcE5MKrlN
         M28sOY5aSPpNmgAQaE9dkjKuIJHFwwMdsF/uvHKW0fRmxOYPRJurPxMTWuWaASRmYMwl
         I9EX6TyplcRETzopWM4RLwVNtFEvxTw4xTBdMoBC8vxA9ZpayBeAxmqy1TQM70MKfuZY
         0HjPZeeMxMJjQHDrFY8ZfqXVj/NHxkuSzWRAKi9V0KLuOXvnEBdNxyOFb1QakDmcwT6g
         ULqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750653458; x=1751258258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KP8Igk+q7fY8VDRXUq4VehJo2gUDi58j+pU+41ri3k=;
        b=rQ/PEnVM2XiU2Z0i7WX+PvOsd7kZEcytrhKNXRU6PY1Dk4YSvp4XWG/SRKWLOKdn+O
         cTKBPVyXBOiz3VB1fYf9jrA3vkumAA/cwn4w4OrHfWRDuIHvzzlbcmcANOE0/WLVUC8k
         mhZ4U9auhFN3zJ42db5ln0S7McK57FhnCKAeVLkEi3nDdEruK2WrR1igqhA4kXz+YZ/y
         roj7CFBWSJEbfq8RpVy8fHVB7FdCnduvmY1ttRm+edxaTug695mhLIyOc/rpRpQoe7VI
         sr17IvpW6+LPXqZxu1gvHDSi3leEUrhDSRjbe9RVd1/WU3umPSd9PSsVbP2lPUkCYfTw
         IwCA==
X-Forwarded-Encrypted: i=1; AJvYcCVqBrGWp7fCQU04XcH/LOd30pA9G5nxusInFsBv9dmVkS0pj3ZHBRia6siWYOwNo5AmpF2f2DpM9AfSA6slfVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dMJA7L5ty+nel3P8C7SsfGXuL/Cz4Qbn9UAkjfSaagsBySmy
	5GbjYUAxpqXPs9vTTmraXP8PZofxEw5ImhEdk/D2tetpsJGXFbgbCqjIBmFvcD0sPNkJ2C2iKZZ
	Z905dsqPcYbL0ifaz3AdzwH/jzD6GObNMw8Tze+VE
X-Gm-Gg: ASbGncu9wacxNXDFaftwn90NfOSDCvLVha3/mQSAvVbAleiswCrz7fBVZeMPDgXHXbO
	c9hxMPr2h8z6+wOYCKjCTyZ+C7R9bq8+TLM0WNyqCjWhHRkePiLFl6j+pMrElPr6BntoFyHBq+3
	omv1u6h61uH2leithR6ORUA5jsZ7OmuCVSJ6Nx2bOaEMdHdMePM9Lj9uP6/GXwsxZa56Ab2QqX/
	w==
X-Google-Smtp-Source: AGHT+IG7ZR4RTzfI4eW8Wk5suo+PlmHanj0uoAne2qj/e1iSLFamgW/9NahlQ2mX74j1k5jk+ZtdqMODh/hZ0db4g8M=
X-Received: by 2002:a17:90b:278a:b0:311:e4ff:1810 with SMTP id
 98e67ed59e1d1-3159d6260b8mr17347635a91.3.1750653457880; Sun, 22 Jun 2025
 21:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620054757.1006729-1-naoyatezuka@chromium.org> <aFjD-D45LkBH_gnA@google.com>
In-Reply-To: <aFjD-D45LkBH_gnA@google.com>
From: Naoya Tezuka <naoyatezuka@google.com>
Date: Mon, 23 Jun 2025 13:37:26 +0900
X-Gm-Features: AX0GCFuUkLtpz_jSkZCwgozBAPpiL6gVnuxlDzYa0ZunBfSYveHWg_ajz6zzwro
Message-ID: <CAHYWnBHLhOU+CJC9ViYCntSkercz4hHVnzaeEBeqchKLz7XFNA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Validate ECC parameters against Reed-Solomon constraint
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Naoya Tezuka <naoyatezuka@chromium.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tzung-Bi and others,

I truly appreciate your time and feedback on my patch.

On Mon, Jun 23, 2025 at 12:03=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Fri, Jun 20, 2025 at 02:47:57PM +0900, Naoya Tezuka wrote:
> > The Reed-Solomon library enforces the constraint `n <=3D 2^m - 1` via a
> > BUG_ON(), where `n` is `block_size + ecc_size` and `m` is `symsize` for
>   ^^^^^^^^
> Better to provide a link, e.g. [1].
>
> [1]: https://elixir.bootlin.com/linux/v6.15/source/lib/reed_solomon/decod=
e_rs.c#L43

You're right, I'll add that link to this `BUG_ON()` in the v2 patch.

>
> > the pstore RAM backend. A driver providing invalid parameters can trigg=
er
> > this, leading to a kernel panic. For more details on the theory behind:
> > https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.h=
tml
> >
> > This issue was discovered during develop chromeos_pstore driver:
>
> s/develop/developing/.

Thank you for pointing this out. I'll fix the typo in the v2 patch.

Best regards,
Naoya Tezuka
