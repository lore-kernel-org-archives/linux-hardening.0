Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1D46A4;
	Mon,  3 Jun 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444954; cv=none; b=F0wk3INgurKel+LKp4DKPskOLU08b7VNVPlXtvV1wFpAUXvDQCjG0QbM9Z3rNPZ093Kwq3S2v+XNW8CQmDrNlhzq8oIRN5vJ1IORQJPvtkSPjYmvtbOzsRW3t+j3pY4jsH7UwP/ay4bozrMQZDR/BU7kdn2qA8sU5OgG5TDBvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444954; c=relaxed/simple;
	bh=AYBltyibmcS4U4asfxC/o8WuJGFyFsZjjosU4fSNOks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GczYloGZjRroDsjzOAWfzpgEf5ST0aOhTdszo/qWy6K87MyMUduoqb2IMe54WM/mWOfTy3m9fT8hXkoUbjOR4Ora76QczFCRxpz4apjj74PEMibZqVWVmTfaejq3IFRnOt0+jBYIhjtW9vUR0iK8m5VeKtUnURdWExPgSyanXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IWYq40oB; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IWYq40oB"
Received: from fpc (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 79F9C4076749;
	Mon,  3 Jun 2024 19:54:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 79F9C4076749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1717444492;
	bh=PcR2bwlZQti/encT2nDoXfnro9OdenjYjbHAMNVXpYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWYq40oBY/kBriaYjrguGEQPgQHJNTs1L3nJCnOvYRDD7mfHqTd/QM68t0w45kGN3
	 kmLLTStm3qw64DiVhXnzKdUJ+c9eKCXGbsV3q//0igVRu5IlAlCCCdTXQxUpv7ooSD
	 /tstzyUTlNyEJQyM7xBXImsSIegkTc+1KDWeHZyI=
Date: Mon, 3 Jun 2024 22:54:47 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: David Hildenbrand <david@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>, lvc-project@linuxtesting.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: prevent accessing by index=-1
Message-ID: <20240603-4f7a5fd957aa1f9cbc8d5f14-pchelkin@ispras.ru>
References: <20240603112830.7432-1-abelova@astralinux.ru>
 <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>

On Mon, 03. Jun 18:07, David Hildenbrand wrote:
> On 03.06.24 13:28, Anastasia Belova wrote:
> > nid may be equal to NUMA_NO_NODE=-1. Prevent accessing node_data
> > array by invalid index with check for nid.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online policy")
> > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> > ---
> >   mm/memory_hotplug.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 431b1f6753c0..bb98ee8fe698 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -846,7 +846,7 @@ static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
> >   	unsigned long kernel_early_pages, movable_pages;
> >   	struct auto_movable_group_stats group_stats = {};
> >   	struct auto_movable_stats stats = {};
> > -	pg_data_t *pgdat = NODE_DATA(nid);
> > +	pg_data_t *pgdat = (nid != NUMA_NO_NODE) ? NODE_DATA(nid) : NULL;
> >   	struct zone *zone;
> >   	int i;
> 
> 
> pgdat is never dereferenced when "nid == NUMA_NO_NODE".
> 
> NODE_DATA is defined as
> 
> arch/arm64/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
> arch/loongarch/include/asm/mmzone.h:#define NODE_DATA(nid)      (node_data[(nid)])
> arch/mips/include/asm/mach-ip27/mmzone.h:#define NODE_DATA(n)           (&__node_data[(n)]->pglist)
> arch/mips/include/asm/mach-loongson64/mmzone.h:#define NODE_DATA(n)             (__node_data[n])
> arch/powerpc/include/asm/mmzone.h:#define NODE_DATA(nid)                (node_data[nid])
> arch/riscv/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
> arch/s390/include/asm/mmzone.h:#define NODE_DATA(nid) (node_data[nid])
> arch/sh/include/asm/mmzone.h:#define NODE_DATA(nid)             (node_data[nid])
> arch/sparc/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[nid])
> arch/x86/include/asm/mmzone_32.h:#define NODE_DATA(nid) (node_data[nid])
> arch/x86/include/asm/mmzone_64.h:#define NODE_DATA(nid)         (node_data[nid])

node_data array is declared as follows on most archs:

  struct pglist_data *node_data[MAX_NUMNODES];

It's an array of pointers to struct pglist_data. When doing node_data[-1],
it is actually dereferencing something before the start of the array in
order to obtain a pointer to struct pglist_data, isn't it?

   (C99, 6.5.2.1) The definition of the subscript operator [] is that
   E1[E2] is identical to (*((E1)+(E2))).

> 
> Regarding architectures that's actually support memory hotplug, this is pure pointer arithmetic.
> (it is for mips as well, just less obvious)

Speaking in a dry language of C standard, pointer arithmetic with one
before the first array element is also considered undefined behaviour:

  (C99, 6.5.6p8) "If both the pointer operand and the result point to
  elements of the same array object, or one past the last element of the
  array object, the evaluation shall not produce an overflow; otherwise,
  the behavior is undefined."

Although it doesn't ever crash and probably never won't give any problems,
but who knows what the compiler optimisations would do with this.

> 
> So how is that a real problem? Do we have a reproducer?

This code looks to be executed with memory_hotplug.online_policy=auto-movable,
I suppose it's not a real big problem due to the fact that node_data is a
global variable as otherwise [-1] array access would lead to crashes..

I've triggered the code with node_data[-1] on kernel with UBSAN enabled,
and no splats were observed. Is it due to that node_data is a global
variable or I somehow managed to misuse UBSAN for catching oob access?
Cc'ing linux-hardening.

Nonetheless, maybe it'd be better to define pgdat inside the else-block
in auto_movable_can_online_movable() where it's only used?
