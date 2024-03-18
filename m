Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C05C8E8
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802074; cv=none; b=H8TfeSJP+d94zoCAeMQzNnp9bvuJBnFvHVHtjHZb6h2encNZWKKWnD2M2O3toJKZOjF7BLICG0vw+mYM2u8O9ssJMYxtn1Zxvgsd0gmqS2w+6KeHlaTV/5c94Xmv2kKhJ2Qiw6zg2dMxh11y0VwtrDPQ8efwIqcfLFtAJ3pBKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802074; c=relaxed/simple;
	bh=sgJpHUZz2x1AZvyW1EKEo+nb0tE9bx0IKzCXyGwvoTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CP3NOKlFToJOsgTelgrau/E7zI4l4tcPwinx4CoDvgD2bkuF6rTu0LE020Gv41jbYSVPtXtE9ArLV05csfgU0cgu1FneMYKFEqcRP0NzNQByxSYSRPURMX7H37PmttRFAX9jRsYOp/AZVtIqDOURBopviful/+i4gpz/ARoz3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGzOtRU/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGzOtRU/"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so594183a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710802071; x=1711406871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwEDj39erEoMuYqN28dZy8EutQd8hp6VzWoX2fGRLFg=;
        b=hGzOtRU/rALna3nKk9+qelRUyYRNxE5XV5JmiLt41VTnhXymVIGzXRPwV80huSoq6l
         CwLwa4Kah4bLxFk7tqZvIXd/Ot9Y3T8xPuYpSWSLCeXruo1rwjYr4DvZ8E34Diqm7oy4
         fcXn9p/5kzL4ElVYd6XKoPo2L1PUXpwqZPG4jePya3K7jxB0QpqwZ/G3Y8TPB1/HCnKk
         OEcxgCmpfuXqXeWKlK6+x7N8y4gV4lypNHfiw5/EtnvTonaVwDQDg02B4Vsed0GTJqu6
         E5sBmAHkDAJANOmajRW0TXGRNtJrVc4PIwmgtf5q9MYNxcQdz54T+1THuBDj7kWZtxgj
         qYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802071; x=1711406871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwEDj39erEoMuYqN28dZy8EutQd8hp6VzWoX2fGRLFg=;
        b=BeeXgEoE8p3GRzRpsZu1JR7w6TvBM/oUKD/wO3YlVZufs+UR8SxBn5hZMx9DFBwxCY
         u9UEMQ4PNf8XgbC2cQAYdTqAGHu3m5Ke9MA2nKiAssKt8aePy8m9vB2lDxpFjPiyKMKt
         wfd91RPQvk0VmHW8g5huHZ51JmUIZ0mNgcuceJYQ4sub1Hjb5F41TP9dLM1tFROarNZU
         I7OeMHs8p4IzDQa1II3DyoddU6Q0sbN2lO2ex3fQFQZ65fLSZ5EzuFzp9wxH90qIzFQS
         PS2EoIMSIrwtXjKH3kQPjlK9NAWLDESrnx4Ng9ph8rR9hqPifvzmApQns3pCdMRN8X3D
         YL8g==
X-Forwarded-Encrypted: i=1; AJvYcCWX01guEJ6mWg+5+XgajD6ryTxJcw2iIkfG6LBIHxNYkRuIFeAUmkXcVH853C0zHE7qNxAy2Oa073uFgxFaMR6Th9t5oyfch/P80A3X42Xh
X-Gm-Message-State: AOJu0YxeZcIr2m4FgWIdy4iY6+iioUp8VodcPO/LJ4IqKsucE9+vd0KI
	Ixzn+Kdl8SjlWXYm99AumZtcT0yCE8FWVSGkcDYHKB+ZdwXf3zeNOvj9QkQ9kYpbKuabr9OJbb6
	Lp2TDv+esgvXzsa1KdoKZ02bdUjVdLPRfjWpX
X-Google-Smtp-Source: AGHT+IHrzcDD4slpLWRRwgUrWX1KwFH+U27AhsbRWWZ/Jqtxr01plt1XfumdAhszv5GSqdbws/3/5gEL+RN+9r6lRXk=
X-Received: by 2002:a05:6402:2483:b0:568:1a8:58b with SMTP id
 q3-20020a056402248300b0056801a8058bmr10681423eda.14.1710802071141; Mon, 18
 Mar 2024 15:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-strncpy-drivers-soc-qcom-cmd-db-c-v1-1-70f5d5e70732@google.com>
 <202403181443.F4021C9F63@keescook>
In-Reply-To: <202403181443.F4021C9F63@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 18 Mar 2024 15:47:38 -0700
Message-ID: <CAFhGd8qJ+Sks33cgEie_cvj-YrAUUiLrA7wY42eWQ2Xr++C4Pw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: replace deprecated strncpy with memcpy
To: Kees Cook <keescook@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:52=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Mar 14, 2024 at 10:29:37PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > @query is already marked as __nonstring and doesn't need to be
> > NUL-terminated. Due to this, we don't need to use a string API here
> > (especially a deprecated one). Let's have our stack allocation also
> > zero-initialize so that we can just perform a standard memcpy. Since th=
e
> > code now speaks for itself we can drop the comment. A memcpy on a
> > __nonstring buffer explains everything that this comment talks about.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >  drivers/soc/qcom/cmd-db.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index a5fd68411bed..512556366a3e 100644
> > --- a/drivers/soc/qcom/cmd-db.c
> > +++ b/drivers/soc/qcom/cmd-db.c
> > @@ -141,18 +141,13 @@ static int cmd_db_get_header(const char *id, cons=
t struct entry_header **eh,
> >       const struct rsc_hdr *rsc_hdr;
> >       const struct entry_header *ent;
> >       int ret, i, j;
> > -     u8 query[sizeof(ent->id)] __nonstring;
> > +     u8 query[sizeof(ent->id)] __nonstring =3D { 0 };
> >
> >       ret =3D cmd_db_ready();
> >       if (ret)
> >               return ret;
> >
> > -     /*
> > -      * Pad out query string to same length as in DB. NOTE: the output
> > -      * query string is not necessarily '\0' terminated if it bumps up
> > -      * against the max size. That's OK and expected.
> > -      */
> > -     strncpy(query, id, sizeof(query));
> > +     memcpy(query, id, sizeof(query));
>
> Hm, no, this isn't right. We do want to stop copying at the first NUL
> character, but we don't care about truncation. e.g. imagine if "id" was
> a 3 character string followed by other bytes in memory. We'd copy beyond
> the end of "id" into query, and the later memcmp()s would start failing.
> I think what you want here is:
>
>         strtomem(query, id);

Gotcha, I was operating under the assumption that we needed to know
the size of id at compile time. Apparently __builtin_object_size(_, 1)
will return SIZE_T_MAX if we don't know the size of something. Sending
a v2.

>
> -Kees
>
> >
> >       for (i =3D 0; i < MAX_SLV_ID; i++) {
> >               rsc_hdr =3D &cmd_db_header->header[i];
> >
> > ---
> > base-commit: fe46a7dd189e25604716c03576d05ac8a5209743
> > change-id: 20240314-strncpy-drivers-soc-qcom-cmd-db-c-284f3abaabb8
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
> >
>
> --
> Kees Cook
