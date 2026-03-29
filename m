Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4837C922
	for <linux-hardening@vger.kernel.org>; Sun, 29 Mar 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801751; cv=pass; b=lv2kyckhkj7pSvDCy9F88flxdDyfwChxQtNz9G12RUfA0GkYBw1DPnofUnGODV/0BupJfx5MlY4rtk/C2nmE+sZsEm6J4RBdRzE6FpegYXtFTCx+TVddTn09a6BORvut4A/j/8JJ07rkNAxY2+WZtg1hnpfBNx1gIFW4Sn8oai0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801751; c=relaxed/simple;
	bh=vEir1DwZKH26fqAJQsc/R0LuSbvMpXsHsRJuEor/s8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wxp99iMVGXSxmpsJqfjFnU9AFZvSMVZ3cgW8R02aHQBpVcD04hsPcuZUrLjdrNoB0ZGPPpjE8mAONGGB24XTIoNnW5U9oVCLTurFitt48BOHjYETh6HfbVrzyAIEtkoyvLnj3qi5AqwUGkeOn6xkiN7NFut4+vXmxdxWbH8Q5cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzvIzuP/; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzvIzuP/"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-679b072ed3aso2067912eaf.1
        for <linux-hardening@vger.kernel.org>; Sun, 29 Mar 2026 09:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774801749; cv=none;
        d=google.com; s=arc-20240605;
        b=J3MzGEx5gHOBDv6FKwAE5Eo8+m5P1GpUkrUCx2TpzgZoc1pczejNxAvycj2XwxDkOx
         /TLLv6pazQjNMm9A6RwqcJOqWVqSBFo3tD55alyOLGF82EzB1OOSCs5CtFEq3CxkNSYc
         bj/A3pUBqVCgUmrP+hDcM2pQlXk0PUm2zzgbbcZQ6ND7Hsy2U1E9z8fJSF7qee5DVhgK
         VLMFDWAkrkSRJfh5CxdR6Lor4LZceeZwT7LqfdvlIFex8zQK7Lba1zZqDXcopyDDznSo
         fmLc+eKEA6anAylrpjrul7AJ+jDnNRWnlF5fTGGvEV5p0tcxmyEfBGZgS9VCF9BsT6eU
         GiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ID8joEdZSv02xx43opqsGRq0MLCufC4Y0nFvBo1+wHk=;
        fh=bNMBpQdn40OolEXzFYCg22lX9or8TL58lyVlpprG/54=;
        b=UYcnu7KrzfJH/BJG8odHw1758HbipgTvHzx2ODVwzPVHmDypuGUJZS+SB1Js0x3BSG
         9kk+a6Y57oL8RjRSyLaq9BWvSDvowbWPW56bn2qF1rQF3e8IaP6aPViaSlvQ6ScDnDxh
         /D5XGdjbmPCRpSsWZiqMMsb71Dm6BUop0GuJB+Ag5wITaM0+SauV9+DACLTXg9+UEYDJ
         F/g75Lx+v4gN9AAIJ05Y0sxkgWfolk7AqoPxsdfQme9042IyxHztHWC1px/mxIHJD4+i
         i8dqBifjBnmuBdv8cRZ3watvxHPAaa1UuTGg1wGlheWkipH6cD8+RSxTQUmlTyR4U90B
         1F+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801749; x=1775406549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID8joEdZSv02xx43opqsGRq0MLCufC4Y0nFvBo1+wHk=;
        b=XzvIzuP/6IlCtj8SwwCV5oeO5S9a8dHnvcwPUcFa7ltkW/+Er+bNOFqiwxVSXdrtjt
         Vu2h6DlfK1sXwNh8pC2v5X9JHuOnpl8SL5ZLxVn6n1bO62GIvpJxm+cg07Mnz4BfnoNH
         ilhWv7utGiVehGZxf1Tmsd511PVCJ9tvx76R3SROZzO8eRRMTPVhOSKQJTPSn14q7qLY
         8YRBfBoLCZ54n5wt2Ql80L/rWfzTTGqjSgyKnQVXeg3kWdMWzq17D3fQkEo3JIQDruqN
         YTr0nb8QWpWpPudsIayKd/2iJMXv474bNEQJbZoSW8z4VgkRdPSrbnjjgdbXR5T/e/UX
         Cv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801749; x=1775406549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ID8joEdZSv02xx43opqsGRq0MLCufC4Y0nFvBo1+wHk=;
        b=L2LSknVUZyZyB59vvVgfHs7uFDwezMaCgVTMQ9xpjh1MGhiGqjDSOBJ/x2idSFAmGS
         vb6b5DOOht1ou9b8o9724QBKYD02limyRLZxcwA8kRpoceTopFmeING1WwK6mRkuIeGr
         Ca/QVNaWLcfMeLHG4PghD11zks4cRpCpQq8dh4OE9Jjw/y/T+8+k/Wu1Uwa43OsprQ9M
         ggVebsyM4E+bM8VvvsXhYsFCiBrC1G2d8P7slTQIDZd+IFDHNz5x5ka/K0xpHXW1Z+R0
         pF7lUcPI8xFl6eXOheJZb8PnIxhAN+YHDJzRsnODHztG9eKWK4GFfAiFh+wFY54wJMoG
         2BqA==
