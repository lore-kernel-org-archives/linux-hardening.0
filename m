Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006F186E52
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294542; cv=none; b=cvpCDh+ryfGwedQKYiVF8nB9OnCCce5MfJP+T/LG9pmDdsVUMNd+4I3fIlzZd/L9oUeeZG7i8g/iU4EUUVgMYJLXqN3zHh0Fak/K8Erbn38NXfDhY7sVxZnkaYlISj8DdI5w82vHu9qjGJSR+EbWvJY32X5R6LFUYgAhXTycT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294542; c=relaxed/simple;
	bh=AuPz2tfvANsmrHVBeiM5pw1siEqDNiTcaua+AbTIVqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkXE3sa7F7Ws+5/+CjjGsKNnbML+SVJNbRBabFriUp++Y1piNDXQzOhssUZmKUCNvdoACCHnbXm6yNLsnV5rHxCH3b29bW4m4a3BnAtjksl9I57PEOnlQ78F533NlamMbbWvULMpieNKk1hpSAq/ZrKhdG13rhzTuvnpfppXMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MPhC8swb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MPhC8swb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ShT75
	gPNDRVqusYUeXWWxcHCd62y/PNbZwGKFg+UZkg=; b=MPhC8swbNGltTEHrFIhOO
	63pFacknJVsyv76+Jn0nMjl9O89/jYb3OBAwYok5QtyuheKHQmfbkbVvrBD90o6e
	9995Sw+GF0H06BdSCXSVa1HjMcjeWApIOYEmbJu8FtOhhcdoItVhlO7RX8bi5U53
	bzHyX8Vvlb50jBGbhT2fD4=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCntZSl+U9nCFQ8EA--.48094S2;
	Wed, 04 Dec 2024 14:41:42 +0800 (CST)
From: 15074444048@163.com
To: linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: 15074444048@163.com,
	lihaojie <lihaojie@kylinos.cn>
Subject: [PATCH] fortify: Use __struct_size replace __member_size
Date: Wed,  4 Dec 2024 14:41:49 +0800
Message-Id: <20241204064149.218136-1-15074444048@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCntZSl+U9nCFQ8EA--.48094S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDGrW8AFy8GFyfKw1fXrb_yoWDXrc_Cw
	n3tw48Cr4xX34fJw1ftF9YqrnYka17Gryqgr1fAF1jqw1DJwn8CF95Zr929r47Gw4kJFyf
	X3WrX347Ja13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRoqc5UUUUU==
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/1tbiLgOrUGdP95tD0AAAsB

From: lihaojie <lihaojie@kylinos.cn>

Use __struct_size get destination size.

Size of destination less of the size to be written will
make buffer overflow, the size of destination should be
complete.

Signed-off-by: lihaojie <lihaojie@kylinos.cn>
---
 include/linux/fortify-string.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 0d99bf11d260..0504b2c8aab7 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -277,7 +277,7 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strsc
 __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
 {
 	/* Use string size rather than possible enclosing struct size. */
-	const size_t p_size = __member_size(p);
+	const size_t p_size = __struct_size(p);
 	const size_t q_size = __member_size(q);
 	size_t len;
 
-- 
2.25.1

