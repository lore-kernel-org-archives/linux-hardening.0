Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91E39183C;
	Thu,  4 Jun 2026 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550398; cv=none; b=ts4Ttc5nPip1v/O9Wwq5Gge3vVglzPw/iaCTKNmS2xGm0EbXLe74W48L007K+sCo7rFF8FLTzLdT8gFxApTsDqCbxMdYZVHkyF9k65LD/ltp+qve2PidyNA4f5w7VZEVVyV9M9qWL9NJp9Wu8H2aBoqjs+tVAK5df+XhIqQCQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550398; c=relaxed/simple;
	bh=zXipXIgKd+8KQkn/WaaFioKTx6VwCL4kWpBxM2Pbdb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9RIv7PJ+OioI9iBYFZy3hqaj/9KDC1OqcEmujQvTNE1yCNhgrxIr6KGoZUfYBgEFHGB8D5/kc3po4tEccgv4DpaCUWIyVEhcFggl9OV3YrzZ33SwMCHer/Yy5y62QaSUBrkZG08T6lzoZNaeTheemQsIh3cMuhX7R70JvvvB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdsUA08B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdsUA08B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE891F00893;
	Thu,  4 Jun 2026 05:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780550397;
	bh=zXipXIgKd+8KQkn/WaaFioKTx6VwCL4kWpBxM2Pbdb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IdsUA08B60viXspX4laPU4RhtoUAglT4tchpnbtoykZ7L+E29e5Fsvj6ToY1eAc4Q
	 uWufd+bXNzcomnTNfoFgkma/R+MsYJE6TU3LtkM6XlhILc5Xhced7r9H6CeiSHcqsi
	 CDzdqyPY7/CGhT03Ra+MZ6785gZFG3R8YschSGGKtpxBMn5cJXnZ++4tw2cPI/muRS
	 ojTr6kpWEhUIdXVn0lCXfiI0niC7bCaZdZBsSJthD+Fi1fP6ufJAUN/4wMx7d2rvjc
	 PxCP6NULO+RpHO0J3LUH89UFTqbYr+/CuXy+Gg7QPXnEGdzMSYiVjfHQmhTdh2V+90
	 YdS+P5Qlr9TdQ==
Message-ID: <ed9e834d-e3a0-40c2-9407-252f7ac7f00b@kernel.org>
Date: Thu, 4 Jun 2026 14:19:30 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem
 buckets allocation
To: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-2-pfalcato@suse.de>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260602183122.747759-2-pfalcato@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------R1qkIECy0a412Zihr25diudF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------R1qkIECy0a412Zihr25diudF
Content-Type: multipart/mixed; boundary="------------8aADOAqpLj38nVKRPt8K4gTn";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>,
 Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Message-ID: <ed9e834d-e3a0-40c2-9407-252f7ac7f00b@kernel.org>
Subject: Re: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem
 buckets allocation
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-2-pfalcato@suse.de>
In-Reply-To: <20260602183122.747759-2-pfalcato@suse.de>

--------------8aADOAqpLj38nVKRPt8K4gTn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/3/26 3:31 AM, Pedro Falcato wrote:
> This is required by users that want to use kmem buckets, but still
> desire specifying the NUMA node.
>=20
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---

Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------8aADOAqpLj38nVKRPt8K4gTn--

--------------R1qkIECy0a412Zihr25diudF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaiEK4gAKCRCGXBN6rc5S
1vM6AQCkY4YYTzaxNH/LFE8/hF3kloS36ybDDdJp9a+btRaPqAEA4IOb16AiRT4O
zjOEcyJ4mUNx0EPzF0P4UEotgig/1QE=
=VEOt
-----END PGP SIGNATURE-----

--------------R1qkIECy0a412Zihr25diudF--
