Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F9BE6D
	for <linux-hardening@vger.kernel.org>; Sun,  5 Nov 2023 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D6CB8
	for <linux-hardening@vger.kernel.org>; Sun,  5 Nov 2023 12:29:52 -0800 (PST)
Received: from localhost.localdomain (178.176.72.158) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 5 Nov
 2023 23:29:42 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	<linux-hardening@vger.kernel.org>
Subject: [PATCH] pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
Date: Sun, 5 Nov 2023 23:29:36 +0300
Message-ID: <20231105202936.25694-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [178.176.72.158]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/05/2023 20:08:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181122 [Nov 03 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;178.176.72.158:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.158
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/05/2023 20:14:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/5/2023 6:43:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
64-bit value since persistent_ram_zone::buffer_size has type size_t which
is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
this value gets assigned to has (always 32-bit) *int* type.  Even if that
value fits into *int* type, an overflow is still possible when calculating
the size_t typed ecc_total variable further below since there's no cast to
any 64-bit type before multiplication.  Declaring the ecc_blocks variable
as *unsigned long* should fix this mess...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Fixes: 9cc05ad97c57 ("staging: android: persistent_ram: refactor ecc support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
The patch is against the 'master' branch of Linus Torvalds' repo.

 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 650e437b55e6..131c1923b8c0 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -190,7 +190,7 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 {
 	int numerr;
 	struct persistent_ram_buffer *buffer = prz->buffer;
-	int ecc_blocks;
+	unsigned long ecc_blocks;
 	size_t ecc_total;
 
 	if (!ecc_info || !ecc_info->ecc_size)
-- 
2.26.3

