Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6268289A
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jul 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252639; cv=none; b=ki5pchtBUi6L7x86YwU0m1CXlbq8nKmZE+zStuuWRyjn08Tm6ulCh/Eu1r2LSzCwePSFZxJ1p590IdXAsyIunoJtk3pv+FWKZSt2a3Nf2ELdltLhl7PxVPDRf5eyl/MfsYFZiPD/sjAOb7eYKnmm4a2UywvL/3x2CBr76V+CpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252639; c=relaxed/simple;
	bh=pjObBwxxiFHux+NXjbaAhUXpRgJOrYS8GRm5NvagPLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFdJGeiN1/oNXbqhQzlkVtMC7z6lMq/1qVdNyRr4eNmZeXT9tRZeYgBIWqfX1uUsDksNP7q6M4jkNJeD5jpaRYNHgnOYq9lUGy6EOY2glwaOmBt7QA4Di7k0mlmF4yLQLP7bHrBjD9IWRbycRf5+e2TFQq6QNudEGrMJkb1emQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Xh1I36du; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Xh1I36du"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281abc65daso8914515e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jul 2024 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722252636; x=1722857436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwXA3dD7SAZsbhApPfN7AfejG+oDqK2DgA1HjnsQ1MY=;
        b=Xh1I36du0EI1G22t6ZhEKZUd0vk+nFhyBiRlAVKtmPdcl6lQiI6ozLicL62xWu7qxw
         dVnggqWJUa59TNIQj3JjI/+phmK3mABLsUhwfFHPg2TeVa3foAeimVnDpKGC1hgWzLLo
         RbFdHSNI/zXPsJGRXe7RXbgnVC3NxRfTi+2oCrcPTs2YVUjWfPfBLJJMxjM3G422E82g
         zayELY4PZCpWCndFxiKiqPmAXs9Y25YqV2X+kq6+hCiRqv8k6ujesd+q5cZASovFtJjA
         NbretkzflV0+mg8+HzFXMLcuYFZodOwsU2RkCAiJF1w7n88jZaEhJ/6ROE9yiYoSNUOR
         rOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722252636; x=1722857436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwXA3dD7SAZsbhApPfN7AfejG+oDqK2DgA1HjnsQ1MY=;
        b=BIzj66oiBc3YPNDqhSlP/X4KjiykJTwEYA31cAwtWfROSAxDweGFgqLyLf4A07XSzk
         I6N8O5I2xzTyffZ19tUifO6KnTEqXmO7Annu4/epF8fA7W7KEdwmJd9HB4XKoW59/8AS
         Tt+4RuuCux6pXXO6OJgizlqBqtJt9EUiYOLuO/MjdajPrK/hL0Bij6e3NxPzMHHm0p0C
         /Ela42u9KqZjB1ejXObcXiKIJD+L0nTd1Acd77/bXuHKZ4mG9XMBuVCc4BBpcrBKhZcN
         /9JNsDcVSnwZiyyVAMYTxMcKA7jcvhOxg035o34N2egVBI+PcbGVcUpzb9H4Y7PrMkOH
         0ZHA==
X-Forwarded-Encrypted: i=1; AJvYcCVgIBREvDrts35/4DaxVoxt9cE1uIzo5vGs7haFR7DsKYWrouFyTX/DjwVFuP8fONVYZxrSU2l1nIuEsHXD5GNxDBqWEcySoX+dewFmw8k2
X-Gm-Message-State: AOJu0YyUFMEUU1DXL1UlNq7dL6EL7NkYOcsP0SyT6f/0m9pyka85Mm8X
	4+p+Ma7xLTVG0SdK/0s9cNPilHi9C7ZDjehOmYwNpPQLcfkrvkU5RtMXe6JwgdY=
X-Google-Smtp-Source: AGHT+IGjHB30wevbTXYBKu03d2S8jAWUf0rPrsqnjpTSyTPyWNnUBy5LQUpZyVzyw3MY9OFVpUWL2Q==
X-Received: by 2002:a05:600c:4f50:b0:426:51ce:bb14 with SMTP id 5b1f17b1804b1-42811dd19d8mr41565735e9.30.1722252636324;
        Mon, 29 Jul 2024 04:30:36 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428054b9196sm174041615e9.0.2024.07.29.04.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:30:35 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Mon, 29 Jul 2024 13:04:56 +0200
Message-ID: <20240729110454.346918-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Remove the now obsolete comment on the count field.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ext4/xattr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..e14fb19dc912 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
 };
 
 struct ext4_xattr_inode_array {
-	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[];
+	unsigned int count;
+	struct inode *inodes[] __counted_by(count);
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.45.2

