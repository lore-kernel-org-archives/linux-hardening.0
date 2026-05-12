Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B22D0C97
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556082; cv=pass; b=ECiZ/DMl/lrrdrm+oUauXgGFHmNAWlH8CCRNKGfmXqhnmZnYWNNvU8KedJBQXI7rb+4xbBsNkqhl1lYs/su5nAnyMpRixj8BMCaUcpTCq1U27EaNITWBA84P6mAxVr99q09E0VlkpAK/3rmlXvNfxcYOmDeAfntUZ/rTZGFgP30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556082; c=relaxed/simple;
	bh=DQ6N9oauDzHXFObRY052Krwwsu+VJK2/LFDTGHUly6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxWqAzsdc/MoaBCs7JmmIVhKxCxZCMBDM455NOn7IGHMr1R6FcJeSX7fP2/YjrtDLmWK/Of/E04cWDi0FHJnkoYtpf2qPWQ3+ckIKHBek9naGg1nUd2Dcp4T3E2xJjzV62RgMNqK+Frnln+k5oGEwNJREq139XEUc1ljrEmzh10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgf4XXcr; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgf4XXcr"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bcf41831af1so281590566b.3
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 20:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778556080; cv=none;
        d=google.com; s=arc-20240605;
        b=jWfA9U2l6IrKw4AIxTHhetNrK3mJsGgBKunjievuEBDkximbt0IHZMRfnxjut7fGE5
         uX4LplORgXImHFOTnqVr5H89BCzEpMjho8p6JSQA5ihVpjdhUOu5H/dTcbpzbnu9sXSN
         eLbKdJt7lJi4u9uzM2TCdoQh+0Tvr1P5YGVO28xYGY4324/IJvI9K8RVgt1qhQMNO0rL
         tVfvBLyp66WlXfguGDoFzI44lqlv3yXorbLgWXOXs85BfrW0q0DJ7kyroOBPiF6fg24t
         BtcdjvHpF9wPFOlTyCH5nwKRzwGU+hDvRpJoitiO4waGkDm57kVL++40eqgmpxD0Aeou
         lLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYMrozMNVZ904cuoOkrVpAxkzPl3CJ2UJtFltjYOwQU=;
        fh=2r5DhSZakd36OTuIwoDcBBwdiTLn531/JvFAW2bfLQE=;
        b=LCPE90ZpVC0l+xLsEtobr8LDT3egK37BTkz2jsWBANqAikzoRhz4DKSuXvWCaSL8dg
         EbCRys1abuDPgFDjyzBp7mfUuob4fHJQZO5Vnqn525Yg1UMbhxtR5CesQaSZCAlL9Vaz
         4uW1ApUGtaGetmr2LFESOf/6l1fNzUtH5gVpi6z0RLNHl9vKSJQN3B45T8O9R9Unj70T
         RWCxo8L5aPTRngPyVtmOhSo0ZI/bfdVJpeAf+uI/NIe9BGSnHINXNhJlcLuwg17ilvMl
         KUSSM2pX/PN6kxoEcnp96N6FlDvZKnBeyxUiX1+UPV6o8CB2GavOnC/enpO7zNj6q38p
         zyHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778556080; x=1779160880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYMrozMNVZ904cuoOkrVpAxkzPl3CJ2UJtFltjYOwQU=;
        b=hgf4XXcrpZKhUcXa64RtGRaGTYt/keJqkQr5boTlmfhkBzpCQqFP21hk7tiuPF9uIB
         e0n369ctGt1nZ5Dk7uTNcsgtA2yvZaH/FE/tOB4R/+u60i78pmVVxzygySaHccjWpNvm
         J9C64EVQqFrIHdmAYB7bHDaUjSeC7mNWW3x6ljzODRESFN52EXmNNUFTVsHIMsCSNlPa
         tkgFczbZdDbalV7FfHrf/9Clv3Q4hVcBbsytMMK9y/TuUowEnBfOw4hwdbSG8zBth7nm
         vVSBObsJ6S/suYMDND7sOGSqyts7PA+Vmn0p8URT1eHi7CQoEl9py1niAwM0TSZEIrtJ
         otLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778556080; x=1779160880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYMrozMNVZ904cuoOkrVpAxkzPl3CJ2UJtFltjYOwQU=;
        b=lXqpIdKZWKqNSpHKSeVV8Asgtt93pNqwtCyAvRoXRqy9Vnd/gjwN+W9l7RarpwHwP8
         W0N4z2PdvNfOQaqV42CcqjNnXkqkqn1FGuPNdgirExTEWy4/z+Wk1aja9zNbaX+18SKQ
         5gz6w8toGYE+8sgOSxgpq3mS7hqTQZe7vkUKu4nv95Yk1e/mtDBKmj+3VRobPvDj6C3c
         UlStTn3gD72C6TooBA1nq07zACicDVgchzo4T2uu72sCzPm66fEP7UhBKjxnO1IfIGr6
         s6G9OOw5ZB3XDK291Kts0Q+slYYVR3NyRKRWocxsysfCEVDM4Sq7deDGA3txcinuJwFX
         RbbA==
