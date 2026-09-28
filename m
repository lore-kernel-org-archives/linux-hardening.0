Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573ED501F49
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632866; cv=pass; b=A3T7/a4e1EfMoHQTe8PIZSv/KodKSCLpgkDfXdmedZS1gIr8VvXajJsuhOzIl+nYTc69jIWOt7ivm39lKFSWYBrbjsnk8KLWG5eQ6YJXz/6HMWHyEQHzstL8HDjG524QsJ87lPgte+P+Qx8SdjTdsIm9iLNhLCCOU79tCHrpPzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632866; c=relaxed/simple;
	bh=TGsgu118fb0aWZcIW4jWQUOTUObcVcSpLFpjYKBcXDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st0M7/dTGuXG0t/yefau6mvZnz3oOsUAHD2cNZ4lakqkxw5AwtGm6rTpAYxXwNhMGNTBrojytiC9a13EC3YvhGdf+pAjzthCZlDZMaB68GT0CwQbmjZ+oeIDrNM0L8mAQFC951/8V/B0OYUFQ1pq4khUwFYg51ii4Wy86d+Nyf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJ6iIMM/; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJ6iIMM/"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b2d5062bcaso1482074137.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 15:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790632863; cv=none;
        d=google.com; s=arc-20260327;
        b=e3ijxsIBZogAQIqxw7bai8jQHtLkxoN7xr833hH52QWU3D9CLcoAMEs5MWKCs6t7/J
         tjQcdPGtMMoO4zSmQ6pVwGpA0AYfmt877+ZU9/z/S5/Vdspw6h0zN43R//T3N96tLSy+
         5lEegA/3CTQlU9mDaf2OyG4/YUMpe4wCYkc+4/IRWetPlh8LDsM/DismmK5VD0OVRKCN
         aqnbG1g2JWnYAbbo5Ct5gzV4Hi8kesjqaZtVXElrhLy5/M9t1i/xxOEiGzDyhLuAAgnb
         gKXDj9sxdBZdk5UKSd5DqriaYqOXZW3j4j91Q21uxN+9QGKh9n1jS55MMM5RN1ItbjRZ
         5ENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IIbizLL1IW50D5D/SYfMtdqVqG9t1BZagIkpl9KdDG8=;
        fh=J0aNEcSsUWiTfodDgknGmEFoxZ8/18LqDlv42HXH7DA=;
        b=ZkANvlQoT+gBuU0oU56TwdooSe2FaOyI+I7u5Bm90PhmSo01YQ6y/HyHSTVlhA8R6O
         Q93jv8/z2aunKEQXFqPrOzf6evS1uI+YgGOPn54rFEdoe43Y228gsGKMcbOxaSa57MFF
         Ln90fjvyxlFIQ5gdo689vNB8opoLvv2YmmnFstXwqrRrDW2KOha1biv1pcRt+c5Bi0Cy
         sAMqncK50ewk5zv1dCjgR84vOKwRqST5dFhj+rmP2XmgdzjfDkmQOgBw0gOV/4ZK3Vl7
         eZag1NvU6dtVBEmvvZai84b7Trwm0qp7UAP7ck6xtPwa8DwV0i18byZdscmBLR1nvYBn
         Ke7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790632863; x=1791237663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIbizLL1IW50D5D/SYfMtdqVqG9t1BZagIkpl9KdDG8=;
        b=ZJ6iIMM/hIEkTW+jQXaiBAdfmf1Zying4RIvihgdh5hr2Q6zlD+qxOIplVPnBDZfxH
         Gwf/zu8qDA5Y0uOmhG37i5vBKGszqw+OiE/7YvWaaenVrqTScnT75f6I98A3qHUFo+Fz
         BtFYRv33Wtf+/FX07Q518WpipQuzqrtaRIubF0cKx4B+T3yYc3llJxfiINaMSNrJUM6z
         sr8iVuQlqvBVpPPrhkbicVbCjvEWlcgwxjgy3GOx3HAppsaV7ZP7m2tj/n1MzBm3wOMr
         xkLyMb09uMUpmFTDqeer2xaVEdQRLUvhfCbrbYb/c2LBgE/xpk9DGVYsrKVvRq53Kmfr
         Ksqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632863; x=1791237663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIbizLL1IW50D5D/SYfMtdqVqG9t1BZagIkpl9KdDG8=;
        b=lLSoNViRK+9iF7j5XTigfJ5VATBDQ+dAnKEe3Zf/l62i2omP3gP/AmAj7MIUjB9tm8
         peMFX4kaarhyHUiNGkiFW8GUOiMkAF7RYCyCHRixVuxiBmh0itPvzlGQE7fXoHYa8LAW
         lkzuAsEZaikCo1qBwDZK++GLwkyWKTgMduVMZyXc2RfKO+V0EdMpcWOshgNBirwqNm42
         GRix06t/qwX7AxHUACS3S7H/r/sVr5MSDEDY1P+4bbJE07xP6Gc7rcCVqHhg/h33Gjvy
         yyZ1FEGjSRGn5tl1xwbfDA6tFWXdkL3RupYA9tE260c877r5kWJ9zwzJiT6xXnkb+lGV
         91Yg==
