Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793877896;
	b=G5ExvP3uQ5+NZI92XmHzBmxhUDhWhH7cbXJ2uJF/DcpZfEefm4c7fMcOVhWuzJE/AAOk
	 Nbu2rw4Lh0RaNQ4yXq8wUKkwfv0VKlCf2MvKX9jgWgRp2ii4eCQCA3BYogV167UZ2z1As
	 GX7tR9gUrLijOuVwHwUB9y3YP1SSJbMgZ+4D8u5kCn+4eC2ExmbDTcqOpcP4UF+GeY6YG
	 evxq242G+D9zcccNsaWPgBpJqqjNIXWQbsSwotStWCA/LNEGtyXMYYqcaEC6ltNg92LYI
	 8xHctipG1ezyquGFhtn3bWFvYcOBl1iAeEugHrcg2KWI158J9YyNtLWZ1M75jCxERVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
	b=vJNeTjsaw0Y4WVvfZsXYb+oWYa4cHDmKR39iZizRYxFLMqLusY+w+KRk+QMCRfkXVuPt
	 1AgAlNAlgACsCa443M+RpnGlSmE8YKeqNG0oQI49mcIhWU+SxRzGbBmpESP1XGAj7QmHR
	 NkQNi4+pD7FkQFFOP+7+W5Gzjbk519jEChwbLXpL52E/fS3nzp11i9C5XmHeMxkNaJBOh
	 ZozskiMYt+MOXeCDF+sCuVZqTH2XQyh1EUZw+rKhiMYqXXeLaD5JpBUnKRYo36OwjerBu
	 qfjueG0/F/yGz3qjmdSUCzKAdzMc89ctfn+gGUkME1tjHX8q4xNTMWLyJGw0TyIcNAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCyRuxf0;
	arc=fail smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F868606A32D
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 11:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F868606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCyRuxf0
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4ced671398so269935366b.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 03:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877895; cv=none;
        d=google.com; s=arc-20260327;
        b=WzCiFUIqSm6WxD4QA2JDDezOTQ1qLO/JUSwDDfIMn69EnDmhMHVWY6l/WNIlR/1Wv7
         KLqm6jgutCNlc4Qs9ESavMZZSN30hTbarWbv9NogHxh9k1SYsCIE4bBTR3CZPnMuP4AD
         TNkoeU18sD9vn4aguU+WbcFWGkO5KuBzCFZf8cdQFtcfjmRG5WQEIAC1kuI1xNc4Xpp3
         0FCQRIAEvFG4MfzIxm9CAsIIb8zKA/lqEProZk9RytgHgQpqtz95aOwWcfqmOIHy1fpg
         +8+rDWiyFsTzBsbtUkTU5+YT8kIHzW3cvAXCUdEkl3IkjEDVrUcrGI3unlgiVbLH46BX
         AKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
        fh=Cv1bz4M0fEOcsRv8TKDFLhNcSBl4de4YtyG2w+cDeAo=;
        b=kzHDF9aazBvmSmcy+Pw/Qz7VPlrjEY1XUbVrCUy5UyJMFN+xwXFi+rumzYP43Md/Gk
         WduxspPqMtGDYsm8rTOarrcOaOUJoNrjFXSeMkZIvlbNMqW0q15xZd6FplOggOKiu0dc
         +oWIrAQpjzF+6lEkeqCrjPUjJlB4Z04XxrSCx4UHBKI+OEPkoc7LHjxZBSrzyBhRpr5L
         j5jYfZR9NkKtbxPjP+SdYI3HGgAgtoDPbQjcy9ePVqhreHdy2mpT9Jl0UJqrPDNg17Tx
         BB4pqlcthIk/ClXCCXUU9yUqURxRGcE2rXXI2s7FZx7wWkLaknCcLwR+E6iXrcqrkQAs
         oeOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793877895; x=1794482695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
        b=CCyRuxf0P6J6k8bWApFVRzmmmQ4a3nezFhlH23PgLEzGEftofIdTYht54rkMPSxqZ2
         /N6dWyeLvZ3t5ckDi74aRNo2yvUplMuzeF87p+SrRLFswIheQK11EAMfgONQoUmsEnEe
         ak3lTmUJPNYDs7n+W3y+FrnQqNLfaVlgsCS7/AoEJSXFGJS/uoo6dTu0piEUOcSwoNXy
         qSQc4qOwI5/lBCfCziXhsnKcQriiZn1/LpLXFBVGVCBa5Nm1lMvs3nCLwfOv1t+ObDwv
         66A1hJWg9khNx60mm6v/I6sK000uQTULOFdYaXulbZrAc/k9t8/TzBP4LYJIO4G33uyO
         snLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877895; x=1794482695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
        b=WgbOoDlD5RDPpkEijNgBJNBowT+g3wqiABV6r+SMpK5qPGwCuHjOI5M8S4S8xIl5Iv
         k6xFcgmIhbTqGCIzOF+MUWqZClsEAplrpB2H86BScqtvB4CxOrkOjafxEquiYho8/UUR
         n4TezDxgc0ooodfIEd7VTQsmRYcrQzTEMu9C7WiVGQSDMhhkflgHx047lRpmSK3nZ7Zu
         8eb7bCfdeA5IZrTRI+cCX+751NSFW6qjGSTKuCvDAUMlYC9R/FtFQFc8dX3AVLUAz6In
         AR7pO/8VN+KgFmPyLXkYKk9QP9A+w99r5RoAhCCngL3hu9FPUM0H0bcBIus49q+ugtDS
         gZOg==
