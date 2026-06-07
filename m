Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E428371
	for <linux-hardening@vger.kernel.org>; Sun,  7 Jun 2026 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780816015; cv=none; b=RSmbr8veC7Y0dylkb4FLB+xnzv6qSNcjiK/BPY/tFTLq36m6L0/dBl9J39WSDIR9aGsKniLQh8RNBz9frR561l3XmAsD65qD3yiuHYXhY7XDRel24Cew3ceJFSDfH7Yto+Ar928AHrD/bKp3J6FB8DibBfCk0e+zYgvo/Rfs+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780816015; c=relaxed/simple;
	bh=heTeMpu75d0octllsLN2T80w2EU3DkJ/ZmCHQiUIajE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e95dZf0ajhVuJq4NCtz4X98mrQP03T9lEXXcf09mNSUgd+0epmRDaI5K/oTsSsGUFsKxIezGb2tElR7wYN0OnpgMzKMqQ5i37k6KWIaONow9IlUlIMT6u35RIkhkYyPkbY4moivpcnoojjjFINyHnuwbC+HVuSC6TF1fCmkTlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKrV7Q8k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKrV7Q8k"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b7866869so38403255e9.2
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jun 2026 00:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780816011; x=1781420811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjFCfZnGIYF5PioRnZOk1Y+cKLSfcfAJ9sx8UaHZ3lQ=;
        b=TKrV7Q8kNugCnqjStbMJi03g34l9fS0MBsTXyHuUozxqlz0jZo9eOBzC9sA55/4kYB
         12xfxBDa7nPUb/CCy+BGVvGtRsbdKGQJatr6LOSsjkAEZzqQ+qKXMsnuSPghimGigeta
         gOvUl7kBTP4CzMxGEovI7b6B7dXdk6hjHPw6caZr1JORDUlRIX3TlVZj7F8Btv3EoAYY
         XrnIa/V7JrLrNWw+EEpr9OUPBnZ+k17i1oAKvucU4pICEzR9X/84MIJmyc5xDFhIDlfz
         3qAg1nHW4ySAA7MzoHTjL5UjtjIqDrU/HKMod4GatGMZ69zWeKtYYfKHltKQ5WGkxLHS
         gwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780816011; x=1781420811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EjFCfZnGIYF5PioRnZOk1Y+cKLSfcfAJ9sx8UaHZ3lQ=;
        b=A7rHAvkSS9Blla/NDWc3azF6F0R5OkGMWkle/p67FU8EUfe38OT/ZnaCPmgfMV45Rf
         kbS3ucfMiUOtTKLb867Udn1WHAyVYjlU/UuVeVnd5ifa6RMlqakY5OE5jKYjrfSQXmRh
         XhRnuPb1e50MWTJltWmbJ8PS8RKKwVHzY8FrCaLV72gMMavYwsnlMZJjitYNjD4B5q7I
         JmdPCwfBiTFJySj6QzDLT7FU9/2XVBKKRxrgbQOLsG7c6AfsooZJS3YsnsDjbVs7mlCa
         drQKKHNdHzPzHy2vjUPkBhJQWefPnropLudK53WYczGRz1hKR68OqHrDQkXRtonXs8PO
         4hfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dtg0LFSv9Us/SdRYt2mKvoWw/jIIGSUSn/QvEY12I/jiE6nmryVBIZGQ4Yb/3SFajLQoLrw/CLlrMHdDpjVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2CZ2snej04kDUxYVpxB3Xrz4tfMSMZSoVYuuzbNBldWS3n+i
	C44Ks7bCNxRBfyMdapXDzQcZTHuC9/8NVqgquCBNGXCddD4dDu8x3iw63tJGdqw=
X-Gm-Gg: Acq92OHbfemq6J3YLJc81RSAJlV8xpExJwTgbyJqGOLUk0U1pMntazA3FEzp8osnwpS
	ok2fspIaZz9ubwRIWcfE4ppkgvgrk/mWlLYeoGL3ROq0L1qQfzxSsuuWlHvs594sahoXUqj2ARS
	jc94wN7V+6y/bNfOYH7ePEuG4yxPZLjQMxbiYGSeBzXkbEz2vL0LALSMUrAf6aK1GEGvNgyjt2G
	HO203MRRSF6tI2NizGlvZp0S/MaooaNhQZk7y9eDXEq6/EWBGmJId7VeYqWPEVwHh2C7kzzvw/G
	zNo0ARrGqG0T6TTf7haxPoyOdZWUjPVueMpvKdruFzKJurJlr7xbAOenyir4BIy9e5ImYE1eWGr
	WSDNRAjignNyIzZ3lLbkodXtBIYcZtkhONrdPDvFWNLcG3MUWors4z0S9QSnfsYBu22YJTnqPyX
	gTQWkwBtl1GBloIVVOrimPguwPnUjIE9AVD1ZLqZLT1XM60zP5DA+49cjPLrtjX4dap9gJpyrvD
	4tck98y9MlGvWtXz7hm5hNNPcUnddBpi5V4cknpgw==
