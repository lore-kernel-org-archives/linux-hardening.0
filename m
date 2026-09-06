Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8A36B916
	for <linux-hardening@vger.kernel.org>; Sat,  5 Sep 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615731; cv=none; b=GuwsHXNB3a2LrGp2o7WrprhAxecCfd4iaNmLAoas2svYxAB2Ho5zgbZesLOI8+kS+7cNKu3YtYPbSjzufPaAF7aQcZqlQhpxyPX/wrzke77Qm6LTDkjRlfHAVifL6pvaGfxTOrnnvFmkWR7IHLW/aa5VIMUwqN07Vbypu+ylH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615731; c=relaxed/simple;
	bh=gujLFDmKH34mSihkLJVv/GgCXRblzjXyxvJi9I5YSJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5NZv6EYoCiks0GpnLYliGhUqqr55WN5OeCXkBxd6NCfqfPY5miGwti4SZDbLPWkSScBXJiR4BvjK6DnMqb6eB7B8BUdTT7ATy2WJOdP8O2KIHRy7OcZNtAZC7irgp+zt9VlOeXo5WQPL8QOcuTZzYIACSoYqF5UkRVZPZ2dEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=E7KYbYzR; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="E7KYbYzR"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 2a4xx9b4caC0U2qefxsdP7; Sat, 05 Sep 2026 13:42:01 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 2qeex7AEAadLA2qeexLZXB; Sat, 05 Sep 2026 13:42:00 +0000
X-Authority-Analysis: v=2.4 cv=Aqzu3P9P c=1 sm=1 tr=0 ts=6a9c1c28
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=YQEJvNNBgD4jPn6sMTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8BEkY3FtYIA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CSyeHYVTcE1BVMMQTJAehN0jhyMwSCefFzltosUlKlU=; b=E7KYbYzRIqPmaD2LJy4CZjiOga
	Dli8t3x3i9IrZZnJRRQ5AmuGbq1oCT1lVQ6OJ0Z6thPum9Zu3hK//WWQcTzca3ldNbvYhFdua6aq/
	IlyhvopGkpwil2M/P3D9ZqWhmlV5eNxDgFXQO2ICu8mHWaVdsaft2qiTMTthq7RLixqKtPHHyStIq
	OLLpYS3082p1+c31PHoyMtTmjUNmnjsyYEMlXU/i1G5Vb04McH3BmIplE5+OgtEmXIfqWTK1q2Gyj
	y8PHA0L5/dulxDbYMC+yhfeVOl/07vDtK+HdsK2yioxpJe/H2xJ/QeFPJY5ACLznU5lCEK7FmF/9V
	OFi5PW/Q==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:37868 helo=[10.203.100.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.5)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x2qed-00000001HpK-383z;
	Sat, 05 Sep 2026 08:41:59 -0500
Message-ID: <2f707a62-d4cb-4d50-9eb4-f60d0b4dbba4@embeddedor.com>
Date: Sat, 5 Sep 2026 22:41:05 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree-object-size: Fix type-1 size for pointers to
 FAM-containing subobjects [PR126975]
To: Richard Biener <richard.guenther@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Siddhesh Poyarekar
 <siddhesh@gotplt.org>, Kees Cook <kees@kernel.org>, gcc-patches@gcc.gnu.org,
 Martin Uecker <uecker@tugraz.at>, josmyers@redhat.com,
 Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org
References: <aojDH2Db6XIkVqcf@kspp>
 <CAFiYyc2Uhw0iCwfmCET7gWLnXXYeV7wwPJv9Ny0uEcOrYA2f4A@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAFiYyc2Uhw0iCwfmCET7gWLnXXYeV7wwPJv9Ny0uEcOrYA2f4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x2qed-00000001HpK-383z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.4]) [125.195.69.90]:37868
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKTdFKkpzE2/avBhdRwyDA22Uq3cejUuNq5yMKldrx0/4wybE+1Tx/xgzxdKJeBXvbVIcfRIHLfFP9KVJm9NyYMhqD7q0ASCEnSqboHDQ3MvcgxYuIfV
 VMIqUQFB5BboETsbrF+rrQrM0jxKKuLnt61q+WVJP4fP5ITh5DgsTRxQqpibgpsuRgX3i8X5pX4mNJbTI36hQYwDJ2E1F8wAyFPhWpchz0ERTYnPXNPOse61



