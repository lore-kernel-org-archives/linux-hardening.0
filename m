Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC334B662
	for <linux-hardening@vger.kernel.org>; Wed, 17 Dec 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988890; cv=none; b=Qb0SEFc8rmTK6bqGi2h0zp/n9UMvPbw1cckEcaaxr8dfd8ZjELPfPYF1c6/4R+DFgh9nLhu1iXbAm97cCVK+0APzgktbK4MNbByXLgnrXGp2U7rG3mKG0RkZkNP6uL8fcV7s9Ss8D6eBLwtHJvGC2loEU6zKt78Zh6CkEesfvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988890; c=relaxed/simple;
	bh=EiPp5UR3odiaNu3fVGfrz6bU9tX+nxjcHoSZdd3tcLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9BEZqrLCmCTkORtd7B9E/TKvGMcRMAyffnhOMQo/eA9aTdrSq6k3YoZNpS/QeoHqGn10bFMR5HEPaTgfuA/g6N91ACw10kzib3hRL91yMAsK4sApWN4J+om8jeJFir+8QT5aT3197C3x4crxLp8xZluYsNhHfQud8d0CoUTMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JGnvzqj6; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JGnvzqj6"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso2351258f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 Dec 2025 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988886; x=1766593686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfQau0odZ8gUGBEhG5i1wvM039LCZUqSFw7CAdbRE6k=;
        b=JGnvzqj6iCYWKkJNPpK3HGmQrS0fjcwiSI+Vv6QjbjtyBBGiRrOvk0xJq4582XMBFp
         AF5XBJWEyPdY/TFBRUEUnpaZgs4gMigLgvwVUe8KFtMLBG1O8hec9w66FO0VNp4zOc9e
         PHSPcqfBlVF45d33W4IXj8acFy2ZCWV9qdsVS3d/r28BBYZDw6swgAxf9ymC+sN2QDJR
         umKtcGRKZpfUANCVuPyWm9wNAGgYLEvQGoQ/KFkDMpxHRQYasE0P1LC1cKJDdtRek46r
         NVl0k9Ut9nq7MkEhg77shQv5zm3mcEAbUo1yBdqQCmOLJhESqlk4U8iRZuhVQCj79+LQ
         MmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988886; x=1766593686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfQau0odZ8gUGBEhG5i1wvM039LCZUqSFw7CAdbRE6k=;
        b=tScRq2h92Cj6qq9zCs8OALA2HuMimlT8Dv/Xzp8nKtVpkn86d2rvbBs2As99vB8/Gk
         UcxWaSyYFj1vZHJ4caF55N5xRWgAEiSo+IImslHq4P6ivnjYPNYmA8/42GuPdxnrCuKo
         2zL5tlxbuEmZPdzMi+fw60jRbcUBQp7W2yY68HpgZu7c1at7X55jhwt7Lj2pDbXX8WzB
         fQlB9xfFmzw1d/WmHu7/EjvWvIMbGPVtbPyMeRE9rizRfLhboXv1GzNLoW3tgLQhJh8q
         o4a4z+GX6fAYFClAWZ7G9dm+lONP/2iVa37JX9k1hdo3Fil/0ia+eqxUvgl9oK53AVAx
         CNbg==
X-Forwarded-Encrypted: i=1; AJvYcCXOFlA/SsfEH5yzMv3I3Cp5MauEGgUNE3eqY6MrAvrVfdqQqmNroHLDo7LwWP0cTEMcHqavvRfk+AR2OLJk6RU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+B6ToGpVR/xZErANDCe4va0RhUHyLsoste45VlgEOQG6X1QES
	qUmiU5CzgMcYqKxUGbHOgpgonjs0xnK/fTGGlorXfQNcOSc1/t/gtOxS4C2vE99lntY=
