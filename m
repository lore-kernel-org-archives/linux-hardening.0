Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C761426D15;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469671; cv=none; b=WhkZOOCBMldCx3iL+0V7N+H3pocg/HobOjlzVi1XZLE0IFL10wbZUvk87+/HTUBvf8wz7Z6zFkZ9mLnTTmFi+Rb4xZauEQCOr6/7ZgJzOLf6SEQ9MxY80nSwOZbMwZ+Afo068J1R10lqK71e9XaapkXfJ8Bey+kartPg2mPK26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469671; c=relaxed/simple;
	bh=G52yNr/mjvH//WKN8I/I22tm0myDjYubrgazvSxDbzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPzGaA+74CG4Hw5vlF5RDoBVVgVq8z9e/b2Yaj9Py3/U/X/r3um9D5wfhQG8J9iMpWQEgGAltTl5AQ15qBHQdVzI2DfmlsKWl7zAVwCEIBkcvHt6ujhYeKxJuviKeUDYDBCVSnursZiWOUAvmifeMM+5jb2y06RwEGFgNkcRXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Paeiv/e4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Paeiv/e4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD20C2BC87;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469671;
	bh=G52yNr/mjvH//WKN8I/I22tm0myDjYubrgazvSxDbzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Paeiv/e4uMb5jfkxD9Ej7ISMmm2u6rvgsxtr36hWtUYono287sIVUitmcYttya+ta
	 CI1Pubsa244rO4mqN8N47vp1cTyYdnxmlvDXea1oamStj3B9EjB2mOR6yFAPm/7QI3
	 f59K2uyVp6djDUAosimso3VJck04KgZVQaRq3vqrmHEyVbflsCI0Y9HIkxtC4JfJL5
	 qWSr3PddOFmZ8AYyO+pZiXAGMyCh6sIILIH8d/DUjAaBm+F4wBqIKQX0VAkmCATuZD
	 dCaTYQDc+DphChemHUakuOLSxzS1WDLlgExiSiMymfxYh5FFrFULy752Yu2J2rJDf7
	 ZYl/skuh4AN0w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KT-000000003ES-2Qxk;
	Mon, 02 Mar 2026 17:41:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 15/18] docs: kdoc_re: don't recompile NestedMatch regex every time
Date: Mon,  2 Mar 2026 17:40:58 +0100
Message-ID: <0cf2b72d4785aa8b727188b56688ff442d1c65ce.1772469446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Store delimiters and its regex-compiled version as const vars.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 35 ++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 0a7f12616f9f..00afa5bccd6d 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -99,6 +99,13 @@ class KernRe:
         self.last_match = self.regex.search(string)
         return self.last_match
 
+    def finditer(self,  string):
+        """
+        Alias to re.finditer.
+        """
+
+        return self.regex.finditer(string)
+
     def findall(self, string):
         """
         Alias to re.findall.
@@ -134,6 +141,16 @@ class KernRe:
 
         return self.last_match.groups()
 
+#: Nested delimited pairs (brackets and parenthesis)
+DELIMITER_PAIRS = {
+    '{': '}',
+    '(': ')',
+    '[': ']',
+}
+
+#: compiled delimiters
+RE_DELIM = KernRe(r'[\{\}\[\]\(\)]')
+
 
 class NestedMatch:
     """
@@ -183,14 +200,6 @@ class NestedMatch:
     #
     #   FOO(arg1, arg2, arg3)
 
-    DELIMITER_PAIRS = {
-        '{': '}',
-        '(': ')',
-        '[': ']',
-    }
-
-    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
-
     def _search(self, regex, line):
         """
         Finds paired blocks for a regex that ends with a delimiter.
@@ -220,13 +229,13 @@ class NestedMatch:
             escape = False
 
             d = line[offset - 1]
-            if d not in self.DELIMITER_PAIRS:
+            if d not in DELIMITER_PAIRS:
                 continue
 
-            end = self.DELIMITER_PAIRS[d]
+            end = DELIMITER_PAIRS[d]
             stack.append(end)
 
-            for match in self.RE_DELIM.finditer(line[offset:]):
+            for match in RE_DELIM.finditer(line[offset:]):
                 pos = match.start() + offset
 
                 d = line[pos]
@@ -247,8 +256,8 @@ class NestedMatch:
                     string_char = d
                     continue
 
-                if d in self.DELIMITER_PAIRS:
-                    end = self.DELIMITER_PAIRS[d]
+                if d in DELIMITER_PAIRS:
+                    end = DELIMITER_PAIRS[d]
 
                     stack.append(end)
                     continue
-- 
2.52.0

