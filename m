Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221184;
	b=q4glERDjlWNAM3hAdMCvYo5h6iVf77ZXn4nw8IV2whlqRBWZcizUFPIwh/erZ/4UEl6O
	 5671aVRfxtqQp95RkphP6OOzPHR/Wc1RA3VjyoOj4t8Qp6Jy5fzl9gJ/xjvqoh2MRoD0S
	 gda0QbQ9a+SMKdnWcuktPuSUdNlwu9jiY2TEUkWiZS9g6OSBkzmuARwtKP33ndZD6Z62N
	 Dkl/l3NkxkP09+joqyZ+htOR9Z4+D2VJVR4l1EZGvLuxVx3l+uP65Tmz0xvG4JHadqOB3
	 LvicgbaW14zP1Raf80vwsvbNclCtrBBjgb2M8k9YidW4OR5TdEA/LJzvqvQD0IFiM4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221184;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9nOlNgC+ffLrqVykbkDTz8rKzDkyZbGtwBA6+1rkdRA=;
	b=rZHArShynkRswoRDzhFB0h6ivSo+R0tV9xCPbmIKOX8ctqFXHpfmKMW5xspgdon8nxMO
	 mWjvk/2zqnGZO0fwAOFe0p9U8JgLXBQogaqQ3nc+Hh6KLBiRRnDWNCQhlJcmty31W7HXm
	 9jYRgzQCzRXsrfcfBk5Q7bv32E/Bwely9tZic4XdL1zppygkg6sm930g7Fe+Sb/EKK5DV
	 8YJ8i3DHxYetm0dJc57Dc09puweU6ojI9hMd8cjckmqD+uJjpu8QC6SAFcsXWHYT1CCjb
	 zlZNMLjUg1hcpSWFQzuScXPtZG8UjoxQHOxIQH5qzhVjlgPlgWokVfk9kQOrz4TTTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDzvS4mZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3E5606A32A
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDzvS4mZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3252C1F01825;
	Wed, 28 Oct 2026 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793221184;
	bh=9nOlNgC+ffLrqVykbkDTz8rKzDkyZbGtwBA6+1rkdRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDzvS4mZxJazedkhRMxD8boXrkL6d+xwgy4nsA21I9Bk9vVgPtxS1LKnT5Hwy3EMz
	 SLWpedd01/x/uD5OevKTb2YNsxpHHFhd18uohsaO5wQvkPO7xyL4AQzBInSSgldiyt
	 W79uZQsSH/CSlCpE4RNhunzCzMN1vsS6CL+/0GTbsgfw2C0HX/Qcv8pTUgKUFWQ0+p
	 JHznCqNzg0dnqgmTql9q7NUwj9l2DmkJ3Pndp/w+gawyLbZGQ6XESFJSGekbm/iMYo
	 HlmwO4uT4yL6OetBHQcQl19oRqVdRi2Ut+HQQyqYCkh4U8kmAQD6ROPBO0IeLkJT04
	 04RDvhEDunfKw==
Date: Wed, 28 Oct 2026 21:59:39 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: seq_buf_used() return value on overflow
Message-ID: <auJfBNeZGDbvMBxS@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dqjmnpzg4ydcmto5"
Content-Disposition: inline
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>


--dqjmnpzg4ydcmto5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Petr Mladek <pmladek@suse.cz>, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Subject: seq_buf_used() return value on overflow
Message-ID: <auJfBNeZGDbvMBxS@devuan>
References: <auIrUV7A8eF8DCGG@devuan>
MIME-Version: 1.0
In-Reply-To: <auIrUV7A8eF8DCGG@devuan>

Hi Steven,


Another question that arised while rewriting seq_buf.

There's seq_buf_used(), which replaced (in 2014) the previous
SEQ_BUF_USED().  That commit changed the value from
	min((s)->len, (s)->size - 1)
to
	min(s->len, s->size)
