Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A431E5B6D
	for <linux-hardening@vger.kernel.org>; Sat,  7 Jun 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749331829; cv=none; b=T3YYBvG+CzBPOBBEkJe/OaTMycGCwgKTLB3S+5mLIv8ZQ4n0FrOVfCkuQnIQmvzxGGCF5bo1N3yh4R2vVYG2andc8F46P8oQ84Wk5wwzw6xxvxqAEbJC5RzXQGezCK2MfleAlK5Wy57Rrp5hiIY4sapz6yAeVKaIRKgbgvZCyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749331829; c=relaxed/simple;
	bh=cCui/UBexPOb+w6Y2QnKvfiASEiXWL1n2zIGSxWohaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dv/f6Z51qLE7mrJrd0FnaPblp7YpMDLmZjS9fAvcTf/ZudqauFTIUA9M68LVe46t94l9QjU8fahIXTMKxhHLoI6AS326EgRBVRpWQll8Hk5M8AdEltxfAd5czDYd0SZvo0oGRzRcXb5eiNVoDN+KnJ4H6tR5ltdbnCdS8jAXBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=1hrfMvYF; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="1hrfMvYF"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bFBDV2t9Vz9smv;
	Sat,  7 Jun 2025 23:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1749331818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNzK7t/kTDrEu3ZAe2BVUdBYjisR+xcRUFsS6jLDuk0=;
	b=1hrfMvYFFhtvWdGADpcQy0aN+Dw/WPd67jBGx6Orn3GyPbkKgoCKPwHYnovEs+b7+gzbqw
	jcp4GrOGKYyLQ3Dz3+2Ut+CHbJLt5E05xcM78flowv5jh3tp3HZRhDoeeQqK4gMRT3oNxy
	2iKL3BVQd3YUwhHhXF4HBQLW4qXS+g21ZhVlePf8eEyNvK0kiTUKVpiudpSsBCTcDZIfvh
	afFvVX7ujKPgqKZagXc3it2TVqes7xZlid0RipJ6+otyYVLA64lZSU/VOWBwtQYutL5zta
	arvBZ+sifzYWjxCTXmYde9GbpMBNzBX1/cAJks9Js3RO2tj9/m1NeNAXLyeDMw==
From: Brahmajit Das <listout@listout.xyz>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	justinstitt@google.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [RFC PATCH] um: replace deprecated strncpy with strscpy
Date: Sun,  8 Jun 2025 03:00:06 +0530
Message-ID: <20250607213006.7858-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This modification is mainly due to the concerns on
https://github.com/KSPP/linux/issues/336, where it was mentioned that
strncpy_from_user is confusingly named as it does not NUL-pad the
destination, but it does NOT guarantee NUL-termination.
With this approach/patch we can always ensure that the dst buffer is NUL
terminated.

My initial guess was to create a separate function, something like
strscpy_from_user that would use strscpy_chunk_from_user which would
inturn use strscpy instead of the strncpy (like in this patch). But I'm
new quite unsure about adding new functions to kernel code. I'm open to
other ideas and/or approach as well, since I'm quit sure there might be
a better way to handle this.

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 arch/um/kernel/skas/uaccess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 198269e384c4..c00ef385591c 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -170,7 +170,7 @@ static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 	char **to_ptr = arg, *to = *to_ptr;
 	int n;
 
-	strncpy(to, (void *) from, len);
+	strscpy(to, (void *) from, len);
 	n = strnlen(to, len);
 	*to_ptr += n;
 
-- 
2.49.0

