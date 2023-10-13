Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6C24203
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djcfVWzg"
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D4BB7
	for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 12:54:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so3863751a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Oct 2023 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697226846; x=1697831646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nr5rTcvx3Bqes76zmwwUrfRUqUSHDocyP1SazHWr+w=;
        b=djcfVWzgXcmHpwjkTng5NwzHLhHeTcuTOg1UE7SXquOkVesAbN5DsrQrmETYpVO2YV
         /ctBV5PnIvsdRvRIZQ+A/1fVqDDaJMc0lzQjazR8+jZ+CDNtV+yuXsyu7D9G1U9YHmyA
         kt8orGquHe2FZ7kRPACc9elns1cBPpIsTlYoVWIMgkyHcM57GNmzXjDoXcG5pWzjWixA
         siIMHUvWpcw3KvXjXsR68OgtTW5QJsm0pdjPA891TmLajS+fOYVT5M5Bz7DdbcLJux9G
         1pNfngINuldZ08In7wISM0WVReHGRnrUUBkGlRQ0WbIzV0E1wYWia1Q+y8kbKpnrCfQV
         vWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226846; x=1697831646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nr5rTcvx3Bqes76zmwwUrfRUqUSHDocyP1SazHWr+w=;
        b=f5+GMJyarxLjk3Ei/NP80scO7ODa/MxdD3yiWauc4z46aydvqrR6eHkOaDpoBVHmnE
         9yj67mY0/BKbYT0GwGM57bBrvI0QHfMF6PxrXJY2eMGf2BAGK/QDcY3tLz9R6qodf6X8
         gy3p7FfD+8a7IjGd+n7gHAxc1ERQkGg84UsAq8zsQet0zDEoItHF1L7T//0h32rFT+Gr
         Jd8UeLrrHjiasGD66yNXKVAF9pOGD8Bjl4aq7znHDnEBQsxWdGuUQ7cs6BMlG3Y0bDA/
         2XN7La6igT7e+77lARRMJixszhPeaok5Giy849FIfL6Hu61h6DG+nEvjhVF5I3/6s8pV
         v9ew==
X-Gm-Message-State: AOJu0YzwQsqjL0qDb8GbqGKgWVWQfyaFVDALDrij0IG64I4nPh84gDAz
	a+mzlz9EkXEgGC0DyXj7XeG7HG8u3EA3+qU/UhGpm0i9ikupCT6odeEePEXM
X-Google-Smtp-Source: AGHT+IEmQdB6jTOkef10X9umxYczo2MAno9vooZhhnlm41Ql4LMTSfvVX0/maWT0UikblvZ6Cn/oh+PSpaj7EXAV2fs=
X-Received: by 2002:a50:c8cd:0:b0:53e:21f6:d784 with SMTP id
 k13-20020a50c8cd000000b0053e21f6d784mr4099063edh.8.1697226845814; Fri, 13 Oct
 2023 12:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
In-Reply-To: <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 13 Oct 2023 12:53:53 -0700
Message-ID: <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 5:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > -     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > -             strncpy(data + i * ETH_GSTRING_LEN,
> > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > -     }
> > +     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
> >  }
>
> I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> be trusted as a format string? Is this indicating we need an
> ethtool_puts() ?

Indeed, it would trigger a -Wformat-security warning.

An ethtool_puts() would be useful for this situation.

>
>         Andrew
