Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A012FFFA4
	for <linux-hardening@vger.kernel.org>; Tue, 25 Aug 2026 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637026; cv=none; b=hfpLUGeH1WmiERzhXFl+7lIpKGw32JMEjGgoTXRpZ9G+r2jgOe9hqUXq5IB3AuuDnIqhtr+ST7Lj1mmgzZDv2VOUPknlDH+nk/4JuF9X7SMNYBWQv8xjr7tRfTiDbmDTwGWuCumvTp89pfFJhhxz0GwptyVOj4goWiUy9wLO6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637026; c=relaxed/simple;
	bh=NJd9dsrn8p3HJ/iy9HUTyDF8V7jVM4mAdC9H/Rbho3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEIPzC9r5ql1sAHTfPA7M+shkguDVG3tsCpFtMaoXYTW8KJga1vQlOcCj8GhlcWCXcmpej42RQQPN+U1bpU6tTfqpBtLOy7klZbDoqqb1LmOGAq/+88jR4907Oc3t+MjTQneRrxqIkwgau/OU9TiAohxOKwFb2smJcdwCcacWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Ua6J4Nyv; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Ua6J4Nyv"
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id yeNYwtVIJhJKMyk37wn3mv; Tue, 25 Aug 2026 05:50:17 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id yk36wbr859tXGyk36wHhOT; Tue, 25 Aug 2026 05:50:16 +0000
X-Authority-Analysis: v=2.4 cv=KK1aDEFo c=1 sm=1 tr=0 ts=6a8d2d18
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=7T7KSl7uo7wA:10 a=PeOOapuUAAAA:8
 a=VwQbUJbxAAAA:8 a=4CtH7uQIhdueW-2XxFgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0BaqRfgCL6CLbWgV2pdm:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9T0oQ3UXl7WTwu1jo5pR/9jTVArWjpzVKQbNeLS+u40=; b=Ua6J4NyvRYjDzihfll4eaa1csE
	ilStAybPhQGYYVby1R5rKpSOMlfWy7xBDEn8foNgccQI3uXucwPJMmIBd8zKuyhJH2PlsZE7JnMkt
	wc4hal/LSEYN9gm5UrqAU4gvugssc9oAdqXaERtZqaM0y+IoxkvIeDkIL9Zh2/4GzAxQ7Yx2qhvds
	SiOukBiIF19edCEH+8ldS5HqfbqOpydA2z00jb4VO7hoRpWgrK8YVOi6I8JRmvEYVgE3wmJqLG+H1
	e/qs5VwvfY9UD1ejlo1qE1V0j8ITAwiCBtLoGoeMqEhzgFZ7QjtffnExm+FpK+moD1EnOrQuwZhX/
	GqFonbTA==;
Received: from [59.16.68.142] (port=57282 helo=[192.168.0.146])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wyk35-00000003aLs-0Jz3;
	Tue, 25 Aug 2026 00:50:15 -0500
Message-ID: <0a7868be-635e-4872-8376-6d91a7b73315@embeddedor.com>
Date: Tue, 25 Aug 2026 14:49:24 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree-object-size: Fix type-1 size for pointers to
 FAM-containing subobjects [PR126975]
To: Jakub Jelinek <jakub@redhat.com>,
 Richard Biener <richard.guenther@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Siddhesh Poyarekar <siddhesh@gotplt.org>, Kees Cook <kees@kernel.org>,
 gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
 josmyers@redhat.com, Bill Wendling <morbo@google.com>,
 linux-hardening@vger.kernel.org
References: <aojDH2Db6XIkVqcf@kspp>
 <CAFiYyc2Uhw0iCwfmCET7gWLnXXYeV7wwPJv9Ny0uEcOrYA2f4A@mail.gmail.com>
 <aogVH8UtICMP1Ihv@tucnak>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aogVH8UtICMP1Ihv@tucnak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 59.16.68.142
