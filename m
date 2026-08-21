Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B933DA5DB
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303229; cv=none; b=aveAb19qCsxwJCJXOE9LzOfHLD0CdgJnCLzc5Z3Y5/JirKcoNd4UaMS/0zV3PaBmZhYinWXmFP4Pcd0uyJu37MY3+qSjGvLLVELu7ixpWF9haDci4541Zsxa4mKQWUd59y+HJdUiYoe0sah9jf5TRaDZSJf1M7/W0ZfOdvqtfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303229; c=relaxed/simple;
	bh=y5lc1T4QOfSB8WH2ruELRpA3F2dHYBjBghT90sPDVwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RbQJvhXdDX/AQi9cyqQObQxNAPnRC0XW3CwQ/z3aWPd3aIvJ89pTFQnWWy+U/9xtlBeLO87j8O02sT25pFUeWjWWYa+vvb12GRt3wnQL1tNdgcM9U5SlG7RW51bvX3TeI0BX8JUEbzxN3SQf6MCfD4aAAm163ds4t+KgjBziIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl4XEi/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl4XEi/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787303218;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=201DAww7Ii+GbKriFnHJvveC9ZkzEbyaY0CIEBPJ7Bs=;
	b=cl4XEi/C8OC/yafnOQAL1BT4wQIUIQ3oaefuq2n1LtGNHdsQHS17VUKH+8qDZ06d1GG6U1
	+B7otKYcehE0Tq5PndauPdS48JYDphMpQMQ6bS/APJSHSmhZPYzUgqEr9wdqan/lu+oUEV
	rlLIuWVbwgREwIFCEFDhf+e8818D7Ik=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-REjizGWgMIuIdCROnPtNMw-1; Fri,
 21 Aug 2026 05:06:52 -0400
X-MC-Unique: REjizGWgMIuIdCROnPtNMw-1
X-Mimecast-MFC-AGG-ID: REjizGWgMIuIdCROnPtNMw_1787303211
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD66D195606C;
	Fri, 21 Aug 2026 09:06:50 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.44.33.93])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1D6F1800347;
	Fri, 21 Aug 2026 09:06:49 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.18.1/8.18.1) with ESMTPS id 67L96kOF3780734
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 11:06:46 +0200
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.18.1/8.18.1/Submit) id 67L96dRU3780732;
	Fri, 21 Aug 2026 11:06:39 +0200
Date: Fri, 21 Aug 2026 11:06:39 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Richard Biener <richard.guenther@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>, Kees Cook <kees@kernel.org>,
        gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
        josmyers@redhat.com, Bill Wendling <morbo@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tree-object-size: Fix type-1 size for pointers to
 FAM-containing subobjects [PR126975]
Message-ID: <aogVH8UtICMP1Ihv@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <aojDH2Db6XIkVqcf@kspp>
 <CAFiYyc2Uhw0iCwfmCET7gWLnXXYeV7wwPJv9Ny0uEcOrYA2f4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFiYyc2Uhw0iCwfmCET7gWLnXXYeV7wwPJv9Ny0uEcOrYA2f4A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oWNBkSQip7cDJbPGyS39LtrobjeFs3huZg72WVXnhN8_1787303211
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Aug 21, 2026 at 10:56:34AM +0200, Richard Biener wrote:
> On Fri, Aug 21, 2026 at 8:30 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > For a pointer to a subobject whose record/union type ends in a flexible-array
> > member (directly, or through its trailing nested struct), addr_object_size()
> > walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
> > measuring the referenced subobject. __builtin_object_size() and
> > __builtin_dynamic_object_size() type 1 therefore returned the whole-object
> > size, collapsing type 1 onto type 0 and losing the distinction between
> > &p->inner and p. FORTIFY_SOURCE relies on the type-1 distinction, so this
> > weakens its bounds checks.
> >
> > Fix this by computing the size directly from the referenced record/union
> > instead of walking up, restoring the type-0/type-1 distinction that Clang
> > already implements.
> >
> > Bootstraped and regtested on x86_64-linux-gnu.
> >
> >         PR tree-optimization/126975
> >
> > gcc/ChangeLog:
> >
> >         * tree-object-size.cc (addr_object_size): For a reference to a
> >         record or union type, compute the object size from the referenced
> >         subobject instead of walking up to the enclosing object when the
> >         type recursively includes a flexible array member.
> >
> > gcc/testsuite/ChangeLog:
> >
> >         * gcc.dg/builtin-object-size-pr101832.c (main): Update the expected
> >         results of __builtin_object_size (..., 1) queries on subobjects
> >         whose type contains a flexible array member.
> > ---
> >  .../gcc.dg/builtin-object-size-pr101832.c      |  6 +++---
> >  gcc/tree-object-size.cc                        | 18 +++++-------------
> >  2 files changed, 8 insertions(+), 16 deletions(-)
> >
> > diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
> > index 60078e11634..d76286ae454 100644
> > --- a/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
> > +++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr101832.c
> > @@ -92,9 +92,9 @@ int main (int argc, char *argv[])
> >    outer = (void *)magic1;
> >    outest = (void *)magic2;
> >
> > -  expect (__builtin_object_size (&outer->a, 1), -1);
> > -  expect (__builtin_object_size (&outest->b, 1), -1);
> > -  expect (__builtin_object_size (&outest->b.a, 1), -1);
> > +  expect (__builtin_object_size (&outer->a, 1), sizeof(outer->a));
> 
> I think this warrants updating the documentation in extend.texi where
> I think the
> question is how for
> 
> struct A {
>   int n;
>   char data[];
> };
> 
> struct B {
>   int m;
>   struct A a;
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

I actually think we don't want to change this, the handling of nested
flexible and flexible-like arrays has been completely intentional, it was
based on investigation of real-world code and finding some reasonable
middle-ground on what we consider already invalid and what we allow as an
extension, especially because it occurs a lot in real-world code.

What we certainly can change is the behavior when
-fstrict-flex-arrays unless it already behaves the expected way,
and perhaps also when the flex array has counted_by attribute.

Changing this unconditionally will just break a lot of software in the wild
when compiled with -O2 -D_FORTIFY_SOURCE=2 or -O2 -D_FORTIFY_SOURCE=3, which
is very common.

	Jakub

