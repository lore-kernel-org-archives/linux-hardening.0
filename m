Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C313B7A6
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718557; cv=none; b=frZYZntGFfr+G3+w/wyAw/SmWwOC3SGbmZPF/K8JibtF03LuALo2QMsT3TrtJBrR6MmN5hqc6+p8ksatD5SpLuFfZ+DAR85FljDv29ZNaTJd91bI3qYL06zvx2vzZezKoTVSkkxaet9JyUBIx/8+zfjJyIH//J8W76q7avoi5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718557; c=relaxed/simple;
	bh=IwFibWqp0dwgFWN3Q2SCVS4mMjNTktVCU+aOq/rgAfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrg0na7QuJxondhKSZ0dcXfElwIOrvPxn5OZTiz6hbigaARXBn8rn2crWIL6poseIgfdCR+GhM7WNfYmj0mV1iUkGXuXwfaZy6zYvumgI14S3iUylyLeEWmp7ydr/sPrYZ+Y4JzeHBWxms3mO9ch7OFPO4D60o+GtYsdoty0AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaVljmeP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaVljmeP"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e4765c86eso113109466b.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708718554; x=1709323354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mb5cz3ojHnIgcbz7pp9PaVuRGwOWu7mamHfEE2Gos4=;
        b=iaVljmeP662qsA2unP+5qSiSsdCEklDePiE3OzvcWPaxOhwZN98BHh7+MYZK6hbLH9
         E3kQzJ+9v5/cJe8vVC+Y68RBhpJ/ShYxo5Qj+iEhQQTyM6a91Y490iu/cYeHPa0LDcNm
         FgemT3uNPxK269+Pyv0Dflvz8dcVP+BTyV+Vf5hpb2160DPZhOaBcGgOYD5pMkj7h61l
         ahACOs3nyB1yvT4TfPYlPNXSqpQmbVPNn3u7M7qQv0jdI5F5WnNvfRTr4805c249bZ7e
         gqECcyeKWk1z4zPDjvbj9BrJmKWXl4WeWH36JaQm/sOCNZ02QmsXEgdqFSChcBdXePLd
         ZD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708718554; x=1709323354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mb5cz3ojHnIgcbz7pp9PaVuRGwOWu7mamHfEE2Gos4=;
        b=uQeAgNqVPokEN4VIFy1968PlzA/x9NzYqKUG6JFaNurxzbKN/pzt5prbL8u7x/3vBH
         4Swwcp5unXlVKxcpkDsD6uR11GOXQUqtvNxmyz4AHR1KQuxqJ1COm6BQ1DVVtcPtaENj
         KcyHxbC96jhreDxBJUdFpwgtYO+mOAL74IDPOGoLfDPiXikTWnNcpcNWhbt3a+DNrSl3
         9mUuT/wyx8nxIlMyDQkmnMrrMoYJXtTj2V57Q927kBOu9Q+dV9Zko7ntEC+qdhYWVXU1
         beTMzgCUxq01r6Qca5C4DphvrcGMru7Rf0RTUdZePO1bN3/HHYH7AAxK6H1N1wJ9wWKL
         0iuw==
X-Forwarded-Encrypted: i=1; AJvYcCXZjpQ8LDANnsEo9c8F0k/1LCYY6GnEgSGIS79OgMLn8hhfMQAt36IKqWWPunfESEKtWRpNlBDVSZsYNDOUY9mkOM074OYSa5L81AC7K9u3
X-Gm-Message-State: AOJu0Yyu/J1jqPp7s+auuoFSJ2777Wv9hEVbboLN08Xyfkp/YbwL29kf
	bIYMuTvOl31kMcU5bIlydI2r3Ewcc4PXswl+3xAGWa1mYM/s7pU0uKOVO9Aw5FpS8C84UzZRTB7
	nzM71CIQH0ItdETipAmLncuFi0tH6HCBiG/ld
X-Google-Smtp-Source: AGHT+IH+/uyKSsN1ofQFJZfvOtibsO+r/FzbRmfjQZLGWFvPQu00SDorUUbKZkVPPMMHLMMpnKQSmd+1y+TSJcHPeb8=
X-Received: by 2002:a17:906:3609:b0:a3e:f00c:ee25 with SMTP id
 q9-20020a170906360900b00a3ef00cee25mr492276ejb.25.1708718553929; Fri, 23 Feb
 2024 12:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v1-1-20c685bd1b43@google.com>
 <BE9C61AA-633F-4CD1-BE5E-B01DC947626E@kernel.org>