X-Gm-Message-State: APuU4Z/j35JdoARFVaZAYOLG6KT/SfDvRfCjJj/l678xwMwrUH2q3pKx
	l3FadRmAn67WiX7DusElSi09rClx0pbUqzFEzTojsK0UoBiqP/dYswDsP6zGK/NwryfAcTa2vVt
	KGKxKBSxkkWY9famhPAAtleOQKh6v5uk=
X-Gm-Gg: AYBFou3Rn3G1+HutICharAVrS+gY1kphe2Q7swEY9t0XZcwyNpYJ299tpTzJqNbHtbI
	mdYI5PxF65BB0ZiQPZSZjrZfYbm01JL25O/KYBkWKtNiCyju3XOevLZK9P0VJYy0XGfE7mAi54O
	ViFzuDPLHVmykd4hYkk9Ixp1qlYf3VEGeCJYxjB7hCdzf/mKTINJtH6jlw1t2ZlXIa55PcBdEDf
	l7V3zBLawp/W64NqZP+MHztzL08OViSqxT3oA6q4fMrL9BaHXf7YF7X94Gvn72iULe2+/DivXQD
	KXjDUsVQyUQiiGJ2/RWQz+XiXQzpQWW8kDwmL5UZr7ppMOP7q4dJqSI7zTY8g2EBaQ1AwHBcatF
	ZlqdGEx7+YD+EwwVHRBCs33B4XPNoEuMIBNRb3sWElUL+Cr36Nd8niULUQuUoZUM0h2+E/TOzTD
	IVr2L8deYGlOj8fbCo4stISW7cHmIxCGfgoDSM/MfrwRegUiMc09OTHPEpEVvakzC6SYrM4yu35
	pWVbYpHM2K/oDy+YQ2XxkbTCF3xoibNFTWlHYifkR5BP3FxsGg6do2EXu7SCA==
X-Received: by 2002:a17:907:6d20:b0:c46:75e7:25af with SMTP id
 a640c23a62f3a-c4ca7a0dcb0mr1704269766b.11.1793877894389; Thu, 05 Nov 2026
 03:24:54 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org>
In-Reply-To: <cover.1793876837.git.alx@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2026 13:24:18 +0200
X-Gm-Features: AclHuK8KWMbqNnaK7YSgn2BAcqklpjMSStieDr0-B_LC0DeuPxzb2lhrGJOckGM
Message-ID: <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> str_has_prefix() is based on sizes and lengths, which means it must
> overload the valid length 0 to mean not found.  This is a typical
> consequence of choosing to design an API around sizes and lengths, and
> vanishes when moving to pointer-based similar APIs.
>
> This patch set adds strprefix(), deprecates str_has_prefix(), and uses
> strprefix() in one place to fix a bug reported by Bartosz.
>
> We can later work on replacing the other uses of str_has_prefix(), which
> might hide similar bugs.
>
> Testing
> ~~~~~~~
>
> I've built this patch set with 'allmodconfig'.  I've not run the
> resulting kernel, though.

No, all lib/ new code should be accompanied with new (Kunit) test
cases. Update the respective lib/tests/* for that or if not yet
converted to Kunit something in lib/*test*.c

--=20
With Best Regards,
Andy Shevchenko
