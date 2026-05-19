Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B82F9DA1
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155933; cv=none; b=p6r4zw6USiFuAg7YwGZKWjUz3ruQVBDLlPlxTn5Ws+a79XiSc/dFIo872RfCiQc5/Id2jbvTXNwcl9VG+9OVCDszeL1pVggPh+8BnjUEc+mx/BBUOM4wei+MfHpzDp9w0Q52wXf1KOOwwOwbgroN1o2whd0pA2pwLqG0lJKiNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155933; c=relaxed/simple;
	bh=o9tpwTNBKfUuronh2IiA7Q31eMmatIzAB4cU4aq6YU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIWYg+QUxqXmWvmQyBg0k2QGxwWOa2pz75GSAG0LsNzPkYuMtq46Tn5ppjuBHyXtGkHh9uva3itVFqY3EUV1uX1scd/WOPGpyhSQiTfH1B0pD9/16x9LrxOz6AKTuotM/bF5dQtdamrMtT5sYxFJP41IQvIljB69s7s/Z7VHO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFtwA/JM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFtwA/JM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3698e34a567so2451898a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779155932; x=1779760732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJBOwsmVOS7e0w8Q9mvj/KZhpczr6xeaK0EFoTPkDf4=;
        b=GFtwA/JMJRHL2m89MeRU6sYFKKNU00eqY7jiPwOPGNaBTmqhARmsVHtRRH0o3w0KCr
         VsrhyMx1OxWfgHgSTHurPIUlyYxtu4TKX5pEx5Z0o7a6mZ0hjmAXCQv5GmZBMx5TBdjN
         5yOBH8SubWLi/gzQfpOzUM6PwAlx6YCYwmN5QLMIDSE+LHJY2Nz8EmNOM2b3K4t7MNKJ
         ZwWaEmACh8VyI7dIvC6DWZb74TmZT0UC/Kp8Lbg0/0tUA3qtkShBsrQozX+nNOzf/HZt
         a//YBa/yBVP1FayFjWcvma8GQSlYtuCGUaYDiwXn+CHwmi8wcxDYfq/refyNseze9LxG
         PbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779155932; x=1779760732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJBOwsmVOS7e0w8Q9mvj/KZhpczr6xeaK0EFoTPkDf4=;
        b=gAsIgSq/mhiwMbWMvNGVhRF62aRIp5wKYRqrtLMj4AaD223vcF6PGI+idx/0z370Fa
         b1vIbaUNJ9TOzxUNaTZJJyz/uzQc34g6lmM79W2da7JzLkzrMLIaYmKmImVwL9F6Ca34
         YTuypDmg0++bEgUfdt3XYWlqcwN44eJvsqDuphggQ+SmA99tWOweOLGCAljdtlOIFg74
         J2lVqdXY/yexIpxvAExHDNM5CHZ7yMf9qK//zVJraIo4Bonbgxh5exXwsdY7QJWy4lkR
         7zjre2DtjlrhS24HtbgIr3erFvzCZuEg12/XgJDQfgYijP3u2o1wWGQd0IY1Q3S2UZ0Q
         OpXg==
X-Forwarded-Encrypted: i=1; AFNElJ/McTBDyqRw7Bfcchp1n5EP9bM5paoEzmYJ+3cDczStzMwFzQqdoopNIMft3H2zvmOHSVVQD0qch3qFxP11gLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3yvwSoNgALbCKVgZFd/iPDeuZ/RFNRLcgadwAxTXYbyp1dhW
	UujPHSpN+Bvp816WmRYPIZgDLyzMHXvKlTLSxSubTh4JBgAxb/U9AJhY
X-Gm-Gg: Acq92OGq6iTQUT90dPhBkzPjeZ/R1Byqf4WY7ZK9F2uvPsvjIq7pwOfPF0W4ZbyFXjo
	4nGBZ3xf1c0ejHlWiOfoMbWWP2dQknMSvL+RBthVs7BnhDJjveTW9jAdB1B39mW8A29vCSwToVY
	MuTzBNJ9QuVqvTvLs1RdxQgq1+cb2hOKUpTjmn2vNWDPtKnHfwve1b6Rw6RNntPd9ib6SzkdPqY
	V/gX6HbGVlw7jHINWgMQd+nFXlYl/mjWXRgsWYXxw4J8AuZx5qzONPYrDRoROnwP8ppaVLxhlYe
	iEJSQg6eoxZDP3IbYKSHtqIaLTtshYg6O2yu5PEo5z5CHC2TRZpBI0dUuL/PYHFvqBzDSpAhdW+
	/XLUZPkGboimLsEXJoe3322dSucNM3nzL/5MEX2oSvUiKJpZPiPut948rJ48Nles9Fa2dWubC4i
	45VA4RANbsfuJoR82zhkFPXwpeTYomiOeWOtoI4NIhveumhRgI7XUeG9/kSsqEIHRjliSQ0U+y2
	smWKh3Pzp316HQAkTkP0xuGLeOT+OaVE6c=
