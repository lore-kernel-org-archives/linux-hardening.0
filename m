Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478377;
	b=F0BuMLxbJ16F0/i5b01MTW3T+fXM4GM2UtjiPFEXwEhjcRHy+4Cb1g4C0+TZn4XGZorA
	 lfTNJ5EigP84TwU8KQYSpZDBfXc9pvcokGNpiY92r76MTEeizHqnd77u/BaJCek3xIlZj
	 8/lhBIW4dEgkJgdV5Sswk81PEFK8Hlenbg1a+utVshpi9fzVYFAAjuU089+dARQt5tyPk
	 N7n7c59pbwf6KKdZbtwLc87xH4bJ2qfzxTQOAiLob4P7nNzmCuKJx+ipzN3LQ3jtaYHlS
	 xaysCvi/GdlbBLo4ziEfhbDonrfFOyswpcywKp7ayAsRWfI0Eud5209oIjQRALXhFyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478377;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=a4Hiwgo7R+HZm4bqUhmJ5Y10eCIYQ+s+J5vOxQfUPYk=;
	b=v2wcHGiK82DJZd2i4ubEvtUjiId4kPX0i8sXtvFeAgp0G2wSNifM71kg2Em0BWIH3nAP
	 ejHaUOghR5bRLQDpP+1T0a4Vf3AQfX1tCdiVzHI17B6GvjVIlR9AMFCmtXZFey0J2nmru
	 piQhW+E6TVNRfnb9StwWlelmPdF41QaLgyyWdJ0wo8KEjgBl5F+kx31BlfFeQbfJ1XcvZ
	 dYdbJCcdcO/qYjw4R+bAl7rj41ik3QOeHG2z9itLhg1e7o6ZeLPLqBi1TT0m/NOHTF5bL
	 jRMrUN2rzCtWCCcxapC01Pq4+8bUfjt/4Xet6oIwdWNOWRmLN/n3lduCZqrHCdjHFmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yfmx3/iC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC65606A880;
	Thu, 12 Nov 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yfmx3/iC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B837E1F00A05;
	Thu, 12 Nov 2026 10:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478377;
	bh=a4Hiwgo7R+HZm4bqUhmJ5Y10eCIYQ+s+J5vOxQfUPYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yfmx3/iC/7XtkB87cVZUt+yQ4qrcZxoz5n2K/zeQh5PybM8KDx7GSTbpdn0CBfUat
	 8fhbQHgcRoBqhQdIY5LSKJ9+pKm7SpKTtQhY1cR7ZzbGRRSc6zPu4tohQzA7pOwQL3
	 sjOiqNKz8zc03lqdij4x1Bp6X9jNWSwLxR/0SuiepQPmPeN//gYR8VIPrimvfe0Dc/
	 6sLopGM8zQ+51e1IU6qLm1vjenouGD3zZMEiBCxvxCu4absUCiMSeSUhb/4KgW5dFH
	 k6XRaz5uyrKziJ1ClqBRisgmdsRmVEFgVEJk/s/O0hnb4vKKjerHwGNfwAaaoo+rhf
	 C7SVOe9aZdsvQ==
Date: Thu, 12 Nov 2026 11:12:48 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	driver-core@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <avWNCC3_Ff0knO6J@devuan>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com>
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
	protocol="application/pgp-signature"; boundary="l52whvkkcz7sedlr"
Content-Disposition: inline
In-Reply-To: <20261112004039.GA523044@killaraus.ideasonboard.com>


--l52whvkkcz7sedlr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	driver-core@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <avWNCC3_Ff0knO6J@devuan>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com>
MIME-Version: 1.0
In-Reply-To: <20261112004039.GA523044@killaraus.ideasonboard.com>

[CC +=3D Linus]

Hi Laurent, Linus,

> Date: 2026-11-12 02:40:39+0200
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Hi Kees,
>=20
> On Mon, Sep 14, 2026 at 03:32:17PM -0700, Kees Cook wrote:
> > Mirroring the type-based allocation now in use for the kmalloc family of
> > APIs, provide the same for the devm_kmalloc family of APIs. This will
> > allow for future plumbing of type information (e.g. alignment) into the
> > underlying allocations. This immediately gains type check on return
> > values (instead of the prior "void *" return type).
> >=20
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: <driver-core@lists.linux.dev>
> > Cc: <linux-hardening@vger.kernel.org>
> > ---
> >  include/linux/device/devres.h | 102 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >=20
[...]
> > +#define devm_kmalloc_flex(DEV, VAR_OR_TYPE, FAM, COUNT, ...) \
> > +	__devm_alloc_flex(devm_kmalloc, DEV, default_gfp(__VA_ARGS__), \
> > +			  typeof(VAR_OR_TYPE), FAM, COUNT)
> > +
> > +/* All devm_kzalloc aliases for devm_kmalloc_(obj|objs|flex). */
> > +#define devm_kzalloc_obj(DEV, P, ...) \
> > +	__devm_alloc_objs(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), typeof=
(P), 1)
> > +#define devm_kzalloc_objs(DEV, P, COUNT, ...) \
> > +	__devm_alloc_objs(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), \
> > +			  typeof(P), COUNT)
>=20
> I was recently made aware by Geert of an unfortunate side effect of the
> default GPF_KERNEL argument. I've fixed a memory leak in the imx8-isi
> driver by using devm_kzalloc_objs() as follows:
>=20
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/driver=
s/media/platform/nxp/imx8-isi/imx8-isi-core.c
> index 0ae5f35e017c..9373a5256224 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> @@ -488,7 +488,8 @@ static int mxc_isi_probe(struct platform_device *pdev)
>=20
>  	isi->pdata =3D of_device_get_match_data(dev);
>=20
> -	isi->pipes =3D kzalloc_objs(isi->pipes[0], isi->pdata->num_channels);
> +	isi->pipes =3D devm_kzalloc_objs(dev, isi->pipes[0],
> +				       isi->pdata->num_channels);
>  	if (!isi->pipes)
>  		return -ENOMEM;
>=20
> So far, so good. However, the following code also compiles:
>=20
> 	isi->pipes =3D devm_kzalloc_obj(dev, isi->pipes[0],
> 				      isi->pdata->num_channels);
>=20
> (note the *obj* instead of *objs*) because the third argument is
> interpreted as gfp flags. It's clearly a bug, but one that the compiler
> doesn't catch. The typo is easy to make.
>=20
> Sparse catches the issue:
>=20
> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:491:22: warning: inco=
rrect type in argument 3 (different base types)
> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:491:22:    expected r=
estricted gfp_t [usertype] gfp
> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:491:22:    got unsign=
ed int const num_channels
>=20
> I'm however not sure if build bots report sparse warnings or only
> errors.
>=20
> Is this an issue you're aware of, and do you think it should be
> addressed ?

