Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED673F9D2
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196928; cv=none; b=rzreUAVlfmFvOmY2+MCsZKbdxo+vdhROv5mZQfPksLqcXUK7N3YxutfOPCGyUvsVZcert0KYfozG4BZZUH/sZxc+O7WtMih2ERW2oAs0J474VjcIn200vHlswNELRYsxxuyEBVZWgEuufznzfg4nDVolM+fX66sW+aA9cryUEt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196928; c=relaxed/simple;
	bh=CgUyHWN9fMo0ms6nVGa5eGHVou1r5jqG5X85F2ZTKfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUPOgWTCo/oam5ejY2erzlA73lFlG1CbV8kYoruyZDl09ze+vplU4Tm+hUFcwb6OJac4Fuyz5N1ttpfTxBDID8T+k+8F7TUfOQhHffZ/2URKX+luzSL92SCOc3zg+sR/rCPJi4SzbloV4LJNKT/UxFzYqfWnJokW0kLZbFLA7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Icj926Gd; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Icj926Gd"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so4216668276.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Dec 2024 19:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733196926; x=1733801726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjuEEmIiHIfKgwffllPV2dOWbz+SOO+5ThfDHPOLuNY=;
        b=Icj926GdiqIX6WhsHWYKwxJ8aHRtK4JxS4v/QHVzDJrLh828dwPRklQohIPRV4dJmP
         65g8D6nM3pqKA9/OPBNkBIg5vJwnT56gREZd1lXSSbMKE3MU9e/gbeNkizeoBrVc3P9k
         9gUi7FPRdtStanOe4nJgslurosK4yXhHqFXk7fdp+p2TmPLm5sc/aA8c/Jz6nBaFWdtA
         RwPXj+00eT/FNsvfmTqJDqakxbTqxLqIQRg7AOs0YmlkIBR3UbLosGPYYOfe42upG8vR
         t0DDqIZ5UtBBqtojs3XIFgOGWIBmb1ELtNADbfHFTWVrC7+h+TKEHoUqSLkJTFo3zk0/
         R+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196926; x=1733801726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjuEEmIiHIfKgwffllPV2dOWbz+SOO+5ThfDHPOLuNY=;
        b=bDwcVnaptKAId8LwRgF0/8j5YbhpZ9bZ8Q+Z1dR0VFvzVIk175BFZGmcL+W69K64bZ
         TE6L1VuhaL0vfeTCA9nuRXr55rzX864BL6FvYcSC7dTo9GMRxooTXKLjt1kTPYSwmzbl
         +rvaZXNawiTzMheHBk+Q/fpT8bKTJA1lzZnXRRgzftN8DX9v9Api8V4JqyPe6Lum4syC
         Zw0eGWDXfpYFehqOkIg3amHO+1AMBSa8mBgFZ/zIErP/OR5m/r+HGRuLT6MBntAaF8t2
         cPiXoH78cnY24Y1wjtdbbsjM1Hsel2pCJ+THnkmTjQdMC8cDT++HdY5IhdtTJpkt3UYn
         X8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEXwtZxPbzDpMH/kjx3voM/ejc1DF/XDwodMlzNg3SrHyh7W6u8v1KpHDG6bL6GStEqMS40RNlzUVD40a6nF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYdhUw6Sz0XvXSQH48jmMEfSezLu6BEkRNEK6SXxIrt/qIMvB
	OprXA0/oBjaSPcd7MRw744DjJO3GZhdlRHnXi6+bYczgFhG/3RhiW6Kz3iq5PwbHIjamL5+TJ4t
	9lNmSGKpLIKvH1+AG8bX9zRVrpTQ4bckZmW46
X-Gm-Gg: ASbGncuiQWrXJzbb6Um2j92vs1F9waz+QEXv8ApgJjC+trb8uyCn72b9WCO8zOoaVes
	CgQG9ARyc2UTAxv5zZrtceWjJGJlHJg==
X-Google-Smtp-Source: AGHT+IE57rb2m5MDdGUH+Zu0NffgQIJIiNp21IxNkbX5g7ZXkEbTIw0Uaoz24x6px0LNVf7q0Pbg/UcCuDBHNtYk9yk=
X-Received: by 2002:a05:6902:2b86:b0:e39:852f:e7b0 with SMTP id
 3f1490d57ef6-e39d3a290f0mr1444254276.13.1733196925963; Mon, 02 Dec 2024
 19:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR11MB713438072B901F890913803F89362@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB713438072B901F890913803F89362@CY8PR11MB7134.namprd11.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Dec 2024 22:35:15 -0500
Message-ID: <CAHC9VhR6t_LLB5nc=kqqE5FpN4ftxZYidQ8F5x1Lzowf1H9juw@mail.gmail.com>
Subject: Re: v6.13-rc1 build errors from kernel/auditsc.c
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Kees Cook <keescook@chromium.org>, 
	Yafang Shao <laoar.shao@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:19=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> Hi,
>
> I got the following build errors from kernel/auditsc.c file.
>
> The GCC version      : 7.5.0
> Kernel version         : v6.13-rc1
> The bisect commit : 286d7a54c8a2 ("auditsc: replace memcpy() with strscpy=
()")

Unfortunately this is a known GCC bug, see the lore link below.  Kees,
Yafang, do you have any more information or compiler-based workarounds
for this bug?

https://lore.kernel.org/all/CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpWX3Zk=
VtvQ@mail.gmail.com/

> Build error logs:
>
>                  from kernel/auditsc.c:37:
> In function =E2=80=98sized_strscpy=E2=80=99,
>     inlined from =E2=80=98__audit_ptrace=E2=80=99 at kernel/auditsc.c:273=
2:2:
> ./include/linux/fortify-string.h:293:3: error: call to =E2=80=98__write_o=
verflow=E2=80=99 declared with attribute error: detected write beyond size =
of object (1st parameter)
>    __write_overflow();
>    ^~~~~~~~~~~~~~~~~~
> In function =E2=80=98sized_strscpy=E2=80=99,
>     inlined from =E2=80=98audit_signal_info_syscall=E2=80=99 at kernel/au=
ditsc.c:2759:3:
> ./include/linux/fortify-string.h:293:3: error: call to =E2=80=98__write_o=
verflow=E2=80=99 declared with attribute error: detected write beyond size =
of object (1st parameter)
>    __write_overflow();
>    ^~~~~~~~~~~~~~~~~~

--=20
paul-moore.com
