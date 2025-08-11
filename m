Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55021DE3CA
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950916; cv=none; b=MGUZJLno+0SllstAfCK1lC1zK/rOq4j9E2o1kAR9h3AY9dGsqT9W59plVxqyqNjpkeNw99MabLASF66h0Yxjb/uY7mf2ji1T2dzlDgdzMjdcTiFWofp1mH/pCnsUf8kSl2ttkNvaPcf7hqqArhRdYMEc4JAZiI2pzXBb/HGDveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950916; c=relaxed/simple;
	bh=hvrFO81+pVnW+NEL2v4vIIIsxTeZIjXLYpL46zMC0p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFY+sTgTcWOmsPhM1OuDIuZ/HSU5BHatLuOgMOAPZLIErB+dQ+rbEiIC2zpmWxNmwf3Dy/St8Eh1lgBQZb0UrhMkWNuK2MU5nifZBGyTUdmo3ZpNnxGUcQG916R9p3DFr1h4a/atvuGo55DX8h2xfkmop4uJSQ94TffcmV5z/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PqQLCcgt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PqQLCcgt"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-321c346ca4eso23807a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950914; x=1755555714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sOd2/5UzOQ6IPXWcksDo92rKHXDYOYJmHlu4KHuS/A=;
        b=PqQLCcgtOhgBgXL583LHhNumspV6JNXHclr5MiWJMYybAGHksUQfBjqRUZhbYZ4mEp
         PLgL6kLDIh8VljGHQ0RBDbyqWbqQ8yGeecO/CXnMA1vi8jgkspCQWpHQ5fDsxzTfENoq
         kE1+tLoiUqjqzKlO1TzhKj+ccWUQew0gGPVEsYLlQHLiuDFuKHV4f7lZn6nOINlE1Fce
         jyzSjUDWkbSzEibxreQaaDwhA9dEY2POcrn9eUa8rrJFAT1gO1thlcLYwE5oPfB2NwxN
         w8G1tEFAwHzGehbuYX6djOfORK46960jbqsYNgowErgk+8LoaZ0rAnk9UyJVOziwLdvQ
         eu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950914; x=1755555714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sOd2/5UzOQ6IPXWcksDo92rKHXDYOYJmHlu4KHuS/A=;
        b=lPHDNriklNXIYtAPqZmG19OK59JWv2XQRKPABhSoeoeaFeguguv/+LV/rxLK0XvwUz
         NgMIXjO3Jv+kKT1sz7Mr0SG934ZdhcPc7b9j9JcbyGYg0X7MKjztNyzwLBsv0TtxJTTc
         D4WSdpQNA/dUX2lB0xeERnmfxQAyeAJwBjMkSizWI7cMdhF9bRD3dTjhkQRN7iMvyK6V
         7gsZxmPdUFyJjr3uA/HeiQ+iRTpgca36jjvUlv+jr3MJsTTB9bbTotBFdmPJd34H4niY
         /nUMcwCoPFuehgVOgbQt5hfgOsZul2U3Fg843F97mJd7skH4Yq2X700z3zUAGdEd3utB
         EkCA==
X-Forwarded-Encrypted: i=1; AJvYcCXGnZc11sEgw+vbCDn6xDhCVVGNpnr20h9SZjhK1bwN0NUQT87wyACgru+7E8JUsNPHALhaX/EjbPlRWfhBMhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxLrf/FGU69yPqp236BbMHQcRLTNS2BGFW+fQbRVhjz4cE530
	szeHVWupEYKUbmf2Sf0Oj+Yf6/UaIqKbLrdBwiStYj3xSscEMFnJk2g+ADAl7bZZ22MjFFug4LK
	B1QWOLjeowDZGpcnM9ANuBZ7hTtlZgGib4flE521Q
X-Gm-Gg: ASbGncvX7FatPUxkt2klRs3paYqUeB4G3Z3JsHRmj0YeiE6OIZhq1eVqeY4Jgm9NWNl
	ImbR0LprtLJb/aPSF75fCVFExRO2oxaRsEHV6hQyS2TrHONsaBLTmxFU7qXruEsd5K7rnrQvJAO
	alHl6S48b8aP2OUXga/u4Nd7eBjJcMxlirx5zil2Wt5nPcq7qnIQcrlIgyc2IoqD3rtCKwNqpMU
	hBYbQhJl4szzu9tqw==
X-Google-Smtp-Source: AGHT+IFPaXyAxbIS4HmKhbNk97XTN257F8PCGf5lSpmuwdoJgBJgfIKi4jJsD4U4Iz3+Yi8t0egwHaNL/4nDwGR6FDU=
X-Received: by 2002:a17:90b:57cb:b0:321:1348:4438 with SMTP id
 98e67ed59e1d1-321c09e6d6emr1846309a91.7.1754950913981; Mon, 11 Aug 2025
 15:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev>
 <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com> <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
In-Reply-To: <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:21:42 -0400
X-Gm-Features: Ac12FXyOofUWjL9ue0ch1jrVS7OsL7RFzTzKQOtEO7nI3S9ASnQ926DM3VVX2v8
Message-ID: <CAHC9VhTxUqW+a4D6cHMutaB3z9dAMoebibiDp04NAPaA=36rsQ@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 3:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Jul 18, 2025 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@li=
nux.dev> wrote:
> > >
> > > strcpy() is deprecated; use strscpy() instead.
> > >
> > > Link: https://github.com/KSPP/linux/issues/88
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >  kernel/audit_tree.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > This looks fine to me, but as we are at -rc6 I'm going to hold off on
> > merging this until after the upcoming merge window.
>
> Merged into audit/dev-staging for testing, audit/dev will happen after
> merge window closes.

Merged into audit/dev, thanks!

--=20
paul-moore.com
