Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FF3C73C3;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327301; cv=none; b=Ud/ZWPHZEM3AtvkAbs4skfi7xzDZNQvvs2hc4oo84ODowg1JXTVewWrUqOxQjYi/ZSHQu5MKPaAulPAeNIE+14lJtKR0RgjUuIou5L83FHUxGnLYf4oNVG8b7LE8uwmbiyR0nlneY2Y275MjJ71As0Qqes/OFwrDFFk+HwakTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327301; c=relaxed/simple;
	bh=s2JDL2gq00i1CWo5FIbS5c+BZONFq0wCeRu3fqck2jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnQ/S7qyU/piocLOL8U6Nqvopv3llADJbcHKDQZy58eSo71bT5vzjZIJCsb7ZhBcHtN3EsH0JzWeDSdVrUadRplQ3kOYGzRgk5ntMoeJFpMoCXOUFaCn4ZnTimJzMUvbTjGHuPkLnq5HEtr8QI/LtNxz/utElL+w3cT+SfryTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwd3yTaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwd3yTaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08D6C4CEF7;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327300;
	bh=s2JDL2gq00i1CWo5FIbS5c+BZONFq0wCeRu3fqck2jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dwd3yTaGtB/revW0Rnq8Qo3hRrpyszX9dMATYcXHcMb7C4nVcqqBK20Cp60qg0AqY
	 Tr3wAclCd25YSr7b8Ip4ph3o0kXQHhEqzspJqjvL2wOUkZycYZwXi4UgiZjlH9/ygb
	 dpKhnql/x87QmXIsyNcVQ1qbrtq+wb62SdAsmV+kZq08AuonqXiDaJmPibml43gLg5
	 P66xHz98EyxAKvxoo3F9Nl6+u3zLCCGrugAAelUJ5TEHNDSuRNdM3G/KMEKaEGfycI
	 R41f8JuGK84bZt9rC1+nEmxFKfOjDVGi1i7lbQMfzDybPWWdER6lqzbuuqpOhiUCg7
	 1lUYFuhAFXA/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRD-00000008y8t-0NPq;
	Thu, 12 Mar 2026 15:54:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/28] docs: c_lex: add support to work with pure name ids
Date: Thu, 12 Mar 2026 15:54:39 +0100
Message-ID: <8ad16ddc6d68d0cc09a16818b240df467a2c7d93.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Most of CMatch complexity is due to the need of parse macros
with arguments. Still, it is easy enough to support also simple
name identifiers.

Add support for it, as it simplifies xforms logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 98031cb7907c..689ad64ecbe4 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -477,9 +477,17 @@ class CMatch:
 
                 continue
 
-            if not started and tok.kind == CToken.BEGIN:
-                started = True
-                continue
+            if not started:
+                if tok.kind == CToken.SPACE:
+                    continue
+
+                if tok.kind == CToken.BEGIN:
+                    started = True
+                    continue
+                else:
+                    # Name only token without BEGIN/END
+                    yield start, i
+                    start = None
 
             if tok.kind == CToken.END and tok.level == stack[-1][1]:
                 start, level = stack.pop()
-- 
2.52.0

