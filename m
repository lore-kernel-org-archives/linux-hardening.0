Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951835A14B
	for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883574; cv=none; b=U0YFdEYtglzrUBPNHUcq3c9P/yjrm46BUz6lGvNRHAt+kDeza+NJQR8h/nfWijUkwLrtMKBaf4YC7zD/ZZdA1lgMlGc0utzqM7jytwoeWPccfRDgq+Ziv0yFF91WXj4493WX/Ethxn9LS3wS+dcsBQtg/UPsyFBwyyeVelAy3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883574; c=relaxed/simple;
	bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf8QKMbSL2gOAohj/Y9OfvzwK5CRJUvXY/WpLLN5zN+lq6FS9ax+pSzEqT0QSe/pMUSmuRGon4jLgfHGVowLzbWI8P2Tgpp4hhupCB3b7r2wCoI2Pes61QsI0WW9exH3kZoeZ1TqRD4d3XMatraJlPthzVKeQzEQeG3aIMPIPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j0uuJRWx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0uuJRWx"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7272012d30so4835466b.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Nov 2025 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762883571; x=1763488371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
        b=j0uuJRWx4TCgzGcs0iQ/SY+Rz3bHmVL8AO9iaZEmEfl2Hvk3Rq1JTDY0Avo9eNwBF9
         g4jcgzz2Zn+9VuQKLxQChIuYSGAHg2DDU10EHVRSc9HmVefDP7xf1duGH/mXH/ktm/B6
         5XK+iNWb7ZvuvPqVV1hlGaSXhp5zZjJyCm6uhxM9HLcul0bmu+qr7hUpjpt8bI3Nkx6h
         PU/5p3MDB2/pt2aS6Ud1UqOm3jJKyIPNDVeSWfH4j/id7I85JcnMm5qASHLEUkY3bhn6
         /xfn1gOFI/5IhBVMBp2HuV5VZkX/9Y4U6qcJACFw8kOrcLTqKTvhn68SVt7tB9yd4EGn
         XIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762883571; x=1763488371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46edM+lm/eIeFQfqmSHoHH2PCoG6egQvGXMvADmFIHY=;
        b=tmXL6/Txf9st0Ds1HB3OJYqJKwNhpFKQvaNjo6Yv/f1oaiclj8p+ulv5Utl79699Xd
         /BbnWjB2QVjv3va4Ze8ICVpdeAs+aDAUCwJ7EykSc5rZWGrhJIKYoQ2uctorNn74bdQ1
         45jR9crHlVM0LXpYioQMsHjIB365uCXSV29XkzOS3Sg168TB664Q4a6uYNX7VuF7VFg6
         dOELCToVWc2sqh1KGVHhjrii3NDDpMEIyIV0Of9damGwLDL1ewag/6MzwkDq70/Ffxp2
         pasbocSZ4hWFr6jNX+P6f8OAXG8Ib3NhjdvaY23GoPYUdFfGxdMVkDbsYR7P7WjDckRh
         j6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU/LvA5ZfzJovyRZphz9E+NuNn2dQsu3VAE49uswI1baekNxexX84rMBkhS+2Cloi4ND4pMZAS6BkfYtjZK2VE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5nXXgKsMxDK6lcO2VE4477xs8+5QcHHHAtz2sqwBwcr8yyWn
	Wt0JDZgcHJ6uTTRoBQgeAMFOPGgF4VFHaDl6CQWDO5jsgUx8zyrTUCLYa1t5aWfN0Mw=
