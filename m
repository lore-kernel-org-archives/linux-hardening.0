Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794514585;
	b=22RUYewpHqCaINdUEkhc8R77clQxgiGLR1T/kslOICbOWJCDPXcpFOCJk1sDxet2PXu2
	 3eUwm/AD4iSL+IZ1iOSEuo+vPFUtCr86uZQzTQbvghgtdZHZNwkSoy4QxZvHWDzLNP3mH
	 LYejsL0Oji8zhznLf8yFfdiLvKyW+zhz2sPeKKP7zWkRrhtqBaE3O9qgOS1mT7hgoahnV
	 HUNZQuDv9foCegiWhkiSMnh6fhi7QhW+mcNkFBe2Z5dr5srxOrlGEtt66azqvsPezXQVH
	 FjMX22Hc06BI3di+twavfwY4kEaGEafq+KXtg/yxAjCy4FSru5NQ73bIOnQ3xr6vqEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VM8sXKaWHmPbV4KhLM5wB9a1VJzd8w4m87HBeipCc/0=;
	b=kNm5VPv0op9RF++Qv9QYMgqoALEHcoJdoEtliEJSGeUYByEp7X3/7x6uRqonFmldSYsB
	 iF4Ia1G65jRuSdGWlwxGvHLz9on4bjIqmQTkN4zr1JzCpzZJ8LC2SGQM3vEcu5djGrfdc
	 YuqkMlz7xXvKYagcbF8d6czQi9bYVqlXqanbXmsa+eEiQr64wiPIS6JTJEARyYbMXZxiF
	 Jph+PwUeqmh85HPjhhl0ogGGQwraHhxHc/CNpkJI+ZEnFFyH8wHuqxKrzxhipO51a0niP
	 8xLBuaQyqDBpBuXET8RJtkP6OzqgE6smXGa2cB6u1fn3s7uozAAn/hrCS1e4NjKUjSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zFFpp0cj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638D606A321
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 20:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D638D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zFFpp0cj
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48fd2e38825so92548f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 12:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794514583; cv=none;
        d=google.com; s=arc-20260327;
        b=jCl4E6x7Qsx0EPk/Z+9+W5tKoFEUUonwg3AvU4AOTeN/QwLI0QggJEAVwHwGo+k1Uq
         CN1az4TzDuNyL9zMPou019h3hT5xynlC/QyisanDRw6RTNa3z2U+TDQJIOaAzVgsSkl9
         8tv39KLCWxrRgJ0+p8NAHbosWiip3XlI6R4CVWhV/2pJmqpi08D1P8AKm12DORdLVE34
         XuAx9xzyeVo6Rv8iouH86ppNjvDWbEKRTMCZ4NgnK06SJsvSJARxHaXOeQmL4DXKq9JN
         6kti9H0guNeX4DPYyzcCmp9U0sClCUoM8QuQwkPXQy3RM/ub1qyDWvnzoEfdkr71gZrF
         1d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VM8sXKaWHmPbV4KhLM5wB9a1VJzd8w4m87HBeipCc/0=;
        fh=9lJwqS2wZu0g68Gk6CEI0p/jXND7iTq1da9n6T/JO+c=;
        b=NsZdNVoIfLyFOTbaEFHSwlj9Rpa8NGg/wUBwqddAdUqm56yEkgeyCPbtWw4SWs/U7F
         zjXvx/vJnBPGaI7TnBxe/KobG4W03F1CeFR3B/M908DzhJvgjlr9eolJhtpI5rYxtSJn
         v/jpasD7h064qMHeBbWYeh4N30F9dOmFWyaur8iNs4ZekPBEcqL80r1ErpKUuMoDRdlE
         tcBMdz0s5bQY1yZPswmBkat1qcUcesCulm7bes0u8s2c/19DJKVJ9xGl9FhgprfUfH+X
         E2jcZfK2M5vHpEOwpZ//TTk5SUCTkPc/sbGopGQrs+l86RGlN2CkC2kXhyL1wcNraYSD
         q24A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794514583; x=1795119383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VM8sXKaWHmPbV4KhLM5wB9a1VJzd8w4m87HBeipCc/0=;
        b=zFFpp0cj/gUseSsTd176Qcq1WPZruZeEVBOY2pKah07OmRduKu5+B80BGhpCiO/KTf
         A5xgAgA1ZurXcSr6JAxU8pbpPonzVLzZVx/IUhdq14mU0vdE+5IgVBxSM89ybfy4/5KV
         x0rpzH9MPXqFDfHDe5Df12E8eaf7zP4vZwE7rG87kGxA7SSGoa75AsYvSjtF9lItO7x1
         jbQhEYu8/5SW53DXYa83rGjzNn+tZxx+xSH7IPsp1swvao75MmhaerEWVZ/xi8+Qze83
         dfAQp33cjKFUw4FjVj8qO9/43+DyISRcUR9lmgjMNd+zlvBuv2B4+fbW4g6NtdOY4yhV
         b/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794514583; x=1795119383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VM8sXKaWHmPbV4KhLM5wB9a1VJzd8w4m87HBeipCc/0=;
        b=ZPx3kA+50Xkr4pUYZWmEXIFACLb+W/BX0j3SkTmXkRDfF2g0j05y59p3sgz/LeK05X
         2hhxzZW7lJOSpeGZvfcTJ5t19JaRomH7kC/zlR5LYF5/ohcejhyh0gAWugYk50bW20pP
         pUXgx8EdJ5sR1hHLEh6ux2yOewItugi4jYwZ2nDafKbkJ5mZlwFffxzWnhcOBIT10zwp
         OfvCATDsG6OSjgv2GZEu8tz3IhxhipBitLaLAkg/qsLhKgj9wdBEddvZqfqEKTQu32Fc
         L1am1N4vb8vX69wylCU4ZBE4zcirHPkMmvyqZ189qUfi4A87Jt2vUAhWiia2GrDW0Qkt
         zVuw==
