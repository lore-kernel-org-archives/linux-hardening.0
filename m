Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BE3FFD;
	Thu, 16 Jul 2026 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167823; cv=none; b=ncf1tsCrkW54pw2TpqYLmNTsS+61WB6udku9R3yk3iXlJpHm9MbTrWbKjkUdWp0U4k5gjqN9SSmL5FIgyOnDUGDf4iZzx1DOoe3zU9Xj/j2iKFcmUGxfLYtT02BtpcD4IyU7WX0w/1Q9YVSpnlXq14MACH9kueaaiRmUkFbtFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167823; c=relaxed/simple;
	bh=mKuHS926pppT7i9/3ZY+neZGbACcs7xl4EzLTYEhtzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQBmgAM8NxdNRjM+xyXGPm8TARPCxPwVjw6l8IeGTcpWPRpeyY5u5Q3fwRf7bMo6cLQXqwgBY/uODKJiN1QSmJtGsMeFVyDwbVCYfJmuTPqbGa8ds0uC+7v4eFN6sRrWksZMmZRsDK6s9sLPQdnk6JziSL+QeC5pizBrK1u96QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ+ft7uO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ+ft7uO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5333C1F000E9;
	Thu, 16 Jul 2026 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784167822;
	bh=Dwgw+pYgZ2OOIDPwWzrI+VmqmUDlicKkSlmRoSyasLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LZ+ft7uOZkBd27+/82RNKYawDSnuYWQ9iytbjMqNXrOf6yaKiVMajTddbylMdz0x5
	 +xy+ODTU4l9hmBpnLftNf3KQbr9i2dp8gScKNmfZO4jJc3MUyrswzV/G6YyOeQIbdd
	 N6ShiJ6bOUePT2ASg1vCDQvCnce/su7LZLTtYyaD80zkWtQhR+K3NLnXhOJZFtBU/s
	 sUQglse9xTNtDRAQKI2bd+JTC+QxX5/9DfeguyeP8YxtwrHscHwdrgXrdmlkefalw0
	 B/B4tLuCtQnd64Xse+xcRqZ47Hi7Or0VAF1lpH/pu9RHndaxMDY2ObrfJOMUM1rcin
	 SZUdHMCDAVISg==
Message-ID: <072337b6-30b8-41fa-a27d-7beb00e01c24@kernel.org>
Date: Thu, 16 Jul 2026 11:10:15 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
To: Pedro Falcato <pfalcato@suse.de>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@kernel.org>
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
 <ak4w2k4Woj55E0On@pedro-suse>
 <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
 <aldpAY6nXwgayHL0@pedro-suse.lan>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <aldpAY6nXwgayHL0@pedro-suse.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nAdHAmQ4m2vnhCex5aHUduqE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nAdHAmQ4m2vnhCex5aHUduqE
Content-Type: multipart/mixed; boundary="------------vIh7QuKEpqskM0EoX5rWRCbB";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@kernel.org>
Message-ID: <072337b6-30b8-41fa-a27d-7beb00e01c24@kernel.org>
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
References: <20260702170728.168755-1-pfalcato@suse.de>
 <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
 <ak4w2k4Woj55E0On@pedro-suse>
 <529e3997-d26f-4d8e-ad90-3329fe90e555@kernel.org>
 <aldpAY6nXwgayHL0@pedro-suse.lan>
In-Reply-To: <aldpAY6nXwgayHL0@pedro-suse.lan>

--------------vIh7QuKEpqskM0EoX5rWRCbB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/15/26 8:07 PM, Pedro Falcato wrote:
> On Wed, Jul 08, 2026 at 10:27:54PM +0900, Harry Yoo wrote:
>> On 7/8/26 8:16 PM, Pedro Falcato wrote:
>>> On Wed, Jul 08, 2026 at 10:30:50AM +0200, Paolo Abeni wrote:
>>>> On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
>>>> sk_buff *napi_build_skb(void *data, unsigned int frag_size)
>>>>>  }
>>>>>  EXPORT_SYMBOL(napi_build_skb);
>>>>> =20
>>>>> +static kmem_buckets *skb_data_buckets __ro_after_init;
>>>>> +
>>>>>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int =
node)
>>>>>  {
>>>>>  	if (!gfp_pfmemalloc_allowed(flags))
>>>>> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size=
, gfp_t flags, int node)
>>>>>  	if (!obj_size)
>>>>>  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
>>>>>  					     flags, node);
>>>>> -	return kmalloc_node_track_caller(obj_size, flags, node);
>>>>> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj=
_size,
>>>>> +						    flags, node);
>>>>
>>>> Sashiko noted that some drivers may require GFP_DMA buckets, and the=

>>>> above may break them:
>>>>
>>>> https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40su=
se.de
>>>
>>> Oh, this is really awkward. Adding linux-mm and slab maintainers for =
input here.
>>>
>>> Considering the current slab bucketing does not seem to duplicate DMA=
 or
>>> CGROUP caches, could it make sense to duplicate those as well?
>>
>> Could we specify what kmalloc types the user needs when creating
>> kmem_buckets and duplicate caches for the requested kmalloc types only=
?
>=20
> Perhaps. But do the users themselves know? alloc_skb() allows users to =
specify
> random __GFP flags. We're bound to see some random caller do
> alloc_skb(__GFP_ACCOUNT) ;)

Other users don't expose the buckets to drivers, so I thought only
alloc_skb() would create the buckets for each kmalloc type.

> In all honesty, I'm not quite sure what the best way forward here is. T=
he most
> transparent way is to bucket those other kmalloc types as well, but tha=
t might
> very trivially result in a lot more caches (and possibly memory usage) =
for no
> great reason. So perhaps specifying caches might do.

Another direction could be merging those buckets.

If we want to protect kmalloc objects from user-controllable
allocations, can we create buckets for each kmalloc type during the boot
process and let the kmem_buckets users share them?

That doesn't sound like creating too many kmalloc caches, while
providing a decent separation. We already have two buckets users,
one w/ SLAB_ACCOUNT and the other w/o SLAB_ACCOUNT.

If you really want each bucket to have a separate set of caches, you
have to sacrifice some memory for security :)

--=20
Cheers,
Harry / Hyeonggon

--------------vIh7QuKEpqskM0EoX5rWRCbB--

--------------nAdHAmQ4m2vnhCex5aHUduqE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCalg9hwAKCRCGXBN6rc5S
1qiTAQDBTgHUQNlbhhV0KovqNCHl2aAaCrah376xCdTsuaTvSAD8Cg9gheKulpHN
2nrpaiNOraIrtk8ZpVzV4Gwnh3mEJQI=
=PjPB
-----END PGP SIGNATURE-----

--------------nAdHAmQ4m2vnhCex5aHUduqE--
