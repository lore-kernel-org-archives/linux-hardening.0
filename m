Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6D3C3435
	for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861692; cv=none; b=H+PXtk6jaHJVsl5sgo2bkUg7WptIBFKp9f1vRkZrZIvtkUEEOn5DcbP6lOUw1Xk39e1KMEdl+bQgbaqpDRXmrE1+V3Cerj/iCZG6OKElSiFxzzQBzrM0J7lR4k+JCLvj2d7A5xI+qumdJZFv0rronSAYGDc78Dyb90rsXn7TXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861692; c=relaxed/simple;
	bh=GDi+SP7TojNzy5Hpcz7mVRnWh7BjfImltYSEk3/gEK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBGpxSF9s0Ezau0BYRjVv9aLmJO70DngHZUhVkzXsfx31nLlwB1eDp7blh7B85So7peUvG98RwfzglnzdCOxj+bBCa+O9VLC1DLe1wM2fpXIFhfiT4r0nz8Zsrqi16A/yyE6jVGxv2yaVfoNKgrcGNUEdli/yYEKsE0p/Lxb2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACshw3Ka; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACshw3Ka"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab46931cf1so11114085ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Mar 2026 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773861690; x=1774466490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPQGa+9XMA5plq4J8pHqZnzGZoUGgCAorDU5naqXgW8=;
        b=ACshw3KalYW23q6WdmUHkzmnJreui0bfPWyKv3R3X/wmEpam5Srbkj0VdgQT1QdHPr
         0d1beZ2YyuB1uDvLCZKUyrP7+TrzYzpr8dDI75VYyOPd8SWgbh8DdcX459mQj/5Lwgrt
         LQ47XE5j3M6F+sCszpqypB93dFPo1VSsCJ660V3ClYjY52MTmA4HefqSe5EEIt1CROKD
         86fywP+u/fQKpKjnzg45Ltky+TgHE6E4y8nTu6BZCYW8PjZCEXwxsnfAvoy5/LMuxG41
         fncjgDQJCamU7OEQjeM+aEqNuC28YxBI2MZar7ghjtYKvusmYNpFUUA93bYiwu9MEcNN
         SSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861690; x=1774466490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPQGa+9XMA5plq4J8pHqZnzGZoUGgCAorDU5naqXgW8=;
        b=nLwdVOO4cLYqT3/vWzvebniWbAVv0BnEsn2MywzB/dyY/BJrbj0Rr3iQ9UbMuwJSrQ
         TYDjz4H1Fq9I7pICDCtBCtokwHt9PIWlVC4g1UCF4TteDWhFV47OHm03Sn5qufOO/+cv
         x4Sbn6t8l4vfnf9rRRSg9EgNUqj1RdpP1tqoid42AFwy/vAFVLNCx5ZmIfIwQM/2iWLh
         AME26AXl5g3GI6TljBNILqnAKbgW4B7cNM9Ey5nhWlCnUxWcr8b8Fq6uMMATlLvpwKbI
         jTR7xDDKe4p3GIGnDFH74g4U0zXzLqB0eawvuqz78/5ZRdi7OfHYNtQAtfpBGCRWGWSJ
         Qpnw==
X-Forwarded-Encrypted: i=1; AJvYcCXScZn8ch8kgX8RL/Iuv4pt58MG/YH+Xv3RHfUGT1goVwz0aWVRvgzxS+ksvQNYCEtvPcWS+6OJLmMvzSu0Aw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImacSZ67cQ7Y0da5+l+Zdan25cuyg5NER4u4/+yDOuKvzLoHA
	lxEQb85j7gLYy55xb+h6eF0btn+VCOxdDIM4cfnSRTT/BR0o3DsBaTjF