X-Forwarded-Encrypted: i=1; AJvYcCW0NhgJs/RY/NL0mCbqyp7Mn4SUn0Tb44HFt894N86gizgBxIWuXUHoSMSjr9Q6a+rNptZeZaoxDjy0h0sB9vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYuA9gjdnoidKNJ22kCaiGopFjX2io3biPzWodkdfsMUxjl+L
	msw5gAlgICAMLRz8zdQSoHGg3i8CpLh0HsQoxqcQQHQkm4ey8QNGmCgxg+m1EvylWo7mYFk8w6B
	frBRPVa8Ip08zWVpIgn5fegyc5D+da6E=
X-Gm-Gg: ATEYQzzHpcX7aoSSOhhfIyU5zZwjgNOkkm1nc69M6KEEYX5sZVC0TvcUSqXqCQHmjEM
	Wu/zCm2TM1H9F3h2Ps05IJrnmTaiSsTPYv1gfw9vXo3i9G/QMiRPVKmrrncdWROQ9RUcWWP4COy
	kRIFfX+juR2iPM7wjt1u0/JOjKfeQp9ZtyVFCN8HMRJEDHnqLosMFKwi8gzn+Yv3S3JBk976RLa
	BmONmh3iVdStkFQ7rJrhtZB+s5gHbbATolLl4aZHTjCxazIDBkThVHBEBWfQHXatWskFzh8rxcE
	NrvCPCGb
X-Received: by 2002:a05:6820:1f01:b0:67c:28b0:392 with SMTP id
 006d021491bc7-67e187531d3mr5156273eaf.53.1774801749602; Sun, 29 Mar 2026
 09:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311003559.31990-1-rosenp@gmail.com>
In-Reply-To: <20260311003559.31990-1-rosenp@gmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 29 Mar 2026 11:28:58 -0500
X-Gm-Features: AQROBzBEYkAgmh7eQXnRGfrPM0LvlOfSkTqABnllUCmZ5jwcMup6jIzJDdEgshg
Message-ID: <CABb+yY2r8Zf1a+nUS6PaMrORTL-4Ee=Bj__jJWox=iZEQyKV2A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: hi6220: kzalloc + kcalloc to kzalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 7:36=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Reduce allocations to a single one by using a flexible array member.
>
> Allows using __counted_by for extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/mailbox/hi6220-mailbox.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-ma=
ilbox.c
> index f77741ce42e7..69d15b6283e9 100644
> --- a/drivers/mailbox/hi6220-mailbox.c
> +++ b/drivers/mailbox/hi6220-mailbox.c
> @@ -79,12 +79,12 @@ struct hi6220_mbox {
>         /* region for mailbox */
>         void __iomem *base;
>
> -       unsigned int chan_num;
> -       struct hi6220_mbox_chan *mchan;
> -
>         void *irq_map_chan[MBOX_CHAN_MAX];
>         struct mbox_chan *chan;
>         struct mbox_controller controller;
> +
> +       unsigned int chan_num;
> +       struct hi6220_mbox_chan mchan[] __counted_by(chan_num);
>  };
>
>  static void mbox_set_state(struct hi6220_mbox *mbox,
> @@ -267,16 +267,12 @@ static int hi6220_mbox_probe(struct platform_device=
 *pdev)
>         struct hi6220_mbox *mbox;
>         int i, err;
>
> -       mbox =3D devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +       mbox =3D devm_kzalloc(dev, struct_size(mbox, mchan, MBOX_CHAN_MAX=
), GFP_KERNEL);
>         if (!mbox)
>                 return -ENOMEM;
>
> -       mbox->dev =3D dev;
>         mbox->chan_num =3D MBOX_CHAN_MAX;
> -       mbox->mchan =3D devm_kcalloc(dev,
> -               mbox->chan_num, sizeof(*mbox->mchan), GFP_KERNEL);
> -       if (!mbox->mchan)
> -               return -ENOMEM;
> +       mbox->dev =3D dev;
>
>         mbox->chan =3D devm_kcalloc(dev,
>                 mbox->chan_num, sizeof(*mbox->chan), GFP_KERNEL);
> --
> 2.53.0
>
Applied to mailbox/for-next
Thanks
Jassi
