Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0C19D8A2;
	Tue,  9 Jul 2024 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542743; cv=none; b=E0eiszO7+gnq+25zh6DDPR0Tt+fSvFPGqZGyeKwLhH3wnIYxZCGFHv2Dr0Tyx/pfyoaEEKZlTnaTPhBweHRCL3qAR+iG0e2jd7LiLN8QxcVWqTkR1U7Lb0aEV/VXW6AGy4Ua/8mFHJtpwNsNX7iGi9pqVPzxm6FpDsmE53TiWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542743; c=relaxed/simple;
	bh=FLdjgr6meJn+TXvEGqYcf52cjuR6shaot6RCYkVxb8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfa+GoZB/whZTXUFKf9tso4j0/H/8EzW/xZbDB9+FTY8jf3vltbBPqeqPhpJJSlWAUHwY5PPmjLUABXrULirF0WZHNO4FAHXDPdLi5YNTWWcfECAieg7UrilmSG2QHOiMSAQ/UvoWjT7afy5R8hCXIReRLPUbjRWLNJvMbfoxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTj75iwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTj75iwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B78C3277B;
	Tue,  9 Jul 2024 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542743;
	bh=FLdjgr6meJn+TXvEGqYcf52cjuR6shaot6RCYkVxb8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTj75iwZnk1OpJyXM9r7G1cS70S6Xcgm89zZriykuejpXMPaH/Y25kY9lldYBVoJ4
	 kIxag7yX2o+u4MESoVReiciDUmjyh64RxiOnjQEJ1xm0IVpO68q/Ab/AEESqTZ/sk1
	 qsNbE+sIyyoaYQUSe0PqxH9UDsgKtxCbNmast2D0ZdMJO39ZCYIZXU9pOllqszIofq
	 Jq2PNHyxDDQSrTxoZIMjo3mK/nufqS3q0xb5N5rSiQXXoFOXBkdVBL6ddGTZ1hMQ7U
	 UR7lW0cIwdXyvBiXsVImIQe1/YUiUT9TbruDmqM0IWMpxALo3ISTn0IMarUJx9mik3
	 sgQjVkaUZblgQ==
Date: Tue, 9 Jul 2024 09:32:22 -0700
From: Kees Cook <kees@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jakub Kicinski <kuba@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 4/4] pstore: Replace classic kmalloc code pattern
 with typed argument
Message-ID: <202407090910.87821CD@keescook>
References: <20240708190924.work.846-kees@kernel.org>
 <20240708191840.335463-4-kees@kernel.org>
 <093108ea-f567-4210-9f2e-eb8e5039d1eb@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <093108ea-f567-4210-9f2e-eb8e5039d1eb@intel.com>

On Tue, Jul 09, 2024 at 09:06:58AM +0200, Przemek Kitszel wrote:
> On 7/8/24 21:18, Kees Cook wrote:
> > diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> > index de8cf5d75f34..7bb9cacb380f 100644
> > --- a/fs/pstore/blk.c
> > +++ b/fs/pstore/blk.c
> > @@ -297,7 +297,7 @@ static int __init __best_effort_init(void)
> >   		return -EINVAL;
> >   	}
> > -	best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
> > +	best_effort_dev = kzalloc(best_effort_dev, GFP_KERNEL);
> >   	if (!best_effort_dev)
> >   		return -ENOMEM;
> I expect raised eyebrows and typical vocalizations of amusement :D -
> IOW: we should consider changing the name of the macro, although I like
> it as is :)

Yeah, I prefer keeping the name too. I feel like adding yet more macros
around the allocators does not make anyone too happy. :)

> other:
> you repeat the pointer name twice, and code is magic anyway, so perhaps:
> 	kzalloc_me(best_effort_dev, GFP_KERNEL);
> and another variant to cover declaration-with-init.

Switch the calling style is, however, where I think it'd be good
to change the name. I've had push-back in the past on changing away
from the "assignment style" to the "pass by reference" style, but I
would honestly prefer dropping the assignment: it is almost always
redundant. (I understood the push-back to be around the case of not
being able to easily use the "return kmalloc(...)" code pattern.)

It also makes it easier to deal with fixed array and flexible array
variants, as the argument count can be examined to determine if this is
a fixed-size struct or a flexible object:

	kzalloc_struct(ptr, GFP_KERNEL);

	kzalloc_struct(ptr, flex_member, count, GFP_KERNEL);
		-> uses struct_size() to get allocation size

I wonder if we can find a way to also handle the array case at compile
time:

	kzalloc_struct(array, count, GFP_KERNEL);

And if so, maybe the naming should be "kzalloc_me" like you suggest, or
maybe "kzalloc_obj"?

The resulting Coccinelle script gets a little more complex since we have
to rewrite the matched function, but it's not bad:

@find@
type TYPE;
TYPE *P;
expression GFP;
identifier ALLOC =~ "k[mz]alloc";
@@

	P = ALLOC(\(sizeof(*P)\|sizeof(TYPE)\), GFP)

@script:python rename@
alloc_name << find.ALLOC;
ALLOC_OBJ;
@@

coccinelle.ALLOC_OBJ = cocci.make_ident(alloc_name + "_obj")

@convert@
type find.TYPE;
TYPE *find.P;
expression find.GFP;
identifier find.ALLOC;
identifier rename.ALLOC_OBJ;
@@

-	P = ALLOC(\(sizeof(*P)\|sizeof(TYPE)\), GFP)
+	ALLOC_OBJ(P, GFP)

And the results in fs/pstore/ look like this:


diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index de8cf5d75f34..bc0e0a170604 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -297,7 +297,7 @@ static int __init __best_effort_init(void)
 		return -EINVAL;
 	}
 
-	best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
+	kzalloc_obj(best_effort_dev, GFP_KERNEL);
 	if (!best_effort_dev)
 		return -ENOMEM;
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 03425928d2fb..e0ba70543121 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -682,7 +682,7 @@ void pstore_get_backend_records(struct pstore_info *psi,
 		struct pstore_record *record;
 		int rc;
 
-		record = kzalloc(sizeof(*record), GFP_KERNEL);
+		kzalloc_obj(record, GFP_KERNEL);
 		if (!record) {
 			pr_err("out of memory creating record\n");
 			break;
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..93064ba2c480 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -228,8 +228,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 			 */
 			struct persistent_ram_zone *tmp_prz, *prz_next;
 
-			tmp_prz = kzalloc(sizeof(struct persistent_ram_zone),
-					  GFP_KERNEL);
+			kzalloc_obj(tmp_prz, GFP_KERNEL);
 			if (!tmp_prz)
 				return -ENOMEM;
 			prz = tmp_prz;
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..9561f4dfa853 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -588,7 +588,7 @@ struct persistent_ram_zone *persistent_ram_new(phys_addr_t start, size_t size,
 	struct persistent_ram_zone *prz;
 	int ret = -ENOMEM;
 
-	prz = kzalloc(sizeof(struct persistent_ram_zone), GFP_KERNEL);
+	kzalloc_obj(prz, GFP_KERNEL);
 	if (!prz) {
 		pr_err("failed to allocate persistent ram zone\n");
 		goto err;
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 694db616663f..312796dc93f0 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1165,7 +1165,7 @@ static struct pstore_zone *psz_init_zone(enum pstore_type_id type,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	zone = kzalloc(sizeof(struct pstore_zone), GFP_KERNEL);
+	kzalloc_obj(zone, GFP_KERNEL);
 	if (!zone)
 		return ERR_PTR(-ENOMEM);
 

-- 
Kees Cook
