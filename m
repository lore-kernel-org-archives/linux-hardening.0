Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97CB42907
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+iFmLSR"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059D114
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 14:17:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so12552452a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697663829; x=1698268629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmzWNRuuuMHLesQTgLE+SaWMDv+DrXY0BM9GFaIRAmU=;
        b=e+iFmLSRPde5OBfeeGguRNuxFKBq6QS1RO3O923Ks4FdwIsgfvga0zkp1A75T0UXGP
         V78GjbrZ1TLlEY7bJWBOi73ia6Se/54+kRlSM8U1KUmFOh7QHap+JrMP7lWCaZn5lJVg
         lmTOuNpGkaP+y0KZ4Lp+4IXShw7Yb+yiZGqlfNbwwd8O3ZYL296tb1qmJaIWeG20mJp0
         3JnRf/RGEJ4XecGoTZJWvtJifAnJj4j8gXOmZ+SqQ5DRBoA06Hgy6VabvyElKk1hotgZ
         cAtUnB+HDn2v53Qf9NFpdTXz7rkNuNk5ZO/QZPh2jjIQ04HMxZtOEzb+8P5SuKfpdq9T
         pSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663829; x=1698268629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmzWNRuuuMHLesQTgLE+SaWMDv+DrXY0BM9GFaIRAmU=;
        b=FbpvuU/QsiRSHe2dSDCR76l2SUo5ZC0snxF3GimWE81A3/917/0OICI3Cz8rR9DWW2
         i6k/tHK6spv9iLYo+oHaBu8mGvIb+AlH1xcg8bgJET7kIw7XBMfTAvbZiKO2kuwfyEYz
         caSaoDu1UfFDO2zeck8XRXobqTtkx+yaGq1mNaN8fFLJBiMUi7GldzGhuRN59y7wwfq5
         V/e9pIv2THzuAi4h8R1wL5fNX4s/+2SWsOAQRZ3w9NlC5jF5BVYmlHT2lzHzC1qM5pV3
         pQSqyY18Gvw3sXWTQ9HFe5AWmOMB377tfEJOC8/d6OjnkHv5ZnWyuqJgqU5WiUmOdx5Y
         Ft4A==
X-Gm-Message-State: AOJu0Yw1zqNMIX7Lk7uohfT0Psv81z2KAJVBcBlCkqbcPCcF0l4IyMBc
	umdd9zOgwgleKjzwCTkVtEyR7YSdmiOimZHEGlk6gA==
X-Google-Smtp-Source: AGHT+IF6zjERAyTclhi1slQ6zRPCjIhAEdwhb3O6LQNCCsuTO+W6R8ZELmUgrESCNkBRM9HEiVaaSPyHU1ysa4KHxvg=
X-Received: by 2002:a05:6402:520a:b0:53e:8972:1d4f with SMTP id
 s10-20020a056402520a00b0053e89721d4fmr158614edd.5.1697663828986; Wed, 18 Oct
 2023 14:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-ti-wl1251-main-c-v1-1-3a5c02382e35@google.com>
 <68fba283-aff8-4751-a4df-78843d89ef13@quicinc.com>
In-Reply-To: <68fba283-aff8-4751-a4df-78843d89ef13@quicinc.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 18 Oct 2023 14:16:57 -0700
Message-ID: <CAFhGd8pTPkY+8=cFf9ys7vfRrzTJsh0rvnKJwDGaWvq3s=MEvg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: replace deprecated strncpy with strscpy
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 4:46=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 10/17/2023 4:30 PM, Justin Stitt wrote:
> ...
>
> > diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wirele=
ss/ti/wl1251/main.c
> > index eded284af600..cd9a41f59f32 100644
> > --- a/drivers/net/wireless/ti/wl1251/main.c
> > +++ b/drivers/net/wireless/ti/wl1251/main.c
>
> wrong subject for this path. unfortunately for you the most recent
> changes to this file have been in conjunction with mac80211 changes and
> hence why you see that prefix. But for a stand-alone driver patch the
> correct prefix should be wifi: wl1251:
>

Ah, I see. I fixed it in [v2].

[v2]: https://lore.kernel.org/r/20231018-strncpy-drivers-net-wireless-ti-wl=
1251-main-c-v2-1-67b63dfcb1b8@google.com

Thanks!

Justin
