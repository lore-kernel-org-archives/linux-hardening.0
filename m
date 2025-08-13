Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1D2FD7AD
	for <linux-hardening@vger.kernel.org>; Wed, 13 Aug 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115740; cv=none; b=It8NflB8JK2EjptNAc0z3drFUJnwE2lId1aFQbHbB5KA9CYpg0rSnM/YcnoAEp9I6dxiTVfA0VikhNFKm2q3t+DZMPWcfjpA3vvaiVsRVQVQmJaZD638LDSLV9WaOV9l/D1X0Sew1O0F1cnir0A43vyppZ6MRu6oqpEmT7mGUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115740; c=relaxed/simple;
	bh=1skY21SIj71xIEw/Mi4zbMqQgNac/OYdQ2LiQJTQRXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+gm167ySOOrifXQGA/i/StWBnB3nRWvtYj7xAZABc/S9iI4ahXET2awaUZPNoQMhEUz6NpdzKLqdHZteE6+lqA8SU5+QG6fwgbyu4NmRn4zfw9c9aZC/WRp7Vh2lEiW+W49cWMmkQMbrNlfxRWLXeUq+S5e3jrl5WVNDOyIU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFYnVjqt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFYnVjqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8TVetdancKlSFrfJSB6yQxe4MFxTONVgMPDkztUaCk=;
	b=CFYnVjqt3yuMMXSfqlFl/rMOSUqoR21gHN7/O5LzHDWYq+QVUnfhag79rtXcGCfwypQXg/
	wyIPWyXY08qeZ8+RjiYh+YBTGpe3vwXM7nYWt9L239YesSM1JhmqKuYR+HkzB9Gtq2N1Fu
	Uta7WCBPkkWcILjvhRkql1RnKX3ZnIE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-N8_2nS2bNFqZBOD4IFl2Sg-1; Wed,
 13 Aug 2025 16:08:57 -0400
X-MC-Unique: N8_2nS2bNFqZBOD4IFl2Sg-1
X-Mimecast-MFC-AGG-ID: N8_2nS2bNFqZBOD4IFl2Sg_1755115735
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324A219560B4;
	Wed, 13 Aug 2025 20:08:55 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.32.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22331180044F;
	Wed, 13 Aug 2025 20:08:48 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	bgurney@redhat.com,
	jmeneghi@redhat.com,
	emilne@redhat.com
Subject: [PATCH v9 8/9] nvme-multipath: queue-depth support for marginal paths
Date: Wed, 13 Aug 2025 16:07:43 -0400
Message-ID: <20250813200744.17975-9-bgurney@redhat.com>
In-Reply-To: <20250813200744.17975-1-bgurney@redhat.com>
References: <20250813200744.17975-1-bgurney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: John Meneghini <jmeneghi@redhat.com>

Exclude marginal paths from queue-depth io policy. In the case where all
paths are marginal and no optimized or non-optimized path is found, we
fall back to __nvme_find_path which selects the best marginal path.

Tested-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c042a9a11ce3..38e40dd88e52 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -420,6 +420,9 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
+		if (nvme_ctrl_is_marginal(ns->ctrl))
+			continue;
+
 		depth = atomic_read(&ns->ctrl->nr_active);
 
 		switch (ns->ana_state) {
@@ -443,7 +446,9 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 			return best_opt;
 	}
 
-	return best_opt ? best_opt : best_nonopt;
+	best_opt = (best_opt) ? best_opt : best_nonopt;
+
+	return best_opt ? best_opt : __nvme_find_path(head, numa_node_id());
 }
 
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
-- 
2.50.1