but didn't change any other code.  I don't see any mentions about that
off-by-one change in the commit message.  (There are two 'Link:' tags,
but I didn't see any discussion about this patch in those; they seem to
focus on other patches of the same set.)

I wonder, because when changing to use pointers, the good behavior would
be with the -1, so I wonder whether we can go back to the old behavior
easily, or if anything depends on that value.  Was this a regression?
Or was it a silent fix?  Or is it unimportant at the moment?

This is the commit that I'm talking about:

eeab98154dc0 (2014-11-19; "seq_buf: Create seq_buf_used() to find out how m=
uch was written")

Here's what I'd like to change:

	diff --git i/include/linux/seq_buf.h w/include/linux/seq_buf.h
	index 05e70ac18ddb..63d077dd8a74 100644
	--- i/include/linux/seq_buf.h
	+++ w/include/linux/seq_buf.h
	@@ -78,7 +78,7 @@
	 /* How much buffer was written? */
	 static inline unsigned int seq_buf_used(struct seq_buf *s)
	 {
	-       return min(s->len, s->size);
	+       return min(s->len, s->size - 1);
	 }
	=20
	 /**

The rationale for having that -1 is the following:
Consider a representation of a buffer where s->p holds either a pointer
to the terminating null byte (or the position where it should be written,
if not yet written), or NULL if the buffer has overflown, and s->end
holds unconditionally ARRAY_END() of the buffer.

By doing s->size-1 on overflow, we'd translate it to s->end-1 with the
pointer representation, which happens to point to the null byte (or
where it should be written), which would make this offset quite
consistent.

If we do s->size without the -1, then that offset puts us one-past-the-
last element, which isn't usable in the same places.

If you would accept a patch to add back that -1, let me know and I'll
send it, or feel free to do it yourself adding the following:

	Reported-by: Alejandro Colomar <alx@kernel.org>
	Suggested-by: Alejandro Colomar <alx@kernel.org>

I guess it would be better that I send a patch with a proper commit
message.


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--dqjmnpzg4ydcmto5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmriYjUACgkQ64mZXMKQ
wqnkNQ/+N9eaVJ+D2optyyrF+GVqqfV5KkyWaYFutAXiJPD+qgCLrW2ppeU2NYX+
uWwVMduZ+WIbNdGyZip8oriV1WA6LuDCnn3Fi7Liutjt7c1nOYOt9UCScYGMKGOy
TKOnxik9VNDGwLB/RmJTWESUa30ZWp1nCEfYunuwZmozppSFuEG4cFBYOOVLNdNn
8UojjvikWSHdlhJ2XOoRmuZh4eC5j3E6KwkqVm6aTeHLz1jaEyzWFx2HpUpK1lDx
JYjIySn14DHj5wK8mY5m6h3qzFAqWk8Ot1z1wV/Sjm8seghJ4vckprl2CfzPsTkZ
8pQ67ntNxnWw9jEVGh8Hj/84dL/Hebod5HVT0cBgR/et47Ual1TR1TlBG61ngngH
vv44NzPxnro0Tpt49xlDahT7sMNuPW+CDHw2VEZ6MkBGe2yufm5lEb1PoWH0EwWL
riAHm4eC+tGnyBI3MFD/xsKwuzkeBataoZeUlnh7kK86FOaOnUAmmfZnduEaCgiO
qnqLdNxBIEDjIRCsrdNegYAa9zaFf7WBkxhYmQ2mimEk3NhPqPga1i9mFLjzlKef
XOd4LqPaDbVLyVYbosjFYsVbMZ3YZ4FiBSj+sJfcVVNGFTMYGJj3vsB/mtqprdg1
SyBwEOyr0XOSEALyu31VaAY3ROM/5bEijp/KwvP17b6rCwcxaCA=
=SAg8
-----END PGP SIGNATURE-----

--dqjmnpzg4ydcmto5--
