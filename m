Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F53AFD1C
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217599; cv=none; b=CWeyEhoAwwyKcIa5aCI/zAmOkAe0pmkwW/NwEXh4w/Fm3B5ssjT0IdgoOvIGYVf4PZ/vimyGydOo8dcDvrRF0OfwMoKJOM0frV73r1fN/ICDhuF5OP6YLFpaRTdPqP6W3uufzSmIa6OkHcJgNukB4Vp/f3ApPBOYAV1dDkfL8wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217599; c=relaxed/simple;
	bh=+R+LjFInjA7vyxj+p9DyJ35DmVdXYIIr2T3gPmEFlxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhxRlgBAfup24oY+KwZ37M4PS57sQiRFCPEzFLl+hUpbzGJyiBRh+rJ6Slf/5UvXWjEvirrm9ahiD1csI5BcRAYOCSNwIGJjOFUzkRILXmMiPecW069P1jupACcGxAlMkdAh3dpWyOV5kbe1MFNz6EvaoyrQR5VQ1/olLB5Gr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJa+iHYc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJa+iHYc"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d6b9bca48so62465751cf.2
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217597; x=1779822397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=;
        b=LJa+iHYcOuO7UmgxhESdF1A3p/p9GLOxYoRWs70GT11DKUigMrojexeIzrt1xlCKu5
         gV/im335br1SxY83lJuHxkB3GG9kwJYm3QWxubm7V6RIfW5PisdFwIF/W1vhp+Ifwtfx
         qcft3npId1yqCxQU+/Poi1BikkS3oANz224LlSlRKm7uFQmtbZmwV0zkpo0hutSSBRtU
         vjSgVtorwKBMpW4vT0zNRkfpL4qIIH28RAOTs7pYE66o3j7neW1ADZOA1iuhwCoXXJb4
         fO5b3tGG1YiiyAFMpxB2L+oEESWw9irNUoHdnaYRb2ZQHzpK3qQ7ybKhXBqORtY5kIzs
         zRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217597; x=1779822397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=;
        b=fqxnZyCSKCpFkJdU94fbQICLt1I1uFmf6X5+s+NxlYdiwxLxWM8qdrcM/ufkKVSoA1
         1gjh5t4RYQAHdJ4nvUQ5zy6UcZHvbbK5uDhz5fF2I6qhiUtuwv8xusiY/l9PFeMhhKFQ
         VUPbl3lPqIaebhujXm4TE9Y+L0gD0g7eNKd0T3AMfJVV4IJv+74FF0c9lIkB1TxZ3kOW
         DX+6XI1FtmAODVuZI4ulRMBXAmq8zFNRVyghW7kHeDZUj9IL8nFXsIWdjfiJNUHG1DcL
         hDXnElBRZlrpCu2pW8mV0QN5bF28ov25xWCSoaMwYiGSniGAIgrOFu1ECMJkb1V09oj/
         DPEA==
X-Forwarded-Encrypted: i=1; AFNElJ/xjSF3QvyrWQohtH4aSpurTeROD6OQiDrJ35kMNC/vAXtVoE6PboFEkRkeZ+EZ4oQJzpeZ0fhsaIuC1ta/ZtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPspp4hqnG2PYMVZ9K01b23czfoLlDsWEIUvqrjeCJ1/PATeg/
	REnqfDg6kqg+WTHXnI3NtpV91salG+eZcSDr02ddP1SnF4ztqZks2lG8
