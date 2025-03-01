Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8C1BC4E;
	Sat,  1 Mar 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740848250; cv=none; b=RjtM1ZogvwtUw9O47LeUovEhgdKvQ2icNzwBRUOI93bidxMEcYqwmiA183Tft01f9pQyU+ntJVUl7DbBrKlWhF1zfdOoDcX8uTpCD6L0bxggiVtH1cWzOEs97xsOKjCmEHlI5ALsEsJoe+KsTYjxmyJDaxf24eaI6RitTmfG5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740848250; c=relaxed/simple;
	bh=861EVDC7x+OyGKwSipHTxhIzgg06WFsS/lrp6j4vdXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Aogsm2G1DHs925/riI8MvbWsLov5XWK5bPF3gexZCXa+6rXMXshA/dpAEpL4wsZ3mFxd1IsaPO5OQHOEwsBYRl8S54HTiFAROK5XJEAw/EsB//FS5jkuu8n2IaUTwt8C9XA7CyWBE2tinZ072Nf9Du1CgswE/PCGpqbxAOqtkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=HbrJfcYq; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="HbrJfcYq"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z4rpq6l8hz9smn;
	Sat,  1 Mar 2025 17:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740848244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RPlJyMQSOJ2wMYTmAfyfebLAl5Ru+/PjDjFutvpbEog=;
	b=HbrJfcYqmRqIaAv96HLJvK25k+DWJ98fobbKa0p2903dojUzCgifi/KKZiCEVWrGNqL5Hp
	G2CA5kn+9O/jrtG/9wCFvJE6VAgy6jDtK0qoeaL75SQGPwjVhgeT3fTefdWkHvTDMQOU6C
	AKz8tuEdUNZqRq2Tcmhh2nbA+vMiXbehLLZUd4r9sL6a1YJfp12T6RilkdeD0eBeJgg5+R
	z9LR8YqTLoA4pL1Xzz8uGZg4uuRyYst3ALIDxndCqbTOSjypvnwJwH0wogwl2XLMn/M2rO
	ysin6aY/dyHYky/b0viqRQW7N5vJjiXZEiaiFgTsoH798CjZZ7TpX/SlrQyuxA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 01 Mar 2025 11:57:19 -0500
Subject: [PATCH] mm/shmem: fix uninitialized scalar variable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-entry_order_uninit-v1-1-3543b4e3fb28@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAG48w2cC/x3MPQqAMAxA4atIZgtNpYNeRUT8STVLlFRFKd7d4
 vgN7yWIpEwRmiKB0sWRN8nAsoBpHWQhw3M2OOu8rSwakkOfftOZtD+FhQ+DrnYeRxymOkAOd6X
 A9z9tu/f9ABOc159kAAAA
X-Change-ID: 20250301-entry_order_uninit-129251b1ac9f
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=861EVDC7x+OyGKwSipHTxhIzgg06WFsS/lrp6j4vdXQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBCKzJLV0M5dU1XdTdlemIwOG82SzhxT3VxaHRpdC83CnArZ1o0OGJBTXdmNTV1ODl5
 cHZhVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0luOEZtSDR
 aNzMxdlorZTZ3M0R5d2VxQlF4VXpNS2VMVjZlMnJxblFmZHJiTkZjK2ZuUlV4bitlNW03M21YcQ
 pES2lUSzFsNmNmbjg3QVVDTXNJemprN1ZjREZoL0xxa28rb25Nd0RPc1V5bgo9RFdQMgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4Z4rpq6l8hz9smn

int entry_order has the possibility of being uninitialized when
returning. Initializing it to zero at declaration appeases coverity and
reduces risk of returning nonsense.

Closes: https://scan7.scan.coverity.com/#/project-view/53698/11354?selectedIssue=1637878
Fixes: 6dbc440b79b6 ("mm/shmem: use xas_try_split() in shmem_split_large_entry()")
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d19d33e98320d5e0ccbc86616bb3ea30d29f0cc1..3718c71aba9304dd3ca8df137a19e0564b8aadb2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2153,7 +2153,8 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
-	int split_order = 0, entry_order;
+	int split_order = 0;
+	int entry_order = 0;
 	int i;
 
 	/* Convert user data gfp flags to xarray node gfp flags */

---
base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1
change-id: 20250301-entry_order_uninit-129251b1ac9f

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

