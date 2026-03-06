Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85199372677
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772780368; cv=pass; b=sgTrROOG9hVFAZ55cVn8NvDP5H/OAMZVjX04Q7Ryc41GkceegSYQh1TGvAqNq47VeVEgIdK4quFBucvPxNGfVjCr9FEcdEy+jdjtlwhFHbfZMNkGcr2rL5hgUGyu/28jjYEYA5KAV3IJqLJCgfXocNhqM+wMEBaWwJStLV6o90w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772780368; c=relaxed/simple;
	bh=H8A2pb3bWTY3QTDNwQYcwQRlfG4CWWzDSz/uhrkZqUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkm523P/UbQSA7E30AtujcPCzGChImtwbtKo2a5CzUdXeklAPwg7/8kCeKhgIygAY2260IxXZsL8pqqOYmO/s8jJT2/wMDbXQGnD367SDATLB27jyahzcxVU+gqPWkEt+rFsXlVZ2upg81CoXRdK0KtiViU72+Jd3EleDOqRmeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpIUgUy/; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpIUgUy/"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b941bb3e23cso167951766b.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 22:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772780366; cv=none;
        d=google.com; s=arc-20240605;
        b=GIWxFEs0gXCbJiXTPSc6XQSjT0Zt3eKYndT4zQ1g6HH/v4PRvA30HeFbjjXruRYL4l
         xvTcYXusFZEXKOqzfq/Qo6YR3bn2AgQGFtKXcFLfGfh1UcTE6Ea9AItSFaEs6jua1aBE
         ses6PWS17C8ycB8xVO/Yw0rmlmCMZaSidCHHnlukU2sscPF6sQ+G4+ps7tdWQNdWbm85
         Qc0mlzwTzmbvAvAqXfkyPeI5r3YMrttGFhJnsI3pKRtqDPEoIICp8BaOCnjwmZnTsKIC
         7zT4qitF3C7NmMtD44ESCy0FTeGHI+kV0RZaVRU41pPMRQb78CQ3sbENcW2xxQo6uTWQ
         zUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVlhqHe7CkV4fZT/h0SneJI3zUiLhQDfGLpZ4oeyULo=;
        fh=AohXxxs/JORMjKEbEIQxmgjFVYympfnAymZgAg9fOcs=;
        b=UFtvU5Tn5sreChxVNJ5jq8NvEjZKLS1CVgFOYgoOwFdMXtR02SjIsY3/v1morltbvl
         7jJTFzIGVWsyIQIR3d6OUB29WiSRE3/x5+2z+j6oQqKk+/0l3pjZUScoXs1lhySB1d7R
         rFiAcw8aXxdbyImY7vAHEtNweUNOplZStxYa6QngMX8zmoXCkv0ZwgCBFx6BnHpfi56X
         TeFdzhYfFEds0vAnKLMZnMAxucOFKnNS0A9j3Ol3nc7nvwscP/Hn7QPpYKkpZXn4UT+R
         WtzN+pJB61ZPpiLJa4iVa2vA9g7K4vodPk7fuQXesqOquBLYwqzK9FkeAtgzHemIO5Rt
         gDLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772780366; x=1773385166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVlhqHe7CkV4fZT/h0SneJI3zUiLhQDfGLpZ4oeyULo=;
        b=cpIUgUy/G2tnv2cmIoYaAu1HnDF5yYgqQz5PvAvexIr2GLjX7P20TVtfX/IB+as10J
         0VJXWJlxPeVoPHAzfNUIAifU8lr8pmPctOp51am1/xU0PQH9SRrMRjCGRKCTuIItSPat
         vnV5Rtps+EK8CeagoZo3UPpsfwmseL42BwWjMt9/4SsNFUehs9u6ZSlMINM7qATnhczJ
         FJvcEIOvs1REBr8/FL7BODvzy5ueC+bEdTd2CJ43/6Zzs4s8ZDo/PN6GJ+3kWofyMeXg
         Z/VaqUTom4QzpQjuoyG5JVj0iFADImFYNADtpUPRXVzgB3KJinYjFCMMnLUIAvKUk65B
         60Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772780366; x=1773385166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVlhqHe7CkV4fZT/h0SneJI3zUiLhQDfGLpZ4oeyULo=;
        b=WF9iy6OdVTQ+hb806y4AHTywuRICcIhzJzbpNy/ZXnks0HSIQ82sMx+03iUBqMchxV
         qPN3DrWakBhifo+bD0WF+dwDQlXWB3IoyNJn4AEQp+uiqO1xyJ1M+/b5V+7Zxg12AtAv
         JOa1bMYQpuh6h/kqBlx0vl764c6PJprvbsKO2gc0mX/jHEUuzjwI66BzQ0+uNcyFAymz
         DaxMQXRyc4lh3V8g24Uf/Zn+rm2W5I5ke3GTUwBszy1Geu3tpoUboDimoxvln+4ZDI/c
         +d5LRkaQZhODao4DUZHEvnE8NaFkD7viBxVl9Mb1pVc1SCWOiieB5UpkQkcog7ONT8kt
         FRrg==