On 8/21/26 02:56, Richard Biener wrote:
> On Fri, Aug 21, 2026 at 8:30 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>> For a pointer to a subobject whose record/union type ends in a flexible-array
>> member (directly, or through its trailing nested struct), addr_object_size()
>> walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
>> measuring the referenced subobject. __builtin_object_size() and
>> __builtin_dynamic_object_size() type 1 therefore returned the whole-object
>> size, collapsing type 1 onto type 0 and losing the distinction between
>> &p->inner and p. FORTIFY_SOURCE relies on the type-1 distinction, so this
>> weakens its bounds checks.
>>
>> Fix this by computing the size directly from the referenced record/union
>> instead of walking up, restoring the type-0/type-1 distinction that Clang
>> already implements.
>>
>> Bootstraped and regtested on x86_64-linux-gnu.
>>
>>          PR tree-optimization/126975
>>
>> gcc/ChangeLog:
>>
>>          * tree-object-size.cc (addr_object_size): For a reference to a
>>          record or union type, compute the object size from the referenced
>>          subobject instead of walking up to the enclosing object when the
>>          type recursively includes a flexible array member.
>>
>> gcc/testsuite/ChangeLog:
>>
>>          * gcc.dg/builtin-object-size-pr101832.c (main): Update the expected
>>          results of __builtin_object_size (..., 1) queries on subobjects
>>          whose type contains a flexible array member.
>> ---
>>   .../gcc.dg/builtin-object-size-pr101832.c      |  6 +++---
>>   gcc/tree-object-size.cc                        | 18 +++++-------------
>>   2 files changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
>> index 60078e11634..d76286ae454 100644
>> --- a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
>> +++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
>> @@ -92,9 +92,9 @@ int main (int argc, char *argv[])
>>     outer = (void *)magic1;
>>     outest = (void *)magic2;
>>
>> -  expect (__builtin_object_size (&outer->a, 1), -1);
>> -  expect (__builtin_object_size (&outest->b, 1), -1);
>> -  expect (__builtin_object_size (&outest->b.a, 1), -1);
>> +  expect (__builtin_object_size (&outer->a, 1), sizeof(outer->a));
> 
> I think this warrants updating the documentation in extend.texi where

I updated extend.texi in v2:

https://gcc.gnu.org/pipermail/gcc-patches/2026-September/729904.html

Thanks for the feedback!

-Gustavo

> I think the
> question is how for
> 
> struct A {
>    int n;
>    char data[];
> };
> 
> struct B {
>    int m;
>    struct A a;
> };
> 
> structr B *outer;
> 
> and object &outer->a, how, based on 'type', the enclosing object
> size is constrained by its enclosing object.  Also for outer->a.data
> what the enclosing object is and similar how the constraint from the
> enclosing objects are handled.
> 
> I'll note that __builtin_object_size behavior might be in conflict
> with constraints set by -fstrict-flex-arrays.  IIRC "nested" flex arrays
> are a GNU extension, flex arrays not at the end of an (enclusing)
> object as well (a particularly bad one).
> 
> You also need to update the toplevel comment of the testcase
> which explicitly says your change is wrong.
> 
>> +  expect (__builtin_object_size (&outest->b, 1), sizeof(outest->b));
>> +  expect (__builtin_object_size (&outest->b.a, 1), sizeof(outest->b.a));
>>
>>     struct B0 *outer0;
>>     struct C0 *outest0;
>> diff --git a/gcc/tree-object-size.cc b/gcc/tree-object-size.cc
>> index 54c320d36d0..5c8b4ee7862 100644
>> --- a/gcc/tree-object-size.cc
>> +++ b/gcc/tree-object-size.cc
>> @@ -732,21 +732,13 @@ addr_object_size (struct object_size_info *osi, const_tree ptr,
>>                          v = NULL_TREE;
>>                          break;
>>                        }
>> -                   /* if the ref is to a record or union type, but the type
>> -                      does not include a flexible array recursively, compute
>> -                      the object size directly.  */
>> +                   /* If the ref is to a record or union type, compute the
>> +                      object size directly, regardless of whether the type
>> +                      recursively includes a flexible array member.  */
>>                      if (RECORD_OR_UNION_TYPE_P (TREE_TYPE (v)))
>>                        {
>> -                       if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v)))
>> -                         {
>> -                           v = NULL_TREE;
>> -                           break;
>> -                         }
>> -                       else
>> -                         {
>> -                           v = TREE_OPERAND (v, 0);
>> -                           break;
>> -                         }
>> +                       v = NULL_TREE;
>> +                       break;
>>                        }
>>                      /* Now the ref is to an array type.  */
>>                      gcc_assert (TREE_CODE (TREE_TYPE (v)) == ARRAY_TYPE);
>> --
>> 2.47.3
>>

