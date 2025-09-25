Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38622D4F9
	for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819766; cv=none; b=PVbqZWBTG6z6lf899ggq7vEfK4R3Gpt7F70iLTXbBvK/yLFZJiLXK/YUsYm1agLtMF+RA8gnrmLl7e2w8rq3WddJloLnBkva/1bKtstgprN3YZ2NGINPl0CVDVRku5GAMohPedsiCaQrqepyCINEKvZWbdo6y7oDh6ko7Ev8ofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819766; c=relaxed/simple;
	bh=eA0tUDThErSrjVbJGEhqmG2sB/xJpKZekH2BLeva/34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHkFBej39EZi+LDtSIJYtZ/IokxR9wJ1MwL8wQuOyu2+uhI0seWHLcZQNrWxsAWHdhdt/cCoyBCkhrYAmfcnm4/efSobjRlM2ZJ6duYeWZ88ZBFPWNjwq+8zmSu6VkpiUtRkMqU95FDTnlbyxixptQBuhFsO+UNpNPVqxfFX+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAGWfoOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAGWfoOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758819764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2qJ3u9F3WYpp3Qx7MbbugDMzN7PLrs8CIX1/6KerXA=;
	b=eAGWfoOoDkBAevqhPvS3oux+PU1iU5738OeT5LASUWgHQrP07U7tdlEUKRCUwf4h2U6rhY
	JneGjhypzt7FUuTWxVmZXgH/wM/3viODaywsw3rqMG4lVXUnrTQ0BPBPPHe7wZEZQ45l1h
	fi5Nn1JfmKGwlDDySRV78Gl9lW/sjOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-hDWnK08sPC-P-6jFGEozZw-1; Thu,
 25 Sep 2025 13:02:39 -0400
X-MC-Unique: hDWnK08sPC-P-6jFGEozZw-1
X-Mimecast-MFC-AGG-ID: hDWnK08sPC-P-6jFGEozZw_1758819758
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6CA018002D1;
	Thu, 25 Sep 2025 17:02:36 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.32.119])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABAD7300021A;
	Thu, 25 Sep 2025 17:02:29 +0000 (UTC)
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
Subject: [PATCH RFC] scsi: qla2xxx: zero default_item last in qla24xx_free_purex_item
Date: Thu, 25 Sep 2025 13:02:23 -0400
Message-ID: <20250925170223.18238-1-bgurney@redhat.com>
In-Reply-To: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
References: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In order to avoid a null pointer dereference, the vha->default_item
should be set to 0 last if the item pointer passed to the function
matches.

BUG: kernel NULL pointer dereference, address: 0000000000000936
...
RIP: 0010:qla24xx_free_purex_item+0x5e/0x90 [qla2xxx]
...
Call Trace:
 <TASK>
 qla24xx_process_purex_list+0xda/0x110 [qla2xxx]
 qla2x00_do_dpc+0x8ac/0xab0 [qla2xxx]
 ? __pfx_qla2x00_do_dpc+0x10/0x10 [qla2xxx]
 kthread+0xf9/0x240
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0xf1/0x110
 ? __pfx_kthread+0x10/0x10

Also use a local variable to avoid multiple de-referencing of the item.

Fixes: 6f4b10226b6b ("scsi: qla2xxx: Fix memcpy() field-spanning write issue")
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 98a5c105fdfd..7e28c7e9aa60 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6459,9 +6459,11 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 void
 qla24xx_free_purex_item(struct purex_item *item)
 {
-	if (item == &item->vha->default_item) {
-		memset(&item->vha->default_item, 0, sizeof(struct purex_item));
-		memset(&item->vha->__default_item_iocb, 0, QLA_DEFAULT_PAYLOAD_SIZE);
+	scsi_qla_host_t *base_vha = item->vha;
+
+	if (item == &base_vha->default_item) {
+		memset(&base_vha->__default_item_iocb, 0, QLA_DEFAULT_PAYLOAD_SIZE);
+		memset(&base_vha->default_item, 0, sizeof(struct purex_item));
 	} else
 		kfree(item);
 }
-- 
2.51.0

