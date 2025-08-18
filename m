Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F032BF44;
	Mon, 18 Aug 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540832; cv=none; b=Lie0UAW7D2HwOi47JOQolVsPvEncZaHvMu2hA5k8uD7/sQrw0OeCf4vxbY2eqBZkGqLwrocJ29frqZA3vbIBs5/z8Jm3a8jMhBue/mHAHzoecGDlhoma5HT5ELK48taNHWHUM/fU9d39p1tFBh/9tR7tfmmypB84O12kjxKYdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540832; c=relaxed/simple;
	bh=k8gLsgTcQcKx2dGi60BkzRgf7hGwLXkU/yfl0npIIgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKvGxlSS2//EKWgiugUzrwMuVwLhkQYT+8ph7FsqlThZ+cTRilxVifIMeqs9e/sSd3eEVt8j89E3fm3KdHBCVhCpe+PBg8quJZGfoy5KmnXpmpYiY3b+qn9ThZ3ZIDBjDchXMv1ZaYAoqY5/3Tn2MzzF6A/fFQFFF2x8JhmmtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p15d+1RM; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p15d+1RM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755540828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbuTw8s/32WyiV4l/ZjNIAKNLZC4fckrAYE8HM66W2M=;
	b=p15d+1RMl0WBq0dkflo76g1fiDiRKnsnrTH8R3jOGGrPJMSfFHUxLsQO54iRNXAhi2fymN
	Vg+gOmbpgN4q8407D5ACEhDuKjl+XlsktO7HwExQs6gQgTf2/SBXBP2yEH35D6ylezCDSq
	hLN1erNextw9VDf5+07Ms3b3+S6N4rQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kdb: Replace deprecated strcpy() with memcpy() in parse_grep()
Date: Mon, 18 Aug 2025 20:11:43 +0200
Message-ID: <20250818181153.661431-3-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-1-thorsten.blum@linux.dev>
References: <20250818181153.661431-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

We can safely use memcpy() because we already know the length of the
source string 'cp' and that it is guaranteed to be NUL-terminated within
the first KDB_GREP_STRLEN bytes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7a4d2d4689a5..cdf91976eb7c 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -860,7 +860,7 @@ static void parse_grep(const char *str)
 		kdb_printf("search string too long\n");
 		return;
 	}
-	strcpy(kdb_grep_string, cp);
+	memcpy(kdb_grep_string, cp, len + 1);
 	kdb_grepping_flag++;
 	return;
 }
-- 
2.50.1

