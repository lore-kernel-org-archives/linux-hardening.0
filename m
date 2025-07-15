Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4473C2DE6F9
	for <linux-hardening@vger.kernel.org>; Tue, 15 Jul 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585444; cv=none; b=T3dDKrKtWnuZlUvme6jfU+iMSmS58q8EkiZX93QPk6+UyEDByoMl8q7ywk797t96IM1l4S9hvwgoGLmS5TWsfC6GGJWFM7wr+zmK+HAKONNrQskcR6knqj+CX0+Kt1xPFLfNJWJiEywY9NvqPTVjqg6ilI5V+fhbY6KK/EzY+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585444; c=relaxed/simple;
	bh=EbPOhYxKmhpuxZYPk4B6pkAFB6wXuZvAR/vSuYVQ5XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOEV1R3xd/VBfMalbU4FZrYVAhbMjFyKH+za5kye3G9iQUnTyq3jEUApP+vFIelzq83rOymgMRGA4u+oRJWud3ArmkKzI/ML6k+N5vXG8u+Io8SFWKuHGbQiOaPCyM2xgBFZ3kkqNYAA09LFfhiJrPB5gb8LpgbEx9ZWqmwSIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m0pE6wcl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m0pE6wcl"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso5753931e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 15 Jul 2025 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752585440; x=1753190240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbPOhYxKmhpuxZYPk4B6pkAFB6wXuZvAR/vSuYVQ5XA=;
        b=m0pE6wcl9/rA+zZrcKJgGP+4k0hvB0TUxfzPkMuqyTqdcwrQqUD1Q4dz770UY1P5dq
         ou8rGDrKbPjxs2F2dzgOoiMh8JQrGzU+f+S9S/hMY6HPtoUJ82xT9lg4wq3DGlapPqwk
         FeVIAAPiwQkwl07oon3Ti7I+TB/ZAT26dmIYg1VUnf+CHOQbAVYOjYkVTg6P1gNiJsMg
         yxb4rgHLpvm1+qX5AUppvm1mq3lgvZ71RMu/lZD2+MjRHkOEQQPvIJFvRXl/zpYJI6O/
         byrIND1HhswYcDapYJ6UKAegvG6ecjHLrpXTJO4jXuGvxuKMNMxpnqz5ldn1qGIHfjTE
         woNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585440; x=1753190240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbPOhYxKmhpuxZYPk4B6pkAFB6wXuZvAR/vSuYVQ5XA=;
        b=MoYu3R3JjeSIj/2HLGSlajriMwtwNRsOqzl26TBTXpfJVzQnZQJsKhYdFW3kC2D7Lj
         +qt0YfLJ+vLNQAo2a8og2zImEdCSVkmdgQLVzRx328d7bfdmy7frmrMgbZs9IaMCcsWr
         cDN7SJsRI0688F4KaC/4tFMk2vEoWPKHrgvSIbFZ+zwjD7OfrT5SogFj+Aa7TEC+T93J
         7dbXzL2P0VDIbmBJZVc/syAYJPYWuxa4PFxQovQWbLOOnSJf6UBIrVzQ7z0G4TzL8/py
         zOwiGz4KkkjXhkBjLY4KqBS2ocTzyoHohyZY0JjQvjP/YfzFyS4Vn49Ilo0xHaRfPr8z
         +blw==
X-Forwarded-Encrypted: i=1; AJvYcCVhaGb+GyZv847ZfGgUvkSypXcuqQPW+DBnx4JVQdqG1KXTxxGqARqtbq9uE3Tot5C0ln2prRuLESty9AI60y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdptogEjib3imaXuY7XxGw0zhBRrX+0zQKfm17mKzz6IUe4AR
	7t5a9JsJQjHhwuM1YNwIg9eZhHCX55N4uP5IkfMzsq4H1Qb1eFVvFSokiReEibsBQPpjpapJ/VW
	/JbtClVbrNsr5bYnmtjQQZdxURlcohYLgGEIBLrkEhA==
X-Gm-Gg: ASbGncuYnpMh2U9nkD7nLRXB/S7nuV/Q8nfc0QWM0LRn/CvJPNYEaLtiTu312ufFvYJ
	f8tQTTHAPoq4V0qlzNnv9WpUDM1VsX2aGkeqGLAb3gD3RfJSClps0O2h+YctVlaRXONtC2zKShq
	c1dvkOBQEIYAkoGsawalRV8jytbhP1L6q5MfkscLI5FCZbpK4OFBUSnSqeDWL4QKfHjmMaSsqGW
	Fv81Bhlv1lSI85lUxAWZuCxYcnziHoMpAQi3nA=
X-Google-Smtp-Source: AGHT+IG09J9PA2KclI10YV95njLPiWN/K6zvwX5knhUkHxQZ1/HA1h98MK7b6qFAh/thxaE0FtygrGZqtBXWqXa8aSM=
X-Received: by 2002:a05:6512:3054:b0:553:3770:c91d with SMTP id
 2adb3069b0e04-55a044d0e3amr5712015e87.4.1752585440185; Tue, 15 Jul 2025
 06:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-aaeon-up-board-pinctrl-support-v8-0-3693115599fe@bootlin.com>
 <CAMRc=MfS5Em65n0fwbu8JtJsc3rTgQO5cv+PymSonJtf6_zRKQ@mail.gmail.com> <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com>
In-Reply-To: <824ec6d1-4272-44c7-b3bb-93d716ed3d43@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 Jul 2025 15:17:09 +0200
X-Gm-Features: Ac12FXxvAYS_y1k5VysfY5vrsZKSD3qX4LU77mI9zq4NyAOxI1SkYaUSlMb4VSs
Message-ID: <CAMRc=McnU6TO5p7Jwy-DOg_8-=AS7rFRfaPD0yH1SERWXM8L+A@mail.gmail.com>
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

On Tue, Jul 15, 2025 at 3:13=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:
>
> On 6/25/25 10:26 AM, Bartosz Golaszewski wrote:
> > On Wed, Jun 11, 2025 at 11:00=E2=80=AFAM Thomas Richard
> > <thomas.richard@bootlin.com> wrote:
> >>
> >> This is the eighth version of this series. I just added a missing head=
er
> >> file in gpio-aggregator driver to fix a build warning reported by a ke=
rnel
> >> test robot [1].
> >>
> >> [1] https://lore.kernel.org/oe-kbuild-all/202506092324.XqSwWl1z-lkp@in=
tel.com/
> >>
> >> Best Regards,
> >>
> >> Thomas
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >
> > This series looks pretty good now, any objections to picking it up? As
> > usual - I can take the GPIO patches and provide an immutable branch
> > for Linus to pull.
>
> Hi Bartosz,
>
> When do you plan to pick the patches? Will it be ok for next merge window=
?
>

Well, nobody responded to my last email. This is a cross-tree series
so at least Linus must confirm he's ok.

Bart
