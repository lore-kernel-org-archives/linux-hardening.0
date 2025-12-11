Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E62F1FE4
	for <linux-hardening@vger.kernel.org>; Thu, 11 Dec 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472622; cv=pass; b=GJyOdXY/um9Kql6ZiGGT6SXT7xzabe28HMKnlKJ+dFrQ6tiSrubTL8IBZbq9D54Z68Ne+wXeChTMe4g9bP9OxGMJhdhfsM+ISNN0HZM/4+mdzbDNsfidl2GPhHP+OSmWqcBh7afRPThbp34prlLU9AQn6n6KlPd39PqSm4roeHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472622; c=relaxed/simple;
	bh=dhK4Q7kDIu3zi/kAqk5vEc3dRn/z99FEvKqsdSQw3vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLy2wM4rdk4aHSXRwwMo2VrL+KVy2HMSWwPrplek98BCn0UyBuL2hUsjblJ14PSrwOxBFkQ/0r+PIvN7NpNzMVmOAoG0mwG4TzuLOzm8BMKqdMa8oFrFsPmus6Klbp0A4+7gVSANKsqBOZfyk4iae++0JTckCTLKZWhnAu/lG60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPZoVqsE; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPZoVqsE"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64175f78a6fso11431a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 11 Dec 2025 09:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765472619; cv=none;
        d=google.com; s=arc-20240605;
        b=Opg2LL/LG9rgZXMyIqlzjMnIDbO0NcWp2LSL39Tn68wRPFZO31NC1iv9L2Tx+DzLUc
         Jiy5dCF1p4WGfZBOKHmA18baCAOgXFiqg1wMJRoeJuCUGFwHILqMZDYgA5vyg106NTvW
         hHgER8qI13wOIVVJvJJ650e3b1tiZcOeLHOLrceqiNhfxNVQXG2c6d5mcB1jq95PUojm
         jI2pmTOHX59cJFMrcxKqr2JpQsChz2xDcmPngntNfHtS8+zkkIW50Bf0eOuloNYR8CYO
         dOz3CXuG6k6HOGwDalVMISs1A3ll1nWGZ4lysuFdJhkxVDRZFxocqGNks+XdBPfMmbgo
         Re0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVdcC9AVWtN6X0R2G6LEfvI3W7plOZrvAmF1E2ynVb4=;
        fh=clZwNbNg+tY980GMEcWpfTLtVDI4RZdPHDkn7/tDEW8=;
        b=MU0skRJTHh8Yx08EVfZZB+T7q8Dt1Wt4BZ3rZ8I9aJRaSexWUuDVEGjEPH5Fd4MSTE
         iM5Pu7vwIo4KlxydDpUqJGcDNSeu2HP0VxmjzVynuUi4ZXjFEvWRlQvVI4Z4M7aU2n/O
         uRBLgYWSqUGb1hbEO4YUqJDBa4CKXgo1HY1cy5CCWAJEQJtP0uXPEErHkreoXl4rkYXb
         Q8BQKt0NI0zdNy405YfJsJMEJZTtmwOJJvDZhks5uFvopwkzgvZUElNDNjF3WHfK9EM5
         SY/onPAWBGcXdDBMb1Rtd2sDWrNp+uok2gglkcGOi7opDksd+xMdr3owLC7h3+KoDT1R
         FpDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765472619; x=1766077419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVdcC9AVWtN6X0R2G6LEfvI3W7plOZrvAmF1E2ynVb4=;
        b=PPZoVqsEZhurkULXCRc7AZUKzcXInkbTplhWtlxNZQ1WXEXlWBz8AVOTi4zSNj/rtb
         +AGcVOuDKhLCmcbrN/NOWYaypGHfvuI42h8qoGlk2BD4buODzmRBsdckMLATAqNJzIDI
         V/MksXyDFHSGT6ulp/LmXtj5AuDm9ZZHap6IeCz0E37BBkxXC9SRekqbDTzroKAhIuSo
         bsqK9YIRqfqrOtWB7wdNxeGZbOBoB04g+1xBzaN/bP16JET6+/7kW1jKCjLP/ix3Pmkj
         OqOsLvgizq1cpQZtWLU8hbA9q0qAgTULxKb9Am/XHb1LhFMVxK896fzzWS5s55FhXkXk
         3MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765472619; x=1766077419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVdcC9AVWtN6X0R2G6LEfvI3W7plOZrvAmF1E2ynVb4=;
        b=ssZYS+dS27AVg6P8B10WuM94w/vv3nRWGNW23qoZu4XIWo/4MQ/QZLj2atjJ+9xZ6T
         ww3eHO/b6Guw55BqHiYIXH+zl/6Vo+j4+lZ6mNCTv2HY12kk+UPU2y7JEMPeQfVCioDv
         5wrJ65SJmWFj49DwWeF0o2LR3jk+wep8sULM9Ql9rIkSLW97ukm/50mUCkIhNa3KYwRK
         OPR2yRCUJokl3QO9+ymuuDiCyYgdw2iqxtHeUuxRan2PQQcoFSvQ93v8fIp585xwYskP
         hwdtqYQRCMR3Pi4E8FX7u/fSvK0kzvuK5Uirwp6biHQu8fV+wDq9KTd9PiMJCePEHA8u
         kHog==