In-Reply-To: <BE9C61AA-633F-4CD1-BE5E-B01DC947626E@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 23 Feb 2024 12:02:22 -0800
Message-ID: <CAFhGd8rTBqqQvr9vhpbfcSv6cpj5JSPVPSftqOPyWkZEWBP1AQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: replace deprecated strncpy with strscpy
To: Kees Cook <kees@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 6:38=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On February 21, 2024 4:41:52 PM PST, Justin Stitt <justinstitt@google.com=
> wrote:
> >strncpy() is deprecated for use on NUL-terminated destination strings
> >[1] and as such we should prefer more robust and less ambiguous string
> >interfaces.
> >
> >We expect ae->value_string to be NUL-terminated because there's a
> >comment that says as much; these attr strings are also used with other
> >string APIs, further cementing the fact.
> >
> >Now, the question of whether or not to NUL-pad the destination buffer:
> >lpfc_fdmi_rprt_defer() initializes vports (all zero-initialized), then
> >we call lpfc_fdmi_cmd() with each vport and a mask. Then, inside of
> >lpfc_fdmi_cmd() we check each bit in the mask to invoke the proper
> >callback. Importantly, the zero-initialized vport is passed in as the
> >"attr" parameter. Seeing this:
> >|      struct lpfc_fdmi_attr_string *ae =3D attr;
> >... we can tell that ae->value_string is entirely zero-initialized. Due
> >to this, NUL-padding is _not_ required as it would be redundant.
> >
> >Conveniently, strscpy also returns the number of bytes copied into the
> >destination buffer, eliminating the need for strnlen!
> >
> >Considering the above, a suitable replacement is `strscpy` [2].
> >
> >Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
ncpy-on-nul-terminated-strings [1]
> >Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.=
html [2]
> >Link: https://github.com/KSPP/linux/issues/90
> >Cc: linux-hardening@vger.kernel.org
> >Signed-off-by: Justin Stitt <justinstitt@google.com>
> >---
> > drivers/scsi/lpfc/lpfc_ct.c | 5 ++---
> > 1 file changed, 2 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> >index baae1f8279e0..42594ec87290 100644
> >--- a/drivers/scsi/lpfc/lpfc_ct.c
> >+++ b/drivers/scsi/lpfc/lpfc_ct.c
> >@@ -2569,9 +2569,8 @@ lpfc_fdmi_set_attr_string(void *attr, uint16_t att=
rtype, char *attrstring)
> >        * 64 bytes or less.
> >        */
> >
> >-      strncpy(ae->value_string, attrstring, sizeof(ae->value_string));
> >-      len =3D strnlen(ae->value_string, sizeof(ae->value_string));
> >-      /* round string length to a 32bit boundary. Ensure there's a NULL=
 */
> >+      len =3D strscpy(ae->value_string, attrstring, sizeof(ae->value_st=
ring));
>
> This could be < 0 on error, and at least lpfc_fdmi_hba_attr_os_ver() may =
present more than 64 bytes...

Am I putting too much faith in this comment?

static inline int lpfc_fdmi_set_attr_string(void *attr, uint16_t
attrtype, char *attrstring)
...
/*
* We are trusting the caller that if a fdmi string field
* is capped at 64 bytes, the caller passes in a string of
* 64 bytes or less.
*/
...

I see lpfc_fdmi_hba_attr_os_ver() calls lpfc_fdmi_set_attr_string()
with an attrstring sized at 256 bytes:
char buf[256] =3D { 0 };

Can we really return -E2BIG from strscpy() if the dest buffer is the
same size as the source buffer?

I'm happy to just make the standard strncpy -> strscpy replacement and
drop the len assignment. Let me know what you think, Kees.

>
> -Kees
>
>
> >+      /* round string length to a 32bit boundary */
> >       len +=3D (len & 3) ? (4 - (len & 3)) : 4;
> >       /* size is Type/Len (4 bytes) plus string length */
> >       size =3D FOURBYTES + len;
> >
> >---
> >base-commit: 39133352cbed6626956d38ed72012f49b0421e7b
> >change-id: 20240222-strncpy-drivers-scsi-lpfc-lpfc_ct-c-f54b67eeeb68
> >
> >Best regards,
> >--
> >Justin Stitt <justinstitt@google.com>
> >
> >
>
> --
> Kees Cook

Thanks
Justin
