Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5F1D0DFD
	for <linux-hardening@vger.kernel.org>; Wed,  7 Aug 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024849; cv=none; b=J0OLNtIu48FJtBSfX97UcVYeBmxcuYeV2/NxqwnBUwtLn2f40sDu4Uzy2wCsoD0eq6fQAfJtxj9i3esNaMIYGPJSIPgL7aIJW91/MDuDWa4WiBmh5ZTIri799piZmxCNB/3n62tv3iOTbYY69C/X90AZq50emNewW3F2NioAVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024849; c=relaxed/simple;
	bh=JFeEg6KS1tps0Hdi+bU03Q7DXumXvmBP/um59ZL2G9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8iE5b2Ko6AeGyydVxJ+S/pwHGrccy6KWQdbshAevyXh4fC/AM2Qx9uKDnot5tg11SBGs6/+7tC96cbNHkc4SVj6DcaKnGLS0XzLjo36X3N/Nro3hxYsLS7pGvbiCAqBHI9gBuCHBl9IRFPa3bGBe5q4S23kRFHuU6P3Ml5zwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ad+i+6Wj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ad+i+6Wj"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so119192366b.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Aug 2024 03:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723024847; x=1723629647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DP4grgcwBnNDkabKnZ/UoFhQsHN4IHhDNvWB2Kwa3HQ=;
        b=ad+i+6Wjp/W+GrsjIeQXGUpHDjM0IHW3NXIu4YGc2vDcBTAZd5cNQ1IDNjg3l+9Eam
         Mx5aWVzsWYePeBs1eLlB/5CAoBvUA72ppHZr6RtPl1d0zpe4SOUrccrQ2I5Iu2pRD62o
         mXOp8JJNzD0ZVwlmbzAUfTEzPzIDf8KGugPORlQwK+7Y79sjILM9uvu+jzZthsoeKX0y
         aTU4AuALdRos80QzmHpo+J0zJyMbahiKiQ9txrgm2c9b3dK7EuuRzSbgu60suTENU1z8
         B+dFaBQOG26DdPChrz8a1nTZPvRpvwJr3vvz9GSYEw7nWREfhRvHL3Gatv9O3Jm6vgvA
         /vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024847; x=1723629647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DP4grgcwBnNDkabKnZ/UoFhQsHN4IHhDNvWB2Kwa3HQ=;
        b=HyzgC6NAiOOOZelrnQbaz7HLYeVK0cq2EBFzXPYsHE4zJ8z5q+mc+S18ShMaIOnf38
         yd9tX03XpAFE6Nb9ICptx1sIUTqt6xQyl1UMqGBE7m9Ec/qWrRZpQYQP4zfGr+/zzzKZ
         z8NNm84AjKFErqi3fKHzjxfZ7jxu/QfxFxm2cfaMhGWyEet3HyezCy3Yzedf2zihe4lE
         PHZjL5mlZ7NAJoEwfH3Nddlwe8gHV1rQmUYfIayWNge2yATx1kq/UPNn1zq6HFcz1yYo
         X1TM87AWDp9GHbp7YVADt4pN7gjAKloVBcwXdBAS0EQnodlCsu3vreRa9CS4JrR7iQEJ
         8g3g==
X-Forwarded-Encrypted: i=1; AJvYcCWeormh85JiabB+KhR88b/nQVi5IHLSwyPzri/VJVukcxlNVGz/Pq83/+ZL5bEUg7K+brIxPk8ypWmQPnm6MOs7qH3XiA6JaLaBM7KajQW3
X-Gm-Message-State: AOJu0YxNf+DqIAIsyzULTGYf13qXSmT5X91MhNy+Quh2lZ9m3ik0Pqbx
	/ZIEqHlgE/4v5x5VdGU5wrBYTd7Cma4wt5FjB3AXBEacJ3ZQoaGetvBow9BbH+Y=
X-Google-Smtp-Source: AGHT+IEKOsNBlWol3pZuzwoRWU5Ks5wtno2ZLUGOAKgnsV2/zLCuNitPlkJsmivU+bMoZuYZaD8oqA==
X-Received: by 2002:a17:906:fe06:b0:a7a:a33e:47bf with SMTP id a640c23a62f3a-a807905171fmr121374166b.18.1723024846497;
        Wed, 07 Aug 2024 03:00:46 -0700 (PDT)
Received: from fedora.fritz.box (pd9e1640a.dip0.t-ipconnect.de. [217.225.100.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de4e7f336sm492467166b.131.2024.08.07.03.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:00:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] rcu: Annotate struct kvfree_rcu_bulk_data with __counted_by()
Date: Wed,  7 Aug 2024 11:55:00 +0200
Message-ID: <20240807095459.1400-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
records to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment nr_records before adding a new pointer to the records array.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..76d8d75dd8b3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3227,7 +3227,7 @@ struct kvfree_rcu_bulk_data {
 	struct list_head list;
 	struct rcu_gp_oldstate gp_snap;
 	unsigned long nr_records;
-	void *records[];
+	void *records[] __counted_by(nr_records);
 };
 
 /*
@@ -3767,7 +3767,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	}
 
 	// Finally insert and update the GP for this page.
-	bnode->records[bnode->nr_records++] = ptr;
+	bnode->nr_records++;
+	bnode->records[bnode->nr_records - 1] = ptr;
 	get_state_synchronize_rcu_full(&bnode->gp_snap);
 	atomic_inc(&(*krcp)->bulk_count[idx]);
 
-- 
2.45.2

