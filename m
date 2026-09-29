Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946304483B4
	for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709881; cv=none; b=qgZ7szl6rJh26HGtkCoMhMCzQcshZAJgtjaxGcy9WElg3c6l/cBs44BLH6KjVe1TmLZgD3nTR5iGKgyMgw96OaSP+YCM7bIawYvWTbyXDwuHDB0kdoSlEMPKFuPr5E8nVRopk0/3O7xWGrn62uuv2EFaxUN6kjs3TpKSJhKDsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709881; c=relaxed/simple;
	bh=RvBlO2Tj+oD4izUACOcTsnJXXEePaYc3n30436iNNw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NK8OaVJLlkb3e2Rk+ipcHnjNac22B/mU7Iztpzzu6I5oOoHDmvV8YaXXDaUX0VuWcNhgiZEuC9udzP6E5/d34EDmd+mi1Qx9bQ0XQ8oERQkR+keSI/Hif0hA4IekCiAVYHjSfbAp8VjCiy+Rh5U4pfQqzbn3xFJejB3F6zInu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ086+nY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ086+nY"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f05ffcso21900145ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 29 Sep 2026 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790709880; x=1791314680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzp9+chQ6iocMfXVjqbrn94FQKdp8G+cswYdgKOgF0w=;
        b=JQ086+nY5kJDLHKyAbdl0+rEpv8Mvc4WKEGAZBVgQVlLfLm6bWyhV0R+cOZt82lCX/
         z+zeEHbkX4aTok2m0hyQ3gGCDbU8EnaSjqfV4TNyugBb9YDVo5M6GMnRfAM4x7rDIx2f
         aOAWZV6Mgp88HSGqP0x7TETh5reoEqwi/yLbbMNXBp3XAFGzr47tlD/Ro+yAOPQuQxGa
         8BKFHFCAgNiFquCPIc1rBmr1wtZFODks4LFMTAfiShjaGb9abUR4jokaWpryP8Wbfh4Q
         3UkNL89bfbMqDT9a5gQRW19Qc0LUzEMg3SWUFNgmoqUP9JmCvONCGPxDpwbobFpc26mL
         30wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790709880; x=1791314680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lzp9+chQ6iocMfXVjqbrn94FQKdp8G+cswYdgKOgF0w=;
        b=kgoVrGgTMiWwgSjHstnPyUhQsGrDqDD9ok+YbqObH+furjiRJoylKz23Wztb8+dA+q
         YD/5f/BhWCiHpJ9ylocPJg42PGyWr9nOnkmwBwIN2GRKrvCAlBdOGySC4uAzW5KPHuTU
         G81mABpHHUnhBhspJf4C0I0lFWAfM1P6rSqqznvh3ZXueO/YPPPMEZYmQ2RrLNUgZ28p
         cfLdJEFrZ1Sm9i2sxtKHDebF6go2OavTyz269XGrfg1KaC5Ne8aPHtJWc2kxI9ogOEkP
         BrxComp95vYYVvPYWUJY41KXQUuRRB2ZBAB+W09PZETDm+bEYXrxk30rPGLuAyi7nzzp
         pyyg==
X-Forwarded-Encrypted: i=1; AKwUvBy/ZHyRVdlfoE8OWIs9Kz8POiOm8wVCEKsheraECWNYngbwwFY2B+2J4koQesuE+lE/E0FSSAAKhOxDBtEQIFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mBr+XtKNy9Eu6/LRwp78gSk9GGEY8kU6rLaj4ip4tSVwklFVmG
	fzArQXZg+5TGXgv9naK8BGquvcqXNX08/xCXdEXPLaLO8uJLuJiXFQqk
X-Gm-Gg: AYBFou11YT6/f4uPlyRHd5CNclhbu2EO4axgINPJ0cZrLsYZzeinS6EhzQIlvcBWLnd
	wwFEa7yHMIlm0Cdj2Qdp8uwVec3kw1xi4jkWevly+go4dA01/NmKe/4JJZwrnRxVsNxyoSg1ceb
	2T7YdEiWWeCMf1m1kfWuwSxT45MQXhU1PBEzplGDp2v813Ds/btECCRw/JYPyJftOAfFbdY5Ty3
	j8PD2NFeZL//A1w8fYkOJxhlQYCVSf3mmPoqw23musQAyjuBOKdFwWDhgFV5YjtAUCPMjeQmR4g
	Urieaj8Y5s7EXJ0d773p59IlQMBCp+PQAofCQ8nHMl2ypXiu3gs9/DHtbaVnyQe+SRUxdWL/npS
	toZv+fynZPU2rcXFIUw5ttlJ7E2M5lxIMofd0/oXH0GaY/uE9pMeVHDYAKBti1P5SBnPgU/Qax9
	ZAcns336wxgDZQLclw9VNef6eF+Qfek9k18iB1lki8PXNmEwLhgBlx4mGJRC6pUdpwLVci/5MOb
	nchesREfnysRcH8OnI8GZSnPxPr1JPMI6JT+qpTWqyskeXCKZ44epuQOKqq7ak1RQaildtPgSH7
	Wsvlmr2Gz1SZyDLQIxW8yq47sly854MoL0ICw2lX5B981U8Y
X-Received: by 2002:a17:903:32d2:b0:2df:b5c7:d0f1 with SMTP id d9443c01a7336-2e2de565bcamr475215ad.44.1790709879930;
        Tue, 29 Sep 2026 12:24:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2dd39be7csm611795ad.3.2026.09.29.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 12:24:39 -0700 (PDT)
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
Subject: [PATCH RESEND] clk: tegra: bmp: remove kcalloc
Date: Tue, 29 Sep 2026 12:24:37 -0700
Message-ID: <20260929192437.27775-1-rosenp@gmail.com>
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

