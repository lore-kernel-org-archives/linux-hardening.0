Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZWfVsi0"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E52E9
	for <linux-hardening@vger.kernel.org>; Mon, 11 Dec 2023 11:11:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so6749742a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 11 Dec 2023 11:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702321898; x=1702926698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53+GQ9DSChkfFqfGSXLQ0QMyql+oTK4NA8OXD5BIsZM=;
        b=aZWfVsi0nhc27jgWVTLOn5u5JI7n/FejXbGaYxrlG9ZYP57iGMBuWw/3c+6ABQFN0t
         /IIap0t111JzD/rBOv574CoJefv9C4xr8851F9HnUkwWVjUmTAwmFx2GiYCtyqw01iPN
         1yaEqSA5Fr5cxOf0XOJ2QqlDYbutU+J2+IZkGocCN37wwRwB/bJQoXVf3bGixpPidEQz
         PugIscb+bt7JblMgLidAqvJ5QB3veg9Xui3L8wo51+zgEfdzKZtIw/m5OsMKUkDL0eRD
         ni3eOEFGGQnAnaN42P9hEodtgq+jPjnZXKH3yTewWCskzh8NPLed0HfDJP/AGD5UUNhm
         RBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321898; x=1702926698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53+GQ9DSChkfFqfGSXLQ0QMyql+oTK4NA8OXD5BIsZM=;
        b=mcc3D10nTYtXSi52x312MfxyfrlHLzvrCod9YvZbhQdkzSEAlhJoSsQV8Zve7nDj+i
         kai5nq2js8wyDQFF5JCxAYLCZ7laYdG79b06pX78Kas6o7SRH+Ld7Pa3tddB1WjbEm4/
         BHL+mHdD4HvSigWavZ22Ix3ScxbftpL+XpuA8BK3mUs4Z8pw6L3Phb3rXRdmqS0FOzYi
         tkDGRSr5PFYH5hZYpgCyZlzSJDectXdHvw8q5nIb1pMxOaJtx0gc5UuAUCWgaxXIvkuM
         75Jx1Gapf4uZjyZ5Vp3w0GnKZxO1ROmppLY0LDQAEMuZZv29Rc60nHPcX+0QFNrWp2Aa
         Nmpg==
X-Gm-Message-State: AOJu0Yw1EL3hqCYKuJ4f92aLkWXimmjL97CVhZWch2uUA47CHjkDCauJ
	kEds/ncTPPlWxNIsP4VsJ8PmvRBkivkIzglLMQ+m8g==
X-Google-Smtp-Source: AGHT+IFvmTrqFmb3KMd/5xiFQbhGpELJ/arHQLgqbMwaN7GGJJxxJmDMIqQ2CDnleZexNcIu6ZMsfzm7/A6/dIyFIGQ=
X-Received: by 2002:a17:906:c141:b0:a12:7a14:5355 with SMTP id
 dp1-20020a170906c14100b00a127a145355mr1440878ejc.39.1702321897853; Mon, 11
 Dec 2023 11:11:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207-strncpy-drivers-net-mdio-mdio-gpio-c-v2-1-c28d52dd3dfe@google.com>
 <ZXJNwrcSfgUFhaz6@shell.armlinux.org.uk>
In-Reply-To: <ZXJNwrcSfgUFhaz6@shell.armlinux.org.uk>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 11 Dec 2023 11:11:25 -0800
Message-ID: <CAFhGd8r1t8Gs5_idKiLqWL8Aicj1A_hTuqvO0075TP23rvjxJg@mail.gmail.com>
Subject: Re: [PATCH v2] net: mdio-gpio: replace deprecated strncpy with strscpy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:57=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 07, 2023 at 09:54:31PM +0000, Justin Stitt wrote:
> > We expect new_bus->id to be NUL-terminated but not NUL-padded based on
> > its prior assignment through snprintf:
> > |       snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id);
> >
> > We can also use sizeof() instead of a length macro as this more closely
> > ties the maximum buffer size to the destination buffer.
>
> Honestly, this looks machine generated and unreviewed by the submitter,
> because...
>

Not machine generated.

Was just trying to keep my change as small as possible towards the
goal of replacing strncpy.

However, you're right. It's literally the line right above it and now
it looks inconsistent .

> >       if (bus_id !=3D -1)
> >               snprintf(new_bus->id, MII_BUS_ID_SIZE, "gpio-%x", bus_id)=
;
> >       else
> > -             strncpy(new_bus->id, "gpio", MII_BUS_ID_SIZE);
> > +             strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
>
> If there is an argument for not using MII_BUS_ID_SIZE in one place,
> then the very same argument applies to snprintf(). If one place
> changes the other also needs to be changed.
>

Gotcha, I've sent a [v3].

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

[v3]: https://lore.kernel.org/all/20231211-strncpy-drivers-net-mdio-mdio-gp=
io-c-v3-1-76dea53a1a52@google.com/

Thanks
Justin
