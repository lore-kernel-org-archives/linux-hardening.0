Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E629346F
	for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115035; cv=none; b=sJj4SoEU5QTdPIH3Vm4IojaDNsS+Cvkf+SV8AXz2kMbmwt3+sJE4lqJBsWnLtPUz0hwcHP4+ifR0JBX+q9YxgA1tHdXhyFOVKnZCXYJF8/e4PzT1LK+8WQUNjXiyufmnvypPoukg0luG1P2kasrMdR04aJ5RN8yqDg4Cx6mjQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115035; c=relaxed/simple;
	bh=QKtDY3LLPN0iqcBYUIpG1gwwPfRppvyhEdYgjVlJ5zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arTkqpoFhqFbIj5b6rs3UFCnyR+UfOFyGh4iw/+pY9KOSBPcbr5l1jGI/QJE3vM03TBq0REoQPS9r8TD2W9vbF1TgC8tzyTUkQOsZ0O7pw2vxDVWqG0+FMQI8svU4upFqW0t5+yLP7hV+5ELNNWCHApobMrezkzd/oOgA9o5Cjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYKecKP7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYKecKP7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d876329bbso26250021cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 May 2026 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779115031; x=1779719831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dh1s6OdAS1PfBEWRup+gzc+11JwMqjGvirdDEgh7WY=;
        b=lYKecKP7W3Te7wHyW0MMddxp2um3EqJarRjXoe2OxCM7X+v1VjUAmM5/HR9ubOeBn/
         KjQrJk9xbe/Sq7RdFInMkYffLqEg/oKoZXAEOuTMZXZtG0cvJUWjaKxHtWrY3mdus1du
         o8bJvwyToJgmRiPxmu0ngi6zVpRvZskFL23WfmsWoK2DsN+6+ZitweHsrCXfV0M6/vr0
         Q3CMVg5/k2TvNLDDkgXz7zo4GuMx62icg3Jb0hhxPd8KRtnn7PTjQ8m0oAG5S8+WF7CA
         StEtiHITQbinEtEq9n9ke6Ci1ijMtIiEvE+JA18bkchP/dVLZHh1eEstP/tFhDQgYTae
         1BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115031; x=1779719831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Dh1s6OdAS1PfBEWRup+gzc+11JwMqjGvirdDEgh7WY=;
        b=gNdnqF/t/o5EgnMiw0F14hYL5UI0y1z5u4aavJ6xuSENoYxlhjGLI3j/8kW/8cLvhd
         ST9T1u6ytKGFJP0w+kxo21msSblWZWlKHJZcKDpJZ9/vGelqNIbTDod0Fjwzc4yRXov5
         22Qo3edcu/DeIbj+ce1qsbtF/NnwEZVgtPUUtH786sMwcNKHTsekeltFbMna67Y9gZca
         7GB3qGPrLarmxC1rblDsc85PUb5mWLytbLcQPxi2+o+5QAs1kTmZT610CBAfRmmHzwI8
         5WTlMudLMml6emy62DLNtWO3qcZypCbygkfCfuPwp+mzqTBcMlK76OQQUlN5/R+XixGg
         fPdg==
X-Forwarded-Encrypted: i=1; AFNElJ9sg/nF6AwzbSNqMEOUH07iLCzuRBuJMDMo3aVToYKAbEFDP+RfLM7lRGZeVzeQW9RHXxZBZA78q/SNGv4w1nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6Up7AXW3cINXXkKL9eVKkXHGUYZg+nMiljsY43l0pHsM9yYh
	s8I92U9cJC7NzFFGzaI8VI3hfqyYrIFX73yraU6LNhF0as5XXO9LUW3J
X-Gm-Gg: Acq92OHXxmuNXXk73cc9mcb4XPhgipU3hL4p2hvZsgTA3YL+QFUPafjhpah+lGeU5YY
	kPB7AMg0DvBmQdGWt/1Fmo6fwzyIqnxzdXPzm42qJt1ThssC/rRxRFBRT68hK+MtIcUHwfbdaRq
	+2/08qUNYyPOJ8T7jjEk6/SNpV+y51N1jIX82YdwzMtkCn64HGWTdG/xcjOAo8FSpnptx5+ywBl
	ycNcNPXdpBvOKXwHVtlXHIwEn0m4jejH9kjHKHy5fk4bIkDIJR0LsdIcOw+Eslmbr1SkBQJVYhl
	PjNwoHlwVAe1JYVWjVna19PDQCodkByJVlFWMpYTC/JEmx5z8/fZGhsOWY+v5kgCGhTaJJUGEuY
	tZAdxbBRdwweu6HmuV4yjtInc4vgx/2AZ3Xo3qsphb8r06+1JADlzXZipMjGxzSekLhdD/76+Xe
	nQjhd7l8I5oiEcc0dyOZSMY+mcaI52/5ijEpfGAq7ojiTqsQnfXc7V8L44YYpYXMn7hAJQJp2x+
	/bJ42fHShhgKBKTh96qvHR/JjjqKePSa3+EGWx22hc=
