Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DD368D7C
	for <linux-hardening@vger.kernel.org>; Thu,  1 Oct 2026 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790833629; cv=none; b=KIwYLtXkXvJTgR/+0zzGI+2oZHcd16BTmEDLkkrcdD0snhiScmt4OqM2jC3ZSgp+K+fFkUNzwksknRT64kO4tFCOPJdzFx3NlLudVtRAiFU7HAFf25zB9xH+mLNnMts4pe3hGvlmVPxs/3NTrmXtsO4pePtrRKDhPxfEQ3gn3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790833629; c=relaxed/simple;
	bh=J6CDJfDrHs9Xh8xm7mF4JVU7BUMT89ttkfJpwjj06p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foL9YK5b2D/bC9yYsogMG7jJz2C+dcVvaYF6KYF0EIEFoiQTYY3aMmmhSpahmR8FJAXY2KSw2hW949cN4ivli23vXQpMiqztrpTetQfeuxtjShO2N9Pxk1wRjgY5IHrzRnSoja+KatzupwTHqhokNNDGLaBeQlo9uK3uhlnXYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwD7LtRm; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwD7LtRm"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93ca7aa84e4so134298285a.0
        for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790833627; x=1791438427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ole5s+LPcjnPZwgGNmuzsjKHTKb0fD2/ZAwdN7H+e4w=;
        b=EwD7LtRm+QdsLN1rVB2nV3oa6TUh8JPA1zIm+wENinQnq2/v3jIg8EaMTubh55Hw/J
         3qmBgpeBr6dqyLkR5c+judV5Psg48LOKCNZr3iIFKaHCO9I1x3uArM/vYmAmZfhhmlVQ
         p0mXjsR1ff4P31r6fw5UfnzO2kG7CYaC8VILjnh0ak1Mbrps5CJq4NtZAIUhRr6/R3sT
         G2E6ToaR3bcs9b/u/YWTVkygA3RhmP22AG1ZcMbs1WTZbsswnkUbqeNS0fesrXEWZhY3
         0wY723tmJvqPxOsy7SWBC2FB1yc6xJI+334CnTMd3Qp5FUAkXHfTrUn6ScZ8ytj+UyQC
         UiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790833627; x=1791438427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ole5s+LPcjnPZwgGNmuzsjKHTKb0fD2/ZAwdN7H+e4w=;
        b=io5qE7KAtfXi7xfXIeh5avkF5ZargzTtDGMCacCK2mHgHLe/Hrwej75m47Ojf/KEDm
         71ObEeI/A89CtlQOP7G6hbEKed2FINQNqUTk+k7W+SHHN7wBoTjCS0sufXNyCrMcY2CM
         AWiZ7BbJG2MvRmjxBEcjoGIIRi2bPNYKKRvNW3b+wmPNmg9flWQY01kIPQ+9ONdw3EjJ
         epye7NUECQ3MlxCZ04w6IDx7ITkPeCjkNio4FmqaT1XMId+/X5t8q1SdD+qF97mpnElz
         wCMcEFvC0aDjCwXR0LNHIYfgHKZVHSKfQE518O0/IgZip7cJjn5dMCpK3IECLjIGCG08
         IkgA==
X-Forwarded-Encrypted: i=1; AKwUvBxyv9sKk21RSWqfDscFkMPTt+E6PwJtNsih9xylUBS9I8J/QfALyoXemvTw1pCvydaO4WAJ6wu5+dqmcqmQ8pw=@vger.kernel.org
X-Gm-Message-State: AFuF++kwFPR6kVP2u0Z9M/+dh4VblVGBSH9H8F3wsVHkZT8licT/dvjW
	5SItTh1OjHzgg02qIVtO5XLc/TRaZOw2yP6i4SS8ppzPgeIero10jTRy
X-Gm-Gg: AYBFou3sia/r5vvGzxrzihqyTuAmDXFjxyi55Wnkvvaw81+TX634N8wLHP0h6nIAPUw
	q0j+1E2qun2zaJBHGZjGEaOlqiS5k9CFecQk+XDMiCTDX+snlH+bSM6wBAvoMcej/dWdofxV4qq
	RM1Qg0Fe7/D7ZyIAICKLmd3CJsFTxVlyXMID2H2buQBVNF9DDiv2/j+a42D/U/N2mUqzg6E4iEJ
	cM/2Jul0WXgdh1iuT1bqUagCR1OTPFMLG+Z9JxYQQ6sk1kWRkmpDCsC5eBbYNSyAEw4r3pZ5dCs
	K4ug3/97WCzJoBEpJF9a0cCwABndjPu5sqTj2NgwwEyFOqm+AgvEEOH83TPwNxGp9iTROjQCoNt
	84YvV+q/Tt46gLC0yFXM4K09lbdy/r//IZ1J5tozIle0XlJqfiuwmRAYnA9w2SexZGeUOI8gYHD
	VPdQCfobjglhhkFeewFQxWB0My6smhlytX937Fp1B00NuZ7QZwewNfglRob2KupOx2B7SrP45Xn
	dyObGyWml0XWI05zMYrnxIvNvaH8dRnJSJffN7KpN5t3a3HxATCd0RX97zgz6Stfa3HVp6g3Pko
	Y1tMdxj66VkkHJFrO0jEI9Krumo+p6hBvrWf+NgPFVKwxqVodXkoVIWyNM0z
X-Received: by 2002:a05:620a:2b96:b0:93c:7b3d:38a9 with SMTP id af79cd13be357-93ca94f6521mr633545385a.2.1790833625365;
        Wed, 30 Sep 2026 22:47:05 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb64eb59esm140040785a.22.2026.09.30.22.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 22:47:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v2] clk: tegra: bpmp: remove kcalloc
Date: Wed, 30 Sep 2026 22:47:01 -0700
Message-ID: <20261001054701.39160-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to avoid allocating separately.

Use __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix subject
 drivers/clk/tegra/clk-bpmp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 067a8555c4e7..15b976162b59 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -32,7 +32,7 @@ struct tegra_bpmp_clk {
 	unsigned int id;
 
 	unsigned int num_parents;
-	unsigned int *parents;
+	unsigned int parents[] __counted_by(num_parents);
 };
 
 static inline struct tegra_bpmp_clk *to_tegra_bpmp_clk(struct clk_hw *hw)
@@ -518,20 +518,14 @@ tegra_bpmp_clk_register(struct tegra_bpmp *bpmp,
 	unsigned int i;
 	int err;
 
-	clk = devm_kzalloc(bpmp->dev, sizeof(*clk), GFP_KERNEL);
+	clk = devm_kzalloc(bpmp->dev, struct_size(clk, parents, info->num_parents), GFP_KERNEL);
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
 
+	clk->num_parents = info->num_parents;
 	clk->id = info->id;
 	clk->bpmp = bpmp;
 
-	clk->parents = devm_kcalloc(bpmp->dev, info->num_parents,
-				    sizeof(*clk->parents), GFP_KERNEL);
-	if (!clk->parents)
-		return ERR_PTR(-ENOMEM);
-
-	clk->num_parents = info->num_parents;
-
 	/* hardware clock initialization */
 	memset(&init, 0, sizeof(init));
 	init.name = info->name;
-- 
2.55.0