X-Forwarded-Encrypted: i=1; AL+hErFVAi7jkDv7IK2XqyzzP0l/6GaAlLYnGPH8nJ0t8xvoh9XbYrTPAE3QmpF8BPcICurNX6hf9IiqnLuCktNLrYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z82BG1Rwbe8g2v4rAiu94GZn2qB3L7O1ojmZHETJlIYEoYlWYO4
	5hS+cRi8UgGhz80FBKN7pjX75+h1lcQL3p9kAh6GjCvosIXTpMbJWRr4mArQGrGsEhD1qe1PRxS
	mREdS4Ml1x0VJwZ6DRRgeCzm2b5d++ww=
X-Gm-Gg: AYBFou2lMyh7Jfm5pF+OUy+mpPfdVK494fFCC/1gd891mfLlrseGIxgvyVB4DcfI4oI
	2EFlVtTq1gYgnDR04q5e9d2m1BZyULXGtzEfTRFafiyzLUF2IjN+0QVm9dib6YXrx73cR2ERXPK
	oDY3l1EDiOOW72yjuO0wfqoIPzlsCGkLE0th7BE++GbCsxaaxyd0Tr6nrA0h29rssKmDYxdRPEL
	8U/33SrWeF8dzTFEjyIQXT3jn0mhk+CTF+X/GacuvTK72FaBFu6LU8VKf0AcZx+ytbvMd/yuy9N
	YTMIX2EWjcG0ZOgLQ2lEwDpbH6yfsSPYnc9GaQFOr3JKk1YIezsnRcupXd1nk4aByJk8EG1S/sy
	281Q0iqDdu8ngrupKq2MJAlB5tCWviV0lX1zhL14=
X-Received: by 2002:a05:6000:2888:b0:493:d5f0:4e68 with SMTP id
 ffacd0b85a97d-49c72307130mr1133640f8f.36.1794514582969; Thu, 12 Nov 2026
 12:16:22 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260927060000.518354-1-nikitash.mariiaw@gmail.com> <202611121039.836B308B1@keescook>
