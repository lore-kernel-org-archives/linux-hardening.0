Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923286;
	b=ULdh+mjaydENvlkLetUGtbYq85jswCgJz6lLgSu0qVsW1eIEbOY+7EHKZ/oTdEzeYAib
	 DTLxikHrRQRVGpdOO76T47N/q5xo9oLPkHb/FHt4RS6nSqR5YTsNSdSV/LaDtcM9Vkzl7
	 tu9wqre4gEVSWttGdmK+O29QdIhNJRchMCwyx6GBCLHiWQJyyNpMmPQ8S2NrY+LI9eW+M
	 TRW6PKN2HjvG+sOHfpE1mPiMaMxuEEvZRxQpyF3icjuqhfMqXxfUXI5U6pjNndG8jQ449
	 PDbG2FNmSLKEKHYA6uT+1WokXCE9kaAuL/b5ipOjIquYxlTVK1b9UbdzJm1dZBl2zwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923286;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IbgAues4A/QbzQGKTApxwzLkqZnWANPJllUF/xvoERw=;
	b=D7Ljju7E8JffkcDMh6yNkZdjMincaxGtVKXgEqxy7F4jVpi1DgVT9jBlEdDYFNpM0WyJ
	 FkQV87NWL1smZw5PEs1IomnzSvqxsIO7BoqEOj3qBM1a8VVDQhymyqyfLnXxdf5eLeGKu
	 8p4UcPQs6qF1Nm5sc+2LqudbpwqvygVU/qkj694EJcQe0fki3UK4Q3Njqdckwfh5UUBKF
	 KaJgihmLCObtX3Q87CLRjZHAh7zoAIfADFVPYl0nWEu7AxFDKdYQPnUxeC29VMYvtr/aX
	 ZcK+o+gwcxHjBNpOIEg6L7bLmiU0v9ExRExJMrsZsMaF/qG3BoPJ48GOxP/Zh/CwGyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPi48CP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75927606A31B;
	Fri,  6 Nov 2026 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPi48CP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805361F008A1;
	Fri,  6 Nov 2026 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923286;
	bh=IbgAues4A/QbzQGKTApxwzLkqZnWANPJllUF/xvoERw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QPi48CP8AL7eUFFoZqnL0GvfCOdEYfMRfwp24DBiVe4FNQNex4z8zK+n8EbJ8uvWn
	 7fDB0E1pKBbsIqeEjYsQ4xnM5ljXaaqDD/Ze/8oXVWYFwMOhjzwYXCU9C0fQ7FS4gG
	 fRrvgz0su4f0Y6yEdPAA9Djx5doENKCkWmkWBABXcXd9nX69KprUu/nCrFVeeYcPAf
	 rhXFmUAkL1QfdetUusYdNkkjVj0J9bWiLty7w07trB1c8tWUl+xHXh5K8ffO4XKvgl
	 MapWckKuefQ2uoi10f3jlOLgLe+PFtigCv7jQb3mUqEosual0CNyRr5vfC0Jz13RtM
	 ujOUzWwpftMwg==
Date: Fri, 6 Nov 2026 01:01:18 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-hardening@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <au0XuGWZ1rXdHyPn@devuan>
References: <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
 <auzHFRzd86iV4-RA@ashevche-desk.local>
 <auzxXyAU6zyHtMtn@devuan>
 <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
 <auz79Izf6Q5qOQPi@devuan>
 <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="jyov6e2ogi6jfrb6"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>


--jyov6e2ogi6jfrb6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-hardening@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Joe Perches <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <au0XuGWZ1rXdHyPn@devuan>
References: <20261105111423.360f4ba8@gandalf.local.home>
 <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home>
 <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local>
 <auzHFRzd86iV4-RA@ashevche-desk.local>
 <auzxXyAU6zyHtMtn@devuan>
 <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
 <auz79Izf6Q5qOQPi@devuan>
 <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>

Hi Linus,

> Date: 2026-11-05 15:21:35-0800
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> On Thu, 5 Nov 2026 at 14:25, Alejandro Colomar <alx@kernel.org> wrote:
> >
> > I'm not a fan of git-grep(1), because it's easier to remember grep(1),
> > as I already need to remember it for other stuff.
>=20
> Why?

