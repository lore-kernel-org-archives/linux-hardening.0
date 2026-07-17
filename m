Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174873890EF
	for <linux-hardening@vger.kernel.org>; Fri, 17 Jul 2026 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319580; cv=none; b=kJnXqpr5rCYiMo7mQeA/gxjU6mC/F1gVHEeqk7lONuzPM/WL9MbVveXjGBpqIi5Ia8IhCnsAqhev/igXA6G3nl6uaGeD3uLJMn6D7/JGfK2wTdMpfmLCMOtvaL6aUYxLgTzaXecvQ4Kh6cq/qTV2eu8TSje7zGw9aCgJc3+A99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319580; c=relaxed/simple;
	bh=hF2jFPlnj+enfcVrUfvGwllNWPt8U897s7TZXUGoA1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bT7Wa5z9hBwmeL9cPuMsPKVYwu8twM/6MKZ87rQDTAIZc2O8gz6hMYqHaW372sKq6aDI0VeKXDuw11o6fGOktqFF1FJ6B4WTuoyBzjHiHucFs71VzI9ZrbstA/euXZjXqn92BR4mdyYDFaL6wac6SQPJ3Ll/CqoMGg7FgQ7/UnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=kpQKMNJa; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kpQKMNJa"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id kmqww85WUv0ndkp0Sw4yQQ; Fri, 17 Jul 2026 20:18:00 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id kp0RwCObNFb3lkp0SwOz15; Fri, 17 Jul 2026 20:18:00 +0000
X-Authority-Analysis: v=2.4 cv=Xo36OUF9 c=1 sm=1 tr=0 ts=6a5a8df8
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=P-IC7800AAAA:8 a=20KFwNOVAAAA:8 a=24SvauvoKvPOlVEqMToA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=buJP51TR1BpY-zbLSsyS:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JibMIgX1U3zcWR29AYKNxJ+JdhEE1PQBr5OO4tSFk7U=; b=kpQKMNJaE3CiBts/Nf8BE5p1EI
	V6yb5KR5lp/HekLTd2rfUYuv0nC0E932VEeEzC+03tqiENVajZraEdWCOQJC0GGM1LawNK4yDOSwc
	3NZ42dmyklDsSCLnFX7kVpsjkUo07+OJwiSTCh4KYlLWu4NwZszSU/2KzspUBY98vBKkX0IAhbnf6
	gzQevHW1NT4A02Da4nHC32Sdxo/5x9j9YScH9jL8VpNHZPCI41CVk/AdAxG2FJS3cfmghrJWkEV3a
	oUJCpkxO4UnE9DjQnWB5CSRKEMYWhvYiaOKD/uR1bK7lZNCDNT1EA17VjfhbBXk+zDS06Cw9CzQUi
	nwNGh4cw==;
Received: from [177.238.18.24] (port=40600 helo=[192.168.0.12])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wkp0Q-000000040h5-32xI;
	Fri, 17 Jul 2026 15:17:58 -0500
Message-ID: <838b5a6c-aecb-4ab7-9aea-b329b16a6acf@embeddedor.com>
Date: Fri, 17 Jul 2026 14:17:48 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] overflow: Add DECLARE_SIZED_FLEX() helper family
To: Jesse Taube <jtaubepe@redhat.com>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Christoph Hellwig <hch@infradead.org>, John Meneghini <jmeneghi@redhat.com>,
 Chris Leech <cleech@redhat.com>, Jesse Taube <mr.bossman075@gmail.com>
References: <20260714151818.538869-1-jtaubepe@redhat.com>
 <202607150906.33F01B40@keescook>
 <CADRr4bfXHAHhOwnxaFFTJ7CWFE6PAReqnCWPAqQQuPAmU3d-SA@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CADRr4bfXHAHhOwnxaFFTJ7CWFE6PAReqnCWPAqQQuPAmU3d-SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.18.24
X-Source-L: No
X-Exim-ID: 1wkp0Q-000000040h5-32xI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.12]) [177.238.18.24]:40600
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMJ3/Rt0G5BKP4YQyAPS882XNkB0kUz5hT+sa4qkuLRasKBeAcV3pEIpjf3IkxeCw7tnn3ynPk9ZOD7935UzgQp/Y85D5Lofzkwn+ALr2GFu4ZT7en1c
 fEPHNoTVkA/QqswpWsvMuXijL8+zQ6hEWH6lH4od+QuWyZmbP8mURWPKcDzPFfADo6I7ebwtWXokxXr6SouXgy85FXnBMXpUWPVrYNL452GF8WSFzpns+353

Hi!

