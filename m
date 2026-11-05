Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878352;
	b=ahYoZ8bsrekXQlPTw/YOc103aRSo971H0zeDJQ5MvnEIYJXAtHZDS1spq5oN4gUgKgXq
	 kBtfKYIvM7C3+Y/iu+I2Xqkio/+rGameuoDw7UdVX9ONas0c1EOAKaylZhtIFrsdHX5HV
	 ExIJv/ngHZXXshbHtp3KbXeBO1lHajal+Wl1auuGa8yu06zkgyij/SZ/0l29vj9ANwFfE
	 scnD1AeNbv+Rh3/+Fj89Gd5Eq6WwdqvHAmcmTZdFYXXiqy3hvB1FH7NJY0XqklkAR4+Ep
	 ebGx+M8PLin0Vhf3tiBHOL3aiWxDSo6xqhaysX1y2OshHPR52LMDsNelCufPAUfZd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Hv/YqhUcbRh9eWhND1HEmPv7Wx8/p/XxUOLWb+cXlc0=;
	b=Vo28kjvCxnEX6p1jR0O327xC8WYsu4J7hMe1wcqZFi2lmgxinyJrm8UDwPMERmUP6tHw
	 f83N+NWvCtV8+Q8LCmcPwmLvJjFH9zcrE5BMCJwTqOhWkk2ZeQR/kfFuHX3c1j8ZLDDjB
	 0ZdYSMbc5Lth5jGq8jXCi0NlsfZRffeEfcDiEj4c/fciqRlaGmp70nXH5YgyI2+EGWU+N
	 o0oqGdAAGLewTxbOZ7eXDuyWda8yUcuvstf69cr50GaLDMJPjJ3q2CpZfaFtyAQU6XEdE
	 Is6f2YJUVxKE3bDI6Dw9sbrox/ViJctdSby1viR/2HSJOy3me98MjFT5PWdA7+XJs1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCzhsiwh;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F9606A328
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 11:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 411F9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gCzhsiwh
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48fd2e38825so1187267f8f.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878350; x=1794483150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hv/YqhUcbRh9eWhND1HEmPv7Wx8/p/XxUOLWb+cXlc0=;
        b=gCzhsiwh+9TzJMsLX87aGG0KzgXUNwVed4ZEt2dCuLs93W8hNgD2S6kh7CnhDWk6th
         c+/CJBoTDuiXWkKZxA4OBTMoAeBM651auVk8jLmD9tODmsIIGa0CQHfpUvEnJniX60g3
         4eaKVYlIIWc+97nFpdoSr0V/kz9Rm5Q7npP/adX545XmrufV/7p+1FuacB+TRxp2iMHo
         eDELcu9+7/fRm0sCUWh7ZPZLywlbhqt1WfY5cSBiksN56N+g2mjgxr04UtSMjA94pZc/
         ICfzzuVeqGRiu8Qzh/bnysZ8Ri9wHCdM8ME6YT9AM3k6WjIOmMWucFGBt5fCrYaVafip
         KyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878350; x=1794483150;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hv/YqhUcbRh9eWhND1HEmPv7Wx8/p/XxUOLWb+cXlc0=;
        b=NnCNcqCwdPDftBZMWMqOLNc0NwGQvEltx/BaJ0EbI+dszc9hfKQ6xOgjRIWD7LohVG
         d6yjriT02zDvgtCGBzp2vdwHzf0IZ00sa3hiTdQkmydtJKyGnsMeNFPP9S5VTNne0x0c
         sQsUdbY/Ki3XzyCW8vFqF/P2juh9LT8e5w7oe+uUHYkL9lhgHj6r6O8Jq+rYH1px7zb+
         0FT5J+8D+7y5GFxF0QERdFB858VwdQ1NfThTUyamIhpWbVH9lOltLZBePn+zFtbuHyzg
         w/fn0771ayARnO4fbTBe/8K368bYP6ZcCLx+Zhglk+yBiaOL1O0jFdrmL0lXPhmy8Qcb
         xJug==
