Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683B3B810D
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=gUfdrpoKhJi8trLUzJ8r0DiQ64lNivMsUj9Bdm08l6ZRATO5siR+lxqEUAAjkd32cj1j+2QD3vqlZpPnpcTm45D9dhfQqgj/saTERvfjdZdzixj2rAzNJcy3q9UjHPQR+1zqTd8mETRNn1mhzqZVpR8esWRRxKBSZxasr/TRdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=pdeQjBqKdynI+jM3QQJdu4gbTnZJVy+aOWZkcjMyLiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHbfQ1Ll+hsJLKV9a/V4RAEElvUHaEPJcdC+ZHviuWwyK0Yzo5i2KBcvQtRZzNYA40+QHZ8U1MtWP+hliQq7L+sA9p+jaSPm/wekIvWC3wxBJWy63QjgyJ58+F1+47hnuvTU0NWtUkxyYhuZ1YIS7M8pPZBBpuhUy0FblhT+Ehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=LUsemBcw; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="LUsemBcw"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhn-00BRwb-F7; Mon, 08 Jun 2026 11:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=NOh4ustH3oIFn5KlV1wcWz6GvRRL0b7hiPQIXKiCeA0=; b=LUsemB
	cwbBbZIKukeW2OxULTgNes6UGUx73wR/AtLuld1hdEzSPkIL9QVwulQot+9Ks+oH0A+83nQg8utpf
	W2kb4ISaJdZriQO4y6C45WzS0y49718T7dC0H/4QJPRxPCmZD/RTct8WsvYuXCfhKyy4ckLFU7gyC
	CSKqbFeJ+kusi2TbESeTdgbPxmtRapTVVwbtuy7ovKbizZyFbRIonfMBaWQkRMjbtRVbJir4Bmzso
	ywwwV2P3jXJLtr7t31SxtMCPL6tm/K0dVxIrxddJUO9TLuHst8CAwyoPueyX6er5klmd7Qaz3nEy+
	htgKvIlr9GRVD3BYT7KDHaIY/FVQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhm-0003bw-SL; Mon, 08 Jun 2026 11:55:39 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhk-00Ag6G-Qr;
	Mon, 08 Jun 2026 11:55:36 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] nfp_nsp_hwinfo_lookup_optional: use strscpy() to copy default_val
Date: Mon,  8 Jun 2026 10:55:12 +0100
Message-Id: <20260608095523.2606-28-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Use the result from strscpy() to detect overflow, only do so when the default
is used.
Replace min_t() with min().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 .../ethernet/netronome/nfp/nfpcore/nfp_nsp.c  | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
index 5a1aadf6e17e..9fbc80334d8b 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -921,7 +921,7 @@ int nfp_nsp_hwinfo_lookup(struct nfp_nsp *state, void *buf, unsigned int size)
 {
 	int err;
 
-	size = min_t(u32, size, NFP_HWINFO_LOOKUP_SIZE);
+	size = min(size, NFP_HWINFO_LOOKUP_SIZE);
 
 	err = __nfp_nsp_hwinfo_lookup(state, buf, size, false);
 	if (err)
@@ -940,25 +940,15 @@ int nfp_nsp_hwinfo_lookup_optional(struct nfp_nsp *state, void *buf,
 {
 	int err;
 
-	/* Ensure that the default value is usable irrespective of whether
-	 * it is actually going to be used.
-	 */
-	if (strnlen(default_val, size) == size)
-		return -EINVAL;
-
-	if (!nfp_nsp_has_hwinfo_lookup(state)) {
-		strcpy(buf, default_val);
-		return 0;
-	}
+	size = min(size, NFP_HWINFO_LOOKUP_SIZE);
 
-	size = min_t(u32, size, NFP_HWINFO_LOOKUP_SIZE);
+	if (!nfp_nsp_has_hwinfo_lookup(state))
+		goto set_default;
 
 	err = __nfp_nsp_hwinfo_lookup(state, buf, size, true);
 	if (err) {
-		if (err == -ENOENT) {
-			strcpy(buf, default_val);
-			return 0;
-		}
+		if (err == -ENOENT)
+			goto set_default;
 
 		nfp_err(state->cpp, "NSP HWinfo lookup failed: %d\n", err);
 		return err;
@@ -970,6 +960,11 @@ int nfp_nsp_hwinfo_lookup_optional(struct nfp_nsp *state, void *buf,
 	}
 
 	return 0;
+
+set_default:
+	if (strscpy(buf, default_val, size) < 0)
+		return -EINVAL;
+	return 0;
 }
 
 int nfp_nsp_hwinfo_set(struct nfp_nsp *state, void *buf, unsigned int size)
-- 
2.39.5

