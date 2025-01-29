Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9119F421
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jan 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137949; cv=none; b=sSorjpfly2YVJMjh3RSPjOtb6erwVGNm7/EuGdjgTbKFwHcPXUBtvSuTbpOS+ZaUC8mPhepj0SVejli359ezrILfOVfbwfspET6Hsa9rNpnzjuPQG4hqdANC6Dt4hPH6FUOsfYe5O3XMpZl2zbrCCl/ptRVJE8ghVgqZCFRsmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137949; c=relaxed/simple;
	bh=oF30+J3IqzruAOpxJYIi5djwvudQtHK2lwBVZ4vPqeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClxGwXjZF412fRX/r6h5cyCL/g47II8Ymd9uMP3l0vnyNrgL2GE1HXn7Xku9Fn2MhhUImyopmFbpFAW7ZhMeQzQoD6mXlzArYAabHijbCcM2XvyPC2fAL9Ta3/dhY+LzSsUHA82/sitkgdEiBJ2cyexhfsOBFsX6Y7Gq++W3WDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hstIpoSI; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hstIpoSI"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id d2zUtypbzXshwd34ttweQw; Wed, 29 Jan 2025 08:05:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id d34stWa2wNMSld34stnvsj; Wed, 29 Jan 2025 08:05:38 +0000
X-Authority-Analysis: v=2.4 cv=K9DpHDWI c=1 sm=1 tr=0 ts=6799e152
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=3GLQtCDrk5mhnYkuwPoHkA==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=n4Tv2M7neSFVITN6eSkA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dJNGaRuyb43KyPltLLyaM42uJkC8Bu7eSEAbbEuHpi8=; b=hstIpoSIJ1JEtZzYmgPkabvpfF
	vewCr2uyaWYPsQL1VMcI/JFT9EhN+mnyLm2Yav6CBKePf/0O5bZ1TgiJzurrvg6vKVXxvyYwuftt3
	Phs8FHj71S77gnoz4FE9O97GBFj9FrkC+QP31HKy0F1MVAokZJW98l2DcBpNFW0v6t5Nk5CeIq1v1
	1OXis5r+oh06nSgCmQpl6Ci4Qlw0a/QYSuvsDNp3J/UfgYEEIAu08TD41rwon3Nf8WPmvrX4dSeTj
	eyhtKibdTY4nS7gWunG4nO/1D5wSr10wMOekg2brDYcK2FtQcXcwWmZbTXtgPHssQoCEQL6dpziK1
	RvaQr58g==;
Received: from [45.124.203.141] (port=55427 helo=[192.168.0.153])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1td34q-0028o3-2J;
	Wed, 29 Jan 2025 02:05:37 -0600
Message-ID: <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
Date: Wed, 29 Jan 2025 18:35:18 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
To: Greg KH <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2025012955-hypnotic-patronize-8931@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.141
X-Source-L: No
X-Exim-ID: 1td34q-0028o3-2J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.153]) [45.124.203.141]:55427
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF7g3mD6Yducij8/cuLPdyXM64PEBD9IgWQkKqhc9KCdYooedcGvvsGuf1znABj6i2mTTgove9JPgVGrDUAU8o46ROUtaBfBzYaMD1WPBtzmFxHou2TX
 xWdy/z10UQ7Cd5S9Z3OskyTaUhkL+JVsgviuBera++3ONgKveKecDbbfaWop2aJDx6ZnGTkQwqz3p0xFiiQena2RhH+JcR7wXoyeMyXVvB+Nv+Nz7WUI+W8x



On 29/01/25 16:24, Greg KH wrote:
> On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
>> This is like container_of_const() but it contains an assert to
>> ensure that it's using the first member in the structure.
> 
> But why?  If you "know" it's the first member, just do a normal cast.
> If you don't, then you probably shouldn't be caring about this anyway,
> right?

This is more about the cases where the member _must_ be first in the
structure. See below for an example related to -Wflex-array-member-not-at-end

> 
>>
>> Co-developed-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>
>> I will be using this in my -Wflex-array-member-not-at-end patches. :)
> 
> Confused, I'd like to see some users first please.

