Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94872E7391;
	Thu, 16 Jul 2026 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181291; cv=none; b=uxWIZwY7Og+rnTG+Im4juFYakrCBTns/IM13W6tbnWl9+YL8H3uP5iYjHyA1L0+K4Gn9g6LHp/QiAxDuALJIZYqSPa5GqGcVAVddHExzvdE5k/ZcLDGj1d+HdrS+UJYw1t4QbgtL2vxMX3rWipoVekL7KU35x5eZWOo7N5aULVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181291; c=relaxed/simple;
	bh=qHqsHlXUbvMT5idpItcGJRfVzZZ+xZwZtrRFDIkck70=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NqbVPahWhJM0H0I6OrjcrHsDSIG1N+SdfCBwwaMcnF2qCEvG0U56GzeTvoTgTiqVrx30N3jcB5Hliz+HT7hlvT0Nce7tiCUY8YjuSQAc4Vl2v2tl8Z9Cc47McJk/Z7TI+115rp0TzFR+Eija7jYLBiT2nNww3WlUMWx0aXbWU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVt8keMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVt8keMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1381F000E9;
	Thu, 16 Jul 2026 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784181290;
	bh=0kltrmg92IxFhBBOgNV/X0hHz2a88Am7o+QnR+QVhDA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=eVt8keMXHCyFAhwrIb3av8NBNKYSnRFAWhkcfizTzrD7qqaKkiR/8CCTOJKmLZPwR
	 04BmfxZFHxozsAEb5um2lPTzHf9JY4yU4ySrJwnyQ6aQtBWqdoUFYfBL2PbuJzm8J5
	 7jn/oAmt/MHX5/ZrkpYnCIvt0Yn4YXL7AlHp+e+x7vO41okuu2BwXCVRiudT1ChloA
	 QKZcBxZjc434mLsUlZjLs0P2tk9X229s3ZFKWPG/Q7dRUCjTShW4RVhowv64ipm5Al
	 ER4tJBbpjZ3SmEcpX1F1Fv6k81NtqjzIxV2i0XwS3BbeYjNP5lWE61kku4ZXFTrK7C
	 vbGNvR3Twt1gg==
Date: Wed, 15 Jul 2026 22:54:48 -0700
From: Kees Cook <kees@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>, Harry Yoo <harry@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v3=5D_net=3A_skb=3A_isolate_skb?=
 =?US-ASCII?Q?_data_area_allocations_into_a_separate_bucket?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aldpAY6nXwgayHL0@pedro-suse.lan>
References: <20260702170728.168755-1-pfalcato@suse.de> <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com> <ak4w2k4Woj55E0On@pedro-suse> <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org> <aldpAY6nXwgayHL0@pedro-suse.lan>
Message-ID: <153C14E7-738D-4411-9F7A-F3A33DABB4EC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 15, 2026 4:07:49 AM PDT, Pedro Falcato <pfalcato@suse=2Ede> wrote:
>On Wed, Jul 08, 2026 at 10:27:54PM +0900, Harry Yoo wrote:
>>=20
>>=20
>> On 7/8/26 8:16 PM, Pedro Falcato wrote:
>> > On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
>> >> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
>> >> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
>> >>>  }
>> >>>  EXPORT_SYMBOL(napi_build_skb);
>> >>> =20
>> >>> +static kmem_buckets *skb_data_buckets __ro_after_init;
>> >>> +
>> >>>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int =
node)
>> >>>  {
>> >>>  	if (!gfp_pfmemalloc_allowed(flags))
>> >>> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size=
, gfp_t flags, int node)
>> >>>  	if (!obj_size)
>> >>>  		return kmem_cache_alloc_node(net_hotdata=2Eskb_small_head_cache,
>> >>>  					     flags, node);
>> >>> -	return kmalloc_node_track_caller(obj_size, flags, node);
>> >>> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj=
_size,
>> >>> +						    flags, node);
>> >>
>> >> Sashiko noted that some drivers may require GFP_DMA buckets, and the
>> >> above may break them:
>> >>
>> >> https://sashiko=2Edev/#/patchset/20260702170728=2E168755-1-pfalcato%=
40suse=2Ede
>> >=20
>> > Oh, this is really awkward=2E Adding linux-mm and slab maintainers fo=
r input here=2E
>> >=20
>> > Considering the current slab bucketing does not seem to duplicate DMA=
 or
>> > CGROUP caches, could it make sense to duplicate those as well?
>>=20
>> Could we specify what kmalloc types the user needs when creating
>> kmem_buckets and duplicate caches for the requested kmalloc types only?
>
>Perhaps=2E But do the users themselves know? alloc_skb() allows users to =
specify
>random __GFP flags=2E We're bound to see some random caller do
>alloc_skb(__GFP_ACCOUNT) ;)
>
>In all honesty, I'm not quite sure what the best way forward here is=2E T=
he most
>transparent way is to bucket those other kmalloc types as well, but that =
might
>very trivially result in a lot more caches (and possibly memory usage) fo=
r no
>great reason=2E So perhaps specifying caches might do=2E

How about dropping non-standard flag alloc requests into the general kmall=
oc buckets? (I=2Ee=2E have kmem_buckets_alloc redirect on flag mismatch?)

-Kees

--=20
Kees Cook