X-Gm-Gg: Acq92OHa+/hzsCPBP/c2xxklV/iiVMyKvZ8GAQBhp/5oi6UNBJIffohRAlxJDQC92O+
	mltzDrAoiSzP79EML+04s/1fXznSPmHYZ6P5R7J+hjG13rVB+aDpcYI49FbBR/9CH5WPsSEgduK
	V2mvnT1PBw1bRioPAvHzLiEGsSEoGeBluU+kg55LhT0csZkLBHC82WxanV5XZztcfVL7NCwxlJl
	yApboeQSQ4Zt9ZFtcGF53FDbTgWNSfzb9dFBk+LYu1IqfndsnHl5G7XsVkqCq/xOMABKjf2PxG+
	i4TnLrqohC/EO4vqdLaa0THUh6HpnW8n4LGocYGZ06ATKKfPXzbDhJO98v0UoySnFnlKD9E8Qr9
	P7pqKrMOAAWSawFEI4BqYhTnRDZsT548vSA6dJrkbiFyJjso39sJzEG/adVLcRal7kB+K8/oeyi
	XQ+6aTpYPNRpGztxkSbuXBkQk2zgMBTXUgUae0awzK8y5WD8+D7VUsfjzOdl3IekT2XP4wcZyt9
	z11ntM1ugWslG73Ei6j
X-Received: by 2002:a05:622a:2445:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-5165a03e931mr269170821cf.25.1779217596596;
        Tue, 19 May 2026 12:06:36 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm187088571cf.31.2026.05.19.12.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:06:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Tue, 19 May 2026 15:06:15 -0400
Message-ID: <20260519190615.2761667-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518143706.2808177-1-michael.bommarito@gmail.com>
References: <20260518143706.2808177-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
in the generic FC transport. This is not a local userspace or IP
network path; the attacker must be able to inject fabric traffic, for
example as a compromised switch or fabric controller, or as a same-zone
N_Port on a fabric that permits source spoofing.

The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
counter against the 32-bit on-wire pname_count field, and did not bound
pname_count by the descriptor body already validated by the TLV walker.
A pname_count of 256 therefore wraps the counter and keeps the loop
condition true indefinitely.

Factor the shared pname_list[] walk into one helper, widen the counter
to u32, and clamp pname_count against the entries that fit in the
descriptor body before iterating.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes in v3:
- State the fabric-adjacent threat model explicitly in the commit
  message and clarify that this is not local userspace or IP-network
  reachable.
- Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
- Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
  body length calculation.
- Factor the duplicate LI and peer-congestion pname walker into a common
  helper while preserving the LI-only host-stat update.

Changes in v2:
- Drop the redundant cover letter shipped with v1.  A single-patch send
  does not need one, and the v1 cover carried stale draft markers.

 drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf0..0684d8c69c3c6 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -737,6 +737,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 	}
 }
 
+static void
+fc_fpin_pname_stats_update(struct Scsi_Host *shost,
+			   struct fc_rport *attach_rport, u16 event_type,
+			   u32 desc_len, u32 fixed_len, u32 pname_count,
+			   __be64 *pname_list,
+			   void (*stats_update)(u16 event_type,
+						struct fc_fpin_stats *stats))
+{
+	u32 i, max_count;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		max_count = 0;
+	else
+		max_count = (desc_len - fixed_len) / sizeof(pname_list[0]);
+	pname_count = min_t(u32, pname_count, max_count);
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			stats_update(event_type, &rport->fpin_stats);
+		}
+	}
+}
+
 /*
  * fc_fpin_li_stats_update - routine to update Link Integrity
  * event statistics.
@@ -747,13 +778,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
 	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
 	u16 event_type = be16_to_cpu(li_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(li_desc->attached_wwpn));
@@ -764,22 +793,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(li_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(li_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(li_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_li_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(li_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
+				   be32_to_cpu(li_desc->pname_count),
+				   li_desc->pname_list, fc_li_stats_update);
 
 	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
 		fc_li_stats_update(event_type, &fc_host->fpin_stats);
@@ -827,13 +845,11 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
 	    (struct fc_fn_peer_congn_desc *)tlv;
 	u16 event_type = be16_to_cpu(pc_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(pc_desc->attached_wwpn));
@@ -844,22 +860,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(pc_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(pc_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_cn_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(pc_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
+				   be32_to_cpu(pc_desc->pname_count),
+				   pc_desc->pname_list, fc_cn_stats_update);
 }
 
 /*
-- 
2.53.0
