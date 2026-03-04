Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C53890FC
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662553; cv=none; b=ckPsXgR5gqJenmTgYEuB4RJXfe0mGj4SMZkvseVnqEmqGTgpYBC5dYPaUBhyiYOpiek1bxqDXfB/YAM+X08LzUYIgTUSkC5eaEGetqjbxXu5K0Hy6eJKG2lmyG+pBQ+jDRul3EFxkhhCGGBW2Bt0gKOkHiis2OtAJ2aZipgr9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662553; c=relaxed/simple;
	bh=lo4wY5ljrci9jyi+y6+SkBX2n4ucfM5inr+hJJjPnL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BT7nbXGgeQWSCxfxt5wQpGrKq2fi7swmaikP02gtKswyPAiPjGcS996jBeK11K8nDbOl88PKzkPZ4LKy0rxlwwnzweBJYbHPa9IqYNU1Ut+N/SGwi+vYf5H03uAVj1FlwyH6eO+IbgQBMjYlrTgT3vaUG2bDxLvfolncFj76OkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0xBW/Co; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0xBW/Co"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823c56765fdso3828970b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Mar 2026 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772662550; x=1773267350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CfzrWus7cpldnCjcicm+ZA4TLtGttdNpR4LRwnpAfg=;
        b=G0xBW/Cog140sp4AOIAlduHWjHqaOSr4bH4/z2n7DuTKWofbmA5EA0dtxcFOOaOX9a
         7aksIcvkQsGe10Bl4U/nJp99/deMzTkxDHsgK5CcBMQ3R/j4mnrJi/s/iEwUWpfy5GHs
         gTkPBOTD0gmGStB0nV5svOmiuraXCPG/7l+RWAt7HfGCu3gkbQ8xsFIDt00Ty9NjB9YR
         2UCdMNHd6kRwiCfAM5WwkBmqde0s4V6CxojFw/nCkJGiolmWxr9jnrv4Khe2bXcyGgrS
         jcI7OU1r7/K0ShpU2LtHFG0iQ+tc7Ngp/+3SUFMh3W3XqbdqPb8RRrll86vexnSiNj7P
         nbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772662550; x=1773267350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CfzrWus7cpldnCjcicm+ZA4TLtGttdNpR4LRwnpAfg=;
        b=m+KXdHYdLrkNixu+PUD4rmi0aKFHiWKbJe9wuVp6xw1lRMvnXcXdjpQp9RbTBKSjqi
         JUKPu65l3xCT6xDzCvk4ovSvYBDXydmslZhGZ398oNWaQSa+wFX23ffu6sdf9N/jt/2c
         hEsCRI/MEA9TrWcqd3YgxYYnALv+xfEqAPaeoZgidIiDEn+fVGiax34VI41Z3RJq9a8m
         yMFgD7/cIzyguA38d+X+p6+KocB9dVVr2Jb7yV8oVgudRuWmEIFi8rklHCQA2/GOUENM
         GVswRLvXnWvGgUEXBXRGskdp82QlyiJwYkV7KnOjXbHNyeuu1DEgkBieOa9Rv+D+HH4Y
         RTaw==
X-Forwarded-Encrypted: i=1; AJvYcCUkkAuT6iPQ0eluIYhSilTNbZWqB1PtjIvmW7DyefHpebCNFu+k+E1pA4K8nqshQ+3XlCTUz2z5PXdzWzqYzaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4YaFZ21tx5syWQaZMshwdxrXLR49jb0gZ+jXte6KFYfU4oOn5
	qeKEbFY+86CQHs3Z3CdYaOFS/FeelF+NN6FOAMR1MBFRb7pTiijUImQM
X-Gm-Gg: ATEYQzzv4Pegm4dAj5IP5H2q6zxMeLfFjMGb8rqlcAQKEI6Qb1sA+/PKu88+AGPKFog
	bFuvgiFFrXqPZQE6t2a86ye6Kc0x7neEz4pIJNEsVMpQqUnoWr410NstSZSVt0myQPPADRwx3pp
	sz4u8E8gSEr78cy52ecLAjCTlW9R/TR9EkKOkNurakPDDJ6Y+jUIfQdhcftVBPReT/xVYtB3XJd
	ToEAZM5+oROpBitK2JEsGy5hotkqmdfgkKZlKPT3CMaSQiEQYzMdjHugzpm6oVoG7XoeDQCmcxU
	5v6AcqnVXyg9N3hjQxzSB4i7vmbaIHt6EZPV80RY8uiTpltp+RU7q3B+8ejoqrSER+fdpTfY509
	of1FBewAYNc65rcCsFig5jCshwm5EKKYNu6hLkmpfCm3PHhAbXnk/mbxXYRdK1xv0+Z4idfMf+H
	bG0NwiAfcvZWmMW5h9uWqp/Yy6cDd+c7TbZzGtCZOxxxuXPT88h8KFbg==
X-Received: by 2002:a05:6a20:3282:b0:38d:f6d7:963d with SMTP id adf61e73a8af0-3982e268f33mr3006564637.57.1772662549713;
        Wed, 04 Mar 2026 14:15:49 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa6203a6sm17637399a12.8.2026.03.04.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:15:49 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 1/2] mtd: virt_concat: use single allocation for node
Date: Wed,  4 Mar 2026 14:15:29 -0800
Message-ID: <20260304221530.15018-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304221530.15018-1-rosenp@gmail.com>
References: <20260304221530.15018-1-rosenp@gmail.com>
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
index aea88d1c9bc5..89e223edac6a 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -31,8 +31,8 @@ static LIST_HEAD(concat_node_list);
 struct mtd_virt_concat_node {
 	struct list_head head;
 	unsigned int count;
-	struct device_node **nodes;
 	struct mtd_concat *concat;
+	struct device_node *nodes[] __counted_by(nodes);
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

