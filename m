Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C873C6A0
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfBu+55B"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6141F10A
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:48:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so10067729a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696974500; x=1697579300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVwIjs7unBVw8/RUbtCg7Be4ufWML8Z8whIdGG4oG9s=;
        b=gfBu+55BcotZ9nxQs/vpg/tvOKCO6Qy/8Qck1grOA3kV1jVCfmvPbGBzKfWJ9Yf94U
         yElSDhorEwPyf7aTF/FZTE6e9gq4uC8DmHnTFoRuSaRajRVpGwmG8xSC1bzbUt15zo2Y
         P+Izz/bZQNonkKVvWPn3Q4nLcwFFCJd68OY2Rbx58fvJpEV0OYs2jUYN4+gE4TMoykn8
         7u2AVO1M5D4QZ1bVOLQG048maxHLgekwBeNUqu4e2XnAoyhHy4dzEThMGn073UHYvX7Q
         bCUii4zeqdA2+p95zbO/ZCpkotAMFga9TEnPvvJ+mTcH5eqomH5+tuMcy0n/s4q9gHO8
         mnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974500; x=1697579300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVwIjs7unBVw8/RUbtCg7Be4ufWML8Z8whIdGG4oG9s=;
        b=I3fnFw7TLiaZL3uS5PnOMmC0eVv/WsWlRhxFI8SHqtdiWOSMXQjjFk0TsTZ4ZsAfy2
         UVeFkUekEqtIAEFA0fNSvQDwNyXInjhY7FiEeOPZpDCRJwrZHoh8xoQVOKK5l/8Syv5c
         atcu0bQAKT0TMVZeuOYd8rbCt7+hNAvxDAFVrwVY+0orycpV7FmzvxYbLKEehSrC34px
         5hYuh1qoApvz1Qd91TPv5sEqB6qlI3r4fqLmYrtOm61SYg+dfaBfqBZwBEcQDExTbuuR
         YJe7YmILPzy5AaAtOW4o2gGBK8w9nMs93xcz8pSa9QvdJXy67Xd3kS+No3+HkylE4E+X
         jHBA==
X-Gm-Message-State: AOJu0YyuR+rOdw3usmvRn90THxPJnoFpi1JjK1GhqveMwPrKCcDet/gc
	c6DvmKeCOSImRUa1U2niC0rVgWyCdkdPr8NUuV+uGw==
X-Google-Smtp-Source: AGHT+IF+KRH5q46pClmuL2EdllDJ0iDb6ACAaOvuq0QwzJ/11pHZFU3ZxAHhhmD6Z6wDNukpEDq7XV+Afz6j7h6C0I0=
X-Received: by 2002:a50:ef0b:0:b0:52f:b00a:99be with SMTP id
 m11-20020a50ef0b000000b0052fb00a99bemr17506693eds.33.1696974499699; Tue, 10
 Oct 2023 14:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
 <20231010110717.cw5sqxm5mlzyi2rq@skbuf> <CAFhGd8pgGij4BXNzrB5fqk_2CNPDBTgf-3nN0i6cJak6vye_bA@mail.gmail.com>
In-Reply-To: <CAFhGd8pgGij4BXNzrB5fqk_2CNPDBTgf-3nN0i6cJak6vye_bA@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 10 Oct 2023 14:48:07 -0700
Message-ID: <CAFhGd8oriABD+Vob3pwXi3fQ7W3XOzp8a48mX_TYxJHDW+aBuA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:36=E2=80=AFAM Justin Stitt <justinstitt@google.c=
om> wrote:
>
> On Tue, Oct 10, 2023 at 4:07=E2=80=AFAM Vladimir Oltean <olteanv@gmail.co=
m> wrote:
> >
> > Hello Justin,
> >
> > On Mon, Oct 09, 2023 at 10:43:59PM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings
> > > [1] and as such we should prefer more robust and less ambiguous strin=
g
> > > interfaces.
> > >
> > > ethtool_sprintf() is designed specifically for get_strings() usage.
> > > Let's replace strncpy in favor of this more robust and easier to
> > > understand interface.
> > >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strncpy-on-nul-terminated-strings [1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.=
en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Note: build-tested only.
> > > ---
> > >  drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/re=
altek/rtl8365mb.c
> > > index 41ea3b5a42b1..d171c18dd354 100644
> > > --- a/drivers/net/dsa/realtek/rtl8365mb.c
> > > +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> > > @@ -1303,8 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_sw=
itch *ds, int port, u32 stringset
> > >
> > >       for (i =3D 0; i < RTL8365MB_MIB_END; i++) {
> > >               struct rtl8365mb_mib_counter *mib =3D &rtl8365mb_mib_co=
unters[i];
> > > -
> > > -             strncpy(data + i * ETH_GSTRING_LEN, mib->name, ETH_GSTR=
ING_LEN);
> > > +             ethtool_sprintf(&data, "%s", mib->name);
> >
> > Is there any particular reason why you opted for the "%s" printf format
> > specifier when you could have simply given mib->name as the single
> > argument? This comment applies to all the ethtool_sprintf() patches
> > you've submitted.
>
> Yeah, it causes a -Wformat-security warning for me. I briefly mentioned i=
t
> in one of my first patches like this [1].

For more context, here's some warnings in the wild:
https://lore.kernel.org/netdev/20231003183603.3887546-3-jesse.brandeburg@in=
tel.com/

>
> [1]: https://lore.kernel.org/all/20231005-strncpy-drivers-net-dsa-lan9303=
-core-c-v2-1-feb452a532db@google.com/
