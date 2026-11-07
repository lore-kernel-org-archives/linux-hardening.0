Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794060394;
	b=Ho5u9pK6qdAAjBREZcqX0+WgRniUJCGhRpSliMYmkZDlNk1MLIOZca7F2OzKSIesJCkh
	 dAaxRuZ+INBb5ehNz8u72xZbZBp/ksfpFx8u9A08anUJ5WmwgC8xrapa2QrTpZJ3t6LLP
	 58ua4Kg5k6ga1FeJ7/wwtf3QZHlVXSbazJeVBvv347zvbJy0l8BZd2cWdIJvuPRA2NMfM
	 ueo8Exy53wWNkA61wce4bHuvvnXrsZ90VT0QOSH6MJMjt3hDmYDENhumwyoRmEIv8MSfm
	 p8l2icv1I9nCsEJNuBTTnaGCgpk5GtthBFAN+fSR6a1rHUjzZfH2Xn2ySSGrhDG2kAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
	b=Q4b06PgLSHRJ1BfnYx8S5rCzAC2LEPDDbW00vQGf6ZHld2mBA5c4Jx6AEgc2pv7DMCh9
	 SxDgka8iOYtpHA4LU2q8lFiJ0Qf7+KZOghUu1ISQWJ2SbrTOQ2DKwRufx9bn1uwsIE50p
	 qvH1OMojQ3PZ0b7IbUb9tfQ90QPvJ1OuQMfa7XfHRBf/HSiY643MzTL7+VWdCIpvg1OPJ
	 JGsQCRZNjmBRBnGLCoJ+0JNrSUXn0TiU1QpNfWvT24uDSnvjs+BkdIEKTEMtjBhyEUu97
	 p7wo//9EgVv3UnS7tteMWtUEMzzD+5gNOybHY3+s0knpQTxubtpchXHEW5kEzcicZAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDBlyIAS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7599606D81B
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7599606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDBlyIAS
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b1a705b88aso1023399b3a.2
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 06:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794060393; cv=none;
        d=google.com; s=arc-20260327;
        b=h9EFkoAsxk+mzLSd2QRxANPa1oM2NNjdJWnlCK7BCQJl1xnZkkTD9V5/RwiCWSjHKw
         YWQE1cZIaYTj1kflF3g6ol8Kj6YiBQXlACNrR7JKIxyOpI11R6rSdJLllVRTy/co4o+u
         IqbjU5f9IEbfz1fAAPwXa3u0IQ4qSPR4MriokSKeFyDgcWjf3xcNvuodi6p3qKxR2CmH
         WumWk5Nl6hJv4LfoXn7vCXAiXHYTtPnSEpftwjrfOr0sShbX+TqAhbAXUYkdzGLWekWt
         joZPY0G8WfB5lZoxq3f+Ltc+pItBCPKK+J3JkRfmll4OS4qKz+dlnMCSJqpm0R4EDb1F
         eP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
        fh=tVbM8e480WCPn2sjgFZ1gcaECQW/ikOADFJaJXOfrwk=;
        b=ffRTHmrepidSYdr8od2fkorQDoICFS4tKfs1K2bd7SZ62gu6XXCmGBTukMy+eyU2xq
         V+/ksNuCLjocLqqdIqZ6sA6IsN8y/4TBeF0nrliy1OEVfNv95IiFBg5mlFpXNkONUjmJ
         yXzR00Hm1FaEI3Dbri60uErMWdM34VyBgU/80htfmlkF26L/qEfFtq9PkXlPJGPFHM+2
         a9Ufr0iMQD2wQ6mRH51HKnGE+oGU2rlaFZ/sA+X/sxevZ9LU88svlKEPCv2OWdyjlGDz
         3PFOkJH4hX/dEUm7Ts4bwRuLjpQj+k+rZHQ476RTwVWQTuuF8K7MVhVEVQrgfNLGLy5g
         X4WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060393; x=1794665193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
        b=dDBlyIASGe87airtRsC6OYAtSLt8d6JrbobgkmqzvHZG4f9MUAgKofmlBTqz06bmf7
         X6/cLnOfY0szRdLNS3X2edK4IKxHbjdDSXYPSt31ow1YyWXi1Kqjjm0QF8nHW2t4qXvA
         0NYnlBfL3p280jC12DBHa5hRcP3rn5qi3RG7leKLPOtEEwGOwBz4i3puzoxLu0A/ERDn
         tEb/Fe4tigaNJLz1eYJOyd+QMI2kRSEuRujtP7juCjFLv+Kx9QXavedEeGOPrXGBfMZd
         CXpWZX3fCI3edsCjV2z66r0g7h11SLsxjerD+lVx8K9D+fefPaf9swx/sLCRgFYnFBR9
         wFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060393; x=1794665193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypt0cQgotkEVzYhfQB+Vym5gYPVJrJp3QalT+ngA/vE=;
        b=ZgQTx/Uu05T+0t8OEHhy/Ruoc6iSkcK97NcPvQmlCVR4uzxcD3ZZobqnre9mfqNMRz
         SHcV2AmqRrOktVMi2yekjuOxNnMDoKpg7Bun0t9TBXslNL0rF2DEiqnWdZDorltrTR2/
         1f7FSBmUGp0FN4YO7xREA5004FctdvB9r0XLQEZ8hCN4InkKNsRGievGUVIuelQdj96r
         Tbc0afOMP5GrL9y49QGK+ajMZ8yCtLlaHV/VY9/wR2OB/YlGd6ak2qkGaqxmYShNMcBe
         YYZEFN+nA/7w0MK2x1CE0vnqoEcT6DNNuOP8qacm985iSg3X6PhLapX23TOgb6eOkGTr
         yRQg==
