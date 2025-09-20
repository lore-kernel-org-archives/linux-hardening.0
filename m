Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CB13AD1C
	for <linux-hardening@vger.kernel.org>; Sat, 20 Sep 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397917; cv=none; b=d93fNkkpSirZaGS5XJlG0OhJSYCpF0zjADRI2HG45bVw5dwbiy5VcBeJtdz9tegAjieWSy1k3JrEAtlmz0F0x4hQ7BQ4ELBewHFDqSZMJkLmwEoHae5+YbImIAuPNoXqN1YknAfte2fNWUZAe6dAivB0FJ+jV/5w4MZ+3rCHSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397917; c=relaxed/simple;
	bh=tiTkcMmh+nNrmywKQAIj2Lz1/rTUnbo/0jbQHAzPJM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8L3LNZB3NHVCcYIzSsjzhCHv0zaXWIx029GPLOi6ub1Iuqj7/w1lzHCvDZbeN9nMyyZL9pLzEAGCBp+EVkWjOmUV37tTQxeWfJ8udeNKZGMQqKghsQM7X8volB2VOCxOsoK0t96wJlIfkg+mSySdtU+QtJ2wVtov4kRqUpN80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=IvQdruxw; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="IvQdruxw"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 50CFC240028
	for <linux-hardening@vger.kernel.org>; Sat, 20 Sep 2025 21:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1758397911; bh=4HU/WLZD5CRcSdOtBE//CFyDLWe3j5+9WVqQ68QqyM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=IvQdruxwAtn5IofNFucQ1Ky+gPzjOCOZOx0EM0d9ecVb8pWRHY5gstEWYxAi/1490
	 3K7MoNhnX4qLQJuRKR6lRjeZ4UcE1LmyrJfWh8fFmD9V4NQEACJZPOZTB+QHTBPxFF
	 LiNMwKgzvFhDFcAoDizl7dFN2HPjbwAoRSAJA6QPT3mxvnMWBLbXC49g9xP8wRXXRA
	 jksdRojBfvixdUskx6zFVwu8lu56xRbawyecu4ZXMFerkKDULIpschfjofqIcqpvSl
	 x8Q1xf7UqKSS9UP/2b6DUzwOXryoaxA72UWEm7Dud62ZfoD/kJINq59P8A4e3lSMss
	 nHmXs+t08EOwQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cTg4Q3pKRz9rxB;
	Sat, 20 Sep 2025 21:51:50 +0200 (CEST)
From: Christopher Fore <csfore@posteo.net>
To: kees@kernel.org
Cc: linux-hardening@vger.kernel.org
Subject: [PATCH] scripts/gcc-plugins: Remove TODO flag
Date: Sat, 20 Sep 2025 19:51:51 +0000
Message-ID: <20250920195127.22425-1-csfore@posteo.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TODO_verify_il was removed by GCC at
9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8

Direct link to GCC commit:
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8

Signed-off-by: Christopher Fore <csfore@posteo.net>
---
 scripts/gcc-plugins/gcc-common.h            | 5 -----
 scripts/gcc-plugins/latent_entropy_plugin.c | 2 +-
 scripts/gcc-plugins/stackleak_plugin.c      | 3 +--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 6cb6d1051815..cedc655f4741 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -173,11 +173,6 @@ static inline opt_pass *get_pass_for_id(int id)
 	return g->get_passes()->get_pass_for_id(id);
 }
 
-#define TODO_verify_ssa TODO_verify_il
-#define TODO_verify_flow TODO_verify_il
-#define TODO_verify_stmts TODO_verify_il
-#define TODO_verify_rtl_sharing TODO_verify_il
-
 #define INSN_DELETED_P(insn) (insn)->deleted()
 
 static inline const char *get_decl_section_name(const_tree decl)
diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index ff0b192be91f..065e1fe58f75 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -564,7 +564,7 @@ static void latent_entropy_start_unit(void *gcc_data __unused,
 
 #define PASS_NAME latent_entropy
 #define PROPERTIES_REQUIRED PROP_gimple_leh | PROP_cfg
-#define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | TODO_dump_func \
+#define TODO_FLAGS_FINISH TODO_dump_func \
 	| TODO_update_ssa
 #include "gcc-generate-gimple-pass.h"
 
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index e486488c867d..6f663bcfda84 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -503,8 +503,7 @@ static bool stackleak_instrument_gate(void)
 
 #define PASS_NAME stackleak_instrument
 #define PROPERTIES_REQUIRED PROP_gimple_leh | PROP_cfg
-#define TODO_FLAGS_START TODO_verify_ssa | TODO_verify_flow | TODO_verify_stmts
-#define TODO_FLAGS_FINISH TODO_verify_ssa | TODO_verify_stmts | TODO_dump_func \
+#define TODO_FLAGS_FINISH TODO_dump_func \
 			| TODO_update_ssa | TODO_rebuild_cgraph_edges
 #include "gcc-generate-gimple-pass.h"
 
-- 
2.51.0