X-Received: by 2002:a05:600c:34c9:b0:490:688b:f10d with SMTP id 5b1f17b1804b1-490c25b3549mr184516635e9.7.1780816011186;
        Sun, 07 Jun 2026 00:06:51 -0700 (PDT)
Received: from hp-ubuntu.. ([41.248.186.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm44225082f8f.23.2026.06.07.00.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 00:06:50 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH v2] docs/mm/slab: document cache isolation with SLAB_NO_MERGE
Date: Sun,  7 Jun 2026 08:06:45 +0100
Message-ID: <20260607070645.9559-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606155856.15548-1-med08elkadiri@gmail.com>
References: <20260606155856.15548-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation to slab.rst explaining when and how to use
SLAB_NO_MERGE to protect security-critical slab caches from
cross-cache heap exploitation.

The document covers:
- When to use SLAB_NO_MERGE and what it communicates
- How to verify merge status on a running system
- Tradeoffs (memory cost vs performance)
- Relationship to CONFIG_RANDOM_KMALLOC_CACHES, SLAB_TYPESAFE_BY_RCU,
  and the slab_nomerge boot parameter

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
Changes in v2 (per Jonathan Corbet and Matthew Wilcox feedback):
- Add content to existing slab.rst instead of creating new file
- Fix markup: use plain function() without additional formatting
- Use slab terminology consistently, not SLUB
- Remove How merging works section (implementation internals)
- Remove cross-cache attack class section (redundant)
- Remove Bounded allocation volume criteria
- Rephrase unmergeability guidance per Matthew Wilcox suggestion
- Add Assisted-by tag per coding-assistants.rst
 Documentation/mm/slab.rst | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/mm/slab.rst b/Documentation/mm/slab.rst
index 2bcc58ada302..c485bd257c44 100644
--- a/Documentation/mm/slab.rst
+++ b/Documentation/mm/slab.rst
@@ -4,6 +4,66 @@
 Slab Allocation
 ===============
 
+Cache isolation with SLAB_NO_MERGE
+===================================
+
+The slab allocator merges caches with compatible size, alignment, and flags
+to reduce memory fragmentation. While this improves memory efficiency, it
+allows objects of different types to share the same slab. This enables
+cross-cache heap exploitation, where a use-after-free in one object type can
+be leveraged to corrupt an unrelated type.
+
+SLAB_NO_MERGE prevents a cache from being merged, ensuring it receives a
+dedicated slab. A freed slot in an isolated cache can only be reallocated as
+the same object type.
+
+When to use SLAB_NO_MERGE
+--------------------------
+
+SLAB_NO_MERGE should be considered for caches holding security-critical
+objects whose corruption leads directly to privilege escalation, such as
+credentials, cryptographic keys, or capability sets.
+
+It is harmless to specify SLAB_NO_MERGE even if the cache is already
+unmergeable for other reasons (e.g., it has a constructor or a non-zero
+usersize). The flag communicates intent and ensures the cache remains
+isolated if those other properties change in the future.
+
+Verifying merge status
+-----------------------
+
+To check whether a cache is merged on a running system::
+
+    # Check how many other caches share its slab
+    cat /sys/kernel/slab/<cache_name>/aliases
+
+    # aliases > 0 means other types share this cache's slab
+
+Tradeoffs
+----------
+
+**Memory**: Isolated caches may have partially-filled slabs that cannot be
+used by other types. The overhead is typically a few extra pages.
+
+**Performance**: Zero impact on kmem_cache_alloc() and kmem_cache_free().
+The only effect is at boot when the cache is created.
+
+Relationship to other mitigations
+----------------------------------
+
+CONFIG_RANDOM_KMALLOC_CACHES creates multiple copies of each kmalloc size
+class and randomly assigns allocations among them. It only affects kmalloc()
+users and does not affect named caches created with kmem_cache_create().
+
+SLAB_TYPESAFE_BY_RCU delays freeing the slab by an RCU grace period. It
+does not delay object slot reuse and does not prevent cross-cache merging.
+It solves a different problem: safe lockless access to freed-and-reallocated
+objects of the same type.
+
+The slab_nomerge boot parameter disables merging for all caches globally.
+SLAB_NO_MERGE provides the same protection selectively for individual caches
+without the global memory cost.
+
 Functions and structures
 ========================
 
-- 
2.43.0

