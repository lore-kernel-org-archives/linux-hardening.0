Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625229;
	b=bc9yUoqwcgqw02qIc7gUlmqdbBWbwm+paWu/+y22W3Y7kG0AEiEx/fsN8rJ+VBSfs34H
	 FsjZgOdONFDUIDo3YmRB9b3edRHdv0Q0PmVKFla0ZBNOyORZ369bcY6BcbjGNM4u3+7kb
	 c0p2EcNisGje6uXNXU7rR6Tur7bvg5ksq5uhsl7oo5NGMzilbArjCF9In1ZK7mZ//0LWy
	 RpJBFrkRRKtmZUOT36/jWcsTfvBDlhFwR/8kFQE41yOOUZZm5/dmbH/Pzhp44pdKdLVFW
	 ywQL/7FY1IcIAU4z/eE8YFAk+cIEfM7PByPpzg2DZ7v0U9W0GHqeK3nIU8nByn4DATQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2soaXjuh6WRTXowbhNMNIHhfnZfKrjV28fZXYvBHPj4=;
	b=piIoa7oaOynBnFdm2swyCkN1hOnhd7gvELHYbo84rxMm2yhFxtl48krV0GevCemRsC0u
	 CvOKcrJt6qcP582T8kwNaomfG6pIELP0MX2UjsRcoA4E6xnD0eOdh18d+VxwNNzK3Cuen
	 Nhsz3RL56hS6hyeo7jbwCbLfaoBqNOropWq+ROJBEbiMkpAM39ALYoJ+WI+QCIV++o9A7
	 aZmrpMeOKXiObGME511U6RO63bLBtvC6DX3n05iNj8TVx9p8uiJVzKttM1Q+nmGnKbMGi
	 ibih5Thzd/CyrITy4yGUtLmZopLIfVfuEYyzrn9e6SFdEn1cA1RDsWAPZiANVPi4Kvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hogNfQ+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77379606A31E;
	Wed, 25 Nov 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hogNfQ+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304AC1F000D3;
	Wed, 25 Nov 2026 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625229;
	bh=2soaXjuh6WRTXowbhNMNIHhfnZfKrjV28fZXYvBHPj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hogNfQ+F+Y4E2RslqNtzTCLa+aPXk9fgHufUng+80Kqyh61plChu/GSQXSpLCoux6
	 LK/tUBibRHPDslb/35oQkMMiLrJYZXd42lc25Hxnscz1JofWCzPpclgnQuxc3IkhbD
	 FfCaQnqRhwzBbOeVJeOz3vqzYPNpU8P6FBeR6rpzppKHLbbdcL8QJCanlVZmc7XvYr
	 eqOBO6FwPjchWi1edSyv37dKhRIfheADUxa1+F6MPMQ6X1kWt40dbq5dq7/rn9bQB9
	 fEx/TGsl/3gT6z/fEHYZAoSKPLy+IiMxfc/53pdYzWsr3GvXvXwYUlv/26fOljb2HZ
	 9Rlpjb+5FPyRQ==
Date: Wed, 25 Nov 2026 17:47:00 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 04/19] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <awcQVdF5A8ZrbbeC@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <7fc1321995f1aec9d7b92c6a89047cc9fb28c52a.1794667407.git.alx@kernel.org>
 <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>
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
	protocol="application/pgp-signature"; boundary="pgohlg3lnyvn34uw"
Content-Disposition: inline
In-Reply-To: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>


--pgohlg3lnyvn34uw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v6 04/19] device property: Fix fwnode_name_eq() for empty
 node names
Message-ID: <awcQVdF5A8ZrbbeC@devuan>
References: <cover.1794667407.git.alx@kernel.org>
 <7fc1321995f1aec9d7b92c6a89047cc9fb28c52a.1794667407.git.alx@kernel.org>
 <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>
MIME-Version: 1.0
In-Reply-To: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j4lb3flk>

Hi Bartosz,

> Date: 2026-11-25 17:10:35+0100
> From: Bartosz Golaszewski <brgl@kernel.org>
>
> On Sat, Nov 14, 2026 at 04:22:16PM +0100, Alejandro Colomar wrote:
> > str_has_prefix() returns the prefix length on match and 0 on mismatch,
> > so the mistmatch case can't be told from "empty prefix matched an empty
> > string".
> >=20
> > For instance: the OF root node's name as returned by
> > fwnode_get_name() is "" and will return 0 for any name matched against
> > it and since len is 0 too, fwnode_name_eq() will return true.
> >=20
> > Let's use strprefix() instead, which also makes this function simpler.
> >=20
> > Fixes: a9c8c738066b7 ("device property: Add fwnode_name_eq()")
> > Closes: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-eac=
h-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>=20
> This series has grown substantially since v1. My GPIO series[1] depends on
> fwnode_name_eq() working correctly so I would really appreciate it if we
> could queue the bits and pieces fixing fwnode_name_eq() separately and so=
oner
> rather than later (it should also be backported to stable).

I agree.  The const-preserving macro can be left for later.  And the
global replacements can also be left for later (Andy asked to see them,
but didn't require that we have them in the same patch set, so we can
now remove them from this patch set).

And strsuffix() is only for symmetry, but can also be left for later.
Same with streq(3).

I'll send a small revised patch set that is minimal for this fix.

Thanks!


Have a lovely day!
Alex

>=20
> Thanks
> Bartosz
>=20
> [1] https://lore.kernel.org/all/20261120-fwnode-for-each-prop-v3-0-808e30=
4dc73e@oss.qualcomm.com/
>=20

--=20
<https://www.alejandro-colomar.es>

--pgohlg3lnyvn34uw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHEP4ACgkQ64mZXMKQ
wqm4Ww//RWo5b1PWZXxaXDJWbLwrZWPs81SQr8o7iw3WZRt+45HdbIfKHPubIlWF
LPU7zcEQ2VffBb/ifYDwuxbPuFpfX8/W6i/PiPh2DSKnxnOB5OmFj3qzCL2wjLl4
/Y95eCc0sWU9fN2V8IE3qo3p5RWn2uPdzeO1mOKw2LQ0QOF06M8cYuW8aLUi0svy
LpkSuPhBd0M5hQhMyVVLBy5mn783osV62jcHHlaxGoO/s67RJq4RBP574xghxJHr
dTgu7eUcKx58W6QKGiVdQo7pKLo+1GzQkpBk77qQYNbUiEwPPJXCfyMvcyp0B4Q3
3GwEe2LKayXym/8eiBIy1GZRHQoqpKqsxzdJiyFWuGiBkeRWVOI8LhJB/WbeAeZ7
T1IboelZnHAFQsiH74rx9TDGH1a6aQEI8yFwV7tpODQ1PwT9uA0xNG+7Q7RPkKS9
rqauqhT1k0wodX8qaisDB4UKMWYmKO2SXArW3ihN6tZSz9cy7lOovhuIzYt5JXR9
i9VwgNq23/9pKcvFWgrjO/M+BUNu6ck8IiimI98xFAMSkCJvNgHE5MC9vF8vmVCq
O+rcZENNhcfdbQqaZdfL+CLJPd5F+lNG8PM+jYSuuJD/RK4WgOXuXgDpAw2/BKDJ
Qp+6+pD+4jMQ2zZKxQUwoAsBzspMdwYUb6UpL7MnSsg76iOEGFc=
=/wuZ
-----END PGP SIGNATURE-----

--pgohlg3lnyvn34uw--
