Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944CE4A1DF8
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999481; cv=none; b=P2L6AT/Zo+CyFGQgpG2ahcC1fRChTgvj3D8L39xRDKDP7IRv1gsRov29iJrKqjf9vUOIiKrfN4jZXneByfWEuJJJ5V/O1ML3+H64l2c+5oClhsLFh9PVO57fGkh2xKmq1rl+SO43d2b2Y8dmD54mFMh4n7342gMmf5ve/e7A6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999481; c=relaxed/simple;
	bh=qV43YwvHNDbICRlF1TEf3aYCeOo6/eQgG/qT4ElCmqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6ZCK2LLXGX4Grd0mM8Ok8NssRqnXotLrgCi/CZ1uNzwY1xXM6G3EKkgKf+ypciYHKMz6EDXF6hN2sqILThltmZy5O6na5hJSN4tv2MurhFiiOakJsKdRlfLnlxy9GS+L16d0/+7rY++2ed2VeIwBcnLeKoEayQNaiXd2hwp5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org; spf=pass smtp.mailfrom=gotplt.org; dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b=HuM9EXZF; arc=none smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="HuM9EXZF"
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7E11A402ABD;
	Mon, 21 Sep 2026 12:46:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.99.242.205])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 45120402C5B;
	Mon, 21 Sep 2026 12:46:29 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Towering-Whimsical: 2ee206466aab4b0f_1789994794387_3768880453
X-MC-Loop-Signature: 1789994794387:1564987128
X-MC-Ingress-Time: 1789994794386
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.242.205 (trex/8.0.2);
	Mon, 21 Sep 2026 12:46:34 +0000
Received: from [192.168.8.195] (unknown [38.74.41.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4hpNJh0D2rz105D;
	Mon, 21 Sep 2026 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1789994788;
	bh=VqszO7lUsJIXYJ6O9Ii+Z+i0nLuQRHtAL4uhSHrSsto=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=HuM9EXZFSVRqEYF4ti4xpeB6maBgNlazPvfLvj6L276istdUvqwDacWKfX4O07EJi
	 e9qUaS36FBq5ZkYzjGUGu54yHSoOjdLvEG9DE7ZGMc3mBKlgLb38FcBV5tROkWxeSf
	 xpHiPzjlLVEw8qUK4Z4bFY2/789jyuRO7qhtHzcIN23wZTUkXCMzLvnJWiV4Q8my1k
	 zvnE5CSC2LwOa6dywwqIJhGsU5HCwar7KRi4uZ+pEhXXkIMqlGF4t7dArumtCky9uR
	 2Q3YHZF0T52TCzWMTFbA6BI0shZ3JytYQ3CPsEK8NbyGqwfaK8Te8fYicziWTMxMWH
	 twAo3+Atd13yg==
Message-ID: <ece8a3e4-8792-473e-b8cd-c0921f1edf95@gotplt.org>
Date: Mon, 21 Sep 2026 08:46:17 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 Richard Biener <richard.guenther@gmail.com>, gcc-patches@gcc.gnu.org,
 Martin Uecker <uecker@tugraz.at>, josmyers@redhat.com,
 Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <apomrLZp1ee3NnBF@kspp> <202609182117.7AFD5B1@keescook>
 <7f43c0b9-2ea7-4038-82c5-ca01aa2c1309@gotplt.org>
 <2df2f47d-5bef-4272-936b-13cfb350aac7@embeddedor.com>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <2df2f47d-5bef-4272-936b-13cfb350aac7@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-21 07:48, Gustavo A. R. Silva wrote:
>> I think you're confusing type 1 with type 2; type 1 is the *maximum* 
>> subobject size, not the minimum.  The whole object and subobject size 
>> distinction is only material if there are members after inner, which 
>> is technically "supported" by the complier as an extension, but is a 
>> terrible idea for members with FAM.
>>
>> Here are the different possibilities for &p->inner:
>>
>> 1. If the allocation via __builtin_malloc is visible: same result for 
>> types 0, 1, 2 and 3, i.e. allocated size - offsetof (struct outer, inner)
> 
> When the allocation is visible and the FAM is annotated with counted_by, 
> we use
> the information provided by counted_by. See commit 6f17933548fc ("Use the
> .ACCESS_WITH_SIZE in builtin object size.")

Yes, the counted_by would basically override allocated size information, 
since the .ACCESS_WITH_SIZE gets emitted after the allocation.

> BTW, I recently filed this related issue:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127234

OK, so is this the core problem you're trying to solve?  It's different 
from pr126975, which AFAICT is NOTABUG since it confuses type-1 with type-3.

>> 2. If the __builtin_malloc is not visible and there's no counted_by 
>> annotation:
>>    - type 0 and type 1: cannot determine size, since FAM could be any 
>> arbitrary size. So, -1
>>    - type 2 and type 3: sizeof (&p->inner), since that's the minimum 
>> estimate.
>>
>> 3. if the __builtin_malloc is not visible and FAM has __counted_by__ 
>> annotation: same result for all types: sizeof (&p->inner) + p->count
>>
>>> I would, however, expect the use of counted_by to change it. For
>>> example, if it were this:
>>>
>>> struct flex {
>>>    size_t count;
>>>    char fam[] __attribute__((counted_by(count)));
>>> };
>>> ...
>>>    struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte 
>>> object */
>>>    p->inner.count = 48;
>>>
>>> I would expect the results to be:
>>>
>>> ok:  __builtin_object_size (&p->inner, 1) == 8        /* compile-time 
>>> size */
>>> ok:  __builtin_dynamic_object_size (&p->inner, 1) == 56 /* run-time 
>>> size */
> 
> I agree with counted_by changing things here. This is actually something
> that Jakub mentioned in a comment to v1 of this patch:
> 
> "What we certainly can change is the behavior when
> -fstrict-flex-arrays unless it already behaves the expected way,
> and perhaps also when the flex array has counted_by attribute."
> 
> See: https://lore.kernel.org/linux-hardening/aogVH8UtICMP1Ihv@tucnak/#t
> 
> BTW, I have a patch ready for PR127234 (the missed counted_by bug) where
> I implemented some helper functions to get the size of the object based
> on the information provided by counted_by. I could use those in this PR. :)
Yes, I agree this would be interesting to fix.  I'm not sure if it needs 
  to be under -fstrict-flex-arrays=3 though, since the size of the FAM 
itself will always be dictated by the counted_by; this will just be an 
extension of that behaviour.

Thanks,
Sid