X-Source-L: No
X-Exim-ID: 1wyk35-00000003aLs-0Jz3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.146]) [59.16.68.142]:57282
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfETVqaqjq/hSKGJ8DVFH7n8CG5e92D1MiHUGm+SC3b7Lwjl5A84vneu3tpd9Sfx+6Lzcv16S4cVrw/1e0EEYNyf3I9WbXVSvojn6O1OiKxdoScfZHHwx
 9fW9jEu/hhuydweX3X0tLYFEnc/nj0xKUPCiW4NQq3X6hlZtj7yo9V8vWJpi7jUVMw6AzqBgQG19D1I/uqDBmEmYDzuK0HEMbjIaHYNPgCmLzbs94BEN3auX



On 8/21/26 03:06, Jakub Jelinek wrote:
> On Fri, Aug 21, 2026 at 10:56:34AM +0200, Richard Biener wrote:
>> On Fri, Aug 21, 2026 at 8:30 AM Gustavo A. R. Silva
>> <gustavoars@kernel.org> wrote:
>>>
>>> For a pointer to a subobject whose record/union type ends in a flexible-array
>>> member (directly, or through its trailing nested struct), addr_object_size()
>>> walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
>>> measuring the referenced subobject. __builtin_object_size() and
>>> __builtin_dynamic_object_size() type 1 therefore returned the whole-object
>>> size, collapsing type 1 onto type 0 and losing the distinction between
>>> &p->inner and p. FORTIFY_SOURCE relies on the type-1 distinction, so this
>>> weakens its bounds checks.
>>>
>>> Fix this by computing the size directly from the referenced record/union
>>> instead of walking up, restoring the type-0/type-1 distinction that Clang
>>> already implements.
>>>
>>> Bootstraped and regtested on x86_64-linux-gnu.
>>>
>>>          PR tree-optimization/126975
>>>
>>> gcc/ChangeLog:
>>>
>>>          * tree-object-size.cc (addr_object_size): For a reference to a
>>>          record or union type, compute the object size from the referenced
>>>          subobject instead of walking up to the enclosing object when the
>>>          type recursively includes a flexible array member.
>>>
>>> gcc/testsuite/ChangeLog:
>>>
>>>          * gcc.dg/builtin-object-size-pr101832.c (main): Update the expected
>>>          results of __builtin_object_size (..., 1) queries on subobjects
>>>          whose type contains a flexible array member.
>>> ---
>>>   .../gcc.dg/builtin-object-size-pr101832.c      |  6 +++---
>>>   gcc/tree-object-size.cc                        | 18 +++++-------------
>>>   2 files changed, 8 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
>>> index 60078e11634..d76286ae454 100644
>>> --- a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
>>> +++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
>>> @@ -92,9 +92,9 @@ int main (int argc, char *argv[])
>>>     outer = (void *)magic1;
>>>     outest = (void *)magic2;
>>>
>>> -  expect (__builtin_object_size (&outer->a, 1), -1);
>>> -  expect (__builtin_object_size (&outest->b, 1), -1);
>>> -  expect (__builtin_object_size (&outest->b.a, 1), -1);
>>> +  expect (__builtin_object_size (&outer->a, 1), sizeof(outer->a));
>>
>> I think this warrants updating the documentation in extend.texi where
>> I think the
>> question is how for
>>
>> struct A {
>>    int n;
>>    char data[];
>> };
>>
>> struct B {
>>    int m;
>>    struct A a;
>> };
>>
>> structr B *outer;
>>
>> and object &outer->a, how, based on 'type', the enclosing object
>> size is constrained by its enclosing object.  Also for outer->a.data
>> what the enclosing object is and similar how the constraint from the
>> enclosing objects are handled.
>>
>> I'll note that __builtin_object_size behavior might be in conflict
>> with constraints set by -fstrict-flex-arrays.  IIRC "nested" flex arrays
>> are a GNU extension, flex arrays not at the end of an (enclusing)
>> object as well (a particularly bad one).
>>
>> You also need to update the toplevel comment of the testcase
>> which explicitly says your change is wrong.
> 
> I actually think we don't want to change this, the handling of nested
> flexible and flexible-like arrays has been completely intentional, it was
> based on investigation of real-world code and finding some reasonable
> middle-ground on what we consider already invalid and what we allow as an
> extension, especially because it occurs a lot in real-world code.

