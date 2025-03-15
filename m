Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EEA95D;
	Sat, 15 Mar 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742054551; cv=none; b=KSrL17l/xHnHXn+KTcF2mR4qj0+0NH38Ns+HjW3vxDOUxHuAa9BelP/bwTEkzLl+xzlmryb/vg1IAgarFW3AQf8+k6YStJ9uABDt/AYc83289Vuw7udaskVZrbb8zTP9e9hOkiggLLStwW+WAvwNgVQHcjsivl+TRUTW4H1cHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742054551; c=relaxed/simple;
	bh=qtl5AjnqARyOJj1pkFXL9QYbeb0Yr975nxxzZ6glj0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8U5FQbolkMnSPTogndTW8FjP1erQO3KtvYTOFP7wmiY4F1MtMRC6bIxEx1z0w/2gGVgLx97508c15usy3mwz5UjO+2+oqEbuMIVXlnaUUyXDN0DLdboaWJuMBbfsHXK+xhMSxWCzf5zLTmj1lRAj7KiI7m2MIA3SUpn0ANreho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXpQBWj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXpQBWj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA9BC4CEE5;
	Sat, 15 Mar 2025 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742054550;
	bh=qtl5AjnqARyOJj1pkFXL9QYbeb0Yr975nxxzZ6glj0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXpQBWj48xsce/ksUL3+pGVteTAcFsUGsuif/VCnorTFV9LpdUvaqmKmpif3L8lPz
	 orVLZ3abz0wTcgN9bor8M+J0w8GO1YLQ6DbXdY8A0PkaSyZjBVFXu2CgNlukKhfvrt
	 7oJtFk1GFJgMk5hIBDSFI813s0QSKNCrGugU6uEAORxn5wE8DYdtKjGZh44vLYHsNS
	 FyA4a2SJ52VXKdTATHeZk1lBvZkwIKs24Z1jKaMNzsQFxOux99v6x4xvhP0yxxJs46
	 sAPOOx5un11Gx8QsWF52yvcbwfuoJZpEcfbi2tSG1DaMJ7jrw0EK/1+4IpkxuB2hx0
	 kpwViS0OC4mpQ==
Date: Sat, 15 Mar 2025 17:02:26 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Alex Elder <elder@riscstar.com>, Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Alex Elder <elder@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Increase length of device names
Message-ID: <y5hkfx6tld2khsv2rb7w3k5hlkhfjfn7ndwwj5g75hkdebvjat@mypbmvg5brfi>
References: <20250310222424.work.107-kees@kernel.org>
 <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lmt4x4w65wae6rm"
Content-Disposition: inline
In-Reply-To: <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>


--2lmt4x4w65wae6rm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Alex Elder <elder@riscstar.com>, Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Alex Elder <elder@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Increase length of device names
References: <20250310222424.work.107-kees@kernel.org>
 <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>
MIME-Version: 1.0
In-Reply-To: <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>

Hi Kees, Alex,

On Sat, Mar 15, 2025 at 09:27:36AM -0500, Alex Elder wrote:
> On 3/10/25 5:24 PM, Kees Cook wrote:
> > GCC 15's -Wunterminated-string-initialization warned about truncated
> > name strings. Instead of marking them with the "nonstring" attribute[1],
> > increase their length to correctly include enough space for the
> > terminating NUL character, as they are used with %s format specifiers.

It might be interesting to mention where they are used with %s.

> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> > Cc: Alex Elder <elder@kernel.org>
>=20
> This was interesting, but based on the bug text I suspect you
> meant to address this to Alejandro Colomar, <alx@kernel.org>.

Thanks!

> For what it's worth, it looks fine to me.

LGTM too.  Assuming that changing the size of the arrays doesn't break
something else, it looks good.


Have a lovely day!
Alex

> 					-Alex
>=20
> > Cc: Sumit Garg <sumit.garg@kernel.org>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> >   drivers/eisa/eisa-bus.c | 2 +-
> >   include/linux/eisa.h    | 4 +++-
> >   2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
> > index cb586a362944..edceea083b98 100644
> > --- a/drivers/eisa/eisa-bus.c
> > +++ b/drivers/eisa/eisa-bus.c
> > @@ -21,7 +21,7 @@
> >   struct eisa_device_info {
> >   	struct eisa_device_id id;
> > -	char name[50];
> > +	char name[EISA_DEVICE_INFO_NAME_SIZE];
> >   };
> >   #ifdef CONFIG_EISA_NAMES
> > diff --git a/include/linux/eisa.h b/include/linux/eisa.h
> > index f98200cae637..c73a410bf88f 100644
> > --- a/include/linux/eisa.h
> > +++ b/include/linux/eisa.h
> > @@ -28,6 +28,8 @@
> >   #define EISA_CONFIG_ENABLED         1
> >   #define EISA_CONFIG_FORCED          2
> > +#define EISA_DEVICE_INFO_NAME_SIZE	51
> > +
> >   /* There is not much we can say about an EISA device, apart from
> >    * signature, slot number, and base address. dma_mask is set by
> >    * default to parent device mask..*/
> > @@ -41,7 +43,7 @@ struct eisa_device {
> >   	u64                   dma_mask;
> >   	struct device         dev; /* generic device */
> >   #ifdef CONFIG_EISA_NAMES
> > -	char		      pretty_name[50];
> > +	char		      pretty_name[EISA_DEVICE_INFO_NAME_SIZE];
> >   #endif
> >   };
>=20

--=20
<https://www.alejandro-colomar.es/>

--2lmt4x4w65wae6rm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmfVpIsACgkQ64mZXMKQ
wqnRRQ/+NlEKzkhK5BB+hw4aSas+IA7ih+NEusuImQm7F8R7OAayOYPrFWv6et0n
ZCW8LC4+qtUOUL6e6kgWXkAFigwlxt+y4/EaX6PI6Gs4zr9NNq/bgA2IgTi2pTo7
J+UhRAh9nZnPYXcv+ggME4CtfJTuWoikuIrNYOVNbIPYn9Nz4YnKPm+PDQIBa5w6
h804yhi4rBtV1Mir1TfzYvYfCgaipSJ71nvHcKv/56clnPVUG78LOP+QV/wtWVxc
e0sW5jQwEqTBOq11GG+YF7f7zpILd5cs1YOOsVpUhV6w74eCOYK0XVmzLtDJGpli
n4SBPMVXNRju46DAQfTSXtY+uFSBkrS4XrCqjSLHHRtSN0qOuOlUtJCVstAHY+wI
Bc+s2jzslhmd+XdNbGy4RuoW1x0p68/A7KfBRCpIthaPuPPQHotX1hErfp9cclwG
yAFQ7Kh+11MJQOo7JGNCPXN6YR/bQuMfqhIVXpMO3Wxy0U3b7PmRqw+/oBLniC1G
vbUmPD+rKZogVa91v6wEjRu9VCqron8Oci81FX4yfHRU4r8qDSSiYxBK731LGVnc
MvQfE1t7eE1vF8AKfRXeAWipfY35Tiu3DQ97OhZcg3PU7BVTvG+lBLAdhfyqSNvc
D7W/er0m+07WL/p1Nyf3PT/B5m5CE25t4jzLzeTb4OUsKG/QwXY=
=cawG
-----END PGP SIGNATURE-----

--2lmt4x4w65wae6rm--