X-Received: by 2002:a05:622a:54a:b0:50b:37a6:e497 with SMTP id d75a77b69052e-5165a2c6a09mr217034241cf.44.1779115031155;
        Mon, 18 May 2026 07:37:11 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm57986926d6.14.2026.05.18.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:37:10 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Mon, 18 May 2026 10:37:06 -0400
Message-ID: <20260518143706.2808177-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518140945.2751273-1-michael.bommarito@gmail.com>
References: <20260518140945.2751273-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

drivers/scsi/scsi_transport_fc.c::fc_fpin_li_stats_update() and
fc_fpin_peer_congn_stats_update() walked the on-wire
pname_list[] with a u8 loop counter against the 32-bit __be32
pname_count field, and never bounded pname_count by the
descriptor body the TLV walker already validated.

A fabric-side FPIN sender (the elected fabric controller, a
co-tenant N_Port that spoofs S_ID 0xFFFFFD after FLOGI, or a
compromised switch supervisor) could hang the FC ELS receive
thread of an lpfc or qla2xxx initiator indefinitely by
emitting one FPIN ELS frame whose Link-Integrity or
Peer-Congestion descriptor sets pname_count to 256, because
the u8 counter rolls over and the loop condition i <
pname_count stays true for every value i can take.

Widen the loop counter to u32 in both walkers and clamp
pname_count against the per-descriptor available bytes
(desc_len minus the fixed body that precedes pname_list[])
before iterating.  A malformed descriptor that claims more
entries than its TLV body can hold is rejected by the clamp.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: drop the redundant cover letter shipped with v1.  A
    single-patch send should not carry a cover; the lead
    belongs in the commit message, which the patch below
    already has.  The v1 cover also carried stale drafting-
    time envelope markers that should have been stripped
    before send.  Apologies for the noise; please ignore the
    v1 cover at
    https://lore.kernel.org/linux-hardening/20260518140945.2751273-1-michael.bommarito@gmail.com/
    The patch hunks below are byte-identical to v1's 0001.

 drivers/scsi/scsi_transport_fc.c | 81 ++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf0..cef0c85693fd4 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -747,7 +747,7 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
+	u32 i, pname_count, max_count, desc_len;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
@@ -764,20 +764,34 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
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
+	/*
+	 * Clamp pname_count to the number of pname_list entries
+	 * the descriptor body can actually hold.  desc_len
+	 * excludes the desc_tag/desc_len header (FC_TLV_DESC_HDR_SZ),
+	 * so the bytes available for pname_list[] are
+	 * desc_len - sizeof(fixed fields before pname_list[]).
+	 */
+	pname_count = be32_to_cpu(li_desc->pname_count);
+	desc_len = be32_to_cpu(li_desc->desc_len);
+	if (desc_len < sizeof(*li_desc) - FC_TLV_DESC_HDR_SZ)
+		max_count = 0;
+	else
+		max_count = (desc_len -
+			     (sizeof(*li_desc) - FC_TLV_DESC_HDR_SZ)) /
+			    sizeof(li_desc->pname_list[0]);
+	if (pname_count > max_count)
+		pname_count = max_count;
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(li_desc->pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			fc_li_stats_update(event_type,
+					   &rport->fpin_stats);
 		}
 	}
 
@@ -827,7 +841,7 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
+	u32 i, pname_count, max_count, desc_len;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
@@ -844,20 +858,27 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
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
+	pname_count = be32_to_cpu(pc_desc->pname_count);
+	desc_len = be32_to_cpu(pc_desc->desc_len);
+	if (desc_len < sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)
+		max_count = 0;
+	else
+		max_count = (desc_len -
+			     (sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)) /
+			    sizeof(pc_desc->pname_list[0]);
+	if (pname_count > max_count)
+		pname_count = max_count;
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pc_desc->pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			fc_cn_stats_update(event_type,
+					   &rport->fpin_stats);
 		}
 	}
 }
-- 
2.53.0