Perhaps it's fear of the unknown.  'find | xargs grep' has always worked
just fine.

> "git grep" is *literally* the exact same thing as "git ls-files |
> xargs grep" that you apparently find so natural. It takes all the same
> arguments as "grep" does.

Hmmmm, if it's literally exactly the same thing, I guess I'll give it
a try.  I was probably worried that it might have subtle issues, but
being morally the same, it's comforting.

> Except "git grep" is way more capable if you ever go "Oh, but I'd like
> to go back to an older version".
>=20
> That makes no sense.
>=20
> > I'm finding some issues with git-ls-files(1), though: it's listing
> > symlinks, which grep(1) complains about.  I wish I could discard those
> > with something like '-type f'.
>=20
> Christ.
>=20
> "Doctor, doctor, it hurts when I hit myself in the face with a spiky obje=
ct".

:-)

>=20
> Stop doing that. You're just being silly for no reason.
>=20
> >         $ time git ls-files | xargs grep ARRAY_SIZE | wc -l
>=20
> Just do the sane thing. Look:
>=20
>    git grep ARRAY_SIZE | wc -l
>=20
> Trust me. Just learn to write "git grep". After five minutes of doing
> that, you'll realize that you should always have done it, and you were
> silly thinking anything else.

I'll trust you; I'll give it a try.  :)

>=20
> And it's faster too:
>=20
>   $ time git ls-files | xargs grep ARRAY_SIZE 2&>1 > /dev/null
>=20
>   real 0m0.636s
>   user 0m0.367s
>   sys 0m0.307s
>=20
>   $ time git grep ARRAY_SIZE > /dev/null
>=20
>   real 0m0.519s
>   user 0m1.837s
>   sys 0m1.719s
>=20
> (I used that "2&>1" to obviously remove the errors from the stupid
> mis-used of xargs).
>=20
> And it's *safer* too, because if you have filenames with spaces, "git
> grep" does the right thing. Your xargs thing now needs to start using
> "-z" to git ls-files and "-0" to grep to actually be safe.

Yup, I don't have file names with spaces, because of this (and many
other scripts).

> So just embrace "git grep". I can pretty much guarantee that if you
> use it a while you'll never go back.

Ok.  Thanks!  I'll try it.  :)


Cheers,
Alex

>=20
>             Linus

--=20
<https://www.alejandro-colomar.es>

--jyov6e2ogi6jfrb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrtGMgACgkQ64mZXMKQ
wqlHTBAAkeO8EUiUVJqbN7wxMyXZWajcWJyKquy7/sT9JEjo6HR71jK52w+BZuLY
GG8PGG/ke8LlSYookslax2M//Dc2QNVFXD/lVTnAV51afd+g416fAwqI3ylTTmyM
13fqGtB3OUKgJTwhquHRFh+6WsJ8mdD6gXumRXW1lb8W4YBqMZT3pUYVrVwNeQ6C
ZGcl/sWokhOabWHUbgI2poUA2MIIsm9wtCCIs5ezzkGsE/UHnLzaNYTKqZcfRZSE
rNFvSw1X1wBfG/dxfurwLASeSX8Y1QWiLjkwR62Fl20mWSJ0d8oVWdMFBp2mWh7F
9R9eXz4l9ZoOAFvXbjXbXnpmOTIRrPZ0Q2rjOOYwyQqjvSZSFZ1lkzRapW/Hetp6
Gjm8Kz+6Ab51ru13JFEHevVwidXXfQMLdQukZXodQ20d8jxLmyD0T9tePSanvYw0
cVGKfo9KClItuDhzdSbvN2I6AW3U19Tgjht2jsNL8N4pdfqoW0nHJ5ECC6wariOu
LzKHKQj+HxwvWfOsT/62ZRFixvY80lBnjaZ2AT9236Ob/by2f8k/24/89doXIFLo
W4XP9hEdNdCEZY1Po+lhIkjYasccbwAYQG1fF6IXZKsHFewZLK4bavdtWyixMSpd
5zB74hAW706rDo8Pqx+32Skr0xgixuixEQyuEtdeEfK8mzaUHx0=
=KRnV
-----END PGP SIGNATURE-----

--jyov6e2ogi6jfrb6--
