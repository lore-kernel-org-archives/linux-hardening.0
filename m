Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDF1DA4A
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DD1C433C7;
	Fri, 22 Sep 2023 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695377528;
	bh=KTp3+5YEfk8OXMEq9FRYbmvHCPYkW/LfzyG6e8jyrmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9Ta/PHxFGYtdvyR7EyjbHhgY2PgupOINSohq8W3l1y2ntQltHwu0DFxjAxonBPT3
	 j+A0gQaDzt+PaotHTBPHV10x7An3Gqxx4qdSFjsJWuFjln8X4f/3/34GTehDaGU0jh
	 kYqssWzWSbSJfuTLNCxPyTaGGKnJHcegK5wcHIaXlWU6aE9j8VDt1kvluhd/2Le6a2
	 VGgnpL6DQAMQMhSsAZ5Kf7HGutE7W/yUIDTEj8mqPJGe8Lc5nNbStG5/CWh1MNnYV6
	 oroHipTH3ZVFkWBTIwNe6oXwzVDu4iolSrelgg6/AK41pCq+7WeOMRE9sUbh0lEG/n
	 TUROSSffqfMPA==
Date: Fri, 22 Sep 2023 12:12:05 +0200
From: Wolfram Sang <wsa@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: replace deprecated strncpy
Message-ID: <ZQ1odR+4bLWrxn0h@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230920-strncpy-drivers-i2c-busses-i2c-powermac-c-v1-1-0a3e9a107f8a@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9cBeMkCN/aqfYfhG"
Content-Disposition: inline
In-Reply-To: <20230920-strncpy-drivers-i2c-busses-i2c-powermac-c-v1-1-0a3e9a107f8a@google.com>


--9cBeMkCN/aqfYfhG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 11:07:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>=20
> We should prefer more robust and less ambiguous string interfaces.
>=20
> `info.type` is expected to be NUL-terminated judging by its use in
> `i2c_new_client_device()` wherein it is used to populate `client->name`:
> |	strscpy(client->name, info->type, sizeof(client->name));
>=20
> NUL-padding is not required and even if it was, `client` is already
> zero-initialized.
>=20
> Considering the two points from above, a suitable replacement is
> `strscpy` [2] due to the fact that it guarantees NUL-termination on the
> destination buffer without unnecessarily NUL-padding.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Added "powermac: " to $subject and applied to for-next, thanks!


--9cBeMkCN/aqfYfhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUNaHUACgkQFA3kzBSg
KbZm7RAAk1/spyitaQbYe3PLY8H0wGpdmUP+Yo6vjUIH/2oT5BZDL5XJev83mjnd
GTIDBPXPr1YAK+qpPahs0BNLIVkE8qBXeQMyCfj7LJJcmnvvXuCjoUeyIGtciqLt
y6tOXNy0PwN1KDKW2tE48CsY28VJeFJcXF/ZgGOcx+/FeWz6Fh4A+10fVnaPLPl5
J2iYBxmmrUT/heLsa0WDpuImW/k4iw37gLaEYIYjNlguYES0HgOe3zwQVGmzO38z
xN3CZNr1vFQYqI8hCcZtFayOD50W5YHN88pMbEQC7WJc8Uij0fjdoWLwGLPxSfzn
9noJZkQXGnA7nr+jBM1A4X6uXywLFPacbcHYjcMHeePljzthLhrOuJOJCd96p0IF
F4ckvd8AnRt0q3tXiracT+PnkXWlKGrREIkkxfdJ7L4OWTAzVQbRmcceXjO4+zac
fWW/rnNblvanTac8r7gU0AtVSavJqCnRawLvOeiVxJcNUxSr8IX1w5GMnOkWXT+V
YN9OP4iVcFFM8GEC3mbY49YOeO2z+4H79BjwXpef2lfYu6zYrDfYpgkMvrGjRXaZ
Wp/V5GE1bXbWi3uQhe6F9ruU07xz1ZOEfnW6gVtTt6whyi6g1AksJHCHTcpF0Sna
BIErf242wmZ6BSNpB/a60OXqcovC9Z1xQeXMUUzvdHIuUXZEZ7s=
=8uVT
-----END PGP SIGNATURE-----

--9cBeMkCN/aqfYfhG--
