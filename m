Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BB40B38C;
	Wed, 14 Oct 2026 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952737; cv=none; b=br4fO9FptBpD7rs9/GdezEfODFL+2EqQM7RopN/OP25ezNGpHm1mzol90GYx1OmRKsiRJHNgZCH5rYihTniug3zvIuRR9iRHGVX0UuwtYOJElT7N25coXogCwx5fqn1XKlcwcwXKkmgcOVcVYswgxdJwKntW8rWGrTPMTlRuBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952737; c=relaxed/simple;
	bh=y/yVXEmjQCij2Kicb9rujVTrHhXqXNotpFnToGjCZvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvBI5lttISrDINea13a+7Kyj0xwJkaNZDMVMpH0gxSn3Dix8Reu64+B6RiD9w9n5bPZm2E95BjH0m9ZBpC92a5+IrFgr3W3KOjy7V5jAVxzF/z12Ugf4IZ5kWFx+5mn0n/fYN0gIrY6PIK6JiQb1RKx3hBTly8S7JPpt7kELLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NMSbZI/v; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NMSbZI/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791952733;
	bh=y/yVXEmjQCij2Kicb9rujVTrHhXqXNotpFnToGjCZvc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NMSbZI/v+Ca4MsPs3bGtvHPQBQmdRDNyb12qBSAdWVI8xMeQujeFJ6PYVyvaiDatH
	 Ely60pYFe1196e9MNOR2ZpukiGKZIUkMrKbj9kXN9EHdQNqf1Jor0YxPkt5TmQidGa
	 WJdQ/QJ8pTJmLP6nykkxTK/054qpjNAYFNnhqp5RQ4sltscz60NFb2wrC9Ut8Ul1Ta
	 3kLVpB219PIhMJlNvlbWXGn2zJSDbWjt44jz2saF8g1Df+jnmrWzWlGvA496rhG0SV
	 O/JapWMlpEQnpJmWONi5oVfpkk7sjCsirew51TLy+DkDHDz9bSHwY1MzbSSBkHQ2ic
	 ceoxmqoQ0vdUQ==
Received: from [10.157.79.237] (49-255-141-98.sta.ip.vocus.au [49.255.141.98])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EADD06CEE0;
	Wed, 14 Oct 2026 12:38:52 +0800 (AWST)
Message-ID: <286884581dfff68a20b6439ca1cbf55fe1ccd6e4.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 2/7] net: mctp: usblib: Add test for splits
 inside headers
From: James Lee <james@codeconstruct.com.au>
To: netdev-bot+sashiko@kernel.org
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, 	davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, 	kees@kernel.org,
 gustavoars@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 14 Oct 2026 12:38:52 +0800
In-Reply-To: <178893260008.219967.13546498074867789571@kernel.org>
References: 
	<20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>
	 <178893260008.219967.13546498074867789571@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> [Severity: Low]
>=20
> Should the return value of mctp_usblib_test_rx_complete() be checked
> here,
> as the other call sites in this file do?
Yes, good catch.


> [Severity: High]
>=20
> Does this leak the skb data buffer?=C2=A0 kfree() releases only the struc=
t
> sk_buff itself and skips skb_release_all()/skb_free_head(), so skb->head =
is
> never freed.
Yes it does, will fix.

> [Severity: Low]
>=20
> This isn't a bug, but i is never used once the invocations are unrolled, =
so
> this emits a -Wunused-variable warning and fails the build under
> CONFIG_WERROR with CONFIG_MCTP_TRANSPORT_USBLIB_TEST enabled.=C2=A0 The
> declaration is removed again by the next patch in the series, "net: mctp:
> usblib: Add tests of invalid headers", so the final state of the series i=
s
> clean; could it be dropped in this patch instead to keep the series
> bisectable?
Will remove.
