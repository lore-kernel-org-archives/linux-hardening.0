Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181E26C38E;
	Thu, 14 Aug 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208951; cv=none; b=Q5FOfsXpmG0s//Hj/gQnIR8/RL6a5+JxVKq9N1/hzVGy45kZyIrt/octXb7mmS9vi/gvDWDRb3qKw68EQuY5URCPIGBSqFK0RNMhNkhDRX4t6wB1oGnGYv0JHCcUbN0URfh9O/JncDmhroNegbWYAt0jW3o3PyW6y2g1C+AdisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208951; c=relaxed/simple;
	bh=SlrsZmfl+He3QKv200SLIRGmlBxB+iLaaWr1TZNJMNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnvOWPVUZoZf8i4wATR7Oq/iS6T/R3BZU/wVmsilyowht6aypQfCXhRXGw4g++/4MxSPEPIPErJ8/zJzZf/SUZnNhoW4h0xZspuM6/FXLiRqQhWgoYFSbsmV2MGeuGb3CFPYH3OszR5iWBaYwmI7zr/bM0HvGg5X77/V93PreIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWulBFUS; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWulBFUS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755208943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zI2T3NjNDeX8nhgLV4fz7P1YQu+Cfk5TlJYgANSTK+E=;
	b=lWulBFUS5qiG0b3WPNqtIgIgrO5QC1Uu4UTy2iGSnAEeexXpQfqNac4HUFzY9taWU9Fk+L
	eBFsHgmNZwR9rzHG90oI+DLFh/fnKeDIXcafyTNw1z8BxmEY5PDpW6QFJNfYNq+z2QsbOn
	INd3wiYOL9lGeWgJJu6oPw1XO/PPZJc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and memcpy()
Date: Fri, 15 Aug 2025 00:01:28 +0200
Message-ID: <20250814220130.281187-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() and memcpy() instead and remove
several manual NUL-terminations.

In parse_grep(), we can safely use memcpy() because we already know the
length of the source string 'cp' and that it is guaranteed to be
NUL-terminated within the first KDB_GREP_STRLEN bytes.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Extract the strscpy() changes into a separate patch and focus on
  replacing the deprecated strcpy() calls as suggested by Greg
- Link to v2: https://lore.kernel.org/lkml/20250814163237.229544-2-thorsten.blum@linux.dev/

Changes in v2:
- Use memcpy() instead of strscpy() in parse_grep() as suggested by Greg
- Compile-tested only so far
- Link to v1: https://lore.kernel.org/lkml/20250814120338.219585-2-thorsten.blum@linux.dev/
---
 kernel/debug/kdb/kdb_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7a4d2d4689a5..40de0ece724b 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
 	mp->help = kdb_strdup(argv[3], GFP_KDB);
 	if (!mp->help)
 		goto fail_help;
-	if (mp->usage[0] == '"') {
-		strcpy(mp->usage, argv[2]+1);
-		mp->usage[strlen(mp->usage)-1] = '\0';
-	}
-	if (mp->help[0] == '"') {
-		strcpy(mp->help, argv[3]+1);
-		mp->help[strlen(mp->help)-1] = '\0';
-	}
+	if (mp->usage[0] == '"')
+		strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
+	if (mp->help[0] == '"')
+		strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);
 
 	INIT_LIST_HEAD(&kdb_macro->statements);
 	defcmd_in_progress = true;
@@ -860,7 +856,7 @@ static void parse_grep(const char *str)
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

