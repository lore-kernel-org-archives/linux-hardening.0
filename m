Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F01E3DC8;
	Mon,  7 Jul 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914310; cv=none; b=QMVl+TBx+Fboj79hST9yKopjMmlH89atZRqDuDkkiH0xmgr+pCf7/jYWE0RB31kNq162ZZDYBz/kJhlwsami1a3tuy8P2ZWC8ADC21hy/SJLLUqufqnGug57/PIPcYhvKxbjtYybqxuoWszZqm2BYHkY/SJapi+ztXdlxDZqs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914310; c=relaxed/simple;
	bh=Qqf9ps+7e3Tb2WEX2c8IM7c3U0tYKmP/2GxoInoMShA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REeo/d7a8Ufnrl7L0RkE59mUscBJb6269ZGK6VjOa7aNXEG8Jd9OW0cSNpAUkBERDClSgqc2r1qMYWWQB1go6bPrizqObsreuz4RUGNijj66oBajb6s7Rsrv1SY6maiHYrrhE9/W0AEPIkiXVP2BCPROFS0r1US/cp7f4EiPV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTLwsxqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTLwsxqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7461CC4CEE3;
	Mon,  7 Jul 2025 18:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751914310;
	bh=Qqf9ps+7e3Tb2WEX2c8IM7c3U0tYKmP/2GxoInoMShA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTLwsxqISs3bQMuv+PhebvFr3HLKpLxnYnwGH8PXmMzJQy8f+kxgiJjL4tVXC1A3y
	 cILNNjhSVMHClh6LZpqpJW07AQdJcAAaUhxjsd5rSrRUwzHTkKdgdEh8FrW6OKQK68
	 VTeHY50ttmbU/seFeO+PwXe5Ntf3odGsv8WvlOCXpOltagV8VrDwi584yRz/t9O+OC
	 WgEt+DIJwVL59JkIVHDIZ+Z3fBfeG1kRgLx4b2S1msQg6twRNR+Cts0wR5m8mBZPiQ
	 fCBVGkHrQ4FZS2IiybyVAQXu92RUnHng8sRBNCRQZTTO36QyBjxIQkmsseHPxlNB4G
	 AGeCmeEzBLRRg==
Date: Mon, 7 Jul 2025 20:51:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
Message-ID: <gvckzzomd7x3cxd7fxb37b6zn4uowjubpyrnvj7ptzz3mr3zq2@xovzgew63mxr>
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>
 <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
 <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zymvzrfpwpjx3twc"
Content-Disposition: inline
In-Reply-To: <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>


--zymvzrfpwpjx3twc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Chao Yu <chao.yu@oppo.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
References: <cover.1751862634.git.alx@kernel.org>
 <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com>
 <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
 <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>

Hi Marco,

On Mon, Jul 07, 2025 at 04:58:53PM +0200, Marco Elver wrote:
> Feel free to make it warning-free, I guess that's useful.

Thanks!

> > > Did you run the tests? Do they pass?
> >
> > I don't know how to run them.  I've only built the kernel.  If you point
> > me to instructions on how to run them, I'll do so.  Thanks!
>=20
> Should just be CONFIG_KFENCE_KUNIT_TEST=3Dy -- then boot kernel and
> check that the test reports "ok".

Hmmm, I can't see the results.  Did I miss anything?

	alx@debian:~$ uname -a
	Linux debian 6.15.0-seprintf-mm+ #5 SMP PREEMPT_DYNAMIC Mon Jul  7 19:16:4=
0 CEST 2025 x86_64 GNU/Linux
	alx@debian:~$ cat /boot/config-6.15.0-seprintf-mm+ | grep KFENCE
	CONFIG_HAVE_ARCH_KFENCE=3Dy
	CONFIG_KFENCE=3Dy
	CONFIG_KFENCE_SAMPLE_INTERVAL=3D0
	CONFIG_KFENCE_NUM_OBJECTS=3D255
	# CONFIG_KFENCE_DEFERRABLE is not set
	# CONFIG_KFENCE_STATIC_KEYS is not set
	CONFIG_KFENCE_STRESS_TEST_FAULTS=3D0
	CONFIG_KFENCE_KUNIT_TEST=3Dy
	alx@debian:~$ sudo dmesg | grep -i kfence
	alx@debian:~$=20

I see a lot of new stuff in dmesg, but nothing with 'kfence' in it.


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--zymvzrfpwpjx3twc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmhsFzIACgkQ64mZXMKQ
wqm7pBAAp0OWYMffe4VFeySMyLKfBxSElLM0oKkc8hXHHJmYhodncUpDMxt6a6W0
v3YW6LRCH20Pc1pEj4acCR5smdKJ3vXplvkoHKfKeCRlDL2nWTPG6ped6udUMbxp
i9dz4jMwv+XNZccdN03NF5u+o0f4VF0KQOntx0wcGlqg1yvWlp2yg29oTJ5J/fim
pZV/5L1lggzVnkHCze1+kXY4q6ZKko/olwgOhs4NXOQwVC5oxjBI7BUQX9e61Cca
EJ8EVgQLDyzx9O4UhpXmztx+6fzdJLewN2RVfVScnMHF3wLniIa9ZyiwKZHpeeP+
1a3qfy3o/gO0G/KLHpB4RQEdS61jzZxtYgbMYTqxID6QT2j3fTmCpS+nySEtQ8DR
A86GlXYQlt/6HCp3K6ixmMOiTf7YOuFJkapw1T2zM1YZHMa3euxwEdLYwG+hiri1
ZIt5AQP4CGpy90d5PTzZFGxqOdHELjws+oiU3zFXPDN/p2AepkOtSDU75ohaq6Kh
PaK4Fu0ixILfKDRAhOKBDqcwz8eVzWEgAHV/PzksR/+nYBqUj8I3lPqLpu2eQTkV
a/cHEPj7iu8nV0vdlO8CXzH5C9IM41eLSBGf3i7Hl+TWrRXSCq3pJMDp6rWM/52m
R+nNX4VzpE4SfBI9jemyj2HoT7dA6uyaXQV2a2PrNS+XMnbkXOI=
=h4vO
-----END PGP SIGNATURE-----

--zymvzrfpwpjx3twc--