X-Gm-Gg: AY/fxX5WJUQTBFgme+POVKAniUevDADA9YDX4cZEkAEHigblo5IBnVCy9owePllUYUI
	oY4i1np0L5Fx7gHgneUyybp2CRt3HSZEzQhCddOA8ZDyW2WgaZOlAiGdn5kqJGcP5K8Sz3tTdFh
	20mxezw9iRN0ILmXxg079hKf2OJtJgDdBeivmnMsVUNdTg8eO1CXsGqJrMVbtm3nf8ek6dHoZ23
	I3vgIOp74SMdqIKHWMOMfGthPnf8hDXcDcgwylSWbAFQv6rqOnYSUVCW981vApfH/vQH/9rD+lC
	rZwzXY+scl/K3H9DI1f13g3uInz9x8JfusUvK16l77yT+lAErVCdr4yoWh7Indjupxg6IndIBRw
	NeVFoNDf6XbEfbpkxdA/KvdP1o2waBigRqUrqGBXLInvunSdzQsyrnG9TiJKf2CCqz+Ccud5k0C
	sbyOJV4zvAYAhhJz5aYskxwWKYdvKDVSA=
X-Google-Smtp-Source: AGHT+IEu4DI9WqCByr7rrTwLwlGd6tkHLE9xiBLfLuxbiSgJPjBw/xrcqlQOuJPymNtVyODbYOHj5A==
X-Received: by 2002:a05:6000:26d0:b0:430:f790:99d7 with SMTP id ffacd0b85a97d-430f790ae20mr15969150f8f.27.1765988885518;
        Wed, 17 Dec 2025 08:28:05 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:05 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
Date: Wed, 17 Dec 2025 17:27:35 +0100
Message-ID: <20251217162744.352391-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cgroup::ancestors includes self, i.e. root cgroups have one ancestor but
their level is 0. Change the value that we store inside struct cgroup
and use an inlined helper where we need to know the level. This way we
preserve the concept of 0-based levels and we can utilize __counted_by
constraint to guard ancestors access. (We could've used level value as a
counter for _low_ancestors but that would have no benefit since we never
access data through this flexible array alias.)

Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 19 ++++++++-----------
 include/linux/cgroup.h      |  2 +-
 kernel/cgroup/cgroup.c      |  3 ++-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 9247e437da5ce..8ce1ae9bea909 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -475,14 +475,6 @@ struct cgroup {
 
 	unsigned long flags;		/* "unsigned long" so bitops work */
 
-	/*
-	 * The depth this cgroup is at.  The root is at depth zero and each
-	 * step down the hierarchy increments the level.  This along with
-	 * ancestors[] can determine whether a given cgroup is a
-	 * descendant of another without traversing the hierarchy.
-	 */
-	int level;
-
 	/* Maximum allowed descent tree depth */
 	int max_depth;
 
@@ -625,13 +617,18 @@ struct cgroup {
 	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
 #endif
 
-	/* All ancestors including self */
 	union {
 		struct {
-			void *_sentinel[0]; /* XXX to avoid 'flexible array member in a struct with no named members' */
-			struct cgroup *ancestors[];
+			int nr_ancestors;	/* do not use directly but via cgroup_level() */
+			/*
+			 * All ancestors including self.
+			 * ancestors[] can determine whether a given cgroup is a
+			 * descendant of another without traversing the hierarchy.
+			 */
+			struct cgroup *ancestors[] __counted_by(nr_ancestors);
 		};
 		struct {
+			int _nr_ancestors;	/* auxiliary padding, see nr_ancestors above */
 			struct cgroup *_root_ancestor;
 			struct cgroup *_low_ancestors[];
 		};
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0290878ebad26..45f720b9ecedd 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -534,7 +534,7 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
  */
 static inline int cgroup_level(struct cgroup *cgrp)
 {
-	return cgrp->level;
+	return cgrp->nr_ancestors - 1;
 }
 
 /**
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e011f1dd6d87f..5110d3e13d125 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2197,6 +2197,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	}
 	root_cgrp->kn = kernfs_root_to_node(root->kf_root);
 	WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
+	root_cgrp->nr_ancestors = 1; /* stored in _root_ancestor */
 	root_cgrp->ancestors[0] = root_cgrp;
 
 	ret = css_populate_dir(&root_cgrp->self);
@@ -5869,7 +5870,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	cgrp->self.parent = &parent->self;
 	cgrp->root = root;
-	cgrp->level = level;
+	cgrp->nr_ancestors = parent->nr_ancestors + 1;
 
 	/*
 	 * Now that init_cgroup_housekeeping() has been called and cgrp->self
-- 
2.52.0

