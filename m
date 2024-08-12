Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A2176FBD;
	Mon, 12 Aug 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470085; cv=none; b=LCcOV+P7h2U6RO6U9hSYBbXWfM3W1shk3tU2bdUjHOqgX7IMKAnCMQW9/ZNj4V2XGcpO3IREPaIZx9WWKOuImnlgm48vtXGLmXCKejLJHVUc1eBQaQsL4elDMU0oe9gjV2TFelZ7dUeYvrWg9iNichRa+ASllMrnAFE2d/2lOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470085; c=relaxed/simple;
	bh=9wIFlWNGLO+9YpCpsGJumaQv8igzmWw21lZDMnSWvHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tib7EA9EEcUK4oqadhK3JwUlBzjFb6QtPdCzZUtS95dxPs6SHO373g3mRNDTRZiySatG8mbMmdZafd/BC05D+VcmoPdJmaR6WDL5IMiBHiUGu7ExxIVpc6eMW97YCiWkTdVuFYeAuQebc09+uzL3V/5VYdMTPFpOMoI7XdDrZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CnNsSMvF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CnNsSMvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QJOa6
	KmgBHP1hSSdt1/PY6KcChdAILjfuU5Kpw1Bops=; b=CnNsSMvFhM5dJGsPVqxQe
	eP79qoOnrb+zDygVRDpqzYIknWG4NUswaUjfqZm2SsMSDsoz50buFre9pf+YyR9w
	emGRqFrPqwYerqWNfwiy+2UQVbWpGfBt5Ujy3N6viTcZ/D+idsHT6DJZu4981gF0
	D37ut5CJ30cZej0np04LbE=
Received: from ubuntu22.localdomain (unknown [171.214.180.39])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wD3X7jgELpmOCx0BA--.63134S2;
	Mon, 12 Aug 2024 21:40:48 +0800 (CST)
From: chenguanxi11234@163.com
To: kees@kernel.org
Cc: chen.haonan2@zte.com.cn,
	yang.guang5@zte.com.cn,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linux-next] pstore/ram: Fix pstore lost information
Date: Mon, 12 Aug 2024 21:40:45 +0800
Message-Id: <bd48fa6ca65fadb9ab84a8fec6f0b0ed5e4f2fd4.1723464485.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7jgELpmOCx0BA--.63134S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF13tr18AF4DGrykKFyrCrg_yoWfXFc_Ww
	1Yqr1kGw4vqryfK3s8Aw13Kr1v93ykGr4jgrsFqF9Fk3ykJr4fJF1qq34kZ3sxGr1jga43
	GwnrXFyYv347ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0eHq7UUUUU==
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBZwo4+mV4ImBLdgABsM

From: Chen Haonan <chen.haonan2@zte.com.cn>

persistent_ram_zap() is used to clear relevant log messages 
in dmesg, but in other cases it is not needed.In particular, 
in console and pmsg, it will cause that after we perform 
a delete operation, the next time the system is reset, we
will only see the logs after performing the delete operation.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 fs/pstore/ram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 4311fcbc84f2..4cb6e96df6b9 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -436,7 +436,8 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 	}
 
 	persistent_ram_free_old(prz);
-	persistent_ram_zap(prz);
+	if (record->type == PSTORE_TYPE_DMESG)
+		persistent_ram_zap(prz);
 
 	return 0;
 }
-- 
2.25.1

