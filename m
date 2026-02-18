Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59433D6E1;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409598; cv=none; b=TXFJwwsIi3/25TrDrS7Dpk3tZ0g1iRiyRRCq04C9DfyTfw2+pQ6ABVuWcNPED0zk+QK37h6vQMzFT49iQQ55gLaT+PX1MHQAQz9ZG1ToW2XksCl2t1V5XEev0CQ03BRKk6hpE8AcIWGueY+YOHCHkYxj8GEblqKt6jNEBUl973I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409598; c=relaxed/simple;
	bh=ZQpmZi3xCboNCaTitC+DH8Zwcl8IPzrA6Uao2EOU9sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/sU0j5T9/xhpGlyZ+mEpYSKtRiTz4kX/bQiZxp9i079B044IvQVgZqzvVk0D4RMInmzn+BTHuzRqiYu5UjQtCEJFNQpXXFzxUsuxVQx88oVYltKs/a4qGPg6t5cqM4W7R3GvGLQRmkx3IGOoLQkQKEdrPih0F2WOQ6oWplLcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4mai1t9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4mai1t9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE31C2BC86;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409598;
	bh=ZQpmZi3xCboNCaTitC+DH8Zwcl8IPzrA6Uao2EOU9sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4mai1t9MrPfripNwkG+T4D2sdL2EKgkZEsiE7+/d1+6A635o536kp8D/PJk8JfN5
	 jY7ne68OA3MfMpRFOglO9rou7faRljM2edDo7w5fWjhhGT4z34ctWyOgLP5wIYc1Ka
	 OAzHwdsccUyFXZHS63EAhy68OeW+dJ//KdcIPegB+ChAlHM+7s7Y/Y7VD1ZXrjM53x
	 pCD8Nr7cqwwSDDKw0iWZAuQgDwoA/CxtRKlhxK36ZO32/k+CbhkaysSWLLq0gdKG1U
	 Wl+8fR0RKi6gB/0XQPF27N05gWr3DJw5EqGz+mTuBFqW/uxvOsDgnTfO9Oqr4W3Kn9
	 CcKWiujG5to0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYW-00000000LMC-2DMh;
	Wed, 18 Feb 2026 11:13:16 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 02/38] docs: kdoc_re: don't go past the end of a line
Date: Wed, 18 Feb 2026 11:12:32 +0100
Message-ID: <98da31eb6b5b2c84e960945e0ea283d3fcd2cce5.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The logic which checks if the line ends with ";" is currently
broken: it may try to read past the buffer.

Fix it by checking before trying to access line[pos].

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 774dd747ecb0..6c44fcce0415 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -269,7 +269,7 @@ class NestedMatch:
             out += new_sub
 
             # Drop end ';' if any
-            if line[pos] == ';':
+            if pos < len(line) and line[pos] == ';':
                 pos += 1
 
             cur_pos = pos
-- 
2.52.0

