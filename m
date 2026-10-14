Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F82C21D0;
	Wed, 14 Oct 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951957; cv=none; b=On9/YzLQVGzOd3mahYx03Tb6A0Gfl07fGy97xSMcKmgWrzlv12SlM8bOD98I05YL/SyVy8MjEdE73Tt4bQsYgGxYTjt22pxsMLeK9EG4nxOO9xPhhHP20p55KlAw9CAwLG+Unk0TLlAfmNlcA+PhtBHbrcjneGecKTpVsDF/L50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951957; c=relaxed/simple;
	bh=bO48CuVt6th8bZN2UDCZmC2Y8Qh61nEaDFqg08Ble70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A7gUVyRLVmBBtc1CJdNEevZfkIhiAdK/7fQ6zLr4OUEgpZSCKzFeRMjAgfz+cDsFshXFDSma6pcSlhWG5d2zvrlmHO+bEYjG0PXGs/NIOutJFCkN0Vv16/vKm4Ctp+PEWbZf5+kVOmL+q0VezWjvjAEA2N169iu9eYt3gqDuWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jx38zYxl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jx38zYxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791951954;
	bh=ezH3BpnQanjd396/pJFVbraHVmeO2RYUq/rewNmkX/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jx38zYxlVJq+fURXvDTVIjpMc3kQMeuzyvm21VcaoLzwhrVLp5C6gehwdETw4GbsN
	 O2AUWtH1WUsETNtNlQFYw4/IZep9GcThydDBEdaDUeWGf/1dNYxLcKsp4V+5DREuf/
	 KL5NWuXdV9xIkQAr8VKNk3kOY5M9sBVMO//WUaROVBmGf+5sRqXnnyNKBzJRavAZMH
	 ZBFSiXSsngK2AEYMrRUhjeQrHlb6dGx2OripQ8ev4zVCsseb246uhevEGjaHRSE8a8
	 1jHUfIlZGlFNll0jqlOF1RrU7yfy16ovVPiuQvq3qJI0j3/rdCR3O93Xk6hWkMfGFc
	 0UxUxOrKdOGNQ==
Received: from [10.157.79.237] (49-255-141-98.sta.ip.vocus.au [49.255.141.98])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C131D6CEE0;
	Wed, 14 Oct 2026 12:25:52 +0800 (AWST)
Message-ID: <50b4bfd4754351f49ef79c0542276d32a7409ba1.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v2 6/7] net: mctp: usblib: Add initial kunit tx
 tests
From: James Lee <james@codeconstruct.com.au>
To: netdev-bot+sashiko@kernel.org
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au,
 andrew+netdev@lunn.ch, 	davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, 	kees@kernel.org,
 gustavoars@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 14 Oct 2026 12:25:50 +0800
In-Reply-To: <178893260401.219967.13741401547777040850@kernel.org>
References: 
	<20260903-dev-mctp-usb-lib-test-v2-6-313cf15e0b56@codeconstruct.com.au>
	 <178893260401.219967.13741401547777040850@kernel.org>
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
> Is completing the transfer inline here consistent with the documented
> ops->send contract?
>=20
> include/linux/usb/mctp-usb.h says, for struct
> mctp_usblib_tx_ops::send:
>=20
> 	/* Start a USB TX for @data. On returning success, the
> implementation
> 	 * must arrange for mctp_usblib_tx_send_complete() to be
> called at some
> 	 * later point (eg., on urb completion).
> 	 */
>=20
> mctp_usblib_test_tx_send() instead calls
> mctp_usblib_tx_send_complete()
> (which runs mctp_usblib_tx_stats_update() and
> mctp_usblib_tx_ctx_free())
> and then returns 0, so the tx context is already freed at the point
> success is reported.=C2=A0 The only in-tree implementer,
> mctp_usb_out_complete() in drivers/net/mctp/mctp-usb.c, completes
> asynchronously from URB completion.
>=20
> Nothing breaks today: mctp_usblib_tx_send() reads ctx->tx->ops.send,
> buf
> and ctx->len before the call and only returns the result, and both
> send
> sites in mctp_usblib_tx_push() touch the context afterwards only
> under
> if (rc).=C2=A0 But if the library ever legitimately inspects the context
> after
> a successful ->send(), this harness would report it as a KASAN
> use-after-free in the test rather than a driver bug.
>=20
> Would it be better to either record the context and complete it after
> the
> push returns, or to relax the header comment to explicitly allow
> synchronous completion?
>=20
There is no "instead". The documented function is called. Inspecting
the context after a send would not be legitimate. This appears to be a
false positive.


> [Severity: Low]
>=20
> Do the assertions in this test actually observe either of the two
> properties named in the comment?
Seemingly.

> [Severity: High]
>=20
> Does this static_assert() compile?
Yes.

