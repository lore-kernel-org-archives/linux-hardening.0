Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E1218AC7;
	Mon,  7 Apr 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060845; cv=none; b=EfVE5ZtKbUpeY7Ah4WU4mIkM6ICDsn+sbITn6Nw5xYzKVL33Lg9EwYPJeYSRY2fr4e98Vksuu3Zd6AkuUJPr3X2lA9YRsbjOKF5vGKNXb5N3obXTVnRVAnYquSpVv9fC5KfsRxhTYpo6iP8IRkVcARfmP1JoSlgAuD4sR91FWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060845; c=relaxed/simple;
	bh=EK5DbQDCfWudKq25hayyLCM9CHKKTOxpNscsok0J8IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg/rSBgbqQWlinkrgxpR+qW/CBoBrlPKv/y5rW/0A0wdWAssVnAn6P2ZFRnzeWI2w5MR1V4NGUzZVrkjKjtAt6ZqAmrEhYlbQI5o7hH9k7b5XKJqadtCSaR3Q9Y6Q9lV3hXDGREJfW3uPSWwVeZd9g1iSvgQi5xEMDgqyY1IfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWdOAxp5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWdOAxp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF78C4CEDD;
	Mon,  7 Apr 2025 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744060845;
	bh=EK5DbQDCfWudKq25hayyLCM9CHKKTOxpNscsok0J8IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWdOAxp58qBqTNH5/uLEPagtqX6njXoQN2I94OT9XeDpBKNs8qRSWTVAQ/P2G/j6X
	 GYx5G28mKG90XLkE7qzDY67kUdC7FQeAjFdCvUvRRAu/3k8ka0oToXIDRqxtjUtZ3x
	 9aybsl/5RTUaZ0an9R77hAE2MIbUPXs5H1KnS5phYVXHUgKp+ogCGxrLlRcsCduVgG
	 afwY3O1u4Y1BNgiTzassBh6LOQ7GEUU+nTRuBgiJQy++oLcJzKobV51FDcTbLrbCHS
	 S5XxhI5CA8rvX9BaXOvIX5KxcS6gTQeik/F5T5BLyT2kU8/kojuta3UBJqj/F6vieZ
	 GfKbTeoEfVTTA==
Date: Mon, 7 Apr 2025 23:20:41 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Alex Elder <elder@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] EISA: Increase length of device names
Message-ID: <b4bzeghwifymbahgtjrehyulb3ezljaexwwqsjnj4utk2koroz@zsru65co3ufp>
References: <20250407172926.it.281-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zfmjv7bhmf4xtvt6"
Content-Disposition: inline
In-Reply-To: <20250407172926.it.281-kees@kernel.org>


--zfmjv7bhmf4xtvt6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Alex Elder <elder@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] EISA: Increase length of device names
References: <20250407172926.it.281-kees@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250407172926.it.281-kees@kernel.org>

Hi Kees,

On Mon, Apr 07, 2025 at 10:29:35AM -0700, Kees Cook wrote:
> GCC 15's -Wunterminated-string-initialization warned about truncated
> name strings. Instead of marking them with the "nonstring" attribute[1],
> increase their length to correctly include enough space for the
> terminating NUL character, as they are used with %s format specifiers
> when showing resource allocations in /proc/ioports:
>=20
>         seq_printf(m, "%*s%0*llx-%0*llx : %s\n", ..., r->name);
>=20
> The strings in eisa.ids have a max length of 73, and the 50 limit was an
> arbitrary limit that was removed back in 2008 with commit ca52a49846f1
> ("driver core: remove DEVICE_NAME_SIZE define"). Change the limit to 74
> so nothing is truncated any more.
>=20
> Additionally fix the Makefile to use "if_changed" instead of "cmd"
> to detect changes to the command line used to generate the target,
> otherwise devlist.h won't be rebuilt.
>=20
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Alejandro Colomar <alx@kernel.org>

Acked-by: Alejandro Colomar <alx@kernel.org>

> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
>=20
>  v2: crank length to 74 for full coverage and fix Makefile too
>  v1: https://lore.kernel.org/lkml/20250310222424.work.107-kees@kernel.org/
> ---
>  drivers/eisa/Makefile   | 11 ++++-------
>  drivers/eisa/eisa-bus.c |  2 +-
>  include/linux/eisa.h    |  5 ++++-
>  3 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
> index a1dd0eaec2d4..f0d6cf7d1f32 100644
> --- a/drivers/eisa/Makefile
> +++ b/drivers/eisa/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for the Linux device tree
> =20
> -obj-$(CONFIG_EISA)	        +=3D eisa-bus.o
> +obj-$(CONFIG_EISA)	        +=3D devlist.h eisa-bus.o
>  obj-${CONFIG_EISA_PCI_EISA}     +=3D pci_eisa.o
> =20
>  # virtual_root.o should be the last EISA root device to initialize,
> @@ -9,14 +9,11 @@ obj-${CONFIG_EISA_PCI_EISA}     +=3D pci_eisa.o
>  obj-${CONFIG_EISA_VIRTUAL_ROOT} +=3D virtual_root.o
> =20
> =20
> -# Ugly hack to get DEVICE_NAME_SIZE value...
> -DEVICE_NAME_SIZE =3D 50
> -
>  $(obj)/eisa-bus.o: $(obj)/devlist.h
> =20
>  quiet_cmd_eisaid =3D GEN     $@
> -      cmd_eisaid =3D sed -e '/^\#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^=
"]\{1,$(DEVICE_NAME_SIZE)\}\).*"/EISA_DEVINFO ("\1", "\2"),/' $< > $@
> +      cmd_eisaid =3D sed -e '/^\#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^=
"]*                        \)  "/EISA_DEVINFO ("\1", "\2"),/' $< > $@

LGTM.


Have a lovely night!
Alex

> =20
>  clean-files :=3D devlist.h
> -$(obj)/devlist.h: $(src)/eisa.ids include/linux/device.h
> -	$(call cmd,eisaid)
> +$(obj)/devlist.h: $(src)/eisa.ids include/linux/device.h FORCE
> +	$(call if_changed,eisaid)
> diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
> index cb586a362944..edceea083b98 100644
> --- a/drivers/eisa/eisa-bus.c
> +++ b/drivers/eisa/eisa-bus.c
> @@ -21,7 +21,7 @@
> =20
>  struct eisa_device_info {
>  	struct eisa_device_id id;
> -	char name[50];
> +	char name[EISA_DEVICE_INFO_NAME_SIZE];
>  };
> =20
>  #ifdef CONFIG_EISA_NAMES
> diff --git a/include/linux/eisa.h b/include/linux/eisa.h
> index f98200cae637..21a2ecc1e538 100644
> --- a/include/linux/eisa.h
> +++ b/include/linux/eisa.h
> @@ -28,6 +28,9 @@
>  #define EISA_CONFIG_ENABLED         1
>  #define EISA_CONFIG_FORCED          2
> =20
> +/* Chosen to hold the longest string in eisa.ids. */
> +#define EISA_DEVICE_INFO_NAME_SIZE 74
> +
>  /* There is not much we can say about an EISA device, apart from
>   * signature, slot number, and base address. dma_mask is set by
>   * default to parent device mask..*/
> @@ -41,7 +44,7 @@ struct eisa_device {
>  	u64                   dma_mask;
>  	struct device         dev; /* generic device */
>  #ifdef CONFIG_EISA_NAMES
> -	char		      pretty_name[50];
> +	char		      pretty_name[EISA_DEVICE_INFO_NAME_SIZE];
>  #endif
>  };
> =20
> --=20
> 2.34.1
>=20

--=20
<https://www.alejandro-colomar.es/>
<https://www.alejandro-colomar.es:8443/>
<http://www.alejandro-colomar.es:8080/>

--zfmjv7bhmf4xtvt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmf0QaIACgkQ64mZXMKQ
wqm+cg//eBHFhFkJxZKPzp1DP08oDoARdnRx7YJtuMdGmYw0voAl3GIJOzibTcXL
rpVp3Vl+025WtUrgw95fXld35NmXUqFhvY7i16SQEuziKBCHZusCP9iJSQFktNUh
/F7i8+y4IGx8WryzMm6jWrFqXXNQNm1WzDH9s3LnWImUslV1cgol47+TESfR4LL+
H/rzraDFuZHZzdD+P7jUicgxL9lXw8Z84GOSouUkA6VcIvIQjKfiTi2duDNPnK4I
D/jenrpXs3SFhEBw86Eu4MS7kfkecFsePrLgFL6z+gDPkTAf0Jx79XqZlpBbI9aN
tgW2EuIiOLfL+FcEOSkqRFesFxgDCjT2JcmmyO8cAU0xjPc4KcFFVU8I2054UYPv
lpE6XrfciBM1MmE9KPvI1WfuetWfTMv/DE8TqAMgs3+l67EauRZnJqFfYVtih7//
uoUrUmtCCcGUUjXKB/Wm7+I4Bd2GEsZ9ENGva9nxkoYzAyH7VmvhRiKxqUvlZ44D
yeAG4jOoroSYIjb7f8B4gy7RBqtq6kw3I8YpUojUy7CaXEuIGhES7h8DOSAl/FtJ
D7g0EwmBvxKobHD7NBaMjRMzY/lhF7tVEd+UzD2zlf/M5Cdy7Yzft5nSfCv0ge/Q
OAgf0hZe+djDfQ0SiwI/BlCpQLCv9sR5xPqyR1FY7aVR1E199mA=
=ntgs
-----END PGP SIGNATURE-----

--zfmjv7bhmf4xtvt6--
