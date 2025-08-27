Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CCA343D6C
	for <linux-hardening@vger.kernel.org>; Wed, 27 Aug 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286339; cv=none; b=mBgvvWGRLjHzMTWhj4S4GWxirkitj3L454VGzJ/iizWShmR295T4/kn4z+xbQEaq4hGPgkFq1rLJtWY4PgEXdKpskmyJZlkHoV2tPvx39BhzOfAXRv7lB108aZGz0xm6bI6OKBdQx7Cl3mY5SpUpz7iTt09seOmv/eKaLNwy8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286339; c=relaxed/simple;
	bh=OG4WiHcxZg066v5WoBT20PGlcOVMX2ACBVjx6/f8+3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObOzPoFk1rp7r8k9DOyCvlxLxG1RoLWZ4AQjmuzL74PoftaLEdvlqmD/cJ9ARK4cieXtXitTY8XmLOJPAyvpOP8MhSiyhWF75tjobGYk9EYQ5C3UVdmdtgO09zkxnCo3yTdc0h1GaybjOVtgUHbi6eyBuy/BC/3ERCExoHLq6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=A+s+we6F; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="A+s+we6F"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id rAMHukZZPA2i6rCIxuWYBP; Wed, 27 Aug 2025 09:18:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id rCIwuJW1drnsYrCIxuCQuk; Wed, 27 Aug 2025 09:18:55 +0000
X-Authority-Analysis: v=2.4 cv=OLkn3TaB c=1 sm=1 tr=0 ts=68aecd7f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=DR2cKC/DEnBA9KqqjaPhpA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=bElFif_sz3IZGlVFoh0A:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eP4vZfmrGGYR5txqDWlDSGKo8QxzOxy5urI0CNxLkAU=; b=A+s+we6FOi1JLxb6S0WmQYdbAO
	CWMkbri7El1IJZ2Bo8s9kSfrhXAqTFTU+il9797xVfHWm3isom/yf1eT8iMu4ieQvhqiGNNR0sVMd
	5lSc61piUY5/PC+/F3kHhyDYQ8xxS3091rQ/ac29TX/UIyt7+30fUD3yLwVkM7fMH2r/zrf0IrEi+
	2wD8TqkjBiSsqYqE4i6GPzJuB53NbUryZ5n7XFY3uCLBme/m8OiT35O2CLHrNePt80M09z6B1PS+P
	5bV3K9NP/4BcPlEBRLICsMqilKCvKUCGaSOsbP2MpYkbFfsRtA+0IXIEVQLu2kcyOagDrjEEs3H/k
	wTHEY5MQ==;