In-Reply-To: <202611121039.836B308B1@keescook>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Thu, 12 Nov 2026 12:16:11 -0800
X-Gm-Features: AclHuK-GVCQIHsehpFTEXM-0fJJGeLDSyoy-UU19uUMapl4TyOdz3_ihKvAnn6w
Message-ID: <CAPDEY+UbZ_VdJQR3n_nf2M4e5dVEQA5wVDTPbPE-T3ckP6H1OA@mail.gmail.com>
Subject: Re: [PATCH] comedi: comedi_bond: Refactor strlcat() to seq_buf in do_dev_config()
To: Kees Cook <kees@kernel.org>
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	morbo@google.com, justinstitt@google.com, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Nov 12, 2026 at 10:39=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Sat, Sep 26, 2026 at 11:00:00PM -0700, Mariia Nikitash wrote:
> > From: Bill Wendling <morbo@google.com>
> >
> > do_dev_config() builds a space-separated list of bonded devices in
> > devpriv->name by formatting each "minor:subdev " pair into a temporary
> > stack buffer with snprintf() and appending it with strlcat() in a loop.
> >
> > In preparation for removing the deprecated strlcat() API[1], use struct
> > seq_buf and seq_buf_printf() to format each entry directly into
> > devpriv->name. This avoids repeated rescanning of devpriv->name and
> > eliminates the temporary buffer.
> >
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > ---
> >  drivers/comedi/drivers/comedi_bond.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/comedi/drivers/comedi_bond.c b/drivers/comedi/driv=
ers/comedi_bond.c
> > index 8e10ecab4f0d..a10cfbd04c72 100644
> > --- a/drivers/comedi/drivers/comedi_bond.c
> > +++ b/drivers/comedi/drivers/comedi_bond.c
> > @@ -39,6 +39,7 @@
> >
> >  #include <linux/module.h>
> >  #include <linux/string.h>
> > +#include <linux/seq_buf.h>
> >  #include <linux/slab.h>
> >  #include <linux/comedi.h>
> >  #include <linux/comedi/comedilib.h>
> > @@ -170,10 +171,11 @@ static int do_dev_config(struct comedi_device *de=
v, struct comedi_devconfig *it)
> >  {
> >       struct comedi_bond_private *devpriv =3D dev->private;
> >       DECLARE_BITMAP(devs_opened, COMEDI_NUM_BOARD_MINORS);
> > +     struct seq_buf s;
> >       int i;
> >
> >       memset(&devs_opened, 0, sizeof(devs_opened));
> > -     devpriv->name[0] =3D 0;
> > +     seq_buf_init(&s, devpriv->name, sizeof(devpriv->name));
> >       /*
> >        * Loop through all comedi devices specified on the command-line,
> >        * building our device list.
> > @@ -250,15 +252,9 @@ static int do_dev_config(struct comedi_device *dev=
, struct comedi_devconfig *it)
> >                       }
> >                       devpriv->devs =3D devs;
> >                       devpriv->devs[devpriv->ndevs++] =3D bdev;
> > -                     {
> > -                             /* Append dev:subdev to devpriv->name */
> > -                             char buf[20];
> > -
> > -                             snprintf(buf, sizeof(buf), "%u:%u ",
> > -                                      bdev->minor, bdev->subdev);
> > -                             strlcat(devpriv->name, buf,
> > -                                     sizeof(devpriv->name));
> > -                     }
> > +
> > +                     /* Append dev:subdev to devpriv->name */
> > +                     seq_buf_printf(&s, "%u:%u ", bdev->minor, bdev->s=
ubdev);
> >               }
> >       }
> >
> > @@ -267,6 +263,8 @@ static int do_dev_config(struct comedi_device *dev,=
 struct comedi_devconfig *it)
> >               return -EINVAL;
> >       }
> >
> > +     seq_buf_str(&s);
>
> If this hasn't been applied yet, a v2 with the above changed to the
> now-available seq_buf_terminate() would be nice to have. Either way:
>
> Reviewed-by: Kees Cook <kees@kernel.org>


Thanks for the review! This patch has already been merged, but I'd be
happy to send a follow up patch with seq_buf_terminate() if you'd
like.

>
>
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.43.0
> >
>
> --
> Kees Cook

Best,
Mariia
