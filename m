Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645104;
	b=Ihkdg6a4sie7ICNqzG/SJL+tqDqcVvnpj5M0k1x5OKEp5tJs3bfpfQdvl/wSxrHEbVC9
	 FYPWG2kILa/5vACif5j2XQ5QTJ3CE3m+OnHFiQtB/6vF4ZeqOKzA3KjigLoLGVNlGvNmZ
	 TUbut6GBzHGJBTcF0x/saV/2ioJeNsfQcNAzvCP/vS3LjP+vVnDOFndqiz+7/4D9Ujeue
	 X/rixKhig0mhamNQzl+zmXDpIkgJSL92ZAHEZ+rEj5QRrG+hxkUT3pPh06ESC9ReKRgdp
	 hrEavHhlQc9AJ8B/BNwKSJWSUWqOuusrCEQLXPTxxsFIrl0OjgfECFgSOzqg0CrFcRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645104;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xtBf/yWLHGPRxddLFR7vrkNg0MkmjCSVdxTFGDzFQgM=;
	b=0vMP9b8Kh8b22BCW0wNWYyOodY2wO3lKXtPBJGEjL9CkKjdDFM2A5nkfOgLQFcKsgKai
	 o2+HeW1zxP8CKzJp6UR31fgWZp3MK8T/Z03+GuoaZh0uK7IkIHrFIPfOYg/MLQossiTXL
	 qAVQkBOQ4qQ9k+45jNMqyNnYFSyV+BMHRhMwh+40VXmmSz26YLtUVRHM0oGjXLW6ANGcy
	 insW4OyurJNyzcQHMzaTnqpgZMUzhBo+RT+OGsG5+y4hQAwfeiUnUo2J3tVl912Y4YrUP
	 rZSfBw4Tj0A8jv8ll8Ckb39qDA23PVFzIWR7HpwOMbisL3MpjQzwCemWBUM3LyOQz2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLH5G0oM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF26606A323;
	Wed, 25 Nov 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLH5G0oM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B51F000CF;
	Wed, 25 Nov 2026 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645104;
	bh=xtBf/yWLHGPRxddLFR7vrkNg0MkmjCSVdxTFGDzFQgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLH5G0oM2JLxV/KchDGhSFf/Fq5APGHb9tbSqagYg6FBqtQjMrkOah46W7W0stvww
	 IqvBmvN03Uz+8K8ZBD0ZUzgToREH6mftcH8vUhMBHajoIY7F0IiplTwt4Q3Oq/XYSy
	 uLtq40uN1LwxlgfAXtIDRIV2MvbUoRTmkQ7SAd9P5FpQZAX6/YQGDATkBioYmrvoLj
	 aQpucgH0Qakl0Dx9pg+jyg6Haklkj5UMU5U2O+/DELsV/abDAe6F/6rY/g8ayzSpNx
	 pFaZp4VAZtuy0J8TCDoU/am1/zj8kTI/CwgWZ63rOsYEunBziTRmV5135hf+d16nUr
	 r2XRmeu69lwgg==
Date: Wed, 25 Nov 2026 23:18:16 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <awddHt_xvc-lIygA@devuan>
References: <cover.1795639368.git.alx@kernel.org>
 <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
 <awdaYz9NNVv5fHv9@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="7ejnb7qdmhqer45z"
Content-Disposition: inline
In-Reply-To: <awdaYz9NNVv5fHv9@ashevche-desk.local>


--7ejnb7qdmhqer45z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <awddHt_xvc-lIygA@devuan>
References: <cover.1795639368.git.alx@kernel.org>
 <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
 <awdaYz9NNVv5fHv9@ashevche-desk.local>
MIME-Version: 1.0
In-Reply-To: <awdaYz9NNVv5fHv9@ashevche-desk.local>

Hi Andy,

> Date: 2026-11-26 00:00:03+0200
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> On Wed, Nov 25, 2026 at 10:03:55PM +0100, Alejandro Colomar wrote:
> > str_has_prefix() returns the prefix length on match and 0 on mismatch,
> > so the mistmatch case can't be told from "empty prefix matched an empty
> > string".
> >=20
> > For instance: the OF root node's name as returned by
> > fwnode_get_name() is "" and will return 0 for any name matched against
> > it and since len is 0 too, fwnode_name_eq() will return true.
> >=20
> > Let's use strprefix() instead, which also makes this function simpler.
>=20
> ...
>=20
> > Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
> > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4l=
b3flk>
> > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4l=
b3flk>
>=20
> What is this?

git-am(1) has --message-id and the corresponding am.messageId, which
stores the Message-ID from the email header field from which the patch
is taken, to document where the patch was taken from.  It is stored by
git-am(1) right below the last trailer tag from the patch (which should
be the 'Signed-off-by' of the author), and before the 'Signed-off-by'
appended by git-am(1) itself.

	$ MANWIDTH=3D64 man git-am | grep -A5 messageId
	     am.messageId
		 Add a Message-ID trailer based on the email header to
		 the commit when using git=E2=80=90am(1) (see git=E2=80=90interpret=E2=80=
=90
		 trailers(1)). See also the --message-id and
		 --no-message-id options.

It's useful to document where those tags come from, in case it's
historically useful.

I've extended its use to other tags I take from emails.

> Is it documented tag nowadays?

It is not documented in the kernel, AFAIK.  It is documented in
git-am(1).  I included it, because I find it useful.  Feel free to drop
it if it's not wanted (I can remove in in v8 if it's not wanted).


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--7ejnb7qdmhqer45z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHXqIACgkQ64mZXMKQ
wqlH4Q/+K4tq4+xqA+hdgLFU9RuoGu9qlZ9RqtFtH9W87MQooPrhhUG7AbFMBC9u
ucTzbnIgGovA2AO7MQsbTJL5+N9firrgftdeDosezvTNFc5p/znYPlW3P5bcrESz
cS2Auvzbd6s5aqhWgHVxeUNGf5fwQ9QOdkz0Am3ULMnNUXfr/c9KvASfJPO0Qlcj
NfJTuGv98uzzIeQN54tNftEOnbzqjM+hTGyc0LNUSyh3Fo8pIomM/hL6y36ViS2v
xgSGxJ+VDq86TbKtvZMgh/JuA2zJ9Mr8SCIGcUWKQMSz0eksGP/MdtDN/q89yUoI
4u5E7iDcPR/OvgA6MvDIQMlS+LXrSSKAJKrKO+uYO7ee8y0VcmhkSmb6hXnPDpd4
t89hd/ds+h+MHWdbJhxQCnoEbvWPUnS5bvM5Ez17vLt0LaH0P9WeWNnDsbLRAjvn
Vr5cSqAHwvQuFCxgoaGhiRhVNtVj6oLf2EqGCSYpXlyjfirNxp+Mhi2x7/xC/szg
r7LECWvqGXnMh8nZ4b7Ha8dAnETqGLFKwp8X4+3fo/8k0ldmu4VHKhmPWd5FqtsQ
WgN091lpGuSXNAzGUZLcr1u5FcJG2dTc97jSOk+n9nFnjHHSagJ/S0yhOLywhFok
BHSOGIKbY88h/xhKT+v6p2wCllPZO4wmjNUaLiQCx3IAcTYt5pg=
=huBL
-----END PGP SIGNATURE-----

--7ejnb7qdmhqer45z--
