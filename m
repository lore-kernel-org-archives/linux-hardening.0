Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C53346B6
	for <linux-hardening@vger.kernel.org>; Thu, 16 Oct 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637057; cv=none; b=i7Bjun2LDKgrc8LRD2WTJuQnDdbtRQ0TOOyox6CdBSy5S6Ovtr+ouh1Tjc37Vhh/Qz/sgokOejWIVcxd3Xt0sYKgiotcyKDaL2iB70MujouXMXPlGOa1xbR4JiNzWvR+qDp2nO+vP+Mjq0GVyDLegCNq6/C/EFfcIwd5auTktn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637057; c=relaxed/simple;
	bh=8EhcO8P++WCMtd9d5jKiU6/xyxDWH2jKha/FUfKmz0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPy0rQB/6NiHKy8tWQGb2BSvLhac1J1tk6vWitfLDfHO/fqDYR8QcX9TfjeTUN0vx1xuPFLqV5hmbzluVYjavHa6nUIUx6Uj8B5I4DAluiS1ZZXuNSwmWtVP+kRhig/W4EjPOGEsirntQQ6mdS5iAX8ApymXKRcZQj3gNbKGa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oJvdGaVf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oJvdGaVf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760637043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tPptTdvt0P/Pr1HimNZSP+ELp6j7Af0CWu9+zWYFYX0=;
	b=oJvdGaVf1P7nt3yBU9MUXAsTFUduzn+mJaTJ/f/M19lnNzEc9jzlfFgU+RNoHRYsbEOiEi
	KxPVsrAntVNCsFKqE2cPqlFkg3pUtPrX4XgxUV1N2xu/07dM3qelY43Y6ezWA0SpPCyIya
	CPTFUDHXDWRq8dOi9Eh5T2FrsMHluCY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: Replace deprecated strcpy in d_namespace_path
Date: Thu, 16 Oct 2025 19:49:15 +0200
Message-ID: <20251016174914.80831-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; replace it with a direct '/' assignment. The
buffer is already NUL-terminated, so there is no need to copy an
additional NUL terminator as strcpy() did.

Update the comment and add the local variable 'is_root' for clarity.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/apparmor/path.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index d6c74c357ffd..65a0ca5cc1bd 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -164,12 +164,15 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	}
 
 out:
-	/*
-	 * Append "/" to the pathname.  The root directory is a special
-	 * case; it already ends in slash.
+	/* Append "/" to directory paths, except for root "/" which
+	 * already ends in a slash.
 	 */
-	if (!error && isdir && ((*name)[1] != '\0' || (*name)[0] != '/'))
-		strcpy(&buf[aa_g_path_max - 2], "/");
+	if (!error && isdir) {
+		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
+
+		if (!is_root)
+			buf[aa_g_path_max - 2] = '/';
+	}
 
 	return error;
 }
-- 
2.51.0

