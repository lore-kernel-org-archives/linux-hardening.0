Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C79160865;
	Sat, 10 Aug 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723304554; cv=none; b=TyVgWDroK5tmq0ULI5998XpdHUAAn/gieWK8IH3v7VlVogwQttexTIZOVAz/Wi0PjMwN7xZ/fbyScGjxqpabOs4Zlgvevm1YArfXcJJRLEDrdQyeqJCDcJ3dHjKpX9g591UwA/9wKJ1pNNZoy5PYdl1PcfLvysCwIyqjQZiyd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723304554; c=relaxed/simple;
	bh=WGZQ4c3+06GqirOB7NI9r450dEl8mcaYabw4sVBrEEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J22HmSyE2tToQscniX0lGMpfpA+k92qBuw79+S59162sJOeui39fb8GpsqWE9SxdHEQWsnYRGIy793YrZ15CV6H66fLpI04JbfoN79H3JFYRcsIYWwRAjDeZnHZpOB7r4u71+PAHDhL0it4QjCIVJWP60phhBbSbq9VDQJCE9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCwS4k7l; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCwS4k7l"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso4390441e87.2;
        Sat, 10 Aug 2024 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723304550; x=1723909350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll0Zv3scvhHhGUgse8WyyqOtt9U6Ci62SJZyiCrYTy4=;
        b=KCwS4k7lZpME4T5c6Twhiq0IIPhSnkH6KzyNdhDTf99fox6SCWAPZdeRjTXY2vRaS6
         ySlUz5R53d2riQJq+VYCFTWKVITlRppp5+DM2ayGZ+x5AcBYc0NL6/zr/IebcV0q+e9o
         FQgEK0sgc5pxM6VgXpPs4FSVvIZ1ozQ3RDuofo4zSs7n0AzzPIt1AAWIbw86rg5iBl/L
         7FmQkYHKmv8rocc2g5wSqOiLhT0nXj9A/nViHhVE510XEbeSxxd1k6fwK6++5lHu/93I
         zEVZ7ueVZxBZwhNAVpuAxfBdLsRrtJTkQz7sEuTvABBQRSzjc2THid9ggJ5JFHqTPlNj
         ISjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723304550; x=1723909350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll0Zv3scvhHhGUgse8WyyqOtt9U6Ci62SJZyiCrYTy4=;
        b=i1gSiqnjHFb3hAdA514344cI6AcXnReZ/czZuhpoTUOnHkjUhELemm3wthFa/Y26Fh
         M6mmJIrAoSN+jJaUnI3VRot8Dp+TKxrwmQRAfsrYUZL3oMK2ZgEifI6GDO6gYkUeoYHd
         M+xOMVjTI1Ip4FfJjw2holx9qQXmh3rPwxZRHhpyvRwpF8wu7Cy4+3jJgfHfPN5EyJQx
         Ez8Ow44D+8KmltMeuhvff7fIOkmKn/Cm/lSg9xqqJdBCOtQ2HBzzr9qgo4Fx0bMocDAl
         0lONaZ7QvMNhiKpZ4++VPxsPiLzXMnXvgxZARnj4DJisZHZKkeoagCEcO+RnPRhfj/P6
         ShmA==
X-Forwarded-Encrypted: i=1; AJvYcCV2m/ZM6eAAVA6qcDL/7jX9hXW2djo7dzHp8BlwQSB2TcGUz7dNcWZtxhmEBOWRzOgPigxdGeQgF8rJhPUmhOlsHjr+9RcMOKXM9odtkY+7zqdxj4Xoi7AtVOPSsRLECZyk3AbxMyNit9p4fgj0
X-Gm-Message-State: AOJu0YxLR1zDW/8Kzf+6A1HTtHP3A2GUDV4Wx2jfSLYJLdrcn4JSDKFB
	la3i6y/s93E+BeENhaou+XZKZJtL+lCmjadLUXbNXAs+ew7DlEbMj9SHxEiyoHPjKpDIMbcn4R9
	OHv1zn78BeNlgOvHqJNuAoapHZsM=
X-Google-Smtp-Source: AGHT+IH9NWcz126slfd+veSsB3wrrcHX+9BBuTolXnRJCO8ZWubzVMppiuahdh+WY93r6DZwBPLnLcfyDhceGIdD36s=
X-Received: by 2002:a05:6512:68b:b0:52e:941d:7039 with SMTP id
 2adb3069b0e04-530eea22e8cmr3253568e87.59.1723304550063; Sat, 10 Aug 2024
 08:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
 <202408081609.D08D11C@keescook> <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>
 <dyigpya2tb7obniv3g2rzhtahvjhximzjlvoi42c45fqkb7hx5@tw3loxvglexa> <CAHp75Vcpy3+wZ-UuLRMVtvhK8u7X9wAyB8_5t1v8M50NCyTYEA@mail.gmail.com>
In-Reply-To: <CAHp75Vcpy3+wZ-UuLRMVtvhK8u7X9wAyB8_5t1v8M50NCyTYEA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Aug 2024 18:41:53 +0300
Message-ID: <CAHp75Ve-uU9OfyTNUdP=nvEt0SoSWpeKofZ2pWz_J9PDdmJ1Zg@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2024 at 6:39=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Aug 10, 2024 at 2:53=E2=80=AFAM Justin Stitt <justinstitt@google.=
com> wrote:
> > On Fri, Aug 09, 2024 at 02:07:57PM GMT, Andy Shevchenko wrote:

...

> > But, we could  do this too:

> > -       while (*src && --size) {
> > -               if (src[0] =3D=3D '\\' && src[1] !=3D '\0' && size > 1)=
 {

> This one is worse, I think.
> Let's take time and not hurry up and think more about better approaches.

Btw, have you played with the "do {} while (size);" approach?

--=20
With Best Regards,
Andy Shevchenko
