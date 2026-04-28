Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BD39D6F0;
	Tue, 28 Apr 2026 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368658; cv=none; b=AzYVoncoLLvStEfgqSATgjb3l1l1wbMbGL+RLx2IqgDLSd1OaQXdMHyQ5e1xGqLd/woxXVqUz4CIV4ZK2YFkfOJNEzDfH1DHmmSRuVuZGUqOZ6lnui4borpn609O3PQpXDZKI9sp3HFmM/i7uN1XT/sF3T5fhKL2E0v7/kIHJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368658; c=relaxed/simple;
	bh=am9YONt3yjiE7heGEnBc4/rFsCshQT9IJQZzeBKGEEs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=S2dEMGxabCObGRwb9T5jiPIhRSgg0bL3mRZVMq9QXpNF5AAs5I4ll0+l+HfZNmmfB2hMrixoHk1CfIykbfUzXOuS1RgeJ1jpD+HS3AxxxtAvCGzqvUHTfdjnTDwrQ9SVzWl2/CHsCEtP0q3PjO2lYZ5uSwsnAn+3HOWgokpS9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SXZMM+Cp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SXZMM+Cp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A76A14E42B61;
	Tue, 28 Apr 2026 09:30:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77996601D0;
	Tue, 28 Apr 2026 09:30:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A1481072867D;
	Tue, 28 Apr 2026 11:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777368594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fMEkzBNocMsiKjy40VQmGNZYwSqKkfQGiWV9CJVgQMY=;
	b=SXZMM+CpPlXMUS5xlLXexylGODvdLs/jzZuaJ294zqEnvQUjJtYA3c+nhgt8J6ePKhIiyk
	vlzfQd3nEKAcFC3K1UgzYzoDLqgCK1pqNoVT/asddHCH7Js4RJrJ3AmkwlDERlWxn1+OCo
	CPUzNMKe2Pe8kMTYGhoqEoiMUi4cTydKMQPobnc9BIJ5mItU6aTJhvx78tUyl+PafpS1bY
	3NB/6ASDVymZl2XbDTagUlShyxxY0L81P+BfSxncybRx+IpFxZxa5+ZOgc5jX/lu+z42Xv
	7PP4INwhqGhZYMO1GpIsBLffIf8nLDVFLYmCCirOzTBkwd7rA1zhW58Z+qxEMA==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 11:29:52 +0200
Message-Id: <DI4OKZA3428E.5TJAYEV50JH2@bootlin.com>
Subject: Re: [PATCH] i2c: atr: annotate i2c_atr_adap_desc->aliases with
 __counted_by_ptr
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Rosen Penev" <rosenp@gmail.com>
To: "Thorsten Blum" <thorsten.blum@linux.dev>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260427172817.417614-3-thorsten.blum@linux.dev>
In-Reply-To: <20260427172817.417614-3-thorsten.blum@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hello Thorsten,

+Cc Romain, author of the involved code
+Cc Rosen, author of a similar patch elsewhere in i2c-atr [0]

[0] https://lore.kernel.org/linux-i2c/20260327030310.8502-1-rosenp@gmail.co=
m/

On Mon Apr 27, 2026 at 7:28 PM CEST, Thorsten Blum wrote:
> Add the __counted_by_ptr() compiler attribute to ->aliases to improve
> bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/linux/i2c-atr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
> index 2bb54dc87c8e..b52a7b9ec536 100644
> --- a/include/linux/i2c-atr.h
> +++ b/include/linux/i2c-atr.h
> @@ -71,7 +71,7 @@ struct i2c_atr_adap_desc {
>  	struct device *parent;
>  	struct fwnode_handle *bus_handle;
>  	size_t num_aliases;
> -	u16 *aliases;
> +	u16 *aliases __counted_by_ptr(num_aliases);

I'm not fully proficient about all counted_by things, but the patch looks
OK to me, and definitely @num_aliases is the number of items @aliases must
have, so:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
