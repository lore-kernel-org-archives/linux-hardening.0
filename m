Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C6224F0;
	Tue,  3 Dec 2024 04:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198642; cv=none; b=sxAZBizlBhMd56HGmEgWnJRHVvGNcEsODXUah6STcy3i542vn4ieHQGEJDFZcyX1RGkoFtn1FdtbRpzL6+EjDFID2UoKESG6tNmQqTc9j1Ji0yo9EPl8/Tv8mOEKVNS6HEX5XeKdck4bHIDJ0OlFTC5Q+ZU9a+c03waXQ5sbnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198642; c=relaxed/simple;
	bh=irN2mDb4DxV5lPd68poaTr/FFEji/3swiAZceNn9oj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHlMbpyWusdcN1Xnjrv8TWmQJ5zT5n67mxyI7lEy55ECwrtetktdwx5X9mNQKmZZpMqzI7B0cN7ZmDI9FROhtM0diVyzjB4ZPQc3nXcRXmSXo+4EIPsHT8eRqvg/jwXuC8q3PFZPqQ9ZbUK5LBck+gMf+3y6L3485zacXS7dohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHqUe7ii; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHqUe7ii"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8843c44cfso32626186d6.3;
        Mon, 02 Dec 2024 20:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733198640; x=1733803440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7bUwi0TttiL+apQ7VoSfHS8nkT7Ms37eJEkRC/4J0U=;
        b=FHqUe7iiu/D5ltHd+SaTR1HC90uWm9LL1w8u4Gndp8TB1svNx39qQe8LNyQ2u5WGgq
         ZXrM/ux7/CPMT8WFnmT5g2dXHxfPtaYUn6t2x2geTF1dc1bByceYH4BXtQT+TkR5oqTB
         C7PTrsRiHLPjmnCydu41bVcQYKwXKCO2FnnQQao8ywUHvvCnAjJGXWZalmVDdL8Lvo8I
         TfCaipTW3iqjl0hOPorjysZ5rDBaUSmkQJQqiDHoiaDfYgzpisxusfvcDS2Thrl0w/ju
         XJHlrN1Z+gL9VuxJs2miBaNWTbgkstMxx4r/9nIIbVuqEOmQWnYkcDvPg9l1IsyejrW7
         b7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733198640; x=1733803440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7bUwi0TttiL+apQ7VoSfHS8nkT7Ms37eJEkRC/4J0U=;
        b=di/Xc0f5kKibsybdWjNGOeMCIAQOJEVe2HSBvb3Yva7RNx5d76Kl62i2kfm16vBYXn
         PZEWX03gJkGvK3GW/LvepXkXbabxL8XI9pdqxznQm1T5eywprHv/bklrsqHbCJMxkRhO
         tNElwyo9yJgO/HvE2DGbNuTdt/NKH609oT4Qp9l7foA5Ae/iiNaghzUItKeS9Iga65Up
         Lw7T0TuOCURJcN86hw1FI4Xl+eE6pwtt0HYFvU2us9SD8UcvohK21Me3xgFzqBiO4HFT
         xHXKADSt3Sa4L2t+6K+L72GRP8sec1uzjr/0XEXC6gNEYIxXj+7RfxK/bP0mOHpsWfXB
         5CZg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjtyF39pVZOLFAjoUZUKStdYI1mtr8aa9ypITPdGvp+W4gd0tUJXcmeKupaVG+zwPXSvSZ03kz/tIO1TM62l/@vger.kernel.org, AJvYcCVuj3yps8SELHNaKh4kiDw6jEaCqwMt/qIHovwmYdePYS4qbiHlY7JAlohX1zTEJMSFL4cDE1PGv4Wgsl4B@vger.kernel.org, AJvYcCWUJfhTB/KaZVsEGC6yo7vjqCFQLkG16xXq+xh8lvJwTkx3CZlqEnXRiwDamYoiC0IQp2JhsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5vbCcgGruytclDREAX0/IvUAhxyrS8oKInkst7g06efYyRQL
	m9NXymAhnrWwI238SpxenSwjtjBbFfqQVsr/sKEHs+L9W1xF5yu96nUJIsNp5fGFV0wgKthJZb1
	LAmLWihe591QOkBMX2FVb3ACNh4I=
X-Gm-Gg: ASbGncuTQOahAIcXMeFCn+IrotYodb+kjTDzUF9GDnmNxuPNGdsih6TQiqQ7hT86tHa
	uPlGwH2fKMBo15I2sqAzBBcecKjtklLo89g==
X-Google-Smtp-Source: AGHT+IF27TuPPXjjFmy32fsLtg/YixfsUo7fDoj7bds6GLocP9vjpQesILvwjCmKlDjIl6dNP5TWJMJN6XEWHJ6Yfjw=
X-Received: by 2002:ad4:5ae2:0:b0:6d8:86c8:c29a with SMTP id
 6a1803df08f44-6d8b72e08femr23550396d6.10.1733198640226; Mon, 02 Dec 2024
 20:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR11MB713438072B901F890913803F89362@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAHC9VhR6t_LLB5nc=kqqE5FpN4ftxZYidQ8F5x1Lzowf1H9juw@mail.gmail.com>
In-Reply-To: <CAHC9VhR6t_LLB5nc=kqqE5FpN4ftxZYidQ8F5x1Lzowf1H9juw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 3 Dec 2024 12:03:24 +0800
Message-ID: <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
Subject: Re: v6.13-rc1 build errors from kernel/auditsc.c
To: Paul Moore <paul@paul-moore.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Kees Cook <keescook@chromium.org>, 
	Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 11:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Dec 2, 2024 at 10:19=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com=
> wrote:
> >
> > Hi,
> >
> > I got the following build errors from kernel/auditsc.c file.
> >
> > The GCC version      : 7.5.0
> > Kernel version         : v6.13-rc1
> > The bisect commit : 286d7a54c8a2 ("auditsc: replace memcpy() with strsc=
py()")
>
> Unfortunately this is a known GCC bug, see the lore link below.  Kees,
> Yafang, do you have any more information or compiler-based workarounds
> for this bug?
>
> https://lore.kernel.org/all/CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3=
ZkVtvQ@mail.gmail.com/

I'll prepare a patch based on Kees's changes soon. For now, let's
implement a workaround.

--=20
Regards
Yafang