X-Gm-Gg: ATEYQzy92QLdSljPe/SlcWTAzdJr2Twn3m1C2ibnGPwUSGZYuRV5jGxPFrl8xF9yhr+
	GxQIEs2QVTAguUq6UxUSsIGPVjeqYEuOJcZhUBWszWXd6iapEY+T8D8s9uLhpcLhvz5TdoHMbje
	TaQPYc2wcAVMFyAdOGWazySEGZoOwmTKxmVL+QaA4HhLIRfvy74iO6Ezmfg44FCAwfQnkEKquyJ
	2wOrtI+GJDJbp27VMUdh31vMFwwSlU2AHAdUU3aH0WxPvpm5nJFg9SkLbvaH1L55EPsCjHYouH1
	7Z5qhxD5Kjz2XXLsSZpVicsijmjccrV80moSlGannpCYx3XKsJR7heGQ+IF0U9NX/cZUFmJPL9o
	mlnivVYreGMDxBUNRkTKJ7N4qqNRuXW6d6JjoBlKEJ2gulT6rbSXxtOxFpb/RgxJQfh13l7aqvv
	c0RJXuQoLeHL1IltHGfDpFDvPTjfIftMeVmowjRlkzSf/Uf5wU2PaU/4HXZGhCyrECPA==
X-Received: by 2002:a17:90b:5547:b0:35b:9d0c:a2f3 with SMTP id 98e67ed59e1d1-35bc606ff0emr476139a91.15.1773861690455;
        Wed, 18 Mar 2026 12:21:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63204f2sm409269a91.16.2026.03.18.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:21:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Elad Nachman <enachman@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] net: marvell: prestera: use kzalloc_flex
Date: Wed, 18 Mar 2026 12:21:11 -0700
Message-ID: <20260318192111.6802-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member in this struct. No
need to free separately.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../ethernet/marvell/prestera/prestera_devlink.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
index 06b876f6b27f..9c043cddb0f9 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
@@ -125,8 +125,8 @@ struct prestera_trap_item {
 
 struct prestera_trap_data {
 	struct prestera_switch *sw;
-	struct prestera_trap_item *trap_items_arr;
 	u32 traps_count;
+	struct prestera_trap_item trap_items_arr[] __counted_by(traps_count);
 };
 
 #define PRESTERA_TRAP_METADATA DEVLINK_TRAP_METADATA_TYPE_F_IN_PORT
@@ -451,19 +451,12 @@ int prestera_devlink_traps_register(struct prestera_switch *sw)
 	struct prestera_trap *prestera_trap;
 	int err, i;
 
-	trap_data = kzalloc_obj(*trap_data);
+	trap_data = kzalloc_flex(*trap_data, trap_items_arr, traps_count);
 	if (!trap_data)
 		return -ENOMEM;
 
-	trap_data->trap_items_arr = kzalloc_objs(struct prestera_trap_item,
-						 traps_count);
-	if (!trap_data->trap_items_arr) {
-		err = -ENOMEM;
-		goto err_trap_items_alloc;
-	}
-
-	trap_data->sw = sw;
 	trap_data->traps_count = traps_count;
+	trap_data->sw = sw;
 	sw->trap_data = trap_data;
 
 	err = devlink_trap_groups_register(devlink, prestera_trap_groups_arr,
@@ -489,8 +482,6 @@ int prestera_devlink_traps_register(struct prestera_switch *sw)
 	devlink_trap_groups_unregister(devlink, prestera_trap_groups_arr,
 				       groups_count);
 err_groups_register:
-	kfree(trap_data->trap_items_arr);
-err_trap_items_alloc:
 	kfree(trap_data);
 	return err;
 }
@@ -594,6 +585,5 @@ void prestera_devlink_traps_unregister(struct prestera_switch *sw)
 
 	devlink_trap_groups_unregister(dl, prestera_trap_groups_arr,
 				       ARRAY_SIZE(prestera_trap_groups_arr));
-	kfree(trap_data->trap_items_arr);
 	kfree(trap_data);
 }
-- 
2.53.0

