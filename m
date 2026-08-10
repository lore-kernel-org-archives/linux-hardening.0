Received: from out-2uec-a89.jellyfish.systems (out-2uec-a89.jellyfish.systems [63.250.43.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992981A38F9
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398747; cv=none; b=dq+VDf843u3ZlvqAUouXgimYa3T7mFnpakc8mhjGjighZFVerjVs19jRPO/7THDfJ/+NIoqxnNnxtobCjIuCuqjty97wGXPwUJ/Ybx98XrL6fnbNPKSdFhxfjKzEChZ6RMsSEJuV8hyqWpxVzrl43vVEGAlrmxshq4N4hrGTLuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398747; c=relaxed/simple;
	bh=JnAva7BvWlD7HWlrJWTzhueaMfuP/b/E3WgX8cW+Lps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaA8twMuNDfdfScG8i4ql5YgTWvJ/09FQbyCiSIbg3cNZlIyrh01xAt7ZtAw4nXMJ7I7gN8xhBOteftNNJ3ZWof4fSF/XwVAXVgotpknU9rHrD1iwH7iC+73JwWvajz4uIvEjAu4wvnL8WiJvi70v3AzymifBIJoPISiuDM4jg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJpPt4fKNz2x99;
	Mon, 10 Aug 2026 21:52:18 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 3/3] iio: light: stk3310: support the Sensortek STK36C61
Date: Mon, 10 Aug 2026 23:52:16 +0200
Message-ID: <20260810215216.154484-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anoaYQNHKSNE8Pci@ashevche-desk.local>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net> <20260810110423.41697-4-jorijnvdgraaf@catcrafts.net> <anoaYQNHKSNE8Pci@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

On Mon, Aug 10, 2026 at 09:37:21PM +0300, Andy Shevchenko wrote:
> > -	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
> > +	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
> > +	    chan->type != IIO_INTENSITY)
> >  		return -EINVAL;
>
> Is this now a duplicating a bit with the below choices?

A bit, in the int_time and scale arms. The check at the top is
pre-existing (this patch only adds IIO_INTENSITY to it) and is the
only type filter for the RAW case, which serves all three types
through chan->address with no per-type branching of its own.

> >  	case IIO_CHAN_INFO_INT_TIME:
> >  		if (chan->type == IIO_LIGHT)
> >  			ret = regmap_field_read(data->reg_als_it, &index);
> > -		else
> > +		else if (chan->type == IIO_PROXIMITY)
> >  			ret = regmap_field_read(data->reg_ps_it, &index);
> > +		else
> > +			return -EINVAL;
>
> If you want to keep a single point of return, use
>
> 			ret = -EINVAL;
>
> here and below in _read_raw().

Neither of the new else branches is reachable today: the colour
channels declare RAW only, so no int_time or scale attribute exists
for them, and in-kernel readers are gated by iio_channel_has_info().
I would rather keep them than have a bare else read as proximity for
a colour channel. v2 writes them with ret = -EINVAL as you suggest,
falling into the existing if (ret < 0) return ret.

Thanks,
Jorijn
