Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792981460;
	b=lKUiCBP0tJ0hjs7NwDg6hKQSI6FtOgUB9bU4wahaoMo5lSSpfhM9gXmhA2Ebmm/XM2Kp
	 T4gpaWt052bDj4R6kxj+zYQ6xIKoMA4Zsd6HHQsJWxpcdBfl0d/SRLEux2L/gts82tKZa
	 sVyZQ4ub1cu2uvvxzPQysE7xOhrq86slV5/RQERHSHEwJTEB7CmqHjFlXciK/BDek70Rz
	 aLv5ykLKfoOrDWl52FSzf6JwUi2TfipV9UpwqWij8jq6ULe7TnL9yDJuFgWlOS9pQkI7O
	 9BSe+eZxhN50BumN4Z4llDrEf9uWa+i5snRyjZuVmdDQh/f5WDQeB9tc0OHeSdsbKfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792981460;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=l+Cpnj9kI7AYRodxzQsT0p/xehFVSu3AkRwRpL8ubzc=;
	b=yhDZ1UF5AvT7+Cmvy5azrmLTUrXHWVZJDQr1LhfGDt15tda3h/WpMOIrfY6dguBIje/b
	 JCRif1joaF2EIi3vaqYqM2lAkadmi1lyeHfwLEqsF75gNPEXn4ZNS1Y+KERuGiT2iam9d
	 3CGk0Ixww0DDdNNDqTe/ovSeT9AoEKpf/Eh9pChIfglRjxIBnIfDQkslnqm3gWZ/rFUU4
	 O1fGvuF5+uan+psmTMF+QwbqrJQrJM5iuKWuRqMqIC8NT2JoaqH7B8Gks9m9YqFTU6B0k
	 K+L1CYVLotMesrV2RKkG5sLw925gQHge0cSPAr1kXXEfiXUm5Jq7bF+QCszopB/Rpng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ROFrScSE;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D8606A31A;
	Mon, 26 Oct 2026 02:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 425D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ROFrScSE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792981456;
	bh=l+Cpnj9kI7AYRodxzQsT0p/xehFVSu3AkRwRpL8ubzc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ROFrScSE1hp/YYr7qG90cW1FBP9V7BY1v81H8XHIru6DrTE1nXZX90mtPfu1gtX86
	 vmtEzxK2xe3QnUR04/6EJ96jCDSNy4eK3V7OIvUlebla80erVpTeVqK3oEMCrx9RlR
	 2v8BYjL6bxaytbVHR10CGlwu71W9RrNUbAX4LpoHm2wDM7ElWyZhByp98fPPt1SgSr
	 471Mpw7LQMlVipdQ72YqSQ/szrnrfbYlBaGAT3ADNvmRq5hlSaIKS6goTB4LIO427B
	 lqI95/f4UhQ70BTkaFlZ3foyOjQhLtnpJbSE27n+2P/b0gOz096CmQs3VGD8Pj+1Dw
	 YkN08G75VqfNQ==
Received: from [192.168.72.170] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 273936E6D4;
	Mon, 26 Oct 2026 10:24:14 +0800 (AWST)
Message-ID: <ddac7bab20a90404ae7dfd928f56aa69f1675fab.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v3 6/7] net: mctp: usblib: Add initial kunit tx
 tests
From: James Lee <james@codeconstruct.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston	
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 26 Oct 2026 10:24:14 +0800
In-Reply-To: <CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com>
References: 
	<20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
	 <20261014-dev-mctp-usb-lib-test-v3-6-ee5bc3ea1db1@codeconstruct.com.au>
	 <CAMuHMdXTGGdGWZ9sKz5_sQF1237gV844cEhkXr6v_TUHPOb78Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Geert,

On Fri, 2026-10-23 at 15:39 +0200, Geert Uytterhoeven wrote:
> This fails with gcc-14 (the latest available in Ubuntu 24.04LTS)
> and earlier:
>=20
> drivers/net/mctp/mctp-usblib-test.c:819:23: error: expression in
> static assertion is not constant
>   819 |         static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Oops, should have tested with gcc too. Will send a patch. Thanks.

All the best,
James