Indeed, this is a known problem of these macros.  I reported it in March:
<https://lore.kernel.org/lkml/abhGS0n_RsUG97Ni@devuan/>

The link contains a detailed report of the issue, and why it happens.

There is not a single cause of this bug, but rather a combination of
several of them.

I suggest removing kmalloc_obj() entirely, and using kmalloc_objs()
always, with a second argument of 1 when we want a single object.  This
would remove the risk of that typo.  That is, instead of:

    int *p =3D kmalloc_objs(int, 42);
    int *q =3D kmalloc_obj(int);

we should do

    int *p =3D kmalloc_objs(int, 42);
    int *q =3D kmalloc_objs(int, 1);

I also suggest having default arguments without variadic macros.  The
way to do that is using empty arguments.  Linus complained that it hurts
his eyes, but it really makes these macros much safer.

That is, instead of

	int *p =3D kmalloc_objs(int, 42);

we should do

	int *p =3D kmalloc_objs(int, 42,);

By having an explicitly empty third parameter, we'd be asking explicitly
for the default value, which the compiler can verify, compared to having
to guess whether we asked for it or we just forgot about its existence.

Any of these two changes would already reduce the chances of this bug
significantly, but if we apply both, it's almost impossible to have it.

Another issue with that macro is accepting an expression instead of a
type name.  Consider the following mistake:

    p =3D kmalloc_objs(42, *p);

The compiler can't catch that we swapped the order of arguments
accidentally, and will allocate a wrong number of objects (whatever
happens to be in *p, if already initialized, else we might be lucky and
get an uninitialized diagnostic).  If we require that the first
parameter is a type name, it will preclude that problem.

Please let me know if any of these changes is wanted, and I can prepare
some patches.


Have a lovely day!
Alex

>=20
> > +#define devm_kzalloc_flex(DEV, P, FAM, COUNT, ...) \
> > +	__devm_alloc_flex(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), \
> > +			  typeof(P), FAM, COUNT)
> > +
> >  static inline __realloc_size(3, 4) void * __must_check
> >  devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t =
new_size, gfp_t flags)
> >  {
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--=20
<https://www.alejandro-colomar.es>

--l52whvkkcz7sedlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr1kRoACgkQ64mZXMKQ
wqnFkw//auHnN2vErNki0HxNo/v/DxKacndGhaD1gjlvZ17kHd7QrS7rh03uK44/
3JD96vW7Z7g1/Hm0cu+j4jx0A8Sw6FbuqUTNU8MxTBYjgtTCNUoqHBJvS+ltbuJn
zFCpENgoctzObQiPLgL7KeEz2a0kUN1tTxTY9WeldL+Zq9CPOChtWVYLdJToke5n
Ho2/sRndWnGTPTNLKbgaB2YaBbHHBkcNgYeO7J4H3gzkpaFzqU8WlBFX/snbki7n
he/JQP7kSIenbsUhcV1PzMfMaH3xP0E+qXK1Gla/J4y8qqwpe+bPWTEnHbgwrx0E
dsgC1DoCLwXwMTJw3efjsut5zFh0YtMtH5CX+8S7Fto1u6y3nVvYD45ie7xTlFc8
IYDxLb2JEoSBhtPXIIg5HK7yIVIhwDBcaTOvrm9aJP+um556Nm0GRu5hxRHl7pOK
+cenvuXCc0DRsYgwTxH/bnSDh3aBva2op42VGmdgDEh1xm/4HC4y3X5Z6EYLGiSV
JXLfqoUh/FrmlVMRp1OcMvUrAn4QkDQbumWcHTNDtaIfezP4PbNerwK9M/FsflFG
SD1JTaSOAOXlEHn8HgnqgvpBYco6DAV9HYG6i+kP9fvPWQkUr3xC1fUp2qylhk1C
pspEDaquGj62LlF+VSz0h4VktU968CI3/vzOr4A7tV00Rd67qCI=
=0siK
-----END PGP SIGNATURE-----

--l52whvkkcz7sedlr--
