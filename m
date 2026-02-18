Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D7345757;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409603; cv=none; b=QsW9lFBJzpEK8icv0u8+YzcOZIsjeKlo23RnHNHknRVX1/4JA3Q7PY5kVtaieHit+7JMu/ww2nER+TYPOZPMsnTUuq/QtBdqA4ukY3udUrLJ4MFoa/VdekfUES22yKZ9fprz6+MzLV2AT4GvGEqnqPW6PJTmwapPaCLgRwPFYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409603; c=relaxed/simple;
	bh=2s+fzq6gQbWuB1ApycJQ9BmmsdbPbLOVTREB5x1uqxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZXobOedcPWiW0uOmHUiEnFq5JkUgGbB712DFfEz1Iy0DA5F0pbjRDTiROq9aeWH/33+xHW9BYb/ivx7xgBQ09cuk/0krxI3Z51cZULS1e6THdYmHacPQQa5FakKmxm3UqwLYuJ6phgKU8JBg4Mb4pizr2drWYuid+tLRM9CRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXzlsSSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXzlsSSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46342C2BCAF;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409603;
	bh=2s+fzq6gQbWuB1ApycJQ9BmmsdbPbLOVTREB5x1uqxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXzlsSSLNhbbqZv4lPRJrQvqahR3ZaCkRyRkFGnD6lg7Sy60W5BiePskmESRP/Cty
	 Al/DpzbA4GpxnY4SYtJWZ5vowF3oLv4OTEQPtc6+J+5sNphAgmrH07REMm3xP2LJxH
	 Ium9012IyjZQcYf/hl6TSD66MGlgCs6Bnz85TBnTW+as9GhtZUTi0G08kF9Fpa3EXJ
	 mBSpw2KqNuN2kTo+wpsEjT7i+F74cTLDQwLWrdUt/8pwmxnouST8eJtr7jlRkuO6Za
	 vGLJoV+iuj2C99MfdyjGtV5OW5J7Q8M9CtNXH3gjF6rtgHQATdS2nIuxVU7tMRyo4y
	 zXJjPqeaV7j4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYb-00000000Lc3-2Hp4;
	Wed, 18 Feb 2026 11:13:21 +0100
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
Subject: [PATCH 15/38] docs: kdoc_re: properly handle strings and escape chars on it
Date: Wed, 18 Feb 2026 11:12:45 +0100
Message-ID: <eba972628cc478ab977d0403716029e9190ef9da.1771408406.git.mchehab+huawei@kernel.org>
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

The logic inside NestedMatch currently doesn't consider that
function arguments may have chars and strings, which may
eventually contain delimiters.

Add logic to handle strings and escape characters on them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 6c44fcce0415..420cb8879ba3 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -195,6 +195,8 @@ class NestedMatch:
         for match_re in regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
+            string_char = None
+            escape = False
 
             d = line[offset - 1]
             if d not in self.DELIMITER_PAIRS:
@@ -208,6 +210,22 @@ class NestedMatch:
 
                 d = line[pos]
 
+                if escape:
+                    escape = False
+                    continue
+
+                if string_char:
+                    if d == '\\':
+                        escape = True
+                    elif d == string_char:
+                        string_char = None
+
+                    continue
+
+                if d in ('"', "'"):
+                    string_char = d
+                    continue
+
                 if d in self.DELIMITER_PAIRS:
                     end = self.DELIMITER_PAIRS[d]
 
-- 
2.52.0

