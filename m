Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793938114;
	b=1cUJ6lYBjQS6+DZfvnDirjkrkkOPPfNxis0Y3MLpDrQvUgnbgOo5dScsqU5rUTVX2wV/
	 MxIqAZJN9COr5Tpn1xMHp+TNdO+1mtl0RouJJvRxRwZIqFOByu/kKgEm36P/7MTOXsPuB
	 OTajr17gDm2bXeOG/6NFhfLBapcdbvhf5GDi7TEj4gv4DK415QNysWa/bclvnw4bfwu2n
	 tduNHU4dkVy5O8E6I/pYfUNt/Ja1Ve0suQx97W3aVJEOrUtius/UOUGpC+M4AJO1IGLIR
	 C32cRUA2QnZS3duz6CUVLcm/2wYRKLcs18daedmv+ZJp02oX94ni3djHvHVRW/hhp8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/pk3SmESaznUmyk4iOi3We1OgCG1jt/asSQB3At8gf0=;
	b=1JEkymCMAiEMErnm5cx/SfRX/gs/PnvEaZqY0Q8yr22icgG5nhAP3ogN1DlycO3292D0
	 povORNXoKF6BUZqinVO4Cj9tQOTy1Y4od8SSSQmEHxy36gm8d+hiJh36GRSd3G9ZdhUuN
	 W4tF9mTTH8rJWsQoDV916kV1+G9u/Oo8PnCpQZm/psRCPojCU6MoJCmJh1CUXxVdJ7ERC
	 j1B/TIhbZ/750n1rKVkyYkyLZxxrbfHrAwknf4BvvvlmEirqt+4t/tMt4qqjpPObVd4Rt
	 FyQoCwvkb/JSscQ/EdjscIN5JNoLXz0GErAKsu/mgB6Kjnxl9SisG8XD2rEfn+Leurw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaCL5TeV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9A606A326
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 04:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaCL5TeV
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8446af403b5so169915a34.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 20:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793938113; cv=none;
        d=google.com; s=arc-20260327;
        b=imgimj6JxlljEKsXPFvWKUoPL8P8sTtPe2iFe1BQI3FpBpajUjxHxRb59r6f9xSg3F
         BAIpCVOp5MVzBw/TI3zkLqNfoK+t8I9ymAWikGvonbiJahHkk97tmA67ZjtYpLSwn6iD
         Z7FMpU0Vl2+Ltj0mO0dZZSt2lHVW5Lr8yfgvnw96qlpRbUVDv6fXZJ2sO/gGuhni5n/R
         BnPczMwNkQLLC0QAB7DI3N+vmUihbg/UbBZuc/od07DEvwRV4Hzpyo9uATciqmak8K7L
         FnQ+bCs+ZD8BtNcoZHttJo6jJ1c8uND3Mptn8863GdrXA8iDk3EGSZwBiDZNO+kkKooz
         8j0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pk3SmESaznUmyk4iOi3We1OgCG1jt/asSQB3At8gf0=;
        fh=ENk3Jr5srQ9OHKwrOEeru7HqYlcdsc9uZGN3kxkBzkk=;
        b=IRo3eHYUG5WDSk/VJU1zdBvhjHb7jyauRG03UjlOCWgWeoAVonX8nLbxApUjwDns5j
         etmqYzoh/NU+1ZbKc8NxebhyJXCNVezBLRlfteCOxapIQAsJbuDJfz/Sq+L71xkVVt+U
         8r1zntlxE/ctuKt0QUIcFEP57+cu+sWSwgSPP57sxDRgoRJOK1ZezoJqc30dAqOet2YY
         fUG5+PxXSNnbwGrGfB7g1xS1ktL8fux+QZAzB/cW91PkX2zd9ieEMygB12U9VA0PNQTC
         iLFO6tIzZ8CtwQX1t2/BOQ8HuVDbvGXLi9QK5gAclTV4OPpaBIE3z/vNLQlKe/JWUSEQ
         SAwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793938113; x=1794542913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/pk3SmESaznUmyk4iOi3We1OgCG1jt/asSQB3At8gf0=;
        b=AaCL5TeVWhCmOWRruX6RQ6uYlbxEmgGW0Fu1FL4Te6OGDFc2+E0dbhTmVykihBcvXc
         qW10F+az4GWUxFwfiqI+9lc4XYVEIwEDIhY4R4GQl+Wt06dOdwqAqbrKFKjIbCSDCFWz
         pYZpH++iT7LvufaCGF9Z1/BAjBZFjjaztq2+Y1vL3wkwrdDuXfW3sQ57A/rzTShVijSe
         ZAoS0eFzO5FsQdT+jdv+jDpQRsSMcmGkQc4UTpwS5svzqAROo8Kpf1MKedp0lW+tMIuY
         bss/LwjkCpG+lqsPeXxivKA3ZOlWwv4t1kExE7+N5n/+/dIHDNJf7GsRmJOWy7EVuft0
         8hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793938113; x=1794542913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pk3SmESaznUmyk4iOi3We1OgCG1jt/asSQB3At8gf0=;
        b=SQjdNm3e1sKZ0g36UvCt1iHTbSLYNT5hx5j87QxR44FilhXiK7Uz7qdkiKgOVfhQC2
         T89gSCw1ylG9xcHTFoqLcZZXiW0KajjHgqo6ZccHLMaulkDDQoVLzN2XmK7tv7WRzI1L
         p0+zQKJIOFvbl0CGnj0BT3h+YO4ulcpidqvk4stbzd6jqZLTlk57fpH+0lvHqCfaXDWn
         eI4B+YxoTeCP70EGo/n3gITAXOCTWx/ygpXh31zMf+TAEsWQwX+IUSPCYKU9kXLqxPj7
         cFW5BcF7GNsPzta2WFQiwgfSq1XxnUp/uPabVVFd3wrXh27Nlo4b3SPit35fOhTcqmrW
         1P1Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1Z3ekWB9CHiG5OPUAjTVXja5LV0pe7GPrV4EYrqFL8XHY5hGi/zRjWeVr51mcZbgEGvNYeCT1613U5wCjRck=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qSfBOzPWYc2qCUS4WokKwyKeLkW+vdUEtfEOAA/egodZIwdcy
	+p/ngLcjjy1ryo9PXoZ3fNfct86HFQReoDb6Gb8S3qRKL5p1MaXUBMQDXW/iuJy5K3km4rLqxvk
	S0Q6QVf3UrHxGlE+K2AbEMfumPkUTnaU=
