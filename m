Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFF1DF724
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263323; cv=none; b=b53VqviKakIu0/hoVUFEyiPxCC4g1WYy0Jp0+kLDNxO7rro/fMMqqjK/kxzLDyrZDmwVwWtg2so3+4lJquS9HSctpGGZLfuE1XFNllw6XZhbh6CfBSJUG8kj4888L5dV1w5BrFendALlfsSz9Ou/C5W0v0tRIg+xZ6w/sfZBLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263323; c=relaxed/simple;
	bh=iMjiW31JLFa/JNAGxQxIb5V7x3JFTsVdFyhdXhygqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYCivpcnmv3nkfUCFkwHBgox9G3Yfai2BdDlsQBnkJZ714MkumtSgamDj7iD2wdPy5gscxJprtP1FjoUdcLLTA2A0dw/X6QsWJl5gbjfOr//s0dtJ3xFigLUMUv514Ifu510ym9qBOn0Jd65KeA5PZHqXL8tI5QDLIvp24I6vNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DIYnxpRa; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DIYnxpRa"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so5048378276.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733263321; x=1733868121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7U0GjbcfzhAQB9IgZbw6IGwPJ93YtDIzJ9Nx+titdo=;
        b=DIYnxpRas/702wQjlv5JEDIagTr+a+H+yIw7foToh38+Dwek4EH9nsN5usNGShJf8k
         t7Ead+7sHfBX6d1RZAC3Zs2MJ5wDKyo6wg1WfOTD1rh8hZufN1BTNK/aoE+1dspfrT1Y
         uz9DQ7L4bAbfz0UFx+hGyQsNbyOBFeffg+S3RhGGQBhy0ZDVMBUL4SWhYLp6Dg86dbYf
         BcpscCEbZIfyRB6EK48PpLs2pZ/JIx84alNykL70nLMEvL7VBVSORTtW4jUgmtGCxmFD
         1aojfnEpSkr9zF6AyIGXP2cgKtostbDIvbhXEpwA5wAIfhwYViEEHYvsERDDkwh4tuoR
         JE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263321; x=1733868121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7U0GjbcfzhAQB9IgZbw6IGwPJ93YtDIzJ9Nx+titdo=;
        b=sKCElkFdSd0AEE0LIcRDwO0jypIF7ZngJkzVrLyqS31KCYoSdrBh1by7MIY02vYYW3
         FQfhg8GYwlxMkhv4qmP5GKMzvGJgznNw5Zk09V/EWD/qlNtabOt1aMuN15WrFZ9H4TMx
         v2hNfQXK9u5er4NmSdsG2QiUFN/a+gNww3H7rTYPyRZ7MTBZWRyDEu1FhAMR5Db4uO6B
         8exIySe93RPEUd6Iiy7aY+BVlONDuS0uR1ulSp041oqca8urYunGTM0uBZK6uP1bFPyT
         n9B/y7iyWBGBnS7EhZ11CI9NMToeQRIlGSRmd/DTf/Wgb5jjFMwpSYkl8sKJDkkf49TU
         vdgA==
X-Forwarded-Encrypted: i=1; AJvYcCWe28SF0wrcGOAqg92vUZ/5KjYYkV44tOdEBnTDbyr2F+mm8iXfbjXtfRNGKeTHm9E+xZYESqdP+OLdAt9HP4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Qtx9Sk54Sa9ryLsM45bmVl5TjkCthXkvaTKe5iiJ0xeSZ3Kx
	o418M3epzMpUds/YNSJ8WVDegzGqII2BIi4yuFkVGmOf1cHF8UxL8sdGYbcI8/Vh+VuG+81T3al
	t4i0xHm/960tvaddUE/+13wv5jchvmmTzsA6Z
X-Gm-Gg: ASbGncsIOAvIgniJjhPcBQKO8TuBdVHstDuyE5wS/rOv6xPjwNEHDTqx4pjenGpwWSa
	kBVxdNcG9csKDedmTntU4dH6NcH/wKA==
X-Google-Smtp-Source: AGHT+IHZWymOeLz86ZZRjaQvg6FaFEzznigeaQilocvHe2i14UK6m1/rQtTJLdasUB2xj3FxFm3j0utddMz81VPRtH4=
X-Received: by 2002:a05:6902:2193:b0:e38:b44d:a959 with SMTP id
 3f1490d57ef6-e39d43740c9mr4105929276.42.1733263320861; Tue, 03 Dec 2024
 14:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR11MB713438072B901F890913803F89362@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAHC9VhR6t_LLB5nc=kqqE5FpN4ftxZYidQ8F5x1Lzowf1H9juw@mail.gmail.com> <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
In-Reply-To: <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 17:01:50 -0500
Message-ID: <CAHC9VhQAUfocUT08U99hWoKPM2F=J-F+Ph1Xeb49k1YinN8sTw@mail.gmail.com>
Subject: Re: v6.13-rc1 build errors from kernel/auditsc.c
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Kees Cook <keescook@chromium.org>, 
	Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Dec 3, 2024 at 11:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Dec 2, 2024 at 10:19=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.c=
om> wrote:
> > >
> > > Hi,
> > >
> > > I got the following build errors from kernel/auditsc.c file.
> > >
> > > The GCC version      : 7.5.0
> > > Kernel version         : v6.13-rc1
> > > The bisect commit : 286d7a54c8a2 ("auditsc: replace memcpy() with str=
scpy()")
> >
> > Unfortunately this is a known GCC bug, see the lore link below.  Kees,
> > Yafang, do you have any more information or compiler-based workarounds
> > for this bug?
> >
> > https://lore.kernel.org/all/CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpW=
X3ZkVtvQ@mail.gmail.com/
>
> I'll prepare a patch based on Kees's changes soon. For now, let's
> implement a workaround.

To close the loop on this, the patch can be found here:

https://lore.kernel.org/audit/20241203060350.69472-1-laoar.shao@gmail.com/

--=20
paul-moore.com