When addressing the -Wflex-array-member-not-at-end warnings, the common
scenario is when we have to separate the flexible-array member from the
rest of the members in the flexible structure, as shown below [1]:

struct bplus_header
{
         struct_group_tagged(bplus_header_fixed, __hdr,
                 u8 flags;               /* bit 0 - high bit of first free entry offset
                                            bit 5 - we're pointed to by an fnode,
                                            the data btree or some ea or the
                                            main ea bootage pointer ea_secno
                                            bit 6 - suggest binary search (unused)
                                            bit 7 - 1 -> (internal) tree of anodes
                                            0 -> (leaf) list of extents */
                 u8 fill[3];
                 u8 n_free_nodes;        /* free nodes in following array */
                 u8 n_used_nodes;        /* used nodes in following array */
                 __le16 first_free;      /* offset from start of header to
                                            first free node in array */
         );
         union {
                 /* (internal) 2-word entries giving subtree pointers */
                 DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
                 /* (external) 3-word entries giving sector runs */
                 DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
         } u;
};

struct_group_tagged() creates a new type: `struct bplus_header_fixed`, we
then use the newly created type to change the type of the middle objects
causing the warnings, and with that the warnings are gone:

@@ -453,7 +455,7 @@ struct fnode
    __le16 flags;				/* bit 1 set -> ea_secno is an anode */
  					/* bit 8 set -> directory.  first & only extent
  					   points to dnode. */
-  struct bplus_header btree;		/* b+ tree, 8 extents or 12 subtrees */
+  struct bplus_header_fixed btree;	/* b+ tree, 8 extents or 12 subtrees */
    union {
      struct bplus_leaf_node external[8];
      struct bplus_internal_node internal[12];
@@ -495,7 +497,7 @@ struct anode
    __le32 self;				/* pointer to this anode */
    __le32 up;				/* parent anode or fnode */

-  struct bplus_header btree;		/* b+tree, 40 extents or 60 subtrees */
+  struct bplus_header_fixed btree;	/* b+tree, 40 extents or 60 subtrees */
    union {
      struct bplus_leaf_node external[40];
      struct bplus_internal_node internal[60];

However, this newly created type, or rather the member `__hdr` (also
created when calling struct_group_tagged()) _must_ always be the first
member in the flexible struct `struct bplus_header`.

Then we need to use container_first() to retrieve a pointer to the flexible
structure [2], via which we can access the flexible-array member when
necessary:

diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
index c14c9a035ee0c0..a366f6ac71e436 100644
--- a/fs/hpfs/anode.c
+++ b/fs/hpfs/anode.c
@@ -27,7 +27,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
  				a = le32_to_cpu(btree->u.internal[i].down);
  				brelse(bh);
  				if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
-				btree = &anode->btree;
+				btree = container_first(&anode->btree, struct bplus_header, __hdr);
  				goto go_down;
  			}
  		hpfs_error(s, "sector %08x not found in internal anode %08x", sec, a);
@@ -69,12 +69,16 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
  	int n;
  	unsigned fs;
  	int c1, c2 = 0;
+	struct bplus_header *anode_btree = container_first(&anode->btree, struct bplus_header, __hdr);
+	struct bplus_header *ranode_btree = container_first(&ranode->btree, struct bplus_header, __hdr);
+	struct bplus_header *fnode_btree = container_first(&fnode->btree, struct bplus_header, __hdr);
+

So, if we use container_first() (or container_of_first(), you tell
which name you prefer), we are asserting that that `__hdr` member
is always the first member in `struct bplus_header`.

I've explained all this at Plumbers last year. In any case, let
me know if you need more clarification. :)

Thanks!
--
Gustavo

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/diff/fs/hpfs/hpfs.h?h=testing/wfamnae-next20250124&id=f66219294267a2fba220f4f3118e11c5cda63d0b
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/diff/fs/hpfs/anode.c?h=testing/wfamnae-next20250124&id=f66219294267a2fba220f4f3118e11c5cda63d0b
