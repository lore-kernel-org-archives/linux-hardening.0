Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866738E8B7;
	Mon,  8 Jun 2026 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944726; cv=none; b=evfpOmcBB/wyejmMqhQmFprHcVehtdjvuvmVe9ryWMjlVgZ3RkKT+YZxXikGIo919YNS68HB2ds1ya8aPGo22i5PdIfokFbGY3ditD8ZV25jca9Cb9hLnJiIpMnTW5p4OknDSqNDsdzb7Rx/l/ub8Xypp1Gz2tFHX3UunNYgEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944726; c=relaxed/simple;
	bh=dCzZqsEFSsmTdQjtgd8ONukyg5eOVXelkFuLU6s69f0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h2QY/xuL3qTA3pTRIV690t8AyBjtkS4YwBDhFSqY2DvBpnqESJO8/0SVkSdpJeidNH3KL1t/5gKRUW/N3BAHiVYL+NEPASPmc+QSKp2d5u38tEApo93UV7osYVmqnNA8pGi5Pp5yn7j0W6jydPqfVMhsgnlnxtIwmDLeZKiQw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=PnHF6KMb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="PnHF6KMb"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWf4o-00D00j-VF; Mon, 08 Jun 2026 20:51:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=dG/sfYRvq8kCCeYDOuH74EgMzRpBVnNC9TmW9KHmBDA=; b=PnHF6K
	MbWeBipz0WdMy11fYHsxVRSqjqPpYyOfBaE7d5LkMgDAVsAGYgv7Gwh4+QS4hGFJ1nQDiHOSmev8z
	Qp6s5ZxV54rglsdBLBI0LSmaDbQZN9QRmeN+0mLROGyZmSNT19WKgMZlhBgNcB2NBoeCmEZqi3I+P
	u7RDZQRtPJKSPOu7PZqNg3GuX99n57bBn6ft4pxXYlCLhrRhGzJYfvAM7Xof8zwjzE0683zcuV7TS
	848Nqgs9Mp8PL/781nhKyvenWkXAvbxdUhlIXVpV07wo07b/dE616M6yLuQjqmPOzuYsl6OvXteo8
	Pojl+6XbpA0jdgeADSRsLWTSychA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWf4o-00081k-IC; Mon, 08 Jun 2026 20:51:58 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWf4k-00Bd89-NO;
	Mon, 08 Jun 2026 20:51:54 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next v2] drivers/of/overlay: Use memcpy() to copy known length strings
Date: Mon,  8 Jun 2026 19:51:21 +0100
Message-Id: <20260608185121.22331-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid calls to strcpy().
The lengths of the strings have been used for the kzalloc(), replace
the strcpy() calls with memcpy() using the known lengths.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v2: Improve commit message

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

 drivers/of/overlay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c1c5686fc7b1..656867009514 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -258,8 +258,8 @@ static struct property *dup_and_fixup_symbol_prop(
 	if (!new_prop->name || !new_prop->value)
 		goto err_free_new_prop;
 
-	strcpy(new_prop->value, target_path);
-	strcpy(new_prop->value + target_path_len, path_tail);
+	memcpy(new_prop->value, target_path, target_path_len);
+	memcpy(new_prop->value + target_path_len, path_tail, path_tail_len);
 
 	of_property_set_flag(new_prop, OF_DYNAMIC);
 
-- 
2.39.5

