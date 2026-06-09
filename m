Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED7280A56;
	Tue,  9 Jun 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014139; cv=none; b=nnk58YlT3nCesJW6QWTj9gdSeBkurYPL5nNcqsmp3syblnVXlKjlQLKzgkPsmEw5ySJcSFwpJfw7gEgkiCqjHhY0fCuNm84tPDSDPC3lwyg6fYSie9wtaA01cdhGHNFuPTY0nPH7NRGg0gw3ih45Nxk7LL9NARP44UpXSULvVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014139; c=relaxed/simple;
	bh=Hye8T9Y+lfjZZrmaEQRg3zNYBhyGBAyhnD/dUDQfqfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=W/Weq7W03GJtJzA5YKV+AGvy4h5YmRgyXxNbrU0HGHNsSXholZAXJjEgDt8f9w5jyMzUAjJxjUWwBfiK+uFol1iHHETYGjj+QxQJt2bvCWNqrmci0J8Ns4/1QLGKnSwoBEBiRwdYQblFE5lEpWlWZ/0MEWQVHA95V377LJLmi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9kZThtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9kZThtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1C41F00893;
	Tue,  9 Jun 2026 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014138;
	bh=uPIlLzQpwW5vu88ARSsMdV6bEx3wdI3AO6gWaZkAVRo=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=d9kZThtz+8ViiZjkeGyw+K5F7+mfg4UaRYB4ryeXljw7oTnmqPb1BltjVrlhVjHEM
	 TFPJluyKC/QwpMqsUsiSfz/AWLwYYt9etjior9lqhzfEhGRgHNjE3QyIDDvulqFpH0
	 qUtg/VngVN4hB/V0RUtbzf8DKJ+GJuqHdNEzg4j+FDAT9/4XZTuJsB+k1PAyWxxsnL
	 synyKZRMtkqMmIIeNrBlLQGBBBZ8If8X0oM0WhVpOVYkcKxhpoM78yea8horcNC41v
	 Z17EtZHoqqY35m4Zy86DrCelGqCZv38tml2ruL5/CPgOq3Ws90YuSesUkb2WMrl8B4
	 gt3pdOHiew/5A==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 16:08:55 +0200
Message-Id: <DJ4KTIFM6YN7.3E07VW7CCJ19U@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH next] driver core: Replace strcpy() with memcpy()
Cc: "Kees Cook" <kees@kernel.org>, <linux-hardening@vger.kernel.org>, "Arnd
 Bergmann" <arnd@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
To: <david.laight.linux@gmail.com>
References: <20260606202633.5018-1-david.laight.linux@gmail.com>
In-Reply-To: <20260606202633.5018-1-david.laight.linux@gmail.com>

On Sat Jun 6, 2026 at 10:25 PM CEST, david.laight.linux wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 75b4698d0e58..63fdfffe1a8c 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -617,10 +617,11 @@ static void platform_device_release(struct device *=
dev)
>  struct platform_device *platform_device_alloc(const char *name, int id)
>  {
>  	struct platform_object *pa;
> +	size_t len =3D strlen(name);

This could be strlen(name) + 1 right away, which would also avoid the memcp=
y()
to implicitly rely on kzalloc() zeroing the memory, where strcpy() was
self-contained before.

> =20
> -	pa =3D kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
> +	pa =3D kzalloc(sizeof(*pa) + len + 1, GFP_KERNEL);
>  	if (pa) {
> -		strcpy(pa->name, name);
> +		memcpy(pa->name, name, len);

But in general, what's the improvement? strlen() still operates on a potent=
ially
unbounded string?

It removes the redundant strlen() calculation that is implied by the curren=
t
code, though this may be eliminated by CSE optimization.
