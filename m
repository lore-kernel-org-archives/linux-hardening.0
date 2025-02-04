Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78015689A;
	Tue,  4 Feb 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738640624; cv=none; b=r9MTPSlXUSLuk0GeISJdmwn1g/zxYCDeAj5trMAwSaEiDa7pe3S0sUzrnCDO/EmLBrIZncKf05gftuiNnU/lkYoDjkmfxueAyRpGszq9L4lb7EypBRv/ywTFyWZ+SLBpU1njamFfq0L+/DZhQOLRF3q+RODOcfzsGLG9Nm+G1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738640624; c=relaxed/simple;
	bh=g1a5XHjEnvGgZeINOx+dFk4oLItaQ7cT+dRbSxa897k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o9Mcjr9rOoKCKYc+a7XdIfxhwR0PQ5CH6k8zINOyLWcr/Z7JSMedlWzbdMOT4wNqGtRN1RV0udZ/+DykwedE/V5hUozVcg3+jYkaBlkh2FlJr4rEbJpA4Q6SCc2x4qn+BlPAFL+QyiVjjhv7AMqEvcu7V2HOfDfHsgbXwb/QtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjXW2jT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjXW2jT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F303DC4CEDF;
	Tue,  4 Feb 2025 03:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738640623;
	bh=g1a5XHjEnvGgZeINOx+dFk4oLItaQ7cT+dRbSxa897k=;
	h=Date:From:To:Cc:Subject:From;
	b=VjXW2jT73HfIKhRMQ3Ap5Q+0WCTB4//zehVzcCh3chPxwe6cyOho9jfNaMH2n4cRM
	 3QfE4y8uhE9H4vGadRk34FwejD8sV95ZMwh41lE3uCoVxCweqf0Ab5GvnwPe7ZdEF6
	 WU1w6R0mpu05TELnXsWEnF0PgYhTrv9gFZMRsTeOe3c+4i2Y9t9rJODt0P5XMfxvo6
	 d/ZMztvXDgyrWox3vQdrgmRxCjKIMHqOFHC96Rn2DMV1ssCQMg3ajTbLaXG4fN5ZmL
	 yIGwa/m5LnRv/caDBlR41YjCA/vOojyfQkn8iuZ99zQcPYL+yufqZukH4nyOqEeIMD
	 OeqQ1FRRgC21w==
