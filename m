Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FC32F748;
	Mon,  1 Sep 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740673; cv=none; b=aXktwFvf3BdgrAjmN+FpfIthQrAJDjyHCr69DJbsdgU6npYBX3isQwRVJK3loLdPo1VVqo2awQGHJcT068ViO9x8edgy0YytdRXUu8gEP0l1RGS70prAgI0uVrDQ9ahK9fvi94c3iTCkn2Z2yUf90LczZ2xU0sWtIACKARljbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740673; c=relaxed/simple;
	bh=/8vej4eNYruwNwm97aIZA2Hz7Rzgofi8A9k+GklL0C4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6qieHmOmM0tGcFgs9z1A0rU5bjHSaXl8+9NzFTNpG3QmktI850vGxo4M8p5/58Aqe83ehdHnehFniFXcFDUUpr/gkgGh/s7BFgPg/VNfnfwB8vRDiGdngJQgqjdf9bcIOMnqC4JPOk0HlVH2KW+E7AvZw2ZDq+LPo/ajZE6xOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XVtRrGCf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XVtRrGCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JT
	W7s6g7GEV3g1eaZO9uwvh1qEtAeXGH3zI7t99R1hU=; b=XVtRrGCftiAQsIfP15
	vWQrOLbYwZhqR3HHaioIvAPC4kc7RCjQLAZqBYkCPGCS9dFCqJ7xA0gSQFzAj0XL
	eGMMXnHHwzowJtvaQsaXl1iS8Gc6adHmTeO59j3mL48jHUBmD7K6OdhcVFl4A9LC
	0pcGej2vLmjd7ALllGm4AxgKY=
Received: from ubuntu22.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnhTYcvLVoVj2zBQ--.28532S2;
	Mon, 01 Sep 2025 23:30:37 +0800 (CST)
From: chenguanxi11234@163.com
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	haonan.chen@zyt.com,
	xiaocheng.yan@zyt.com
Subject: [PATCH linux-next v2] pstore/ram: Fix pstore lost information
Date: Mon,  1 Sep 2025 23:30:32 +0800
Message-Id: <20250901153032.737442-1-chenguanxi11234@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnhTYcvLVoVj2zBQ--.28532S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW7Zr17KrW5KF1fZry5Arb_yoW8Ar1rpw
	sxJas3KrykG34fJw1vgF1kXr1jya4kta18Z348t34Syw1UKr1kAr10vw1avFZ0gFWrA3W3
	ArsY9FyfJas8tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwHUDUUUUU=
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBzwSr+mif35eYaAABsU

From: Chen Haonan <haonan.chen@zyt.com>

Background
==========
persistent_ram_zap() is used to prevent the corresponding file from 
still appearing after an unlink operation in the next boot, but 
this is unnecessary for console, pmsg, and ftrace. Worse yet, it 
causes the system to only show logs generated after the deletion 
operation the next time it reboots, following the removal of the 
corresponding file under /sys/fs/pstore.

Solution
==========
Before executing persistent_ram_zap(), check the file type and 
perform this operation only for dmesg logs. 

Result View
==========
Before patch:

root@ubuntu:/sys/fs/pstore# echo test1 > /dev/pmsg0 
root@ubuntu:/sys/fs/pstore# rm pmsg-ramoops-0 
root@ubuntu:/sys/fs/pstore# echo test2 > /dev/pmsg0 
root@ubuntu:/sys/fs/pstore# reboot
...
root@ubuntu:/sys/fs/pstore# cat pmsg-ramoops-0 
test2

After patch:

root@ubuntu:/sys/fs/pstore# echo test1 > /dev/pmsg0 
root@ubuntu:/sys/fs/pstore# rm pmsg-ramoops-0 
root@ubuntu:/sys/fs/pstore# echo test2 > /dev/pmsg0 
root@ubuntu:/sys/fs/pstore# reboot
...
root@ubuntu:/sys/fs/pstore# cat pmsg-ramoops-0
test1
test2

Signed-off-by: Chen Haonan <haonan.chen@zyt.com>
---
 fs/pstore/ram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bc68b4de5287..48e4abd5dcad 100644
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
2.34.1

