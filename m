Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE224676D
	for <linux-hardening@vger.kernel.org>; Mon,  1 Sep 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749895; cv=none; b=QrmDNn+et4FAqumCAsI3F1z0325liqyOTIgXMw3AzinE1OEPaIIzyiAlwexyznUOKcPGPr/aRhK6Opu4B62sH7NN5gKKmQ9JvCU1roI5HaG7H1WMmTW9I913EAf0vuXLLiEtly5Jh6PFheEpJqTZkNxJ/rmwOgLoAOUbkIkpGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749895; c=relaxed/simple;
	bh=LXX4UlSMVwOTvqjWX5B5eOBh7vmGJ6aIXmJVkgBDMuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/dLb4R0y5xOfryczLVVFgohTXu2qhuXs7X6Gic/3Psj+lFiGQr141kDP4XE0T6vTOkUvXoQLJa/Z6GdnazHAZ9kx1XC5lISvTHB5RkVB6Yae4BXvUYJtTvVH8aQLhLnst5w9WGAUhgus2gyKkwHphAaC5qbjS7+USt423k9N2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXQDpso0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXQDpso0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so1982513f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 01 Sep 2025 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756749892; x=1757354692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l12FS5A7Kj14urTYIhgntISCGkQ3Fjpq742xAOboATs=;
        b=NXQDpso0Kup0uUhUx7IxpqCG5BPIQVm7uiIm+rsTE3KMzfDs/R/8WOjfHnHOkoKIOU
         RLhbEyX/U94qwSvkCFy7Iq3akqYns1jRp8NAxIo/uqSLP7kFXPZvEKWL3rGQfO8dgBtQ
         S3nxysi3BOzq5nIIJRtAzZJofeVMhEsGbkYCxMjYvttQCS04cmvz1+qI8P8LPCMyOQMs
         ugnyM1BxLAVtjpzsBOikLHfGOkSJbKjQlsld7AwiYAnoZ1XRd1stgZhDXIye7tZja3WH
         0/o6PmMUn+cQ17C/lRaYKKd+5U5dWdmiicamnb1Zw4Ye9cj5ucbm7Fkhm53AM0/o/Pka
         21KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756749892; x=1757354692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l12FS5A7Kj14urTYIhgntISCGkQ3Fjpq742xAOboATs=;
        b=Fax9gM6pRUysJ+yHdgx0a8kNlUMlmQPftXhA0HHtSQO8NBnjqfjoor8ygwfCblNk8a
         i5hbBxUuRyk8aB8E8v3VhSY6rdBicpR74Za7MbjP/X0hgmEWcA7XqYhvxhAlSdlBElFo
         jfjCYaOUVtNTdu4h5hE+jLhJnQwatjUvzr7BaumZ7m2hIFa2n7E66Jx6oqi9otu0VsxX
         piwNts+1t9URB4lafqGC8QIhGnj/s627y3FDRen3Muyc3vemEUfBHLlGBtMl4DJ8leOT
         m4E3DjRErQYnRfHv1O7uJnXQ5gQY5VYUYK06GAYu70qR55dl5S5GOmIPMoO6UWixYAKn
         P59w==
X-Forwarded-Encrypted: i=1; AJvYcCX1c6ONLyTArbwtUj1lXGL5qyBziyM1cUaMXGD3XsWIaXt9yuI0ovxlmr0vUyX7Bi36y5vyr4eCzeRdKvxt5/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoCrRsdaOHP2c+s6ExfS7+8RYuYczdh6ZuIECCKvLU2sb/rHr
	u8xeybBu5lWzNq0kG+ibIHOxZ/bpHAgMul/YYKUUScfRMyZEeq9BDK82rWk0CCNvXjM=
X-Gm-Gg: ASbGnctYC1pXJqjNLZQeKaLCeFmadG1F86kt4nBquvKS/+GHWk4ouVkcbCVe2rZWv2P
	aQerkkNHZAdwKCOL9j70vt4wYwkcqBi+zhY4TY3f4Tbhq4LKUq8V61bIt0c/KUbyhROFPD1wwPD
	O3Y9ZRre/P9xw2LWRJ11km76rLvQyc0aqr47xAc6rNXYzKplWHIXD5q75lD4zUWoN8Lgm3/9ZT+
	jpDXvn/xiYakpW0ArMbW4eQN9qsvjv6firx5GC7kSCuTXRayPD4timUZTgPfi0v2gATmQ/ihcYZ
	kK9Ps8oAqwhLjJnlVaCxOqGHvzIgKpJEHIe36jsYjG1I9rk4bTAr9poQWGfC0c7bEpyAzvdF9wo
	uS8ypBD11h8/giaWz7FLDIhk/NfzF0owJU0ByxUND8Q4=
X-Google-Smtp-Source: AGHT+IEIPbML0WpZyjUyWFk0CKu2It519a87MynXyVGMeesQEMVKVhve3MonxOXqezGGGsk+FaFwYg==
X-Received: by 2002:a05:6000:2908:b0:3ce:d43c:673c with SMTP id ffacd0b85a97d-3d1e03bffc3mr7460950f8f.46.1756749892082;
        Mon, 01 Sep 2025 11:04:52 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0c344f6casm15352996f8f.36.2025.09.01.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:04:51 -0700 (PDT)
Date: Mon, 1 Sep 2025 20:04:50 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <6ailuetf6jt66q2suzlnqo6ersf4tdqfllgltw6ef3gulvvd64@v2rg6wkulzrc>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <4546ce0f-8f29-4708-8af6-82fd1003e4bb@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z65f7sc4bps2vxql"
Content-Disposition: inline
In-Reply-To: <4546ce0f-8f29-4708-8af6-82fd1003e4bb@embeddedor.com>


--z65f7sc4bps2vxql
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 05:44:38PM +0200, "Gustavo A. R. Silva" <gustavo@em=
beddedor.com> wrote:
> Oh, a correction about this. Actually, if we need to use __packed, we wou=
ld
> have to pass it as an argument to TRAILING_OVERLAP(), like this:
>=20
> -#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)                      =
       \
> +#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS, ATTRS)               =
               \
>         union {                                                          =
       \
>                 TYPE NAME;                                               =
       \
>                 struct {                                                 =
       \
>                         unsigned char __offset_to_##FAM[offsetof(TYPE, FA=
M)];   \
>                         MEMBERS                                          =
       \
> -               };                                                       =
       \
> +               } ATTRS;                                                 =
               \
>         }
>=20
> However, in this case MEMBERS is only cgrp_ancestor_storage, and it's cor=
rectly
> aligned to __offset_to_##FAM[offsetof(TYPE, FAM)]; inside the helper. So,=
 we
> don't really need to pack that internal struct.

My intention with the attribute was to prevent a gap (padding) occurring
between=20
	unsigned char __offset_to_##FAM
and
	MEMBERS                                                =20
which would make the address of the first member to mismatch the address
of FAM (the example in struct cgroup_root notwithstanding).

(But perhaps it's guaranteed that first member's offset in the struct is
always equal to offsetof(TYPE, FAM).)

Michal

--z65f7sc4bps2vxql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLXgQBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhpTwD9E7RIx42k+0sEUTSNWW9f
sEt2Fl/TcjJlOKrl2TinGTEBAJOtsKFN44H18yq872KTqoVnfYoVHW9fmSrz22X0
O9UM
=tbUQ
-----END PGP SIGNATURE-----

--z65f7sc4bps2vxql--
