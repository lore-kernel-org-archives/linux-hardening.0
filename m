Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF48462;
	Wed, 29 Jan 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139708; cv=none; b=fFKjQtNP/iqS84IZOJ/HT35Qr7fFopIq2defyd6nWfYWUDFOHY55KrX4tHVVjq/SLSssn0ff+77/Aq9G8u09Swe80WEef9j37MpB/XkeSLAbbhC2J5NwVDCEL6GjPsi+Zu+RTYIGDxlHB9jAydsOo+ui/aAanDSvt2Y7wwP6C3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139708; c=relaxed/simple;
	bh=gxvTpIAE3DBPCJ8aI6P/6C8gn0iHZTxkw1AhjtXRAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktwT1aRNRJf3DLwWllVIxY0nw6U4cp4bac3ntokx+Y7irYTxm92H7HCEbHtvUVwJOmqALbqPCANyP3oGih2rtMvLrbfOTxEfOD3NxHmprr6wrI7rK0iTHOwiO40RiLAfO3ymh+e7o0OnBvMrnf2pzY78bR6el9ZREZi5rklbOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJVrdmhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJVrdmhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A0CC4CED3;
	Wed, 29 Jan 2025 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738139707;
	bh=gxvTpIAE3DBPCJ8aI6P/6C8gn0iHZTxkw1AhjtXRAF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJVrdmhcaUCdDku6Dkc7A4EBhjdBiwB6W4hwM1Fm73MQwiYceWYCDv/w6aORME1P2
	 dVZh08BTIcP6UF8LMYsHqDeepW5GGCaBa/0ZHO6yfsmRhXL3Hds1P9ArJdSZ95SpeK
	 C5D5xlg90inUXeyD4VuGCXty5PdZTMliXOb8bcX8=
Date: Wed, 29 Jan 2025 09:34:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2025012921-dense-unplanted-952b@gregkh>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>

On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
> 
> 
> On 29/01/25 16:24, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > > This is like container_of_const() but it contains an assert to
> > > ensure that it's using the first member in the structure.
> > 
> > But why?  If you "know" it's the first member, just do a normal cast.
> > If you don't, then you probably shouldn't be caring about this anyway,
> > right?
> 
> This is more about the cases where the member _must_ be first in the
> structure. See below for an example related to -Wflex-array-member-not-at-end

That's fine, but that's a build-time issue, you should enforce that in
the structure itself, why are you forcing people to remember to use this
macro when you want to use the field?  There's nothing preventing anyone
from using container_of() instead here, and nothing will catch that from
what I can tell.

> When addressing the -Wflex-array-member-not-at-end warnings, the common
> scenario is when we have to separate the flexible-array member from the
> rest of the members in the flexible structure, as shown below [1]:
> 
> struct bplus_header
> {
>         struct_group_tagged(bplus_header_fixed, __hdr,
>                 u8 flags;               /* bit 0 - high bit of first free entry offset
>                                            bit 5 - we're pointed to by an fnode,
>                                            the data btree or some ea or the
>                                            main ea bootage pointer ea_secno
>                                            bit 6 - suggest binary search (unused)
>                                            bit 7 - 1 -> (internal) tree of anodes
>                                            0 -> (leaf) list of extents */
>                 u8 fill[3];
>                 u8 n_free_nodes;        /* free nodes in following array */
>                 u8 n_used_nodes;        /* used nodes in following array */
>                 __le16 first_free;      /* offset from start of header to
>                                            first free node in array */
>         );
>         union {
>                 /* (internal) 2-word entries giving subtree pointers */
>                 DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
>                 /* (external) 3-word entries giving sector runs */
>                 DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
>         } u;
> };
> 
> struct_group_tagged() creates a new type: `struct bplus_header_fixed`, we
> then use the newly created type to change the type of the middle objects
> causing the warnings, and with that the warnings are gone:
> 
> @@ -453,7 +455,7 @@ struct fnode
>    __le16 flags;				/* bit 1 set -> ea_secno is an anode */
>  					/* bit 8 set -> directory.  first & only extent
>  					   points to dnode. */
> -  struct bplus_header btree;		/* b+ tree, 8 extents or 12 subtrees */
> +  struct bplus_header_fixed btree;	/* b+ tree, 8 extents or 12 subtrees */
>    union {
>      struct bplus_leaf_node external[8];
>      struct bplus_internal_node internal[12];
> @@ -495,7 +497,7 @@ struct anode
>    __le32 self;				/* pointer to this anode */
>    __le32 up;				/* parent anode or fnode */
> 
> -  struct bplus_header btree;		/* b+tree, 40 extents or 60 subtrees */
> +  struct bplus_header_fixed btree;	/* b+tree, 40 extents or 60 subtrees */
>    union {
>      struct bplus_leaf_node external[40];
>      struct bplus_internal_node internal[60];
> 
> However, this newly created type, or rather the member `__hdr` (also
> created when calling struct_group_tagged()) _must_ always be the first
> member in the flexible struct `struct bplus_header`.
> 
> Then we need to use container_first() to retrieve a pointer to the flexible
> structure [2], via which we can access the flexible-array member when
> necessary:

You don't _need_ to use it, you could use container_of() just fine.
Which is my point, this is always going to get stale and wrong over
time, you are trying to enforce in the .c code when someone access a
field that should have been checked in the .h definition.

> diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
> index c14c9a035ee0c0..a366f6ac71e436 100644
> --- a/fs/hpfs/anode.c
> +++ b/fs/hpfs/anode.c
> @@ -27,7 +27,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
>  				a = le32_to_cpu(btree->u.internal[i].down);
>  				brelse(bh);
>  				if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> -				btree = &anode->btree;
> +				btree = container_first(&anode->btree, struct bplus_header, __hdr);

Ick, so when is anyone going to "know" that container_of() couldn't be
used here instead?  What is going to enforce this?



>  				goto go_down;
>  			}
>  		hpfs_error(s, "sector %08x not found in internal anode %08x", sec, a);
> @@ -69,12 +69,16 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>  	int n;
>  	unsigned fs;
>  	int c1, c2 = 0;
> +	struct bplus_header *anode_btree = container_first(&anode->btree, struct bplus_header, __hdr);
> +	struct bplus_header *ranode_btree = container_first(&ranode->btree, struct bplus_header, __hdr);
> +	struct bplus_header *fnode_btree = container_first(&fnode->btree, struct bplus_header, __hdr);
> +
> 
> So, if we use container_first() (or container_of_first(), you tell
> which name you prefer), we are asserting that that `__hdr` member
> is always the first member in `struct bplus_header`.

Yes, you are asserting it in the c code, but a global replace of
container_first() with container_of() isn't going to do anything if that
starts to happen.  And a driver/fs author doesn't care here which one
matters, they will just use the first one that compiles and runs
properly.

In other words, nothing is going to enforce this check making it
semi-useless over time.  Can't you put something in the .h file to
"ensure" that the field is first there?  Then a normal container_of()
can just be used like everyone is used to without having to worry about
anything over time.

thanks,

greg k-h
