Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C524A042
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476482; cv=none; b=L3CylrUQlDT1yx+jW30u5IHcqRN7zMbSQN3fn0V3rIyDy8ZGq/3NXO85bzQ+7/uKeQISJ3aiWBbGC/NBPrnuG2Smu+A+NFdow4F0ePvk72VWW8qhUreycV0bfaf858OFb3hi+fjiUDTxgFfUFWhDsa2cnLO+i7kC12Qn0fggd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476482; c=relaxed/simple;
	bh=DTFVmRKr/sRy0lujQpNPmaprPhJHgvIYAyhefq5wfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCby/zJTTfDJqEcwdyz8wWmt2FucZ1PpmSzfwb24U7nv+hq2j9wJNmFNp7nlHHcUQTRD7OvMoRjSdCPKShIlbx9Be3MDgmI+5iMQfYYdCfeCM8ylu3UxoAGLisPHwOZhuaHlat3m54I+PMpMbJX7Izws0Wfkl4qi4k/1T0BgrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MOnFxECN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MOnFxECN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739476468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=239vtdGQF+N49EPmM+HoBTCJVsqE4ZMPXJ8M+TXlAZE=;
	b=MOnFxECN+fL3mGdpw0PfKGtjVpIR4qzFZJS7s8hkyHScierwD8RT5IOCC+peRMIAn5bd5H
	2tdgaamZDqpnENViNDU1Z/nXuJwm+1gc7EAMeh9HYFs8ysNcZQ96oZNIRhq/FTYmwItStz
	uQI1aqFVR0zrKrSY3aXWuNab62/AcWk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: hpsa: Replace deprecated strncpy() with strscpy()
Date: Thu, 13 Feb 2025 20:53:33 +0100
Message-ID: <20250213195332.1464-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Use min() to simplify the size calculation.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Adjust len to copy the same number of bytes as with strncpy()
- Link to v1: https://lore.kernel.org/r/34BB4FDE-062D-4C1B-B246-86CB55F631B8@linux.dev/
---
 drivers/scsi/hpsa.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 84d8de07b7ae..c7ebae24b09f 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -460,9 +460,8 @@ static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
-	strncpy(tmpbuf, buf, len);
-	tmpbuf[len] = '\0';
+	len = min(count + 1, sizeof(tmpbuf));
+	strscpy(tmpbuf, buf, len);
 	if (sscanf(tmpbuf, "%d", &status) != 1)
 		return -EINVAL;
 	h = shost_to_hba(shost);
@@ -484,9 +483,8 @@ static ssize_t host_store_raid_offload_debug(struct device *dev,
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
-	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
-	strncpy(tmpbuf, buf, len);
-	tmpbuf[len] = '\0';
+	len = min(count + 1, sizeof(tmpbuf));
+	strscpy(tmpbuf, buf, len);
 	if (sscanf(tmpbuf, "%d", &debug_level) != 1)
 		return -EINVAL;
 	if (debug_level < 0)
-- 
2.48.1