X-Gm-Gg: ASbGncvTJnmwZfX6rKe//jECtovURUyZf5rEZMC3UOj66RNyM3dwPdhxSD363dZYGJg
	7oqOpZr2qBmiCTYEmn3gGl9GuKuMB8wG4eeZtrdoOglQyZyPVulW777y4G3742w5yLBJoIAnOxo
	2Gz1QNTDQqMbOqTpZYmpJxuYPJuPb2LazUmIc7zHjc+FR76haWkCcpME/J/qjSKwmeTdMBUiWCM
	8/gMU4IKqKzYesq7dPKDBcOEie8mfbPXJRhKWP1CveLilppJPusdNEDGZnDtuHM/cJV7eRIxW81
	ryqUYTK9G+rj7lTA+ZmzksGEvtpWSYq9LBe+ddJ7fujnz4TueAvzW7KJykfcMmQxRGy5NPazscO
	va4CJuhaviofakXLIp9NP7Y3EZLUGOkRCTKO1n0SHDFUAzM3dpz7Dyj7lpCDcLOxGja/Inl3APX
	VMRCMWd6aigjd8H7/Tge6r1+j/ipzaFz+QNS2i9u9JnKuaY6ta9Qlkx0iWafF6Tafg
X-Google-Smtp-Source: AGHT+IGZ24gPwNf9yPCfR7VYmGLvGJvKsnhVnsEWjyP34dYxdAWzeTApGxpBX2H8vl8E9dV82whA7w==
X-Received: by 2002:a17:907:7fab:b0:b72:d56f:3468 with SMTP id a640c23a62f3a-b7331aac316mr1013366b.50.1762883570945;
        Tue, 11 Nov 2025 09:52:50 -0800 (PST)
Received: from localhost (p200300f65f2353049e8cfcf6469e7c35.dip0.t-ipconnect.de. [2003:f6:5f23:5304:9e8c:fcf6:469e:7c35])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b732c87ccfcsm76547366b.9.2025.11.11.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:52:50 -0800 (PST)
Date: Tue, 11 Nov 2025 18:52:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <dvdu27leqnwvxgz6rcgsdbovw2576dtcbmxuaznevjvijdxp6s@t64lg6bckgkd>
References: <20251010030348.it.784-kees@kernel.org>
 <3dd1a00d-08f7-4801-a9f7-d6db61c0e0f3@kernel.org>
 <aRMhLEs9NpGexL7B@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwbp63t7mxf4mfm7"
Content-Disposition: inline
In-Reply-To: <aRMhLEs9NpGexL7B@black.igk.intel.com>


--mwbp63t7mxf4mfm7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
MIME-Version: 1.0

Helo Andy,

On Tue, Nov 11, 2025 at 12:42:36PM +0100, Andy Shevchenko wrote:
> Folks, are you aware that this change blown up the sparse?
> Now there is a "bad constant expression" to each MODULE_*() macro line.
>=20
> Nice that Uwe is in the Cc list, so IIRC he is Debian maintainer for spar=
se
> and perhaps has an influence to it to some extent.

To be honest, in the nearer past I'm very passive on the sparse
maintainer side and even stopped using it as it fails on guard locking.

My impression is also that upstream isn't very active any more, but that
might have been temporal and wrong as I stopped looking.

If there is an outcome and a patch to cherry-pick into the Debian
packaging, give me a ping.

Uwe

--mwbp63t7mxf4mfm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkTd+4ACgkQj4D7WH0S
/k6QXQf/WqP001zUT4Bxw/oC7trx3KqIhrnryL+Ih+OAu0LFHWKobNA3K556JcXQ
YEoGffzJU/J7ODVixICet7Uv94oeQ/1Oqr/OSPXlUst2vEIgQrkAO5guB/DCoS6C
c+aODonO57Ovlc834ylWPacex8K1XrSEC3bO3guctIxR+FLcfYyc6w8CI7pMRZ/0
Kqaype/E9cFIvlGjyxnIZ28NKGuACVyiO6a4jrfnLtCiFsirGWww65tqhUg9hJx8
sZ2RViIzMnMbl+Vqgoxm3JhpqsfgiA9k6069Ey0zw6JgBVH67N8IQs4v/AKqeBeB
05CxLfZZIK/RlfUZfQ1d/EY78KJxOg==
=qd7W
-----END PGP SIGNATURE-----

--mwbp63t7mxf4mfm7--
