Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD07BAF7
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587943; cv=none; b=Xo/N3PKZDaFTLDfnI0gPejgUwku62qyILhr2nWe0FaodOnTira70upmImadY7sfaCgECQRDSaO91Nc8YqoOlhOdWVPskftY8ENhhCDHAP6m7xYFJduoj/NSSFymXgeGbCA9+K81jWp3iK46h9wiLD4AdQxH626t9/ffrGixhlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587943; c=relaxed/simple;
	bh=Fid7qZAd/FJHN/tsMQvT21XJE1w7mAABpnaR9DnDguQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm5IOpeklQJ5Q6v9YX7uaS1sznM1eoPeGw8dMXOMrHNJm99NUN2YlKO08mk1oj0PlXrWC2+DvjqQYouZn6yc7Ia/Mc8LRpzYhFlBHfq6lQJXjHcfrpBX/eJ+SiY4fmDaMCLVPHlf9EA2OKYY6gu6KDanKrQo9gK7tauSeAV4MLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LlxvZC8d; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LlxvZC8d"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e62c65865cso938285b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709587941; x=1710192741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AAGBs1uayIPxzgb5qVJOa8HOKMdVNYp2rAU1bHGoGE=;
        b=LlxvZC8dI4upTIvgiol1/vPFgKgj0eEt9Rlrekdddxoa1plFoW6paMLc2u/8Z0C98l
         whP6lPQDQHBOBOXmn2tEdmakrisCM5AC4ZVF2ljUz2f9OnVkT4P3rs/eDlqB97Wjs7fl
         oqLKO6CSdmej4UMCvQKeBtYiufJL65tLIY1aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587941; x=1710192741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AAGBs1uayIPxzgb5qVJOa8HOKMdVNYp2rAU1bHGoGE=;
        b=RJdgMoc1KiAZN+IOBLv2mwq8dkZ0E4FDTUi2c/RsTu86CGkyQSPo17PlaJhpEpjnnb
         w+4to+Uh9uvJ30ROrhv/27+5xsFV8K3Z1N6MeU7x9xkEMQcB+UuWtZEX0n8aHMDzxiMY
         5neejpSeZWtuST8AsBt8sP1jCVL2R9i1X4No0DxzVGzSvgL9NkNzF9Mh4ZpPKi4xrZ9y
         mhV9SYQeBOoQZ2lFJOv5S0mVJ76wFYREDKvJJmGmOLBBq61La/dghSEMQy9Ga8mBgiJ9
         EC+MirxWgkfrchl4sgUinV9QJ9FQrkC318+vXI6DbFHHTpJqaMU8nXwDsS8Ydit31Ji7
         N/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB6ypXyv6ut8068lazN/ojOKcNF/pIXSWCZD1IgiQmnV4Uy/Q/MTUmuSRZeZ+7kk2NMJSjDsHsK1UFOTpl2HoWKIlhbBU8kal+gRYgzSRh
X-Gm-Message-State: AOJu0YzYE5X4+zFNft1GCZzYcwwLe2rcVfEdmXSLnCIjJEDDIYamIFkv
	0e7XjpSOeofuA+kGqNU8dW4+iR8VZ4XjwFGZCeT5AokqHJUfBABGmvoYzLpnUw==
X-Google-Smtp-Source: AGHT+IEEnu5o0IjVhO8m0c2U97SysmqAe9C51lQEBxAa+CLPJbohojNI1/SQD2+C0H93ZMSvh+9SMg==
X-Received: by 2002:a05:6a20:3c8d:b0:1a1:2a5b:a6c3 with SMTP id b13-20020a056a203c8d00b001a12a5ba6c3mr12600656pzj.3.1709587941650;
        Mon, 04 Mar 2024 13:32:21 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w62-20020a636241000000b005e485fbd455sm7872070pgb.45.2024.03.04.13.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:32:21 -0800 (PST)
Date: Mon, 4 Mar 2024 13:32:20 -0800
From: Kees Cook <keescook@chromium.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] xattr: Use dedicated slab buckets for setxattr()
Message-ID: <202403041330.06842D397@keescook>
References: <20240304184252.work.496-kees@kernel.org>
 <20240304184933.3672759-3-keescook@chromium.org>
 <ZeY6Lv4rfUyFHgOr@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeY6Lv4rfUyFHgOr@dread.disaster.area>

On Tue, Mar 05, 2024 at 08:16:30AM +1100, Dave Chinner wrote:
> On Mon, Mar 04, 2024 at 10:49:31AM -0800, Kees Cook wrote:
> > The setxattr() API can be used for exploiting[1][2][3] use-after-free
> > type confusion flaws in the kernel. Avoid having a user-controlled size
> > cache share the global kmalloc allocator by using a separate set of
> > kmalloc buckets.
> > 
> > Link: https://duasynt.com/blog/linux-kernel-heap-spray [1]
> > Link: https://etenal.me/archives/1336 [2]
> > Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [3]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/xattr.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 09d927603433..2b06316f1d1f 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -821,6 +821,16 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
> >  	return error;
> >  }
> >  
> > +static struct kmem_buckets *xattr_buckets;
> > +static int __init init_xattr_buckets(void)
> > +{
> > +	xattr_buckets = kmem_buckets_create("xattr", 0, 0, 0,
> > +					    XATTR_LIST_MAX, NULL);
> > +
> > +	return 0;
> > +}
> > +subsys_initcall(init_xattr_buckets);
> > +
> >  /*
> >   * Extended attribute LIST operations
> >   */
> > @@ -833,7 +843,7 @@ listxattr(struct dentry *d, char __user *list, size_t size)
> >  	if (size) {
> >  		if (size > XATTR_LIST_MAX)
> >  			size = XATTR_LIST_MAX;
> > -		klist = kvmalloc(size, GFP_KERNEL);
> > +		klist = kmem_buckets_alloc(xattr_buckets, size, GFP_KERNEL);
> 
> There's a reason this uses kvmalloc() - allocations can be up to
> 64kB in size and it's not uncommon for large slab allocation to
> fail on long running machines. hence this needs to fall back to
> vmalloc() to ensure that large xattrs can always be read.

I can add a vmalloc fallback interface too. It looked like the larger
xattr usage (8k-64k) was less common, but yeah, let's not remove the
correct allocation fallback here. I'll fix this for v2.

Thanks!

-Kees

-- 
Kees Cook
