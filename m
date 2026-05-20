Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AA1531E8
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283835; cv=none; b=d3WxgXcjkd6breExIOOAmPEU5c7GOIYmwddjcSQNdJpCpL2nQKbxoHoEyHc5w4BxkereIZHr1tg9VHKtyl6Z+5XW9PwGwP2TM4E78T3WeYjqtN1eoyjEEGI07OxuIRhWKINaqbxschC6bBJ23wTTg8soKWU38FkO0gmXYhxNX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283835; c=relaxed/simple;
	bh=81dImCBjpgJ9s4r5i5sIJwiSPnwM1ab60Dzuzfby04c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXksFFAEPPUCqCxjdvb8m7PyiQcJApCq0dpIL+io7YnuyZMa2dgColoDIGa87OWWLDQ893Cw2QemKopQYw/fs+vVzVNrtL6dBPvmCWgy0Jmz//6bLApq6cK08vQnZuDZQUOsFmMB41w6li5Ul/8e2GhM3ur+mLOcXQNlehp08yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOpYCRup; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOpYCRup"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so64357926d6.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779283831; x=1779888631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfxhCV7FuEx6FN3Ph695dMdjOoXCIAnanxO/gTjt8nU=;
        b=FOpYCRuprODo33/HyCjs8joQnos+gJQaUW6l4A7Ej35E9OtHm5kCkFjzHchy4Clsta
         dYPQkWUwruc2TgKdD4VOpwFmpHm9RpelzTCb11FPS0WAKR8J7B9QMz0VnP+5dsRCBJri
         Gew4AknisCfYMmrKEIctDlRcPz6o/K5W1vzNNq00PYg3aUd3xj49Pty9wq2OtY/h30cU
         I1yTYGpzJnA/XzMka68sCqlYZkqE0uFYi7gxejMr38vL4RMMATou0iAphOLlZfVDoijQ
         luWBEQQnPVa5bHr4X9xDxU4mMyEIPoBXmrKu0tGKEVc8KZV4N8gVM4Ub69YDqr09dj0c
         WygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779283831; x=1779888631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfxhCV7FuEx6FN3Ph695dMdjOoXCIAnanxO/gTjt8nU=;
        b=ZHIuryVxuHAaDj6rRA2KXpZ9Dq3Mw6DX5ggnbXUgJ1A/bayNObaBFWziPelCoJl2ja
         poJvzZhOPD3mnLQEU4EkEgfP7zhZ0lwR0dujiZieqvIc/rNyRVTaIFbBK8P555ckY3+d
         sqaS7Tdh9AIAQKmojfPP8C5AkUVn3S/8WMEiRlMMB//S1T2aoww82UNTbTcexDyOY2ca
         DLwRH5Nx9TLFoUuOlt7WrOg55KAMOLM2Wv8k2NQHxrDJFedjIvS2v+vZYmv6xliyvpoK
         f/eQApdIpGDkTMEoM8ubb5r5IK23pgTEntmUjg1abLcNwtq9QAh9iH8+8gVwp40pNT4W
         vx0g==
X-Forwarded-Encrypted: i=1; AFNElJ+hJw7SyBswK3kemde8y1dhHkFoVFkl9JvMdXAebowOy4wBm2lIHrKjfRg3l10r4PRymv2Vb+ebKdBfOzrBbZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3VMzDgSEmNRscEI0zRDEHnX0CZ1Y5+zyyCb/7cMaNXrobQ9g
	eho0niqCB/SI5uIcQGnZM3tCRaA+D6Jp4fxXsbptgIjfRgfwqy0uSzMG
X-Gm-Gg: Acq92OGcgwjm1suCmOc1QXlLIMQ/7d6EE1GeI9dPbpvAGRhbTikgdMEMwq2uJNv2l6M
	7GWiFxzIARtFFsAhNDusq5Nd8WgDv0oH70dkZazSRjTVr/xAPUJA/eONl/h/syb701wJPPfdqhk
	Bl/UU6uxmMtiremB3/btYqcFCOHv7x1gd1+rVXKMo0NMVnr/3Mk0FqVwdcVvllBzipE4YZ5qhPR
	kC9D8se+JC6wVMj+gEVA4Ggd1CUg/m1SPNeOEpQLY1eOfZ/v71NqtxMm1gLXd7pjPj85DcudIdd
	Ro8th/dITToEhEFJWfx5+VTLj6zm9+svpj6BtL1D42VAbP3ivtLGElNs0fKcmiDJEYFyAky3usB
	/AnE2ACAzyLREK5oeU/4UXKGgeKc+Q+jX2ftl0wXFXqjU+pPGyEYz8p3826Oxk+qsmcjVs3dwC3
	948HZGEEn0NRvM8T0H707IvRt2od4WYdIqCd7B4ayYOKLooPrFODamF+h8W1wYaaBv+rj9bmOTT
	klKCfsc1PbgKat/aN0Y
X-Received: by 2002:a05:6214:5548:b0:8ac:a546:7753 with SMTP id 6a1803df08f44-8ca0f601c85mr373645396d6.8.1779283831333;
        Wed, 20 May 2026 06:30:31 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36190497sm121635816d6.29.2026.05.20.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:30:30 -0700 (PDT)
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
	David Laight <david.laight.linux@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Wed, 20 May 2026 09:30:15 -0400
Message-ID: <20260520133015.1018937-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519190615.2761667-1-michael.bommarito@gmail.com>
References: <20260519190615.2761667-1-michael.bommarito@gmail.com>
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
Changes in v4:
- Use min() rather than min_t(u32, ...) for the pname_count clamp and
  fold away the temporary max_count variable, as David Laight suggested.

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
index dce95e361daf0..173ed6373f04b 100644
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
+	u32 i;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		pname_count = 0;
+	else
+		pname_count = min(pname_count, (desc_len - fixed_len) /
+				   sizeof(pname_list[0]));
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
