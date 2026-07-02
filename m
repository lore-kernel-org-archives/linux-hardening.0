Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1798242D65;
	Thu,  2 Jul 2026 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951934; cv=none; b=taEFiDAcZNIu/N2vy7zJW+HuyAHYfNWy6EdxsINYZ6EJky2ppLDX747OSStY4DcCvMwJQBISa3+aLB9a3u5oOD2Z64EVHD3+PS1AhtKznM8eA9d8OQIfL4EFNolRhA47iPYoTWmbwfPAHAbKczBnP4lmIrgDGF1YwqHU2WTst+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951934; c=relaxed/simple;
	bh=b23V63BD9BdyYV2a2cLuU4Mh+dF+RSGxaY+1gI7BIEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4ckXlBQLoz6IzNFZ53QumyL1kBmp3emmsDrhH/f+lo4ngY2NUPA1kcJpRAmagaV72fyWngRWDUw731GvRpjn0jcCyR3gk6FrHqFEe9FOwh3u7/Qi3CU9QIgWTQ4Qol1yTE+itBhUM2tWoQmU8ZSytIoMNF3+mBiekxmGFjwl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=h3bv4x2W; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="h3bv4x2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1782951925;
	bh=b23V63BD9BdyYV2a2cLuU4Mh+dF+RSGxaY+1gI7BIEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h3bv4x2WU3f1qVa7wLIOYvub7fxttSM9mZv8n11Vg4VoIPKJIsENJXvbd+HN3ds0M
	 cNISPiqb448GaEdzSxe5INSLK1lnf5MpWUaVphXrhLC2jQh4ncUfEdnPHBL+RuQeKs
	 +wGvEbXl5aZ3PeTvwmt+3z8oz3eXWAJGGk7SrnnlNbDg0ev2NzTvfzw8XK4vHiEkmd
	 F9sQLOXnw7VPGED1Zvqi82Gpr6J/HfVYUbWIYf5w2n7mkSR3ny0AeN1/6cPPWmQQ4x
	 scUrVFdffYKE8fBRFXe9Uc0GRxKAUcwpnpMzfcoT47eg29b5eVu97Edxvh2UA36dot
	 GGbRjlpj+sJ+g==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0162A65871;
	Thu,  2 Jul 2026 08:25:23 +0800 (AWST)
Message-ID: <33cf45f92e4aa2ca985501807c3e4f74e1a10032.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 02 Jul 2026 09:55:23 +0930
In-Reply-To: <20260701171506.338614-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260701171506.338614-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2026-07-01 at 17:15 +0000, Karthikeyan KS wrote:
> Hi Andrew,
>=20
> Just following up, it's been about two weeks since I shared the
> hardware validation results. I believe I've addressed the questions
> raised in the thread, but please let me know if there's anything
> else you'd like me to do.

Nothing further required on your part. I intend to apply it, however am
working through some other priorities.

Thanks,

Andrew