X-Received: by 2002:a17:90b:57c7:b0:365:7e4d:bcb8 with SMTP id 98e67ed59e1d1-369519cdb59mr16915705a91.1.1779155931783;
        Mon, 18 May 2026 18:58:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm12016286a91.0.2026.05.18.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:58:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] lib: objagg: Use flexible arrays for object storage
Date: Mon, 18 May 2026 18:58:33 -0700
Message-ID: <20260519015833.634602-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store object payloads and temporary graph nodes in their parent
allocations instead of open-coding trailing storage or allocating the
node array separately.

Use byte-sized flexible arrays for object payloads so kzalloc_flex() is
passed the same byte count as the previous allocation sizes.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 lib/objagg.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/lib/objagg.c b/lib/objagg.c
index 23c7105a3f9f..995ec67fbc2f 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -28,7 +28,7 @@ struct objagg_hints_node {
 	struct objagg_hints_node *parent;
 	unsigned int root_id;
 	struct objagg_obj_stats_info stats_info;
-	unsigned long obj[];
+	u8 obj[];
 };
 
 static struct objagg_hints_node *
@@ -66,7 +66,7 @@ struct objagg_obj {
 				* including nested objects
 				*/
 	struct objagg_obj_stats stats;
-	unsigned long obj[];
+	u8 obj[];
 };
 
 static unsigned int objagg_obj_ref_inc(struct objagg_obj *objagg_obj)
@@ -369,8 +369,7 @@ static struct objagg_obj *objagg_obj_create(struct objagg *objagg, void *obj)
 	struct objagg_obj *objagg_obj;
 	int err;
 
-	objagg_obj = kzalloc(sizeof(*objagg_obj) + objagg->ops->obj_size,
-			     GFP_KERNEL);
+	objagg_obj = kzalloc_flex(*objagg_obj, obj, objagg->ops->obj_size);
 	if (!objagg_obj)
 		return ERR_PTR(-ENOMEM);
 	objagg_obj_ref_inc(objagg_obj);
@@ -657,7 +656,7 @@ objagg_hints_node_create(struct objagg_hints *objagg_hints,
 	struct objagg_hints_node *hnode;
 	int err;
 
-	hnode = kzalloc(sizeof(*hnode) + obj_size, GFP_KERNEL);
+	hnode = kzalloc_flex(*hnode, obj, obj_size);
 	if (!hnode)
 		return ERR_PTR(-ENOMEM);
 	memcpy(hnode->obj, &objagg_obj->obj, obj_size);
@@ -705,9 +704,9 @@ struct objagg_tmp_node {
 };
 
 struct objagg_tmp_graph {
-	struct objagg_tmp_node *nodes;
 	unsigned long nodes_count;
 	unsigned long *edges;
+	struct objagg_tmp_node nodes[] __counted_by(nodes_count);
 };
 
 static int objagg_tmp_graph_edge_index(struct objagg_tmp_graph *graph,
@@ -786,13 +785,10 @@ static struct objagg_tmp_graph *objagg_tmp_graph_create(struct objagg *objagg)
 	struct objagg_obj *objagg_obj;
 	int i, j;
 
-	graph = kzalloc_obj(*graph);
+	graph = kzalloc_flex(*graph, nodes, nodes_count);
 	if (!graph)
 		return NULL;
 
-	graph->nodes = kzalloc_objs(*graph->nodes, nodes_count);
-	if (!graph->nodes)
-		goto err_nodes_alloc;
 	graph->nodes_count = nodes_count;
 
 	graph->edges = bitmap_zalloc(nodes_count * nodes_count, GFP_KERNEL);
@@ -825,8 +821,6 @@ static struct objagg_tmp_graph *objagg_tmp_graph_create(struct objagg *objagg)
 	return graph;
 
 err_edges_alloc:
-	kfree(graph->nodes);
-err_nodes_alloc:
 	kfree(graph);
 	return NULL;
 }
@@ -834,7 +828,6 @@ static struct objagg_tmp_graph *objagg_tmp_graph_create(struct objagg *objagg)
 static void objagg_tmp_graph_destroy(struct objagg_tmp_graph *graph)
 {
 	bitmap_free(graph->edges);
-	kfree(graph->nodes);
 	kfree(graph);
 }
 
-- 
2.54.0

