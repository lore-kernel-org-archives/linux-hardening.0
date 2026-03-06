Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0501E3DDE
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765709; cv=none; b=IOxPFRztRNJIz76z/zWhKZg/7SaIU6IvhLCwHKhgV3x/m7O3U+UyphdZFTC9VMjcApU0bRtkKde4faR8fy+5BVsx5ezbhGq2Y81bXk6JeVuRCXbWnuWCB3yt3yN/kMzcjf2oq6fX4Zo+F7CV1JXSvXVoFB14s0hzMKd5SI997K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765709; c=relaxed/simple;
	bh=e7/2qJDCMVAD3T4YsscP9VDk8tfbessIs9nGVfSM88w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViiZWCVBiG6ZIK+7VgwvpaO5AFcVaHN85tFDUCn4rDjBA4xoqsMCmOnr+5SjnpK51nTJHBK66VKjpMDfKK8ca0fi5nZ9OChhTI2hwx9AMSZuYkkIy9aVEq2s2pBC1cj1b57IzHs9kW0y5f2A63n8E179idKGrunelFS3/W+XG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1ylFnJz; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1ylFnJz"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c70c112cb61so4770471a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 18:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765707; x=1773370507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=us6gMYtdEgLuXYRfbamznenxb3koTy/q5+/r4uR2Foc=;
        b=g1ylFnJzvZt1GVhsiWOeb/p179un2W8xUlKwNIBGKrUDXdRI4zJJe7QhsIA1n3Xvwv
         EckQvvjcL2TsWZgxAKLA1GnKQ38uVuMbZox+wYdKTF8GavJamSTYZiIXCFCDNp4hk6ua
         YChNK9zqe0ZEa2FycZtkvQtc6NmVbtZl3JmHZLEiMNq3dtsNMDpWkuvjI6VLP+rTMIhN
         tKqT4kvY4/klsLHG+L5RNphkjbZ53B8Z6JWuRAjCfkqQ/Y/KFfTTBDEG954PPcnFsPAe
         qQj3rKciC2Xzq9YKicHhyPAz1V1V0Ns4pyHJ96Q+e047cU7qz5aWu/ZVp64UDg3qDRjf
         urag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765707; x=1773370507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us6gMYtdEgLuXYRfbamznenxb3koTy/q5+/r4uR2Foc=;
        b=Dvwna9uMf7F+QcNUdBiN5siReQQaL+U+qSUD4uAuqTkUK4aKywTRja8Vav1SodQc/h
         Q4MxGyRiAF8ejkWvyCYNr83KkD639kUGTFf7gRD9xw+np2hVNouXrlG5iNaFiw2HJuco
         nzq2oLx2e7i8kiNlNbeI51/lP0KFTDPCXRUlG2y21eXweF0CPZxPc4gy6IT0SS4N6ePV
         wbFPFelpNcNUUc9DLKZnyt95h9zpaKuGS/6D67+ZgVWSeYkU3AlQc5yXI8tRfXmRRSgX
         i69h0Ubbsb/cb0MjZ+EVTfn0f+WqrzwN6TYWnn+N4oD4Fl7XVuDXykf5z22scCVBXvZH
         GOGw==
X-Forwarded-Encrypted: i=1; AJvYcCWqWe3xrQpcHY+OZt4MoVmY1uD4mW0HKJVqOsdpDouhSLpqeYY1Bw/mHRz3yo/r7sraf6j3pUeyiUz3V/m1do4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbvrUbMSFQYYlBxkL/QVaL9+cO41EOrCA1RmYiiJHahcaLT/o
	8lBce/Djsb10zIB3okWZl+jTtBau7JH5ntwsSne/1jLishzrVyEEfs5f
X-Gm-Gg: ATEYQzwDRO3LF+SZk2yKrROwow0WrS64Bp8ugeNS0Mo2Ru5qv2AxGsyov29MRg8cZZp
	G4DDx9jv8gmH1ZsAVfNXxZgsWLCTSGwrPlCD7EJoCxxdVLR7Y49MnWRRLnmlJi0riYBbvWthLqx
	rSPz4RO3aLRNaBlQbVDmLLLXV7WF1t9dJzl2j/NbtjLhS8BF9EKhNaltKLcp2uArGB4SoNkUTll
	byt+gyOssr/NtVIWurAdeTT1RKokgXmMBJVUCQHL/1rv1zQXEQkOavJiq9nS7i1JBrRe0HCy3bl
	Uvlcw8LQyZkAIukdkO1oD3fe5HU8ZfvGSI3R5aNOF4vSiE7cbV0njm31Q/FUF/4Zazas22B3QA7
	X9N4jrwMPZPbq/x7AHiJc5W2kncSHhWvPVfA3oXIB2hmUmNipLta7timvhu8u+dmBSUuZBd3II1
	XJvLiaz/sUgQ1ckM9oTaOV+9SqgRIQaUTXJHWXGj2SQ2BLl8B0LiVb+JOAWXKIDhSEWg==