Received: from static-243-216-117-93.thenetworkfactory.nl ([93.117.216.243]:33864 helo=[10.94.27.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1urCIw-00000002a63-09fG;
	Wed, 27 Aug 2025 04:18:54 -0500
Message-ID: <8007649f-324a-4dfb-ae33-9bed8c8d6eec@embeddedor.com>
Date: Wed, 27 Aug 2025 11:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: hpfs: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aJnpXOndcEAF6_NW@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <aJnpXOndcEAF6_NW@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 93.117.216.243
X-Source-L: No
X-Exim-ID: 1urCIw-00000002a63-09fG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: static-243-216-117-93.thenetworkfactory.nl ([10.94.27.44]) [93.117.216.243]:33864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDR8LiJ4LhcxkEKp2dHEElKIJFAWvzMZhBCPPFSMai5hkgmZ5334zJIazF3yMPdHiSC9kgYdNaHntB+nxOH7Jq9YjEue5rzMaHHKRGLZRkTsCAyQPheI
 WM77S1C5G3uXTnR70BYGPvejGmQS9hOFTO7O0X6x4HfQvqaXO/tkKo4HXs++/7Pz8BjoLSE1Z7UVja8DYr2RQNSDjmLgaTkCrRV/MatmNTpTDPeEW28FkVwo

Hi all,

Friendly ping: who can take/review this, please?

Any comments or feedback is greatly appreciated. :)

Thanks!
-Gustavo

On 11/08/25 15:00, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct bplus_header_fixed`. This structure
> groups together all the members of the flexible `struct bplus_header`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct bplus_header` to `struct bplus_header_fixed`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct bplus_header_fixed`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> We also use `container_of()` (via a wrapper) whenever we need to retrieve
> a pointer to the flexible structure, through which we can access the
> flexible-array member, if necessary.
> 
> So, with these changes, fix 26 of the following type of warnings:
> fs/hpfs/hpfs.h:456:23: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/hpfs/hpfs.h:498:23: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   - Add GET_BTREE_PTR() wrapper for container_of().
> 
>   fs/hpfs/anode.c | 43 ++++++++++++++++++++++---------------------
>   fs/hpfs/ea.c    |  2 +-
>   fs/hpfs/file.c  |  4 +++-
>   fs/hpfs/hpfs.h  | 44 +++++++++++++++++++++++++++++++-------------
>   fs/hpfs/map.c   |  8 ++++----
>   5 files changed, 61 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
> index c14c9a035ee0..a4f5321eafae 100644
> --- a/fs/hpfs/anode.c
> +++ b/fs/hpfs/anode.c
> @@ -27,7 +27,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
>   				a = le32_to_cpu(btree->u.internal[i].down);
>   				brelse(bh);
>   				if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> -				btree = &anode->btree;
> +				btree = GET_BTREE_PTR(&anode->btree);
>   				goto go_down;
>   			}
>   		hpfs_error(s, "sector %08x not found in internal anode %08x", sec, a);
> @@ -69,12 +69,13 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>   	int n;
>   	unsigned fs;
>   	int c1, c2 = 0;
> +
>   	if (fnod) {
>   		if (!(fnode = hpfs_map_fnode(s, node, &bh))) return -1;
> -		btree = &fnode->btree;
> +		btree = GET_BTREE_PTR(&fnode->btree);
>   	} else {
>   		if (!(anode = hpfs_map_anode(s, node, &bh))) return -1;
> -		btree = &anode->btree;
> +		btree = GET_BTREE_PTR(&anode->btree);
>   	}
>   	a = node;
>   	go_down:
> @@ -91,7 +92,7 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>   		if (hpfs_sb(s)->sb_chk)
>   			if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_add_sector_to_btree #1")) return -1;
>   		if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> -		btree = &anode->btree;
> +		btree = GET_BTREE_PTR(&anode->btree);
>   		goto go_down;
>   	}
>   	if (n >= 0) {
> @@ -151,7 +152,7 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>   		}
>   		brelse(bh);
>   		bh = bh1;
> -		btree = &anode->btree;
> +		btree = GET_BTREE_PTR(&anode->btree);
>   	}
>   	btree->n_free_nodes--; n = btree->n_used_nodes++;
>   	le16_add_cpu(&btree->first_free, 12);
> @@ -168,10 +169,10 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>   			if (hpfs_stop_cycles(s, up, &c1, &c2, "hpfs_add_sector_to_btree #2")) return -1;
>   		if (up != node || !fnod) {
>   			if (!(anode = hpfs_map_anode(s, up, &bh))) return -1;
> -			btree = &anode->btree;
> +			btree = GET_BTREE_PTR(&anode->btree);
>   		} else {
>   			if (!(fnode = hpfs_map_fnode(s, up, &bh))) return -1;
> -			btree = &fnode->btree;
> +			btree = GET_BTREE_PTR(&fnode->btree);
>   		}
>   		if (btree->n_free_nodes) {
>   			btree->n_free_nodes--; n = btree->n_used_nodes++;
> @@ -206,8 +207,8 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>   			anode->btree.n_used_nodes = 1;
>   			anode->btree.n_free_nodes = 59;
>   			anode->btree.first_free = cpu_to_le16(16);
> -			anode->btree.u.internal[0].down = cpu_to_le32(a);
> -			anode->btree.u.internal[0].file_secno = cpu_to_le32(-1);
> +			GET_BTREE_PTR(&anode->btree)->u.internal[0].down = cpu_to_le32(a);
> +			GET_BTREE_PTR(&anode->btree)->u.internal[0].file_secno = cpu_to_le32(-1);
>   			mark_buffer_dirty(bh);
>   			brelse(bh);
>   			if ((anode = hpfs_map_anode(s, a, &bh))) {
> @@ -229,20 +230,20 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
>   			brelse(bh2);
>   			return -1;
>   		}
> -		btree = &anode->btree;
> +		btree = GET_BTREE_PTR(&anode->btree);
>   	} else {
>   		if (!(fnode = hpfs_map_fnode(s, node, &bh))) {
>   			brelse(bh2);
>   			return -1;
>   		}
> -		btree = &fnode->btree;
> +		btree = GET_BTREE_PTR(&fnode->btree);
>   	}
>   	ranode->up = cpu_to_le32(node);
>   	memcpy(&ranode->btree, btree, le16_to_cpu(btree->first_free));
>   	if (fnod)
>   		ranode->btree.flags |= BP_fnode_parent;
> -	ranode->btree.n_free_nodes = (bp_internal(&ranode->btree) ? 60 : 40) - ranode->btree.n_used_nodes;
> -	if (bp_internal(&ranode->btree)) for (n = 0; n < ranode->btree.n_used_nodes; n++) {
> +	GET_BTREE_PTR(&ranode->btree)->n_free_nodes = (bp_internal(GET_BTREE_PTR(&ranode->btree)) ? 60 : 40) - GET_BTREE_PTR(&ranode->btree)->n_used_nodes;
> +	if (bp_internal(GET_BTREE_PTR(&ranode->btree))) for (n = 0; n < GET_BTREE_PTR(&ranode->btree)->n_used_nodes; n++) {
>   		struct anode *unode;
>   		if ((unode = hpfs_map_anode(s, le32_to_cpu(ranode->u.internal[n].down), &bh1))) {
>   			unode->up = cpu_to_le32(ra);
> @@ -291,7 +292,7 @@ void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
>   			if (hpfs_stop_cycles(s, ano, &d1, &d2, "hpfs_remove_btree #1"))
>   				return;
>   		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
> -		btree1 = &anode->btree;
> +		btree1 = GET_BTREE_PTR(&anode->btree);
>   		level++;
>   		pos = 0;
>   	}
> @@ -307,7 +308,7 @@ void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
>   	ano = le32_to_cpu(anode->up);
>   	if (--level) {
>   		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
> -		btree1 = &anode->btree;
> +		btree1 = GET_BTREE_PTR(&anode->btree);
>   	} else btree1 = btree;
>   	for (i = 0; i < btree1->n_used_nodes; i++) {
>   		if (le32_to_cpu(btree1->u.internal[i].down) == oano) {
> @@ -332,7 +333,7 @@ static secno anode_lookup(struct super_block *s, anode_secno a, unsigned sec)
>   	struct anode *anode;
>   	struct buffer_head *bh;
>   	if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
> -	return hpfs_bplus_lookup(s, NULL, &anode->btree, sec, bh);
> +	return hpfs_bplus_lookup(s, NULL, GET_BTREE_PTR(&anode->btree), sec, bh);
>   }
>   
>   int hpfs_ea_read(struct super_block *s, secno a, int ano, unsigned pos,
> @@ -388,7 +389,7 @@ void hpfs_ea_remove(struct super_block *s, secno a, int ano, unsigned len)
>   	struct buffer_head *bh;
>   	if (ano) {
>   		if (!(anode = hpfs_map_anode(s, a, &bh))) return;
> -		hpfs_remove_btree(s, &anode->btree);
> +		hpfs_remove_btree(s, GET_BTREE_PTR(&anode->btree));
>   		brelse(bh);
>   		hpfs_free_sectors(s, a, 1);
>   	} else hpfs_free_sectors(s, a, (len + 511) >> 9);
> @@ -407,10 +408,10 @@ void hpfs_truncate_btree(struct super_block *s, secno f, int fno, unsigned secs)
>   	int c1, c2 = 0;
>   	if (fno) {
>   		if (!(fnode = hpfs_map_fnode(s, f, &bh))) return;
> -		btree = &fnode->btree;
> +		btree = GET_BTREE_PTR(&fnode->btree);
>   	} else {
>   		if (!(anode = hpfs_map_anode(s, f, &bh))) return;
> -		btree = &anode->btree;
> +		btree = GET_BTREE_PTR(&anode->btree);
>   	}
>   	if (!secs) {
>   		hpfs_remove_btree(s, btree);
> @@ -448,7 +449,7 @@ void hpfs_truncate_btree(struct super_block *s, secno f, int fno, unsigned secs)
>   			if (hpfs_stop_cycles(s, node, &c1, &c2, "hpfs_truncate_btree"))
>   				return;
>   		if (!(anode = hpfs_map_anode(s, node, &bh))) return;
> -		btree = &anode->btree;
> +		btree = GET_BTREE_PTR(&anode->btree);
>   	}	
>   	nodes = btree->n_used_nodes + btree->n_free_nodes;
>   	for (i = 0; i < btree->n_used_nodes; i++)
> @@ -485,7 +486,7 @@ void hpfs_remove_fnode(struct super_block *s, fnode_secno fno)
>   	struct extended_attribute *ea;
>   	struct extended_attribute *ea_end;
>   	if (!(fnode = hpfs_map_fnode(s, fno, &bh))) return;
> -	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, &fnode->btree);
> +	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, GET_BTREE_PTR(&fnode->btree));
>   	else hpfs_remove_dtree(s, le32_to_cpu(fnode->u.external[0].disk_secno));
>   	ea_end = fnode_end_ea(fnode);
>   	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
> index 102ba18e561f..2149d3ca530b 100644
> --- a/fs/hpfs/ea.c
> +++ b/fs/hpfs/ea.c
> @@ -41,7 +41,7 @@ void hpfs_ea_ext_remove(struct super_block *s, secno a, int ano, unsigned len)
>   		struct buffer_head *bh;
>   		struct anode *anode;
>   		if ((anode = hpfs_map_anode(s, a, &bh))) {
> -			hpfs_remove_btree(s, &anode->btree);
> +			hpfs_remove_btree(s, GET_BTREE_PTR(&anode->btree));
>   			brelse(bh);
>   			hpfs_free_sectors(s, a, 1);
>   		}
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index 263b5bbe1849..29e876705369 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -51,7 +51,9 @@ static secno hpfs_bmap(struct inode *inode, unsigned file_secno, unsigned *n_sec
>   		return hpfs_inode->i_disk_sec + n;
>   	}
>   	if (!(fnode = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) return 0;
> -	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode, &fnode->btree, file_secno, bh);
> +	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode,
> +				       GET_BTREE_PTR(&fnode->btree),
> +				       file_secno, bh);
>   	if (disk_secno == -1) return 0;
>   	if (hpfs_chk_sectors(inode->i_sb, disk_secno, 1, "bmap")) return 0;
>   	n = file_secno - hpfs_inode->i_file_sec;
> diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
> index 281dec8f636b..353f73c914d9 100644
> --- a/fs/hpfs/hpfs.h
> +++ b/fs/hpfs/hpfs.h
> @@ -394,27 +394,45 @@ enum {
>   	BP_binary_search = 0x40,
>   	BP_internal = 0x80
>   };
> +
> +/**
> + * GET_BTREE_PTR() - Get a pointer to struct bplus_header
> + *
> + * Wrapper around container_of() to retrieve a pointer to struct
> + * bplus_header from a pointer to struct bplus_header_fixed.
> + *
> + * @ptr: Pointer to struct bplus_header_fixed.
> + *
> + */
> +#define GET_BTREE_PTR(ptr) \
> +	container_of(ptr, struct bplus_header, __hdr)
> +
>   struct bplus_header
>   {
> -  u8 flags;				/* bit 0 - high bit of first free entry offset
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(bplus_header_fixed, __hdr,
> +		u8 flags;		/* bit 0 - high bit of first free entry offset
>   					   bit 5 - we're pointed to by an fnode,
>   					   the data btree or some ea or the
>   					   main ea bootage pointer ea_secno
>   					   bit 6 - suggest binary search (unused)
>   					   bit 7 - 1 -> (internal) tree of anodes
>   						   0 -> (leaf) list of extents */
> -  u8 fill[3];
> -  u8 n_free_nodes;			/* free nodes in following array */
> -  u8 n_used_nodes;			/* used nodes in following array */
> -  __le16 first_free;			/* offset from start of header to
> +		u8 fill[3];
> +		u8 n_free_nodes;	/* free nodes in following array */
> +		u8 n_used_nodes;	/* used nodes in following array */
> +		__le16 first_free;	/* offset from start of header to
>   					   first free node in array */
> -  union {
> -	/* (internal) 2-word entries giving subtree pointers */
> -	DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
> -	/* (external) 3-word entries giving sector runs */
> -	DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
> -  } u;
> +	);
> +	union {
> +		/* (internal) 2-word entries giving subtree pointers */
> +		DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
> +		/* (external) 3-word entries giving sector runs */
> +		DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
> +	} u;
>   };
> +static_assert(offsetof(struct bplus_header, u.internal) == sizeof(struct bplus_header_fixed),
> +	      "struct member likely outside of struct_group_tagged()");
>   
>   static inline bool bp_internal(struct bplus_header *bp)
>   {
> @@ -453,7 +471,7 @@ struct fnode
>     __le16 flags;				/* bit 1 set -> ea_secno is an anode */
>   					/* bit 8 set -> directory.  first & only extent
>   					   points to dnode. */
> -  struct bplus_header btree;		/* b+ tree, 8 extents or 12 subtrees */
> +  struct bplus_header_fixed btree;	/* b+ tree, 8 extents or 12 subtrees */
>     union {
>       struct bplus_leaf_node external[8];
>       struct bplus_internal_node internal[12];
> @@ -495,7 +513,7 @@ struct anode
>     __le32 self;				/* pointer to this anode */
>     __le32 up;				/* parent anode or fnode */
>   
> -  struct bplus_header btree;		/* b+tree, 40 extents or 60 subtrees */
> +  struct bplus_header_fixed btree;	/* b+tree, 40 extents or 60 subtrees */
>     union {
>       struct bplus_leaf_node external[40];
>       struct bplus_internal_node internal[60];
> diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
> index ecd9fccd1663..be73233502f8 100644
> --- a/fs/hpfs/map.c
> +++ b/fs/hpfs/map.c
> @@ -178,14 +178,14 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
>   			}
>   			if (!fnode_is_dir(fnode)) {
>   				if ((unsigned)fnode->btree.n_used_nodes + (unsigned)fnode->btree.n_free_nodes !=
> -				    (bp_internal(&fnode->btree) ? 12 : 8)) {
> +				    (bp_internal(GET_BTREE_PTR(&fnode->btree)) ? 12 : 8)) {
>   					hpfs_error(s,
>   					   "bad number of nodes in fnode %08lx",
>   					    (unsigned long)ino);
>   					goto bail;
>   				}
>   				if (le16_to_cpu(fnode->btree.first_free) !=
> -				    8 + fnode->btree.n_used_nodes * (bp_internal(&fnode->btree) ? 8 : 12)) {
> +				    8 + fnode->btree.n_used_nodes * (bp_internal(GET_BTREE_PTR(&fnode->btree)) ? 8 : 12)) {
>   					hpfs_error(s,
>   					    "bad first_free pointer in fnode %08lx",
>   					    (unsigned long)ino);
> @@ -233,12 +233,12 @@ struct anode *hpfs_map_anode(struct super_block *s, anode_secno ano, struct buff
>   				goto bail;
>   			}
>   			if ((unsigned)anode->btree.n_used_nodes + (unsigned)anode->btree.n_free_nodes !=
> -			    (bp_internal(&anode->btree) ? 60 : 40)) {
> +			    (bp_internal(GET_BTREE_PTR(&anode->btree)) ? 60 : 40)) {
>   				hpfs_error(s, "bad number of nodes in anode %08x", ano);
>   				goto bail;
>   			}
>   			if (le16_to_cpu(anode->btree.first_free) !=
> -			    8 + anode->btree.n_used_nodes * (bp_internal(&anode->btree) ? 8 : 12)) {
> +			    8 + anode->btree.n_used_nodes * (bp_internal(GET_BTREE_PTR(&anode->btree)) ? 8 : 12)) {
>   				hpfs_error(s, "bad first_free pointer in anode %08x", ano);
>   				goto bail;
>   			}

