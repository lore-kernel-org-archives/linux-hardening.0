Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5B7641E
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jul 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631097; cv=none; b=DJIICnsuEedzDpISglXHRxfOg9SXTBTV6dfs2vzHKev5r2jlnwUz5qFftKgGN3kNrtxllwnGB4t0xl6afPEQ1RdgrbRrS5p9japbYUqsn67MuUzERJ3KCFRZN7pIP7uSCF0ZbWhuFWspaRADsVAhZo6wZaTZOBIcgNZBaLQ/dbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631097; c=relaxed/simple;
	bh=oq70z4/bCsrC1GoQvBoxOPOia/ExqElmdDJ/iZsXfL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB5/AOmUrahvezV+cfiLr7R4VXV8oxg+qlmj7wqnPrkZ+hTL43vWvNciK3BEk8godIc44XzRSxFQAQdavca/x6BL78dYpEVGlSUSxjoK3gqWPYUaXCuxiOvNenVPBdGCBpHZdhLuQEXdQml/RdrFx7JV9eWaq1DG24Kqr4TwgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TB1BeChD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB1BeChD"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so456a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jul 2024 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631094; x=1721235894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HGeZAs5GCO0/ogUU/V9u51auuYtWzKSV+J+gDPs5AQ=;
        b=TB1BeChDHW6vSnVRI/5kHSoCHullabm7gJQ8B/sVA71vlWgHTfigpyqjJ8WGjR4bgC
         y+Y+SsWXzDiCivYqRr1IfKBImgLQsUc4ew+xQk+Xjw8X0SO5mHQA+5y1C940Dd8hFL25
         eqtNo0BlH/H58pmNwi2b6ffDA8GNUIGW8c5TLCgi5S3D6z1gloUiAAJh+tNo/dTulMIr
         nnf/tWDEfbaDIlTF9Uul5n5sGJSt1su5lO9xdISDIODoc0+Va3WOcwuQ/UK9iI8pLm7t
         k64K0XjuGXp2c1n5YWr5lKJ9QxJI3HM7kB61aNljVpcNUofckiKgKbprRd8kGUsnFMGg
         3+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631094; x=1721235894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HGeZAs5GCO0/ogUU/V9u51auuYtWzKSV+J+gDPs5AQ=;
        b=wqeTVNtVRXizDeMII6BHAHAdloXYiWIYpmvkFD1WdDKuqHcRVUtrJZBcoPnGjE4n1q
         FbRGNfZHbHWMUZCe1mtD6osV9t1921Sf4n37kMUq69fRJCL/DptXHhU0Dh2ZuQi5xZ/3
         VqenTL7s0oYUtfuSeQ7qySh/YOcOAUsFDDHvGOhY+hKTsbvNEFqd4jalM1YQioxYe/Om
         c3nHeBPneUVAaV16GEg6p4zw7nG3RBeWKpTYXXjJIpWiofoRtTRsRaAMeCM7W/XJOkfo
         Wt57AWr7gg3FS1F9Ege95kho6fL1WrHQ/CijGskfa1kTUUbNcVcVT0yoYkqpyatk6Qbt
         HyKA==
X-Forwarded-Encrypted: i=1; AJvYcCVloD6Beo3MkoJrHaU4obd6rnZ7BfXTxboRpXMB09f/3g9JhKy2KZhTLhBoeQnntunD0FnTCTcBSv1+iASsNJUHz8UWCvafzTi6qrSr3wNi
X-Gm-Message-State: AOJu0YyCbkBPMiTrGgqw6mV8QH9/k/Pu/GYpWqmdw6EWhVsEwVv2enZy
	NPFY5qKVNgXlfrayPnCj/FfMu9gRuraJRizQ0U2XCiSnhBi/Vdh9iW0UZeHdvHd6Zu/ewmZ4oqN
	UJROQlba/vwdeOICBv4eATBP2eGE7vXtGh2gN
X-Google-Smtp-Source: AGHT+IFY/CNV/3qrOH0Lh/APA9kMWu5yookxnY4Qhb2zRpXDPgqdWc1JKzZnJgXLhNnDQvH3c7i3SF5iReQ6xkV6bXo=
X-Received: by 2002:a50:8716:0:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-596f914a15amr216846a12.5.1720631093774; Wed, 10 Jul 2024
 10:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org> <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com>
In-Reply-To: <Zo5uRR8tOswuMhq0@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jul 2024 10:04:39 -0700
Message-ID: <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 4:19=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Eric,
>
> On Tue, Jul 09, 2024 at 08:27:45AM -0700, Eric Dumazet wrote:
> > On Tue, Jul 9, 2024 at 5:54=E2=80=AFAM Breno Leitao <leitao@debian.org>=
 wrote:
>
> > > @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct=
 net *net)
> > >   */
> > >  static inline void *netdev_priv(const struct net_device *dev)
> > >  {
> > > -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_=
ALIGN);
> > > +       return (void *)dev->priv;
> >
> > Minor remark : the cast is not needed, but this is fine.
>
> In fact, the compiler is not very happy if I remove the cast:
>
>         ./include/linux/netdevice.h:2603:9: error: returning 'const u8[]'=
 (aka 'const unsigned char[]') from a function with result type 'void *' di=
scards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers=
]
>          2603 |         return dev->priv;
>               |                ^~~~~~~~~

This is because of the =E2=80=98const=E2=80=99 qualifier of the parameter.

This could be solved with _Generic() later, if we want to keep the
const qualifier.
