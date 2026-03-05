Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED28481B1
	for <linux-hardening@vger.kernel.org>; Thu,  5 Mar 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750671; cv=none; b=GofaJLBwS6MX6uGTBu0gzVN0207mMUkqnsSCkqSrGjzsop/NITVKW252oFsaIdg4VQx62+eAoIY5yCJkKfOdSLXodOzO4fZI2k5N7RY84pAzL89RxaXqHUaM5l8u8Y2DhUHNjda8KZnUGvcxj3ywbsAEkRnrMtV67V6Glt1RH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750671; c=relaxed/simple;
	bh=Zwa413fOhFbUimEwOHXOq1zLOgZg0uJm5mtlCImCqQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3w9iYDJDcIaAIaP5lg73SgBqOFZs++ruwPy7K8zQ1mqCKsTHNdTi1VvfjZpCl39vz5EL1yCCOV8y2JGZu+rY+p41Hzga9ClbSkHfTeBZegFTlBAmelm8vFHoOGoC9w9IrdWgDfWTo+aFojKi3LtX/qVWqV3zgerpvr9n5c5pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRdN9Nv8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRdN9Nv8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad4d639db3so39204965ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772750670; x=1773355470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ruj//+N0PDXJjZsC+IcqmIp3UGMkpYjjecZnM6Zp70A=;
        b=dRdN9Nv8xVrjwc68NChlZq6KasvJLdyrnl7pJGP46Ss9G5g4LbI2ABiG8XKXr3to3/
         Eq3GJ/Ou3kxOMv8QVE73PzpLplKh7G5eW+l0mO0PBbIC76XWeC3vmbrNiiTgka4lM69r
         PNffMWb1hev4gv4GjcvqA47RJCUcum0BFg93nZYjN05/5rUP1Cet9Nd8bQgGLidoe2sf
         QwOIoX7YpX1r3V7fZ59LYmqzp4GeP/E2mV79x0qQ/hhnC0Uw74rauIayBcb8VuDwDwvJ
         vCauwY43+qXrHXUHkGQuquDorUVq0CUm4vW+IFfr9UJdH+SeOhnqPtj0PAvLucYtgPRa
         hmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772750670; x=1773355470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ruj//+N0PDXJjZsC+IcqmIp3UGMkpYjjecZnM6Zp70A=;
        b=R7YIODUq7Rx3RBN8F3rjrf7sOHAggz8TfLtEP+6eE9oswgVOqp17CKoHJKRY3RL5bn
         As0UKJB4nMsMIqH68tFfUzmOFA5yI0eW+xDnUknq+N8ZpPaTjWtTY1m0XazOrXojotLi
         OzEzYh1IkfHyizTpPu7dBH8ZhITPzwdui+0Lfp8s5GKRzhOPmp7M2ibhpXGy0GLYTHnx
         n9qbuER5m3VOc0yjfG6+Ec00uO085kPs8HWa2WIgyWMZnsrHJwJzNnIbKVhezj4kybku
         zk9ys25RObi3AHf6FuNANje9CsAoAqIWEi+dx1lxRjsbAV5rHCsJH1YrJWRaxK3vFa6+
         TqvA==
X-Forwarded-Encrypted: i=1; AJvYcCV7HFgckSieAtFS5h+CcEjxuw1g9BNbTpQQwLWJCw1Iyqd6jYxXx64wQmEgg/bMn8eum4n8H2HbQQOOAGGn4QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbWXPz0xe0JTcNL2aHTaPidR3mhFh1u8641V+UAf0CRIQsdij
	EaJO0Wk13ohr3ZqvxC0dO/B7HnyqYY0Oup4wZfWENBlV1/2Cch/s93+0
X-Gm-Gg: ATEYQzynL1UM4oOkXsSDk8aiV4/qI9xrx7hepzCmnRZkI5E2dV68k8xYC1z9NXDrfR0
	Bpw5rfYjDk9m31DxBAPKr0JdNkjuSE8d2RKj+ExsRBODay5/cmmWJslsSwtXkszwEwkRS/LD6RB
	MR/OZwVtHR3AoGlmI0ZBlvQVoPquzrCOcZCMLqWfP9FsZqZAu+p8WvZyQ7eyaSicUAtKUiDhQOY
	BIyCjfrFltpqqB+5o5nIxfDy3/adshiHlKKZe/9/eGHxhYAjYrMK37WSoq44Ia1PrjGGqKX2hoy
	5ssMyYlZMoQ4ul/NphgEx1vPentlR5PrtUgn7Z6kCukRqSvAwxcsx85Wekat7cqkFs5I3mmhZC0
	e0mjnUMwa+hpyLRMJu7a7YzhCJuwACXGcd8n1N0/PXvEROFY6g7CSFs3APH5FBYc4LVMD0Gyhzp
	N6o3ghR5/Kgeq6ky/qmiFLBdNuRpgfrtarfQwGT1YShY6ZcGT5PIxQCA==
X-Received: by 2002:a17:903:4b50:b0:2ae:63a4:3baf with SMTP id d9443c01a7336-2ae8248ed61mr1294875ad.46.1772750669885;
        Thu, 05 Mar 2026 14:44:29 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738877202fsm3565477a12.25.2026.03.05.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 14:44:29 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 1/2] mtd: virt_concat: use single allocation for node
Date: Thu,  5 Mar 2026 14:44:09 -0800
Message-ID: <20260305224410.14251-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224410.14251-1-rosenp@gmail.com>
References: <20260305224410.14251-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler to reason about and avoids having to free nodes separately.

Also add __counted_by attribute for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/mtd/mtd_virt_concat.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index aea88d1c9bc5..33f9a63dd450 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -31,8 +31,8 @@ static LIST_HEAD(concat_node_list);
 struct mtd_virt_concat_node {
 	struct list_head head;
 	unsigned int count;
-	struct device_node **nodes;
 	struct mtd_concat *concat;
+	struct device_node *nodes[] __counted_by(count);
 };
 
 /**
@@ -133,7 +133,6 @@ int mtd_virt_concat_destroy(struct mtd_info *mtd)
 		for (idx = 0; idx < item->count; idx++)
 			of_node_put(item->nodes[idx]);
 
-		kfree(item->nodes);
 		kfree(item);
 	}
 	return 0;
@@ -167,16 +166,11 @@ static int mtd_virt_concat_create_item(struct device_node *parts,
 			return 0;
 	}
 
-	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	item = kzalloc_flex(*item, nodes, count, GFP_KERNEL);
 	if (!item)
 		return -ENOMEM;
 
 	item->count = count;
-	item->nodes = kcalloc(count, sizeof(*item->nodes), GFP_KERNEL);
-	if (!item->nodes) {
-		kfree(item);
-		return -ENOMEM;
-	}
 
 	/*
 	 * The partition in which "part-concat-next" property
@@ -216,7 +210,6 @@ void mtd_virt_concat_destroy_items(void)
 		for (i = 0; i < item->count; i++)
 			of_node_put(item->nodes[i]);
 
-		kfree(item->nodes);
 		kfree(item);
 	}
 }
-- 
2.53.0