The current behavior was introduced in GCC 14 (mid-2023). Before that,
the code behaved as expected today.

Before GCC 14:
ok:  __builtin_object_size (&p->inner, 1) == 8
ok:  __builtin_dynamic_object_size (&p->inner, 1) == 8
ok:  __builtin_object_size (&p->inner, 0) == 56
ok:  __builtin_dynamic_object_size (&p->inner, 0) == 56

GCC 14.1+:
WAT: __builtin_object_size (&p->inner, 1) == 56 (expected 8)
WAT: __builtin_dynamic_object_size (&p->inner, 1) == 56 (expected 8)
ok:  __builtin_object_size (&p->inner, 0) == 56
ok:  __builtin_dynamic_object_size (&p->inner, 0) == 56

See: https://godbolt.org/z/Td8sW7G47

> 
> What we certainly can change is the behavior when
> -fstrict-flex-arrays unless it already behaves the expected way,
> and perhaps also when the flex array has counted_by attribute.
> 
> Changing this unconditionally will just break a lot of software in the wild
> when compiled with -O2 -D_FORTIFY_SOURCE=2 or -O2 -D_FORTIFY_SOURCE=3, which
> is very common.
I'm fine with implementing this under -fstrict-flex-arrays=3, which is the
strictest level value for flexible-array members we use in the Linux kernel.

However, given that just three years ago (before GCC 14, as shown above) GCC
already had the behavior this change restores, I think this should probably be
an unconditional change. What do you think?

Also, notice how the behavior for one-element and zero-length arrays, which
we call "fake flexible arrays" in the Linux kernel, is exactly the same
before GCC 14 and now:

Before GCC 14:
[ ] C99 flexible-array member
ok:  __builtin_object_size (&p->inner, 1) == 8
ok:  __builtin_dynamic_object_size (&p->inner, 1) == 8
ok:  __builtin_object_size (&p->inner, 0) == 56
ok:  __builtin_dynamic_object_size (&p->inner, 0) == 56

[1] fake flexible-array member
ok:  __builtin_object_size (&p_1->inner_1, 1) == 16
ok:  __builtin_dynamic_object_size (&p_1->inner_1, 1) == 16
ok:  __builtin_object_size (&p_1->inner_1, 0) == 64
ok:  __builtin_dynamic_object_size (&p_1->inner_1, 0) == 64

[0] fake flexible-array member
ok:  __builtin_object_size (&p_0->inner_0, 1) == 8
ok:  __builtin_dynamic_object_size (&p_0->inner_0, 1) == 8
ok:  __builtin_object_size (&p_0->inner_0, 0) == 56
ok:  __builtin_dynamic_object_size (&p_0->inner_0, 0) == 56

GCC 14.1+:
[ ] C99 flexible-array member
WAT: __builtin_object_size (&p->inner, 1) == 56 (expected 8)
WAT: __builtin_dynamic_object_size (&p->inner, 1) == 56 (expected 8)
ok:  __builtin_object_size (&p->inner, 0) == 56
ok:  __builtin_dynamic_object_size (&p->inner, 0) == 56

[1] fake flexible-array member
ok:  __builtin_object_size (&p_1->inner_1, 1) == 16
ok:  __builtin_dynamic_object_size (&p_1->inner_1, 1) == 16
ok:  __builtin_object_size (&p_1->inner_1, 0) == 64
ok:  __builtin_dynamic_object_size (&p_1->inner_1, 0) == 64

[0] fake flexible-array member
ok:  __builtin_object_size (&p_0->inner_0, 1) == 8
ok:  __builtin_dynamic_object_size (&p_0->inner_0, 1) == 8
ok:  __builtin_object_size (&p_0->inner_0, 0) == 56
ok:  __builtin_dynamic_object_size (&p_0->inner_0, 0) == 56

See: https://godbolt.org/z/8Pn361TM8

So, this change doesn't affect how those arrays are interpreted by
__bos/__bdos() when used as fake flexible arrays today (that is,
without -fstrict-flex-arrays).

Thanks for the feedback!
-Gustavo