X-Forwarded-Encrypted: i=1; AJvYcCU9KLij+yCbxZyuinjvrvO/+VqJRnbHYSzl76TWqqqZNApXHMXAnPPD1HV66tmvpUz/rzny9gmXKx6NA8kmsQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVca/pwnOKALuJHAIDw30LAg70KzYX9Fl2iEOfMnarGmd9OBzo
	65QH9O8oFYtpVOLVOTHykV3igcej83NbK/gDGH7Tn/KvN2E6x0YjuOCwA6CQCot2+01kjm8S9qQ
	ub0KOgHZV4iwtTHdcW/4gOL2fsDSrbAFm68K+5/Ej
X-Gm-Gg: AY/fxX6hCX0A+FIULQ6n67GODXni2V+HAUBITxQ+QkE5A9pNh0LYxS9YWKWC3HQfTbL
	GLaPaPIzKp4Q5jhSm0xQpdIBvrc9/nw8VUpxs5JECAiekwMu99ImOQmyFmewphzV0f4QZ8kLfm/
	8ufRBUiP0GGXtNcvcmnJiYUlRM5+MNwzg1wg53fY6P6C9pJXd15iyjmk9gT2MAcHj/nSQ1RwYDB
	GZj2r7/xk975iiPfa7RqF8f03JqtXDDci5pT9Am8+3B19EFdacqT2ww1UJnLHKV1Ee9Eb5ox21M
	qNY=
X-Google-Smtp-Source: AGHT+IE1/twXkBw6T9ZDd804UY8hfxB7e6+cB8iDcmq/fCjHoXaBhqis+kpZHtSWJX+Enpr6HBPUEcW+9sWfx502HIc=
X-Received: by 2002:aa7:cb82:0:b0:645:21c1:28f9 with SMTP id
 4fb4d7f45d1cf-6498600598amr51468a12.17.1765472618955; Thu, 11 Dec 2025
 09:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008033844.work.801-kees@kernel.org> <20251008035938.838263-3-kees@kernel.org>
 <aTc9s210am0YqMV4@agluck-desk3> <20251209001139.GA7982@quark>
 <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org> <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3> <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com> <aTn0WdVv-S_EpQmS@agluck-desk3> <aTqAxfiVCR2ch4I5@stanley.mountain>
In-Reply-To: <aTqAxfiVCR2ch4I5@stanley.mountain>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 11 Dec 2025 09:03:02 -0800
X-Gm-Features: AQt7F2oUBa6EQ75AaBiCKmXyExf-Brdy_futQsfDUwAYhQV22rWe0uokYAyYkCc
Message-ID: <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL characters
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Chris Li <sparse@chrisli.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, 
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, Malcolm Priestley <tvboxspy@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 12:28=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, Dec 10, 2025 at 02:29:45PM -0800, Luck, Tony wrote:
> > > diff --git a/expand.c b/expand.c
> > > index f14e7181..71221d35 100644
> > > --- a/expand.c
> > > +++ b/expand.c
> > > @@ -535,6 +535,8 @@ static int expand_compare(struct expression *expr=
)
> > >                     expr->taint =3D 0;
> > >                     return 0;
> > >             }
> > > +           if (left->flags & CEF_ICE && right->flags & CEF_ICE)
> > > +                   expr->flags |=3D CEF_SET_ICE;
> > >             if (simplify_cmp_binop(expr, left->ctype))
> > >                     return 0;
> > >             if (simplify_float_cmp(expr, left->ctype))
>
> I'm not an expert in the C standard, but this feels correct to me.

It only fixes comparisons though, the problem still exists for other
expressions. For example, while `_Static_assert(__builtin_strlen("")
=3D=3D 0);` works with this change,
`_Static_assert(!__builtin_strlen(""));` still fails. Perhaps there's
a better way to fix this than changing each expression expansion
function to handle this flag?

Sami