X-Forwarded-Encrypted: i=1; AKwUvBwTAnfdsdyR3ds1SdaJgoWqWwimCmi4TOV0SZyTIE7hXLgGmiegI0ucVxx4vZuniM1V4Nx4tFRPTCisnnABVQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OWl/5INR95XJotmBv5AT38fd/bzKie0VqPfYXmbYncHMNea+L
	RGx1QRcnT6YJM3FZXVNRYSib43SAkgz0WQ2hZ2NO6wojqyEhNpNBCnl8
X-Gm-Gg: AYBFou01f2UR7Rg6r+Z1po4DT8ps7QXeIUeC6Mz2UctxxVx0L7lArRRm6onrNMrlmsk
	wtQic/flKnQBeZqk+8YrN3AFuZ+8K+popOuzMDbvg126Fn+VXxP43+v8KQBGqISMhE8yqR+lMoM
	soJByiqET7jjY6xKpi9nb9xNausjvdow/+4d3u0jnWMC91V/rKG7DPJM8ayDHcVpAuQI7fk6H10
	2c9qwITETSPR9abSVgyVO7A73rKfxQT+IJkvA1+9xsVqO7mmzJcTcvw+VrPmhImztNEuijVT71w
	fXI0+h4mlbm4MkcEtzmpheH6w/BaaVqQLLhi3QbnQKgvl9BMI/7H0fD9K9XVCjVq/XkdRjBxGED
	VPBo/Z0YPJkUjvo2vSQ339ddEHO1QSyjZppheNWlE6/Se8jJCLuwnlpGAnzcXFwB+/Do9ZhAPtL
	uhJQn1x/z1qsTWvnt5MNlFOwBDZV7s0pF1ErVORaThoHCC/rmIbir85Jgi6//CXGbGLH59CSqEt
	NvXY1Nh/IHltDRBeTJbGAFyiy8JMQNVcPS6fH6Xhp0Ksy9lj3FsyWE4roLEjwnX2E6w+WwiYsi8
	4eVKeQkOxxrzF+A4pgrV7mW5jJRO3Yl4iJHAK63ivdiTesqq/ntPXntUkd5MRvvR
X-Received: by 2002:a05:6000:46ca:b0:48e:679a:4aeb with SMTP id ffacd0b85a97d-48e6e2bcda2mr28288827f8f.3.1793878350394;
        Thu, 05 Nov 2026 03:32:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99a5dsm9469614f8f.21.2026.11.05.03.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:32:30 -0800 (PST)
Date: Thu, 5 Nov 2026 11:32:29 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
Subject: Re: [PATCH] media: siano: Replace strlcat() with snprintf() in
 sms_ir_init()
Message-ID: <20261105113229.4126d872@pumpkin>
In-Reply-To: <ausVkYs1-3rJ5Fj0@devuan>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
	<ausVkYs1-3rJ5Fj0@devuan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Nov 2026 12:25:17 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Hi Mariia,
> 
> > Date: 2026-11-04 01:02:39-0800
> > From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> >
> > In preparation for removing the deprecated strlcat() API[1],
> > replace the strscpy() and strlcat() calls with a single snprintf()
> > call to construct the IR device path.
> > 
> > Both the source and destination buffers have the same capacity,  
> 
> The line above seems irrelevant, and potentially confusing.
> The size of the input is not important, because since we're appending
> stuff after it, truncation may actually happen.

And gcc's stupid format overflow check is going to complain.

David

> 
> > and the return values are unused. This preserves the resulting
> > string, including truncation behavior.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>  
> 
> Except for the small comment above,
> 
> Reviewed-by: Alejandro Colomar <alx@kernel.org>
> 
> 
> Cheers,
> Alex
> 
> > ---
> >  drivers/media/common/siano/smsir.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/siano/smsir.c
> > index 283770d583d5..636ff228108b 100644
> > --- a/drivers/media/common/siano/smsir.c
> > +++ b/drivers/media/common/siano/smsir.c
> > @@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
> >  	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
> >  		 "SMS IR (%s)", sms_get_board(board_id)->name);
> >  
> > -	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
> > -	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
> > +	snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
> > +		 "%s/ir0", coredev->devpath);
> >  
> >  	dev->device_name = coredev->ir.name;
> >  	dev->input_phys = coredev->ir.phys;
> > -- 
> > 2.43.0
> > 
> >   
> 