Date: Tue, 4 Feb 2025 14:13:37 +1030
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] fs: hpfs: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6GM6WIg8f0Ql30E@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of other structs, we use the `struct_group_tagged()` helper
to create a new tagged `struct bplus_header_fixed`. This structure
groups together all the members of the flexible `struct bplus_header`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct bplus_header` to `struct bplus_header_fixed`.

We also want to ensure that when new members need to be added to the
flexible structure, they are always included within the newly created
tagged struct. For this, we use `static_assert()`. This ensures that the
memory layout for both the flexible structure and the new tagged struct
is the same after any changes.

This approach avoids having to implement `struct bplus_header_fixed`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

We also use `container_of()` whenever we need to retrieve a pointer to
the flexible structure, through which we can access the flexible-array
member, if necessary.

So, with these changes, fix 26 of the following warnings:
fs/hpfs/hpfs.h:456:23: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/hpfs/hpfs.h:498:23: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/hpfs/anode.c | 47 ++++++++++++++++++++++++++---------------------
 fs/hpfs/ea.c    |  2 +-
 fs/hpfs/file.c  |  4 +++-
 fs/hpfs/hpfs.h  | 30 +++++++++++++++++-------------
 fs/hpfs/map.c   | 11 +++++++----
 5 files changed, 54 insertions(+), 40 deletions(-)

diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
index c14c9a035ee0..c691e521a023 100644
--- a/fs/hpfs/anode.c
+++ b/fs/hpfs/anode.c
@@ -9,6 +9,10 @@
 
 #include "hpfs_fn.h"
 
+#define anode_btree	container_of(&anode->btree, struct bplus_header, __hdr)
+#define ranode_btree	container_of(&ranode->btree, struct bplus_header, __hdr)
+#define fnode_btree	container_of(&fnode->btree, struct bplus_header, __hdr)
+
 /* Find a sector in allocation tree */
 
 secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
@@ -27,7 +31,7 @@ secno hpfs_bplus_lookup(struct super_block *s, struct inode *inode,
 				a = le32_to_cpu(btree->u.internal[i].down);
 				brelse(bh);
 				if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
-				btree = &anode->btree;
+				btree = anode_btree;
 				goto go_down;
 			}
 		hpfs_error(s, "sector %08x not found in internal anode %08x", sec, a);
@@ -69,12 +73,13 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 	int n;
 	unsigned fs;
 	int c1, c2 = 0;
+
 	if (fnod) {
 		if (!(fnode = hpfs_map_fnode(s, node, &bh))) return -1;
-		btree = &fnode->btree;
+		btree = fnode_btree;
 	} else {
 		if (!(anode = hpfs_map_anode(s, node, &bh))) return -1;
-		btree = &anode->btree;
+		btree = anode_btree;
 	}
 	a = node;
 	go_down:
@@ -91,7 +96,7 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 		if (hpfs_sb(s)->sb_chk)
 			if (hpfs_stop_cycles(s, a, &c1, &c2, "hpfs_add_sector_to_btree #1")) return -1;
 		if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
-		btree = &anode->btree;
+		btree = anode_btree;
 		goto go_down;
 	}
 	if (n >= 0) {
@@ -151,7 +156,7 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 		}
 		brelse(bh);
 		bh = bh1;
-		btree = &anode->btree;
+		btree = anode_btree;
 	}
 	btree->n_free_nodes--; n = btree->n_used_nodes++;
 	le16_add_cpu(&btree->first_free, 12);
@@ -168,10 +173,10 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 			if (hpfs_stop_cycles(s, up, &c1, &c2, "hpfs_add_sector_to_btree #2")) return -1;
 		if (up != node || !fnod) {
 			if (!(anode = hpfs_map_anode(s, up, &bh))) return -1;
-			btree = &anode->btree;
+			btree = anode_btree;
 		} else {
 			if (!(fnode = hpfs_map_fnode(s, up, &bh))) return -1;
-			btree = &fnode->btree;
+			btree = fnode_btree;
 		}
 		if (btree->n_free_nodes) {
 			btree->n_free_nodes--; n = btree->n_used_nodes++;
@@ -206,8 +211,8 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 			anode->btree.n_used_nodes = 1;
 			anode->btree.n_free_nodes = 59;
 			anode->btree.first_free = cpu_to_le16(16);
-			anode->btree.u.internal[0].down = cpu_to_le32(a);
-			anode->btree.u.internal[0].file_secno = cpu_to_le32(-1);
+			anode_btree->u.internal[0].down = cpu_to_le32(a);
+			anode_btree->u.internal[0].file_secno = cpu_to_le32(-1);
 			mark_buffer_dirty(bh);
 			brelse(bh);
 			if ((anode = hpfs_map_anode(s, a, &bh))) {
@@ -229,20 +234,20 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 			brelse(bh2);
 			return -1;
 		}
-		btree = &anode->btree;
+		btree = anode_btree;
 	} else {
 		if (!(fnode = hpfs_map_fnode(s, node, &bh))) {
 			brelse(bh2);
 			return -1;
 		}
-		btree = &fnode->btree;
+		btree = fnode_btree;
 	}
 	ranode->up = cpu_to_le32(node);
 	memcpy(&ranode->btree, btree, le16_to_cpu(btree->first_free));
 	if (fnod)
 		ranode->btree.flags |= BP_fnode_parent;
-	ranode->btree.n_free_nodes = (bp_internal(&ranode->btree) ? 60 : 40) - ranode->btree.n_used_nodes;
-	if (bp_internal(&ranode->btree)) for (n = 0; n < ranode->btree.n_used_nodes; n++) {
+	ranode_btree->n_free_nodes = (bp_internal(ranode_btree) ? 60 : 40) - ranode_btree->n_used_nodes;
+	if (bp_internal(ranode_btree)) for (n = 0; n < ranode_btree->n_used_nodes; n++) {
 		struct anode *unode;
 		if ((unode = hpfs_map_anode(s, le32_to_cpu(ranode->u.internal[n].down), &bh1))) {
 			unode->up = cpu_to_le32(ra);
@@ -291,7 +296,7 @@ void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
 			if (hpfs_stop_cycles(s, ano, &d1, &d2, "hpfs_remove_btree #1"))
 				return;
 		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
-		btree1 = &anode->btree;
+		btree1 = anode_btree;
 		level++;
 		pos = 0;
 	}
@@ -307,7 +312,7 @@ void hpfs_remove_btree(struct super_block *s, struct bplus_header *btree)
 	ano = le32_to_cpu(anode->up);
 	if (--level) {
 		if (!(anode = hpfs_map_anode(s, ano, &bh))) return;
-		btree1 = &anode->btree;
+		btree1 = anode_btree;
 	} else btree1 = btree;
 	for (i = 0; i < btree1->n_used_nodes; i++) {
 		if (le32_to_cpu(btree1->u.internal[i].down) == oano) {
@@ -332,7 +337,7 @@ static secno anode_lookup(struct super_block *s, anode_secno a, unsigned sec)
 	struct anode *anode;
 	struct buffer_head *bh;
 	if (!(anode = hpfs_map_anode(s, a, &bh))) return -1;
-	return hpfs_bplus_lookup(s, NULL, &anode->btree, sec, bh);
+	return hpfs_bplus_lookup(s, NULL, anode_btree, sec, bh);
 }
 
 int hpfs_ea_read(struct super_block *s, secno a, int ano, unsigned pos,
@@ -388,7 +393,7 @@ void hpfs_ea_remove(struct super_block *s, secno a, int ano, unsigned len)
 	struct buffer_head *bh;
 	if (ano) {
 		if (!(anode = hpfs_map_anode(s, a, &bh))) return;
-		hpfs_remove_btree(s, &anode->btree);
+		hpfs_remove_btree(s, anode_btree);
 		brelse(bh);
 		hpfs_free_sectors(s, a, 1);
 	} else hpfs_free_sectors(s, a, (len + 511) >> 9);
@@ -407,10 +412,10 @@ void hpfs_truncate_btree(struct super_block *s, secno f, int fno, unsigned secs)
 	int c1, c2 = 0;
 	if (fno) {
 		if (!(fnode = hpfs_map_fnode(s, f, &bh))) return;
-		btree = &fnode->btree;
+		btree = fnode_btree;
 	} else {
 		if (!(anode = hpfs_map_anode(s, f, &bh))) return;
-		btree = &anode->btree;
+		btree = anode_btree;
 	}
 	if (!secs) {
 		hpfs_remove_btree(s, btree);
@@ -448,7 +453,7 @@ void hpfs_truncate_btree(struct super_block *s, secno f, int fno, unsigned secs)
 			if (hpfs_stop_cycles(s, node, &c1, &c2, "hpfs_truncate_btree"))
 				return;
 		if (!(anode = hpfs_map_anode(s, node, &bh))) return;
-		btree = &anode->btree;
+		btree = anode_btree;
 	}	
 	nodes = btree->n_used_nodes + btree->n_free_nodes;
 	for (i = 0; i < btree->n_used_nodes; i++)
@@ -485,7 +490,7 @@ void hpfs_remove_fnode(struct super_block *s, fnode_secno fno)
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end;
 	if (!(fnode = hpfs_map_fnode(s, fno, &bh))) return;
-	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, &fnode->btree);
+	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, fnode_btree);
 	else hpfs_remove_dtree(s, le32_to_cpu(fnode->u.external[0].disk_secno));
 	ea_end = fnode_end_ea(fnode);
 	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 102ba18e561f..206e069053fb 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -41,7 +41,7 @@ void hpfs_ea_ext_remove(struct super_block *s, secno a, int ano, unsigned len)
 		struct buffer_head *bh;
 		struct anode *anode;
 		if ((anode = hpfs_map_anode(s, a, &bh))) {
-			hpfs_remove_btree(s, &anode->btree);
+			hpfs_remove_btree(s, container_of(&anode->btree, struct bplus_header, __hdr));
 			brelse(bh);
 			hpfs_free_sectors(s, a, 1);
 		}
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 449a3fc1b8d9..0f15ad7cbf6e 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -51,7 +51,9 @@ static secno hpfs_bmap(struct inode *inode, unsigned file_secno, unsigned *n_sec
 		return hpfs_inode->i_disk_sec + n;
 	}
 	if (!(fnode = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) return 0;
-	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode, &fnode->btree, file_secno, bh);
+	disk_secno = hpfs_bplus_lookup(inode->i_sb, inode,
+				       container_of(&fnode->btree, struct bplus_header, __hdr),
+				       file_secno, bh);
 	if (disk_secno == -1) return 0;
 	if (hpfs_chk_sectors(inode->i_sb, disk_secno, 1, "bmap")) return 0;
 	n = file_secno - hpfs_inode->i_file_sec;
diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
index 281dec8f636b..430b960dcf12 100644
--- a/fs/hpfs/hpfs.h
+++ b/fs/hpfs/hpfs.h
@@ -396,25 +396,29 @@ enum {
 };
 struct bplus_header
 {
-  u8 flags;				/* bit 0 - high bit of first free entry offset
+	struct_group_tagged(bplus_header_fixed, __hdr,
+		u8 flags;		/* bit 0 - high bit of first free entry offset
 					   bit 5 - we're pointed to by an fnode,
 					   the data btree or some ea or the
 					   main ea bootage pointer ea_secno
 					   bit 6 - suggest binary search (unused)
 					   bit 7 - 1 -> (internal) tree of anodes
 						   0 -> (leaf) list of extents */
-  u8 fill[3];
-  u8 n_free_nodes;			/* free nodes in following array */
-  u8 n_used_nodes;			/* used nodes in following array */
-  __le16 first_free;			/* offset from start of header to
+		u8 fill[3];
+		u8 n_free_nodes;	/* free nodes in following array */
+		u8 n_used_nodes;	/* used nodes in following array */
+		__le16 first_free;	/* offset from start of header to
 					   first free node in array */
-  union {
-	/* (internal) 2-word entries giving subtree pointers */
-	DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
-	/* (external) 3-word entries giving sector runs */
-	DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
-  } u;
+	);
+	union {
+		/* (internal) 2-word entries giving subtree pointers */
+		DECLARE_FLEX_ARRAY(struct bplus_internal_node, internal);
+		/* (external) 3-word entries giving sector runs */
+		DECLARE_FLEX_ARRAY(struct bplus_leaf_node, external);
+	} u;
 };
+static_assert(offsetof(struct bplus_header, u.internal) == sizeof(struct bplus_header_fixed),
+	      "struct member likely outside of __struct_group()");
 
 static inline bool bp_internal(struct bplus_header *bp)
 {
@@ -453,7 +457,7 @@ struct fnode
   __le16 flags;				/* bit 1 set -> ea_secno is an anode */
 					/* bit 8 set -> directory.  first & only extent
 					   points to dnode. */
-  struct bplus_header btree;		/* b+ tree, 8 extents or 12 subtrees */
+  struct bplus_header_fixed btree;	/* b+ tree, 8 extents or 12 subtrees */
   union {
     struct bplus_leaf_node external[8];
     struct bplus_internal_node internal[12];
@@ -495,7 +499,7 @@ struct anode
   __le32 self;				/* pointer to this anode */
   __le32 up;				/* parent anode or fnode */
 
-  struct bplus_header btree;		/* b+tree, 40 extents or 60 subtrees */
+  struct bplus_header_fixed btree;	/* b+tree, 40 extents or 60 subtrees */
   union {
     struct bplus_leaf_node external[40];
     struct bplus_internal_node internal[60];
diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index ecd9fccd1663..4171c08693a6 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -9,6 +9,9 @@
 
 #include "hpfs_fn.h"
 
+#define anode_btree	container_of(&anode->btree, struct bplus_header, __hdr)
+#define fnode_btree	container_of(&fnode->btree, struct bplus_header, __hdr)
+
 __le32 *hpfs_map_dnode_bitmap(struct super_block *s, struct quad_buffer_head *qbh)
 {
 	return hpfs_map_4sectors(s, hpfs_sb(s)->sb_dmap, qbh, 0);
@@ -178,14 +181,14 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 			}
 			if (!fnode_is_dir(fnode)) {
 				if ((unsigned)fnode->btree.n_used_nodes + (unsigned)fnode->btree.n_free_nodes !=
-				    (bp_internal(&fnode->btree) ? 12 : 8)) {
+				    (bp_internal(fnode_btree) ? 12 : 8)) {
 					hpfs_error(s,
 					   "bad number of nodes in fnode %08lx",
 					    (unsigned long)ino);
 					goto bail;
 				}
 				if (le16_to_cpu(fnode->btree.first_free) !=
-				    8 + fnode->btree.n_used_nodes * (bp_internal(&fnode->btree) ? 8 : 12)) {
+				    8 + fnode->btree.n_used_nodes * (bp_internal(fnode_btree) ? 8 : 12)) {
 					hpfs_error(s,
 					    "bad first_free pointer in fnode %08lx",
 					    (unsigned long)ino);
@@ -233,12 +236,12 @@ struct anode *hpfs_map_anode(struct super_block *s, anode_secno ano, struct buff
 				goto bail;
 			}
 			if ((unsigned)anode->btree.n_used_nodes + (unsigned)anode->btree.n_free_nodes !=
-			    (bp_internal(&anode->btree) ? 60 : 40)) {
+			    (bp_internal(anode_btree) ? 60 : 40)) {
 				hpfs_error(s, "bad number of nodes in anode %08x", ano);
 				goto bail;
 			}
 			if (le16_to_cpu(anode->btree.first_free) !=
-			    8 + anode->btree.n_used_nodes * (bp_internal(&anode->btree) ? 8 : 12)) {
+			    8 + anode->btree.n_used_nodes * (bp_internal(anode_btree) ? 8 : 12)) {
 				hpfs_error(s, "bad first_free pointer in anode %08x", ano);
 				goto bail;
 			}
-- 
2.43.0