X-Gm-Gg: AYBFou1FsL13otD2JhPsZPJc5PhfpB3HVq/Ych6r50uaZP+ezFDGMhewEj+tprMJAvA
	ElVWBAMSYuShdtgEXuYS/qmRG0/D4A9wa4xfY0SzNJLIfmDiNxXMfieEC+/FbtNITGj3CYdrims
	z/LqKaCpA1z9rcCduuq1ZB6IpQ2vIfDp3A8aymYvQ08uiNXz6VvxHIM6g3bLdVIMfGvnnlafwcd
	IhpwDKqEWROgABBxVrzD0ys7gvNm3/ZLy5ATnQPagJcMVeYIMkPCKCMd+WaQQAmfDelsTbDGDq0
	JsnG09cPZuzVwKl4QC5plkqcHGt/7q755K/kH6ZIaD6OSqEeGbf3msH2NpmrBKHctL4bhjH6uw1
	uWHlfzRxt7rzeDUAkVAv2WYTMRWfPtxXUejTtf4vcMN/0hzpbMRly4QscR6OVJbfTLhFph6N7
X-Received: by 2002:a05:6808:190a:b0:53a:6769:c35b with SMTP id
 5614622812f47-567e14c6645mr1033843b6e.12.1793938112995; Thu, 05 Nov 2026
 20:08:32 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
 <ausVkYs1-3rJ5Fj0@devuan> <20261105113229.4126d872@pumpkin>
In-Reply-To: <20261105113229.4126d872@pumpkin>
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Date: Thu, 5 Nov 2026 20:08:20 -0800
X-Gm-Features: AclHuK9Esb9F2uyydCP0odZv_dxt9WsR5I2SP--qP46odrTEOGmh5Cneq9YrqqY
Message-ID: <CAPDEY+WvnrFgriCyvL6tjY2GiBJ+Dsz0Tz4hJz=n1xW_fywTEQ@mail.gmail.com>
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in sms_ir_init()
To: David Laight <david.laight.linux@gmail.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, 
	morbo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 3:32=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 4 Nov 2026 12:25:17 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>
> > Hi Mariia,
> >
> > > Date: 2026-11-04 01:02:39-0800
> > > From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > >
> > > In preparation for removing the deprecated strlcat() API[1],
> > > replace the strscpy() and strlcat() calls with a single snprintf()
> > > call to construct the IR device path.
> > >
> > > Both the source and destination buffers have the same capacity,
> >
> > The line above seems irrelevant, and potentially confusing.
> > The size of the input is not important, because since we're appending
> > stuff after it, truncation may actually happen.
>
> And gcc's stupid format overflow check is going to complain.

Thanks for pointing this out! I initially tested with Clang, but
reproduced the warning with GCC. I've switched to seq_buf for v3.

>
> David
>

Best,
Mariia

> >
> > > and the return values are unused. This preserves the resulting
> > > string, including truncation behavior.
> > >
> > > Link: https://github.com/KSPP/linux/issues/370 [1]
> > > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> >
> > Except for the small comment above,
> >
> > Reviewed-by: Alejandro Colomar <alx@kernel.org>
> >
> >
> > Cheers,
> > Alex
> >
> > > ---
> > >  drivers/media/common/siano/smsir.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/commo=
n/siano/smsir.c
> > > index 283770d583d5..636ff228108b 100644
> > > --- a/drivers/media/common/siano/smsir.c
> > > +++ b/drivers/media/common/siano/smsir.c
> > > @@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
> > >     snprintf(coredev->ir.name, sizeof(coredev->ir.name),
> > >              "SMS IR (%s)", sms_get_board(board_id)->name);
> > >
> > > -   strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.ph=
ys));
> > > -   strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
> > > +   snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
> > > +            "%s/ir0", coredev->devpath);
> > >
> > >     dev->device_name =3D coredev->ir.name;
> > >     dev->input_phys =3D coredev->ir.phys;
> > > --
> > > 2.43.0
> > >
> > >
> >
>
