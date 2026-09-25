Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677B4F4726
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369072; cv=none; b=sL9826O50JSy9rK1M1fDxG2iEiWq0CtBQpT9Oxtqyiz/CUPV72bPSzgi30Aj8OAJk0yaDXEIvOinDDuY1j+NeQafyHJsbAyRdw+19XislgudjXYo+40SvBLzonK/n7xQnGBVyXSu/eUCY/bHJXoEnLHUZBJopjQ1Qq00jo7X070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369072; c=relaxed/simple;
	bh=ATvAQ1iCPE6sZHf7d2RYUKO49r9rU52gt6ALXvFddsI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HATyTJ+7xOuI8tIVuipLaMWD5TlQlUd/6OYnfUMYaejo5IPTOExrPXE/+5lIEYmKjwP2KYWAa7XR4hK2gq4tCqFVioJ+yuqCmXPwodf4Vjltw8kuiQB7IKy6W+qA1xdzwPU7wqWylVvZPTObuPJDo54aCzQrBQ4NWej4ZrNg/0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfgfYiik; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfgfYiik"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396901263b6so1368580a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790369069; x=1790973869; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HF1Qmy6ruPKeRtkKuZoMA0fFwHNLsCEq59RB62k4IKQ=;
        b=PfgfYiikPqei35XWtEB9DDJhymfFjQWMNK1Em5w0+Lfp2VhyHtV3fq9NZL2mwpcLfB
         CQmu8/kYH52Gjgra7hryk8trT7I7OA6Rug96nICAWIYlu+ptXY7YziwyVncMmZdVDje2
         Ovf94CquPm29yJXArbMyMHnlRTgfd8is+x9ad8SSVsx9qyujvyGISPruwSswcM95ZoTD
         zhIUtAWGDM160BzqaJCngpTWVstjJnLDCSN2UNvx8Z+36I8c4SmP5whODDRILro7aQw/
         AXY5DUhbTJ412qqJFALVKgx5bpcGqGgcjtkdK1++VHlnaHyKrTtu5+BYcEwmY/jbP2tM
         EosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369069; x=1790973869;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF1Qmy6ruPKeRtkKuZoMA0fFwHNLsCEq59RB62k4IKQ=;
        b=V9ryEeF6RpxnIpq1zqiRYN8y8/29m3cSW8xiHHP+gTZliIh9XoxVWceTh6AFzjxQcK
         jUJDT9Q5p6116rOVPXJtXTWRcoWhJYI92SNIaq3WxQY8voi1f7ai7tyIJlzkDP6yUtTA
         l1pNALdsElOVnDzCEgGDJUjSj4cb7Uhf2lJO6R/puRuTwTfrCVC6FNDdGC4EjRq1Xte7
         52Mt4jVam8kMorkban7kez9xVaX8kp1AvI9I3OzXrlz3ujJh6h3DZ4UPnEhrPaiBww2W
         hQxoOzC08Hbtv2Lw5tyGufCuz0dLXHpVsILkRHky71RmvwlmUmF8JtAcEzGN0Qii5Wat
         0mCg==
X-Forwarded-Encrypted: i=1; AKwUvBzVsdsw6U58MR/48LfZFDsUF6xtcqqRKepsW1wl58B2CfZ6/y2QIw8WeOe1egTV5ywKNz/tVt3qYV2Kqj2URdY=@vger.kernel.org
X-Gm-Message-State: AFuF++kWVD87RmcfOmMVJpN163ozZvkPVJ8Jxma9j6uTrKSUenIt+01i
	x8W4F5Cov/mBNjrYjpFkrxmZ2TzJuILpSmO1TjboRTZCrUszizL32KEFXRyOzzsNcvJSzZfMjlW
	h
X-Received: from pjbmp23.prod.google.com ([2002:a17:90b:1917:b0:3a0:ca11:2396])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc9:b0:3a0:c5d7:cec
 with SMTP id 98e67ed59e1d1-3a0c5d713camr1775083a91.24.1790369069068; Fri, 25
 Sep 2026 13:44:29 -0700 (PDT)
Date: Fri, 25 Sep 2026 20:44:23 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925204423.80661-1-morbo@google.com>
Subject: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
From: Bill Wendling <morbo@google.com>
To: Matthew Auld <matthew.auld@intel.com>, Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

In 'struct gpu_buddy', the 'roots' field points to an array of pointers
to 'struct gpu_buddy_block'. The number of allocated roots is tracked
by the 'n_roots' field.

Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
referencing 'n_roots' to enable compile-time and runtime bounds-checking
via KASAN and '__builtin_dynamic_object_size'.

In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots' is
subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
mm->n_roots)'.

Since the bounds associated with 'roots' ('n_roots') are fully set prior
to any array allocation or access and remain invariant, this annotation
will not cause runtime panics or false-positive bounds checks.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/gpu_buddy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index 2c36124bb696..d7249e500ab6 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -172,7 +172,7 @@ struct gpu_buddy {
 	 * a power of two, with each root being the largest power-of-two
 	 * that fits in the remaining space.
 	 */
-	struct gpu_buddy_block **roots;
+	struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
 	/*
 	 * Per-order free block scoreboard: free_scoreboard[order] holds the
 	 * number of blocks of that order currently in the free state.
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