X-Forwarded-Encrypted: i=1; AFNElJ9P9ioWS0dNyMLTKSaa6CtigN0R0ukZhav6Ep5q/XBjOLFfzKIeYEWc4oT3nV3FLmRItQwr3ZlYsDVnHiA3vTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wFJ8EZ8uZIwpRA2QX4LoH9ZximCtTmw7Kk2SplzgssJw2xVx
	Y0s2nIBr5NF1xZfpDlsd0hyfojvbxkIkweR+Fc/bxB/8reknEl54rHNY0yvFHk6sccxQCH/Sakt
	+EOpRCPpofcjj5f8ke9Wc5Uc2385nhrE=
X-Gm-Gg: Acq92OEUh2XSzAAUzD6vXmfTuNuYhgAWFZfmLytHV7mf6Yf31MKfThJHad5/aQx3wUL
	kFYYGMmv+q1670ntWp7XsDmFaeGjoCgSFC/ZpBRhMjHu+qZQE+DDCnAvDOhE1RjbcIUk1/2qefV
	MbEcGAUdpL8NAiIiuOJH6om/WI8RxsGgghuq5aHBwRCpgE36of3r8OtARzhckLz1xdOs60/EHi0
	/8AdLsPSHeZcecISu23waADmiJr1/oZD6yYPLgHfNi12g9rqSHXExtS1Eqz7VF7vaP/uDB/Ld6g
	d2b2b3CF2IMW7kgT+iyM7LZ3Ee511Dxu7/GiUQJHStptNZSsKOhg6ktwAiiAxB3Zsq2wr2XqJpS
	2h7rO8seORbcV4h5Dqt+xfA9a2EqN8LsqzWr3Y7wF4a7Spf1dZNnVlAehzg==
X-Received: by 2002:a17:907:7242:b0:b9c:9594:e00 with SMTP id
 a640c23a62f3a-bd28de035e9mr47365766b.1.1778556079539; Mon, 11 May 2026
 20:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430225309.117557-1-rosenp@gmail.com> <db8119fd-6d40-5df0-68ef-5579290c5bb9@linux.intel.com>
In-Reply-To: <db8119fd-6d40-5df0-68ef-5579290c5bb9@linux.intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 11 May 2026 20:21:06 -0700
X-Gm-Features: AVHnY4JZN-SXXU654PMY1RzzMrowggVLGe4oxCAc5hjbYcCbMH4izfBe-B-8Mkw
Message-ID: <CAKxU2N-L9HMnNpuUhUaWo-doW0cJg1YvuaO9urLreJ3uOzqcBA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/intel/tpmi/plr: allocate die_info with plr
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 9:31=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 30 Apr 2026, Rosen Penev wrote:
>
> > Simplifies allocations slightly.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/platform/x86/intel/plr_tpmi.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x=
86/intel/plr_tpmi.c
> > index 05727169f49c..2fd27e80bc1f 100644
> > --- a/drivers/platform/x86/intel/plr_tpmi.c
> > +++ b/drivers/platform/x86/intel/plr_tpmi.c
> > @@ -57,9 +57,9 @@ struct tpmi_plr_die {
> >
> >  struct tpmi_plr {
> >       struct dentry *dbgfs_dir;
> > -     struct tpmi_plr_die *die_info;
> >       int num_dies;
> >       struct auxiliary_device *auxdev;
> > +     struct tpmi_plr_die die_info[] __counted_by(num_dies);
> >  };
> >
> >  static const char * const plr_coarse_reasons[] =3D {
> > @@ -278,15 +278,10 @@ static int intel_plr_probe(struct auxiliary_devic=
e *auxdev, const struct auxilia
> >       if (!num_resources)
> >               return -EINVAL;
> >
> > -     plr =3D devm_kzalloc(&auxdev->dev, sizeof(*plr), GFP_KERNEL);
> > +     plr =3D devm_kzalloc(&auxdev->dev, struct_size(plr, die_info, num=
_resources), GFP_KERNEL);
>
> Is there some particular reason why we don't have devm_kzalloc_flex()
> other than that nobody has yet bothered to added one.
I'm not up to date with the hardening people. Anyway when it does,
this will get transformed by a treewide patch.
>
> One of the most annoying thing with the various alloc APIs is that devm_*
> variants seem to never keep up with them. It would be nice if there would
> be some generic solution that when somebody decides a new alloc api func,
> the corresponding devm counterpart would be auto-generated for it.
>
> --
>  i.
>