X-Received: by 2002:a17:90b:2792:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359be3861e3mr482876a91.26.1772765707486;
        Thu, 05 Mar 2026 18:55:07 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c003bd46sm109309a91.4.2026.03.05.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:55:06 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
Date: Thu,  5 Mar 2026 18:54:49 -0800
Message-ID: <20260306025449.12333-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combining the allocations simplifies things, especially the free path.

Remove ofdpa_group_tbl_entry_free as a result. kfree is shorter.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 31 +++++-----------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 50ea5f9ef63a..66a8ae67c3ea 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -104,7 +104,6 @@ struct ofdpa_group_tbl_entry {
 	u32 cmd;
 	u32 group_id; /* key */
 	u16 group_count;
-	u32 *group_ids;
 	union {
 		struct {
 			u8 pop_vlan;
@@ -123,6 +122,8 @@ struct ofdpa_group_tbl_entry {
 			u32 group_id;
 		} l3_unicast;
 	};
+
+	u32 group_ids[] __counted_by(group_count);
 };
 
 struct ofdpa_fdb_tbl_entry {
@@ -1059,19 +1060,6 @@ ofdpa_group_tbl_find(const struct ofdpa *ofdpa,
 	return NULL;
 }
 
-static void ofdpa_group_tbl_entry_free(struct ofdpa_group_tbl_entry *entry)
-{
-	switch (ROCKER_GROUP_TYPE_GET(entry->group_id)) {
-	case ROCKER_OF_DPA_GROUP_TYPE_L2_FLOOD:
-	case ROCKER_OF_DPA_GROUP_TYPE_L2_MCAST:
-		kfree(entry->group_ids);
-		break;
-	default:
-		break;
-	}
-	kfree(entry);
-}
-
 static int ofdpa_group_tbl_add(struct ofdpa_port *ofdpa_port, int flags,
 			       struct ofdpa_group_tbl_entry *match)
 {
@@ -1085,7 +1073,7 @@ static int ofdpa_group_tbl_add(struct ofdpa_port *ofdpa_port, int flags,
 
 	if (found) {
 		hash_del(&found->entry);
-		ofdpa_group_tbl_entry_free(found);
+		kfree(found);
 		found = match;
 		found->cmd = ROCKER_TLV_CMD_TYPE_OF_DPA_GROUP_MOD;
 	} else {
@@ -1122,14 +1110,14 @@ static int ofdpa_group_tbl_del(struct ofdpa_port *ofdpa_port, int flags,
 
 	spin_unlock_irqrestore(&ofdpa->group_tbl_lock, lock_flags);
 
-	ofdpa_group_tbl_entry_free(match);
+	kfree(match);
 
 	if (found) {
 		err = rocker_cmd_exec(ofdpa_port->rocker_port,
 				      ofdpa_flags_nowait(flags),
 				      ofdpa_cmd_group_tbl_del,
 				      found, NULL, NULL);
-		ofdpa_group_tbl_entry_free(found);
+		kfree(found);
 	}
 
 	return err;
@@ -1166,18 +1154,13 @@ static int ofdpa_group_l2_fan_out(struct ofdpa_port *ofdpa_port,
 {
 	struct ofdpa_group_tbl_entry *entry;
 
-	entry = kzalloc_obj(*entry);
+	entry = kzalloc_flex(*entry, group_ids, group_count);
 	if (!entry)
 		return -ENOMEM;
 
-	entry->group_id = group_id;
 	entry->group_count = group_count;
+	entry->group_id = group_id;
 
-	entry->group_ids = kcalloc(group_count, sizeof(u32), GFP_KERNEL);
-	if (!entry->group_ids) {
-		kfree(entry);
-		return -ENOMEM;
-	}
 	memcpy(entry->group_ids, group_ids, group_count * sizeof(u32));
 
 	return ofdpa_group_tbl_do(ofdpa_port, flags, entry);
-- 
2.53.0