On 7/17/26 10:17, Jesse Taube wrote:
> On Wed, Jul 15, 2026 at 12:12 PM Kees Cook <kees@kernel.org> wrote:
>>
>> On Tue, Jul 14, 2026 at 11:18:18AM -0400, Jesse Taube wrote:
>>> Add new DECLARE_SIZED_FLEX() helper to set the default size of a
>>> flexible-array member. The code is identical to the declaration in
>>> __DEFINE_FLEX() which has also been changed to use DECLARE_SIZED_FLEX().
>>>
>>> Add DECLARE_COUNTED_FLEX_ARRAY() helper which is a variant of
>>> DECLARE_FLEX_ARRAY() with a counted-by attribute.
>>>
>>> Also add default sized variants of
>>> DECLARE_FLEX_ARRAY(), DECLARE_SIZED_FLEX(), and
>>> DECLARE_COUNTED_FLEX_ARRAY(), DECLARE_COUNTED_SIZED_FLEX().
>>
>> Where do you want to use these new helpers?
>>
>>> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
>>> ---
>>>   include/linux/overflow.h | 58 +++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 54 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>> index a8cb6319b4fb..a3384cae49e5 100644
>>> --- a/include/linux/overflow.h
>>> +++ b/include/linux/overflow.h
>>> @@ -464,6 +464,59 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>>>    */
>>>   #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
>>>
>>> +/**
>>> + * __DECLARE_SIZED_FLEX() - helper macro for DECLARE_SIZED_FLEX() family.
>>> + * Allows for easily declaring a structure with a trailing flexible array member
>>> + * to have a specific size.
>>> + *
>>> + * @obj: object to be given a specific size
>>> + * @name: Name of the array member.
>>> + * @count: Number of elements in the array; must be compile-time const.
>>> + */
>>> +#define __DECLARE_SIZED_FLEX(obj, name, count)       \
>>> +     _Static_assert(__builtin_constant_p(count),             \
>>> +                    "default sized flex array members require compile-time const count");    \
>>> +     union {                                                 \
>>> +             u8 bytes[struct_size_t(obj, name, count)];      \
>>> +             obj;                                            \
>>> +     }
>>> +
>>> +/**
>>> + * DECLARE_COUNTED_FLEX_ARRAY() - Declare a counted flexible array
>>> + *
>>> + * @type: Type name.
>>> + * @name: Name of the array member.
>>> + * @counter: Name of the __counted_by member.
>>> + */
>>> +#define DECLARE_COUNTED_FLEX_ARRAY(type, name, counter)\
>>> +     struct { \
>>> +             size_t counter; \
>>> +             type name[] __counted_by(counter); \
>>> +     }
>>> +
>>> +/**
>>> + * DECLARE_SIZED_FLEX() - Declare a structure with a trailing flexible array
>>> + * member with a default size.
>>> + *
>>> + * @type: Type name.
>>> + * @name: Name of the array member.
>>> + * @count: Number of elements in the array; must be compile-time const.
>>> + */
>>> +#define DECLARE_SIZED_FLEX(type, name, count)        \
>>> +     __DECLARE_SIZED_FLEX(type name[], name, count)
>>> +
>>> +/**
>>> + * DECLARE_COUNTED_SIZED_FLEX() - Declare a structure with a trailing flexible
>>> + * array member counted by count, with a default size.
>>> + *
>>> + * @type: Type name.
>>> + * @name: Name of the array member.
>>> + * @counter: Name of the __counted_by member.
>>> + * @count: Number of elements in the array; must be compile-time const.
>>> + */
>>> +#define DECLARE_COUNTED_SIZED_FLEX(type, name, counter, count)       \
>>> +     __DECLARE_SIZED_FLEX(DECLARE_COUNTED_FLEX_ARRAY(type, name, counter), name, count)
>>
>> I ask about where these will be used because one of the things I want to
>> keep tied together is the "counter" and "count", which usually means the
>> declaration should be combined with an initializer in some way so that
>> the counter gets assigned, as DEFINE_FLEX() ultimately does.
>>
>> I'm worried that extracting the internal construction of __DEFINE_FLEX
>> means we may run the risk of increasing the risk of losing that tie.
> 
> We can add a comment to make sure to set count, or use DEFINE_FLEX
> to allocate it. Im not sure if there is a way for this to be a compile time
> error though.
> 
>> So, I'd love to understand how you want to use this, as that would help
>> my understanding and potentially shape the design so we can keep counter
>> and count strongly associated.
> 
> Basically, I want to use `DECLARE_COUNTED_SIZED_FLEX` for a version of
> this patch that
> uses `__counted_by`
> https://lore.kernel.org/linux-scsi/97526d45-ec7d-48a0-bdc6-659f75839f53@embeddedor.com/
> I have checked that it does always set the `counter` variable correctly.
> 
> As for `DECLARE_COUNTED_FLEX_ARRAY` there is already `DECLARE_FLEX_ARRAY` and
> the counted variant is already used in a few places. A good example is
> `struct max77759_maxq_response` which subsiqently gets allocated with
> `DEFINE_FLEX`
> https://elixir.bootlin.com/linux/v7.2-rc1/source/include/linux/mfd/max77759.h#L253
> 
> I assume you are ok with adding `__DECLARE_SIZED_FLEX` and
> `DECLARE_SIZED_FLEX` as
> they are usefull in cases where keeping structure offsets is
> important, similar to
> TRAILING_OVERLAP. An example of where `__DECLARE_SIZED_FLEX` could be used is:
> https://lore.kernel.org/all/20260714185621.610105-1-jtaubepe@redhat.com/

Please show us examples of how exactly you'd use the helpers you propose
for the cases you mentioned above.

Thanks
-Gustavo

> 
> Thanks,
> Jesse Taube
> 
>>
>>> +
>>>   /**
>>>    * __DEFINE_FLEX() - helper macro for DEFINE_FLEX() family.
>>>    * Enables caller macro to pass arbitrary trailing expressions
>>> @@ -477,10 +530,7 @@ static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtr
>>>   #define __DEFINE_FLEX(type, name, member, count, trailer...)                 \
>>>        _Static_assert(__builtin_constant_p(count),                             \
>>>                       "onstack flex array members require compile-time const count"); \
>>> -     union {                                                                 \
>>> -             u8 bytes[struct_size_t(type, member, count)];                   \
>>> -             type obj;                                                       \
>>> -     } name##_u trailer;                                                     \
>>> +     __DECLARE_SIZED_FLEX(type obj, member, count) name##_u trailer;         \
>>>        type *name = (type *)&name##_u
>>
>> -Kees
>>
>> --
>> Kees Cook
>>
> 

