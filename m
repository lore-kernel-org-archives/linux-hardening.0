Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EF3E3D86
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059524; cv=none; b=l4Yy/hKfx8vBr7RmWz43bt3ppYpw9VLL6jSYRZcPrcoHPsINVyPJXcKi6HZbheVvf8EwfO3RE8WoRhi+LsTfpC+92qaKitVO5bUoppIXkW6forXRKBnRdmRjTJ2L8106SPegHhkJLa8x8fEK6n3nh1RmNTtd9V/hqxnOVDS9SsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059524; c=relaxed/simple;
	bh=8IgL6hXPwHLELMr7kfuxvIBfEre5uUmajY4IJi0MnJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TD+8k0uSxo7z5zT6KICotzNh6DSSJcfH94ughIeca1Iz+mqInORO7Q0WEKTeRnOTy/7wBTtyi1t4vWrGgs5+4pV91sm0K1xsI4hyZnjsQQz6h2cOTNPYAvSX4K5K78a8lM6AOirRF0fjD44kiStt3bjS7l8WlK1APVz4YVkmc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HyvrgMPS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HyvrgMPS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CA6FCC5DC44;
	Wed,  6 May 2026 09:26:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 654526053C;
	Wed,  6 May 2026 09:25:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46444102F18EA;
	Wed,  6 May 2026 11:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778059516; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/Rsbf4mZMs3GkDCgp0r8fF0zgqF+6Nq5rqY8JiJK2S8=;
	b=HyvrgMPSbGvgwCaDmjX76wURng5HQ5gZVRKK7yEnMmZ+S+mP2iXU6wkYnJK7zoOTJqU9KH
	ni6ZTsGZtjyXFdqCU92uco45cTBZFjror2+eTvdBUpxS0aq6B59XCMQHeEr2R13LAsnoKr
	hfA/iczxV7CkyB/r+kGUmXDwOsGIqf9j5gb7MrNdex30HpgDBXtve/zuyqpOK40hi1b0Ig
	nPjPIl5d5fjPzjv+802yc/V9WIombN5pXy2I6iBW2H1/gJJD/qObDCwq9c8g5Nx5Ac7BCM
	5xbZwGPuRw0UAyqsEIDGn3e7Wppy8qCVrWFpixCuObPIjbMoCPo5rddBBMlnpw==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 11:25:20 +0200
Message-Id: <DIBHHV8JK79Y.2STMC24WJRDXU@bootlin.com>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, "open list" <linux-kernel@vger.kernel.org>, "open
 list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] talitos: allocate channels with main struct
From: "Paul Louvel" <paul.louvel@bootlin.com>
To: "Rosen Penev" <rosenp@gmail.com>, <linux-crypto@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260506085653.1211263-1-rosenp@gmail.com>
In-Reply-To: <20260506085653.1211263-1-rosenp@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed May 6, 2026 at 10:56 AM CEST, Rosen Penev wrote:
> Use a flexible array member to combine allocations.
>
> Add __counted_by for extra runtime analysis.
>
> Error in case of no channels as they are required.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: error when no channels
>  drivers/crypto/talitos.c | 19 +++++++------------
>  drivers/crypto/talitos.h |  5 +++--
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index bc61d0fe3514..bd4cc06ee13c 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -3409,14 +3409,20 @@ static int talitos_probe(struct platform_device *=
ofdev)
>  	struct device *dev =3D &ofdev->dev;
>  	struct device_node *np =3D ofdev->dev.of_node;
>  	struct talitos_private *priv;
> +	unsigned int num_channels;
>  	int i, err;
>  	int stride;
>  	struct resource *res;
> =20
> -	priv =3D devm_kzalloc(dev, sizeof(struct talitos_private), GFP_KERNEL);
> +	if (of_property_read_u32(np, "fsl,num-channels", &num_channels))
> +		return -EINVAL;

Actually, this check does not guards against the num-channels property havi=
ng a
value of 0 :
https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/of.h#L1384
This check is done here :
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/crypto/talitos.c#L33=
67
when checking the property data in the DT node. is_power_of_two does not
consider that 0 is a valid power of two.

Channels was not allocated because the DT node value was invalid. Ideally,
the driver should validate the DT node before requesting any resources, but=
 this
is outside the scope of this patch.

--=20
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