X-Forwarded-Encrypted: i=1; AL+hErEWkwdE7muC22SUPMzgzvFvqB1ToWt7JRInYH/0gFPGCpzY66AWTkcS3WNUtAeSiWOX+5VlO7jW+IvL9+X8IWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8phE9nJHxXhDX2yaaQbQIPvbppIBl6+ezb5NiUm1VMqcz5jpN/
	vqkSpMZHccvsVb/37x1/BwAe4AwRQkHfw5gbRR9LuCFY4+vAVhtvxJBwlnjUa4h147sILpxyrai
	TWZq39yjdXBKLEsvX/8EAugwmFU/aqoA=
X-Gm-Gg: AYBFou3k9k/qmPUvL3dk1QNFZIHz6F178+ZGCfaeX1z3cNy74a+kA8LmxTCyLw/nFT1
	Rd2/29OGwGzKjTaLr8xtGKt/0kl1TfZK+Q/06HDGNF7RBz9W5fkCmT7TzqRgNb1fcEEToi2Cj5U
	OisAdPLDLIaNqY6xggbP0ZFeXwsbdEMNFcuCNvSRGZNIWBVftNoN2iv2Um//TfuP/ZKxmRjAn5h
	QETu8fsz/WuFX56JbDd4gNH4HQlWZsTIXB6irdNTTFUCFbgYCT1NxYSyhVVDLKx4tQnqFghWC7I
	PAHMRdQVMbriqiptkadQa/cYNg9eLb9Y0Ei/jmc0zw4+PxMg+RMcTSVzabom+YFYmB226CXyidn
	KD/Ks8VPE4bJU7Maq4/IM298YMmuNvPK4riur3+3wv7bVq9aIInBQ67+OPISWvcbk7NcscGrmaM
	+upR8ZoLGxP7wibpIoSRAWPxuBctiMv7X5SPxWVprUZs6R+8vEdBSxpPmwbS3ia9FzipF+mcK0F
	hymp+PGNF4g8PtPvL/oLAudnjI86VX6u5Qkntthetr4Z328+XqG11NhHRm94A==
X-Received: by 2002:a05:6a00:13a4:b0:8a0:21b2:7c7d with SMTP id
 d2e1a72fcca58-8b37525709bmr5141902b3a.0.1794060392907; Sat, 07 Nov 2026
 06:06:32 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org> <cover.1793882260.git.alx@kernel.org>
 <qwpovcqznx6eltou4inmj3v62qhh6ouvihqnze7bobnd7lmcbw@rcri4e623icb>
 <auyOkL1Vb1iKicS9@devuan> <auyV47xUCr1EJ7A3@ashevche-desk.local> <alpine.DEB.2.21.2611070239050.17804@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2611070239050.17804@angie.orcam.me.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Nov 2026 16:05:54 +0200
X-Gm-Features: AclHuK-WBq_EIF1I_SsYN7csCkMj3s3jbsrjUQ08xBHpkztbklIxJpPZrjAee2s
Message-ID: <CAHp75VcVT2kQO+URZbrH_3-A=4DMZU1KfcQsjDf6bNdtjf=t+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add strprefix() and fix a bug with it
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Alejandro Colomar <alx+linux-hardening@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 4:42=E2=80=AFAM Maciej W. Rozycki <macro@orcam.me.uk=
> wrote:
> On Thu, 5 Nov 2026, Andy Shevchenko wrote:
>
> > > But yeah, I can send them as separate threads, if that's the preferen=
ce
> > > here.
> >
> > Yes, in Linux kernel majority of the maintainers (a bit of speculation,
> > I haven't counted, but it feels like this to me) do want separate threa=
ds.
>
>  Cf. Documentation/process/submitting-patches.rst, section "Explicit
> In-Reply-To headers".

Even better! Thanks, Maciej, for the pointer!

--=20
With Best Regards,
Andy Shevchenko