X-Forwarded-Encrypted: i=1; AKwUvBzVhmlK5Tvj66JciAMI4m+mFXmutLrNgYA3VdQTNitWW5glqbjXjcHumJ1FFyZCyKbiaDXxWnuGjecJEvA6wDY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxFtcog5z5cE1Zsybwk/XNz5RqbPc1wqIm+YIkK45Dn/BJgOp3
	E0PWR6IeH/uDUvnuap9XE9KCbjpr0l90Wr6vEB/oA7pKa1jR3zt1VPvilkoejS5LejuXIftyehp
	BpZ1xgulPY2xMcKw0Dujga3PeOpGfLPf7+kY6wPU=
X-Gm-Gg: AYBFou3lLy1ntdI3eI/b09qh4pWbNGgZ8mr2tzZY4kLL41ZFTRahB9Rff427a5FOuHQ
	mbFvohYk/h+Xdw7pC5uBIdVoDm4IYhHW/HvIsw5128RrXx1nlTSX/JmI9aCMq5iwqSg0rPmOQAt
	aWUopTtTFAO+OtU0essHLadLhL7TmhfkmGsmzd5t80/QBD56jXw0j6ibSxl0G62jhvLo9Rd5x2+
	YAS7v6fcwRnIx5XxWvRXqlz9pUqIovWzb4JTi7BCwcP71UNSM4suu7Pz2CkKbEj6JtaIeIu9ekG
	IuT9D+DOeEUgTAHV3V6SdcWPxnPKPpziHynEN3YzrWQpKXpIJMzg8H3pDoCMNr16lHN0xXBuk15
	goqT2KvWxVvdN1TM8VeoQjqHLxgKXcbs=
X-Received: by 2002:a05:6102:f9b:b0:7a5:2792:32d0 with SMTP id
 ada2fe7eead31-7af1ceaa02emr5908124137.15.1790632862303; Mon, 28 Sep 2026
 15:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927190758.609156-1-nikitash.mariiaw@gmail.com> <arrfZ5CYyLt0vwu5@google.com>
In-Reply-To: <arrfZ5CYyLt0vwu5@google.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 28 Sep 2026 15:00:45 -0700
X-Gm-Features: AclHuK94P4MPekguKF_IY4W_INzWG9JHQ-jlAiJvXzpu9Cjfe5tqxJdexiBcwT8
Message-ID: <CAGG=3QVY_OGjSYZgJ8i8Nb-EbwHKPOvZsbqqXfcbv+Vvq_wsww@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Use snprintf() to construct pin bank names
To: Justin Stitt <justinstitt@google.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, krzk@kernel.org, s.nawrocki@samsung.com, 
	peter.griffin@linaro.org, linusw@kernel.org, alim.akhtar@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:43=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Sun, Sep 27, 2026 at 12:07:58PM -0700, Mariia Nikitash wrote:
> > From: Bill Wendling <morbo@google.com>
> >
> > samsung_banks_node_get() constructs each pin bank node name by copying
> > bank->name with strscpy() and appending the suffix with strlcat().
> >
> > In preparation for removing the deprecated strlcat() API[1], format the
> > node name in a single snprintf() call, which preserves the existing
> > truncation check against sizeof(node_name).
> >
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> Are you forwarding this patch on behalf of Bill? I see Bill as the
> author of the commit and I recall seeing this in some series he sent
> earlier [1] and this patch you've sent doesn't seem to be a v2.
>
> Let me know what your role is on this patch and why it has been
> separated out from Bill's series.
>
> It is entirely possible that I am lacking context. Please fill me in :)
>
She's been marsheling some of the strlcat patches I sent to the
mailing list. It's possible I sent a "v2" of all patches, whether
there were changes in them or not.

The patch series needs to be separated a bit because of Kees's
'seq_buf' changes, which will make some of the patches I sent
obsolete.

-bw

> > ---
> >  drivers/pinctrl/samsung/pinctrl-samsung.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctr=
l/samsung/pinctrl-samsung.c
> > index 5ecc9ed4c44d..0d639eec689c 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > @@ -1155,8 +1155,7 @@ static void samsung_banks_node_get(struct device =
*dev, struct samsung_pinctrl_dr
> >
> >       bank =3D d->pin_banks;
> >       for (i =3D 0; i < d->nr_banks; ++i, ++bank) {
> > -             strscpy(node_name, bank->name, sizeof(node_name));
> > -             len =3D strlcat(node_name, suffix, sizeof(node_name));
> > +             len =3D snprintf(node_name, sizeof(node_name), "%s%s", ba=
nk->name, suffix);
> >               if (len >=3D sizeof(node_name)) {
> >                       dev_err(dev, "Too long pin bank name '%s', ignori=
ng\n",
> >                               bank->name);
> > --
> > 2.43.0
> >
> >
>
> [1]: https://lore.kernel.org/all/20260915081910.4142719-17-morbo@google.c=
om/
>
> Thanks
> Justin

On Mon, Sep 28, 2026 at 2:43=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Sun, Sep 27, 2026 at 12:07:58PM -0700, Mariia Nikitash wrote:
> > From: Bill Wendling <morbo@google.com>
> >
> > samsung_banks_node_get() constructs each pin bank node name by copying
> > bank->name with strscpy() and appending the suffix with strlcat().
> >
> > In preparation for removing the deprecated strlcat() API[1], format the
> > node name in a single snprintf() call, which preserves the existing
> > truncation check against sizeof(node_name).
> >
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> Are you forwarding this patch on behalf of Bill? I see Bill as the
> author of the commit and I recall seeing this in some series he sent
> earlier [1] and this patch you've sent doesn't seem to be a v2.
>
> Let me know what your role is on this patch and why it has been
> separated out from Bill's series.
>
> It is entirely possible that I am lacking context. Please fill me in :)
>
> > ---
> >  drivers/pinctrl/samsung/pinctrl-samsung.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctr=
l/samsung/pinctrl-samsung.c
> > index 5ecc9ed4c44d..0d639eec689c 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > @@ -1155,8 +1155,7 @@ static void samsung_banks_node_get(struct device =
*dev, struct samsung_pinctrl_dr
> >
> >       bank =3D d->pin_banks;
> >       for (i =3D 0; i < d->nr_banks; ++i, ++bank) {
> > -             strscpy(node_name, bank->name, sizeof(node_name));
> > -             len =3D strlcat(node_name, suffix, sizeof(node_name));
> > +             len =3D snprintf(node_name, sizeof(node_name), "%s%s", ba=
nk->name, suffix);
> >               if (len >=3D sizeof(node_name)) {
> >                       dev_err(dev, "Too long pin bank name '%s', ignori=
ng\n",
> >                               bank->name);
> > --
> > 2.43.0
> >
> >
>
> [1]: https://lore.kernel.org/all/20260915081910.4142719-17-morbo@google.c=
om/
>
> Thanks
> Justin