X-Forwarded-Encrypted: i=1; AJvYcCVoyx2OXioRePbGbqHlcIkqng7kX1esvzfhGdriszDCLNg/+/hLpk2qjj5/q9ao/zXqrG4Tt3UbDivGO8+SDXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYJQe+rBf2MAQKHSeA4myug/Dq3flPxFkzYD2+NFjUZ/fvSqo
	XSEv0pJzJmt20hy/s7zc3vqVqYyYtMUqPn9qTV+UlM/+MG1Ps5pWWrfO0QZ79/BnMn1uH35UKlA
	BwOJcyF3sFWv+BOhEhTxZtwnmE7CQqt4=
X-Gm-Gg: ATEYQzxN9XGs3QaFcDBm14v6DMoLy8xjH3o6hP6Sc1cFQ2w+e9EQInvVR3yzeFFMd38
	FsycSQexJfkeOPKEpci/AFLJsx1fNxzjT7qGtD2y03d0vqENGKJLTPMcxdE4ZZY2YKfG7zcPxE2
	9a8EGbnmkciUEHOOJLONxMyH59fqLQ9gRwN+4lFhrPGW7/dqHd715cE5wM4YpVBzNnZBqpbdSrD
	IM5iaYQx34sRj0yBNWUacNLOjEBfskTg7T2O8TDpO4VQuDiXD65ny5BkeZxwCXK4A6FkN0Dynsq
	qQEK572+3AW3w4LtLjiNoTsiubXA6chzXn60/hgNO/qxkpQAJmv4Js57vN7FiWX/GedhxzzVMx8
	t7r7H2g==
X-Received: by 2002:a17:907:3f07:b0:b90:ba21:62c4 with SMTP id
 a640c23a62f3a-b942dfe566cmr55999266b.54.1772780365567; Thu, 05 Mar 2026
 22:59:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306044536.149204-1-rosenp@gmail.com> <20260306-handsome-quixotic-catfish-705bde-mkl@pengutronix.de>
In-Reply-To: <20260306-handsome-quixotic-catfish-705bde-mkl@pengutronix.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Mar 2026 22:59:13 -0800
X-Gm-Features: AaiRm50vB-zSPWaBk9wa73JDVss8keXDl3ZA1Vf7DNaa1ZQu4Laz-oBPUltxeOs
Message-ID: <CAKxU2N9szBV0C95=v7_HxJOBgOhFv1J=k9XPE1Lm-w3zQMQWdg@mail.gmail.com>
Subject: Re: [PATCH] media: nxp: imx8-isi: remove kzalloc_objs
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-media@vger.kernel.org, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, gustavoars@kernel.org, 
	open list <linux-kernel@vger.kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:56=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 05.03.2026 20:45:36, Rosen Penev wrote:
> > Use a flexible arraay member to combine allocations.
> >
> > It looks like pipes never gets freed anywhere. Meaning this effectively
> > fixes a memory leak.
>
> It's a devm_kzalloc(), which means it's automatically free()ed after the
> remove callback.
Yes but pipes does not use devm.
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
