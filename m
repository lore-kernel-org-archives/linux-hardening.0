Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMeoIOB5"
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7DA5
	for <linux-hardening@vger.kernel.org>; Thu,  7 Dec 2023 11:51:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a06e59384b6so178570366b.1
        for <linux-hardening@vger.kernel.org>; Thu, 07 Dec 2023 11:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701978690; x=1702583490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyNxMC5UaWA8P1oAZwMgXZGctvwxcnYFcLUj2/+v4A4=;
        b=sMeoIOB5zF8VMBBfBEWvh0cLeRB+50UV9taV/QDpYmqujSA9LYTaOO/5TPsPq9ZFY3
         CIfT0BAwYLrD3IUNCpNgUQaQ/MwCDGupoWz4ICeTNr38J4ujtAVf7+UXWkeWlbIBVZhO
         v0TESlTagtGV6ZdCroVkobHBea9Sy+SuygbS8V1gzylltOxGLsbE1TKq2GH92xccvf+7
         sas/szFF5Rx4anesbQEbnZ/dWQ72huVherJpuTgVe+yzW5SaIJqX1KdLUoSO8MsNq1yC
         OUSPVjhFgruiUL1lfO/ZkbD/GVCcz45ni2TEp/HliCKSrVxvt0Uk7pjGkOY1paZ7b6is
         gw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978690; x=1702583490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyNxMC5UaWA8P1oAZwMgXZGctvwxcnYFcLUj2/+v4A4=;
        b=aZL6IcuKNurbnP5FtKoKlhyTWFin8tFqV6AJPdl6Gh+ddeOSYQV7Rv5Ci11TyG3T5I
         fNIOx1UKyZsyhdH8smkSjimmc3mDaCjvWxol9XZ8ivkFD22vJotCfn2h2kPF/4xzlcpJ
         H+dbIXB0sh8rEW3Lq9CgiKtXud7QSNN0ghZyeSrQwa4LvwMEO6CDU3JOMV4hnFCKPDu5
         FUaJlUq1YcaEjMsCKPOycFWvFV5PS4bqifYktPmAvt7OroF2RmKmsYe5T7YnhmGhxE/S
         vXdNanxYdoI4hhE9YAWBhAZH0C2qjkr32G5y4nt1ge96JPHYk91F5p3vWmtyPc0Clqdf
         hjag==
X-Gm-Message-State: AOJu0Yweowq00JF6vvoAFsBkGXlto0pIfZLTZzAFvNoJ/14kdoNuqjKE
	PhrmCnSaKjiFYGt37XF0EqTnPDadCxmutqwWEiCUyA==
X-Google-Smtp-Source: AGHT+IHn6Gpxs0pG2yGvus7gTfzV0S7QzvF4q0Z2d5XIfpkMDbFezPPz4AmGj5WO8CtAkKxxm4NQ+Hh/9bolotTv8wE=
X-Received: by 2002:a17:906:f2cf:b0:a1b:e80a:b68 with SMTP id
 gz15-20020a170906f2cf00b00a1be80a0b68mr1854717ejb.143.1701978690497; Thu, 07
 Dec 2023 11:51:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v2-1-feb452a532db@google.com>
 <170138159609.3648803.17052375712894034660.b4-ty@chromium.org>
 <20231130224021.41d1d453@kernel.org> <202312011018.478B0E750@keescook>
In-Reply-To: <202312011018.478B0E750@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 7 Dec 2023 11:51:18 -0800
Message-ID: <CAFhGd8pT=QoTaPAzH+NPzu=i1i9oX_7wcP6X1_aDDTJ0vUssmQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_strings()
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 10:19=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Nov 30, 2023 at 10:40:21PM -0800, Jakub Kicinski wrote:
> > On Thu, 30 Nov 2023 13:59:58 -0800 Kees Cook wrote:
> > > Applied to for-next/hardening, thanks!
> > >
> > > [1/1] net: dsa: lan9303: use ethtool_sprintf() for lan9303_get_string=
s()
> > >       https://git.kernel.org/kees/c/f1c7720549bf
> >
> > Please drop this, it got changes requested on our end because
> > I figured Alexander's comment is worth addressing.
>
> Done. Justin, can you please refresh this patch (or, actually, make sure
> the ethtool_puts() series lands?)

Yeah, let's let this patch die. The ethtool_puts() is on v5 and is
getting good reviewed-by's. I suspect it
will be in soon. Then I'll double back and do right by the intent of this p=
atch.

>
> --
> Kees Cook

Justin
