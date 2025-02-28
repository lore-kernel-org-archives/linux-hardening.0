Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE423F360
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774302; cv=none; b=U+1H7OONnkFYkQQBvKY4/HrAlIwbxyM+TUhHViSkShzDbW6rbemqfml5wdbSgvreZGhJaxVfCvSvuX8HCKkpZyd86w0bgvch2JuRlseO36dfXG874Hy8x6HlxRSYo6dmnOwJUpZRki8yXyJyeNkdpYT5cEnTrhTBHg8MPm456FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774302; c=relaxed/simple;
	bh=3Vxydx1OBlKcFvthDu28i+YZx+61qVLM4GNVf6OKkZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVemyolfw0gwkZ8i4XWfREtZUY6STcJttzpc9rdfXD4pfxOval5em7lPMRdE7qOLh3umjoGz3qzCOkEvDlGZDBZU/wB1S3+c9nC9Uiq3SsPNEsMzek7yy8UcYJCFviTTjNEo6SfkOf9RDe+SVDHnM4zAwwYdxOWB4GSX2SvLQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjrVMuNI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjrVMuNI"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so3744897a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 12:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740774299; x=1741379099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vxydx1OBlKcFvthDu28i+YZx+61qVLM4GNVf6OKkZk=;
        b=fjrVMuNIOoHsUlOuUKfILcCTlsTNd1SH55bO8o1y9PgIFlP0pTqIOe4jBBYII1ZPKQ
         iTFy0a/EB0ZF4b3YKBfXTPJbD/hD9p9h3pV/nA5bfVR6DzPzp3Dgo1t7BXRSHkcbnv8T
         +AoolN0MVHTYvywQtlYT3I2/0X13rfbPD3igqQX8gfX2hsifeJne25dT6c015s1Xp3vC
         XvGfKBRn5PFwOdI8/hTx7+roiOVrnQuQowjgx4cXsbJB/xsyuHWFI0tL0T2NVWooK8v8
         kBzuqT1SwSIxAmD58ZMYvhLmtSXys+bPx9GySr7IgcvmUfjOEy+ankqaSHtBawHRuL04
         IeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740774299; x=1741379099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Vxydx1OBlKcFvthDu28i+YZx+61qVLM4GNVf6OKkZk=;
        b=bjDSmh7BLVM/U0ZdQrspGdTh09mEypKwxJMBHX6/Fdcm95CT7jTH7n/hepoT79fqt9
         Ce+GYItvoR/GWGYLa5fpoz52VSEV1Bha5ncqakxOoLsYyDxVDUdupaDEToPPygZDSH9U
         Sp54t2kjk0Wp8MfSGGquF+YLR4fBEpY2NdBDGJFRsBiJdzJgSMrWDPCx1kKKWOA7EmEX
         pCltz9XLmegiSKZwO4GZvvghdRDRLknTU2EKSqNsMAsOQuhs8KeANIkDUUxVOcuGEsjN
         fajMPVXbWlzuKr8QSqzWzdF019JBucgK/Yf31mgvUKq/wyg8GYUUD42I59HiSgVH8HXq
         o9FA==
X-Forwarded-Encrypted: i=1; AJvYcCXj4GEFuL2TH3jwjPYO6eJa09OaiWFjhXf8apJIyWMtHFwUK28mONKTu6bSXLB047LXnkK2H8S0RlHPZxeb48s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCjo0ewBU1t4oQ90sUWDjg+cBe0Ze5X/GVCNUwT61ong5GjfN
	0HeCz3pZAlW89/x6Tio03C8C5T7Fyp36S+bdMop1i5t+h9RPg4+CNYmpT2/gfDnW7pa0iACWTtf
	4XO8auxlC+jpI3ipVVox2cL8oss0=
X-Gm-Gg: ASbGncu7c05MbwOoALNxodWXLC2143/YCJ7OSx+GUJGuJyvID4+HrL1Awbq5kq3six/
	Se8uYH3+2+Ygad+m+yfxGjPE68Y030GVKNgYxlTPkrVACh6oB3c2mktkAFNq5y2IcKe9gyymLib
	B7U1lrv5s=
X-Google-Smtp-Source: AGHT+IHUwOWLocsH26icghfQhxN9DY15QYkuqdABT89ZHN48MwZHA/YVGesY6CbFMqz4NpL3rQTtTi2X2itSZ4oKyBw=
X-Received: by 2002:a17:907:7211:b0:abc:269c:56d5 with SMTP id
 a640c23a62f3a-abf2687deb8mr520119766b.40.1740774298952; Fri, 28 Feb 2025
 12:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com> <202502281143.149423E53@keescook>
In-Reply-To: <202502281143.149423E53@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 28 Feb 2025 22:24:22 +0200
X-Gm-Features: AQ5f1JqUv9LHuQv5WmYugwFBxksmfN82A0qcPDh_mlCeizNjoQWFFdBOW9DuxGk
Message-ID: <CAHp75VdX_LtL8vJAjwSqHfW9KbLGV5xhjX4MjFnpFo0VA2SMWA@mail.gmail.com>
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
To: Kees Cook <kees@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 9:44=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Feb 26, 2025 at 05:34:48AM +0000, Kuninori Morimoto wrote:
> > I would like to use string_choices helper to cleanup the code, but it m=
issing
> > some of well used string pair in kernel. This patch-set adds it.
>
> Do you have some Coccinelle scripts or other patches that show the use
> of these helpers? We tend to avoid adding new helpers to the kernel
> unless there are active uses of them.

Kees, what is the status of the
https://lore.kernel.org/linux-kernel/20241119021719.7659-1-prosunofficial@g=
mail.com/
?



--=20
With Best Regards,
Andy Shevchenko
