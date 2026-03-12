Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6C3C8725;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327302; cv=none; b=RjFp5v9Kys4HSDMXm66akqSjEuBF/Ns88WdyAoWn2JxICxdPUwOFc4AZUMU1JnoYwjSsPY5LRSXpaJ1URrIwwWqI6QMentPkQjLcFlbm2t2NW9juGMEkN6GsLxYg2YTpaSfhLyMbZ5hHuTzSPe+aXIfH8c9IxhHst8bzfr0Zqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327302; c=relaxed/simple;
	bh=cocGuR4ahs9fGSXrTE4ktj6m/i8U23Nz1YJLPdQXD+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBLo0dXhE8Mch+hPEpEWn+d7EJ44Eg+ekFq6OeRZDcoZiEeuCaSUYhZ9CJ6Vd7RQOINgoJo1nv/Mr/sO+Ga2ly0EbF+ncMfXXKmTXKQ6D2r4lprWwSBxfNKFAEu3K6O19c2amPgvmKu1/MAgyyX6mUOPDziaT180n6Sjs5CA5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLClXvvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLClXvvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D46C2BC87;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327302;
	bh=cocGuR4ahs9fGSXrTE4ktj6m/i8U23Nz1YJLPdQXD+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLClXvvCD1iF/POzGTn4ZYtoPLjK7h6NFbbpV/8A2vWbKV2LWCrRNu6XaNswCu94I
	 AoSGYLPEsL8FfRf72boEgcajK9RZvC24Bfk6kYMPWXuY1tuoYz4WzlggB2GsLiZOvh
	 NfmoZaVl/PAP0Mxt8C4vus9sqeOqth5APUwXb9F76VHKnH5SS8GeQYc1UihGV3yyzM
	 yuYGVcTaKEMmiwwUTdcktQFLZWVAUOQ3PdKR90VbOHZE8Ffn3VFhpS/exfRPbkB/VR
	 942oKQ/lmmdQLhBtfXJP2dqprqpZZS7CCrEzugit+whN2McVP2M8gsMgL1ZV93/0Km
	 R+um/JXza9nTg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRE-00000008yJ6-2l6g;
	Thu, 12 Mar 2026 15:55:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/28] docs: c_lex: produce a cleaner str() representation
Date: Thu, 12 Mar 2026 15:54:47 +0100
Message-ID: <5260e485da8f1993bb1bab17595672f2601df6f5.1773326442.git.mchehab+huawei@kernel.org>
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

Avoid adding whitespaces before ";" and have duplicated ones
at the output after converting to string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index e641bace5d69..95c4dd5afe77 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -241,7 +241,7 @@ class CTokenizer():
         out=""
         show_stack = [True]
 
-        for tok in self.tokens:
+        for i, tok in enumerate(self.tokens):
             if tok.kind == CToken.BEGIN:
                 show_stack.append(show_stack[-1])
 
@@ -270,8 +270,29 @@ class CTokenizer():
 
                 continue
 
-            if show_stack[-1]:
-                    out += str(tok.value)
+            if not show_stack[-1]:
+                continue
+
+            if i < len(self.tokens) - 1:
+                next_tok = self.tokens[i + 1]
+
+                # Do some cleanups before ";"
+
+                if (tok.kind == CToken.SPACE and
+                    next_tok.kind == CToken.PUNC and
+                    next_tok.value == ";"):
+
+                    continue
+
+                if (tok.kind == CToken.PUNC and
+                    next_tok.kind == CToken.PUNC and
+                    tok.value == ";" and
+                    next_tok.kind == CToken.PUNC and
+                    next_tok.value == ";"):
+
+                    continue
+
+            out += str(tok.value)
 
         return out
 
-- 
2.52.0

