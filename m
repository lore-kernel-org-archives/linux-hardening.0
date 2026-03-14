Received: from hannover.ccc.de (ep.leitstelle511.net [80.147.51.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8082E974D;
	Sat, 14 Mar 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.147.51.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773499455; cv=none; b=nPISvSzuC5nfea0LFPr/LS7kQDyigel7d+4GhaeZ6ODuOvdcGgCDrN24C4eb16J+Y0NzEr4STsAzJdU0FAnNw1/WF1tycEt+UQXJ4uA54f5kBD1iogJCITCOFTgDgBWs4l4pd34eBX/MPsxd1Ah5KII0A+jMqJ03ZTw0Ss2hF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773499455; c=relaxed/simple;
	bh=rziCd0gyQqnqiI3M7uLBmkAMrsqUXPAnePxoXPsBk4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szio580yfHz0sp8OU/Noe02gsFJwiBhePIbQOzr8KFfZqQEwhV4hVL1xdN/nsyVRH1LXkfqwGZyg4PUIrtx/TCl84iTjnemRYgHxTjB7cAHX0dvB431n7LEjoDTJ+33txs2mq7zjhwqn4I6XBEXQcbcO5RT5w9/ufE2FvM2hj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hannover.ccc.de; spf=pass smtp.mailfrom=hannover.ccc.de; dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b=G88z2Bmv; arc=none smtp.client-ip=80.147.51.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hannover.ccc.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hannover.ccc.de header.i=@hannover.ccc.de header.b="G88z2Bmv"
Received: from spatz.zoo (pool-213.162.156.104.dynamic.wobline-ip.de [213.162.156.104])
	by hannover.ccc.de (Postfix) with ESMTPSA id 34AA020D61;
	Sat, 14 Mar 2026 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hannover.ccc.de;
	s=ds; t=1773499449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thrQjx3etKHgvebjG3KvySyHdbcMkOgU7T895euiBbc=;
	b=G88z2BmvVfkx9FUnpF59ZMjh4FhYNu8hY8ttv4z/1mRtOiyNzHq3pIeEmiDrG4dC1a6y7R
	/3NyqLQ2S213QI/znulcB1FXt6FLzkTD0yrDfcpJldHssdHs4P6k8aXCyalRw7P7jb4juz
	Vl+oKaDoSepZx0D/GuANFPqhFNpjXlc=
Received: from ingo by spatz.zoo with local (Exim 4.99.1)
	(envelope-from <ingo@spatz.zoo>)
	id 1w1QDo-000000010Wg-2meO;
	Sat, 14 Mar 2026 15:44:08 +0100
Date: Sat, 14 Mar 2026 15:44:08 +0100
From: Ingo Saitz <ingo@hannover.ccc.de>
To: Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Build error in next-20260223 gcc-plugins/latent_entropy_plugin.so
Message-ID: <abV0OEcoN6H_QZEP@spatz.zoo>
References: <4051116.1771996801@turing-police>
 <202602242333.24E5CB214@keescook>
 <4147110.1772032451@turing-police>
 <abVntmj9O7uXnES2@spatz.zoo>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="N5ytkd1BYnbboSHN"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abVntmj9O7uXnES2@spatz.zoo>


--N5ytkd1BYnbboSHN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Mar 14, 2026 at 02:50:46PM +0100, Ingo Saitz wrote:
> I attached [...]

Grml, here you go

    Ingo
-- 
const_cast<long double>(Λ)

--N5ytkd1BYnbboSHN
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Replace-CONST_CAST-with-const_cast.patch"

From 552485b879d19780afd3614d69508c3ea7cb242f Mon Sep 17 00:00:00 2001
From: Ingo Saitz <ingo@hannover.ccc.de>
Date: Sat, 14 Mar 2026 14:24:56 +0100
Subject: [PATCH] Replace CONST_CAST with const_cast<>.

For gcc-16, this was removed in gcc trunk

see commits
  c3d96ff9e916c02584aa081f03ab999292efbb50
  458c7926d48959abcb2c1adaa22458e27459a551
---
 scripts/gcc-plugins/gcc-common.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 8f1b3500f8e2..7b3517b31e0a 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -309,7 +309,7 @@ typedef const gimple *const_gimple_ptr;
 #define gimple gimple_ptr
 #define const_gimple const_gimple_ptr
 #undef CONST_CAST_GIMPLE
-#define CONST_CAST_GIMPLE(X) CONST_CAST(gimple, (X))
+#define CONST_CAST_GIMPLE(X) const_cast<gimple>((X))
 
 /* gimple related */
 static inline gimple gimple_build_assign_with_ops(enum tree_code subcode, tree lhs, tree op1, tree op2 MEM_STAT_DECL)
@@ -414,7 +414,7 @@ static inline void ipa_remove_stmt_references(symtab_node *referring_node, gimpl
 #ifdef __cplusplus
 static inline void debug_tree(const_tree t)
 {
-	debug_tree(CONST_CAST_TREE(t));
+	debug_tree(const_cast<tree>(t));
 }
 
 static inline void debug_gimple_stmt(const_gimple s)
@@ -422,7 +422,7 @@ static inline void debug_gimple_stmt(const_gimple s)
 	debug_gimple_stmt(CONST_CAST_GIMPLE(s));
 }
 #else
-#define debug_tree(t) debug_tree(CONST_CAST_TREE(t))
+#define debug_tree(t) debug_tree(const_cast<tree>(t))
 #define debug_gimple_stmt(s) debug_gimple_stmt(CONST_CAST_GIMPLE(s))
 #endif
 
-- 
2.53.0


--N5ytkd1BYnbboSHN--
