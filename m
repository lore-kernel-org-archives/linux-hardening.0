Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98243CF6E
	for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882640; cv=none; b=jV2f4htps0xNb+rDvahe1Br1BrS+a+5f1Cv7F/TgY90EVMwVDHKhP2s1oF/uX4zvl5PR5nTcpdCZsm++BsfPbhu/Z3AAH/S/hJ/HBRIjxDzTkhFJMH4wQ7UZ6jyPoyaBEg2TGIKPZCixYzOn6+UlgXHLP672OcVEr4LtS7DNNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882640; c=relaxed/simple;
	bh=Bg5O22U75rqlMnX/ePS1zsGUIyjtYU5uXFU+wKROdF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn2aN3qbacV/lDX4ykHDCYAvzA4ISvyG7yNs5mF4jHbkzaiefSFmSCozal44N82sTdQqOVUwH15/j2XUiG3xRAsuTi1mYBGc3DlmNMA+aApMnmyy5469WIcR74VxG2muHEVvcin9JI8tM4/wY2IbuzQd3gy1OKG3PJx30dtNQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BrMm7b+p; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BrMm7b+p"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso8083982a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710882636; x=1711487436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXyTHdBINJAGv5SDzujCKegsUk6ZlTJU8rXZcTRQcWI=;
        b=BrMm7b+pPY7gBn2+/DxekGmJpA++PAtwN++AgCi4JvZIczPsYFKAkAKMAtHOwsi+OK
         6wzLPFm8J11iRtGyMWdIQ/ZfCH9z9OmT4vhF+VneGjhj36mljoVVYTEpIVazjTTZeqzZ
         ff9buetMPWFk6wRJdyNx5f9acC+TOPXjhgfwP6fiaEklblVk8BBa1hhVhhp9qtyraidE
         O8/RXJWxBuMyqIQm89MsBAMK+jEXEfE6a7oQGNokKbmdiyAbkcYcuwAmR/pkEXFxL+OT
         FjycS8bAMWdA0MX2sApUkQfM01T362u/FY9V4CUysPpHYLJ8YwLNbvLJnlWPJFvRCcps
         1aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882636; x=1711487436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXyTHdBINJAGv5SDzujCKegsUk6ZlTJU8rXZcTRQcWI=;
        b=Tfsec4BygMjBxBygiafPBLWcd9cTW3Ul2jURFcI/0wV+JywJ9c0MeT6vkW8LLUq+tn
         pFmEjuVFA3P3QcQkqWy8ij6yDy9ClJUt+KMNoisZOcaAcuwfs9BkErBoi33SY44FIUVn
         4Y9Tzc70Tq4hdGamSlbxT7F/NXWcoQtfChT3tKxhQLu3W/nU8qdOxM6jjZmXIkjyyow1
         Ay7yWJ4hxeHuQwKJuMmnSGtBpUXy5uX7g1XvIxd5W3C9zdVBXehWgCrtU9K9e2Z/9wr/
         pSOyqJl6qht2ZAPyPzvAfQDhPQhm6JUZMGOLWydWT4+A0u5QHOkngWr9WeMlfDQmcL6n
         HnGg==
X-Forwarded-Encrypted: i=1; AJvYcCUugLhpH09iMhyro2sFI97toRgbheVatJHPkBwGIEuWUPaWpxeSbGAP94K8WdpDGZOUyrJa506MTygvIjEaXDm29HkgGruJmnarfVKtas68
X-Gm-Message-State: AOJu0YzutJ2e3J37abHcaWNCrLC3TZ+gvA8U4hQRJhIgxiVFxdkjYSi6
	+VezKMDsY+XjboFstHjesZX1jFHUfhgJozGHVLQYeKai5DNSLK61haVgLjInaWf27MWFh5YbxA1
	4ecThsZUAaLbPhQd9h1jy5/UeeSnM5YXfzjCb
X-Google-Smtp-Source: AGHT+IGZHztom/M+JF3mlrAUh1Z4cKu8I7AIhJ/SwhbjcbH/ma1t+dETJuBHN07scTHpDNQJBFnGGFxqx2fwYUfODPE=
X-Received: by 2002:a05:6402:4313:b0:56b:989d:bdce with SMTP id
 m19-20020a056402431300b0056b989dbdcemr2132942edc.24.1710882635868; Tue, 19
 Mar 2024 14:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-strncpy-drivers-soc-qcom-cmd-db-c-v2-1-8f6ebf1bd891@google.com>
 <ag7oslzfcuiyuehxq5n5jth4adrhel4xafby5whxsvyybbm6dc@6rtwaolbmm45>
In-Reply-To: <ag7oslzfcuiyuehxq5n5jth4adrhel4xafby5whxsvyybbm6dc@6rtwaolbmm45>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 19 Mar 2024 14:10:23 -0700
Message-ID: <CAFhGd8rdd=qmAmax27gvExZ5sweC=porkS6dW3RJh7NV1ydjSw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: cmd-db: replace deprecated strncpy with strtomem
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2024 at 8:37=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, Mar 18, 2024 at 10:49:23PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
>
> I don't mind changing the strncpy() in this function, but I don't think
> this problem description adequately describes the problem you're
> solving.
>
> If the motivation is that we want 0 users of strncpy() in the kernel,
> then say so.

Fair. You caught me in a bad case of "copy pasting this blurb into all
my patches". You are right though, the true motivation here is to rid
the kernel of strncpy.

>
> > @query is already marked as __nonstring and doesn't need to be
> > NUL-terminated.
>
> You're not wrong, but in the event that strlen(id) < sizeof(ent->id) the
> destination should be NUL-padded - exactly one of the well known,
> normally unwanted, effects of strncpy(). strtomem() does explicitly not
> do this.
>
> > Since @id is a string, we can use the self-describing
> > string API strtomem().
>
> "self-describing"?
>

In the sense that its name matches its functionality:

strncpy    =3D=3D=3D string to string copy, bounded by n

strtomem =3D=3D=3D string to memory buffer

strncpy technically does the latter functionality as well but it may
not be obvious in all cases that the destination buffer is not a
string. Granted, in this case, it is extremely obvious what the
behavior is because query is marked nonstring.

> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v2:
> > - use strtomem instead of memcpy (thanks Kees)
> > - Link to v1: https://lore.kernel.org/r/20240314-strncpy-drivers-soc-qc=
om-cmd-db-c-v1-1-70f5d5e70732@google.com
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >  drivers/soc/qcom/cmd-db.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index a5fd68411bed..d05f35d175bd 100644
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
> > +     strtomem(query, id);
>
> query needs to be NUL-padded to sizeof(ent->id) bytes (like strncpy
> does), something you recognized by adding the zero-initialization above.
> But why split this requirement across two non-adjacent lines? Isn't this
> what strtomem_pad() is supposed to do?

Yes, strtomem_pad() will accomplish this task. I'll send a v3 fixing
up the commit log and use the pad version.

>
> Regards,
> Bjorn
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

Thanks
Justin
