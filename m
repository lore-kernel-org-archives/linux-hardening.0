Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779D358D08;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=jl8SjJC7aAai59NABPdreXn2Qwd93idhiZkzvwgrU/JCk9a9Uo9SwbNK/PpFxU/jcPABz/0Ec9y77pKRfngp9Iw94v+2eMK04R+2sTx2Ue+SmgxbkAky0Ztt8LfYc9HI4xTpF+0+xIhWY7JuB/V+2XurmeMAsGMu/KCzJ1VzJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=T/tjtljgzM6ONqM7zhOV7Yk4y75K/wRjyLKxDsGKFtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJggXgVQs1plvs7oZ4TEsdQBgYltfbWYGsMyENw+0mYGczcnoekikwO1MDqMSV9BoTaUhT7jxP3N3MKBfbOE+zMcw8H7m5K8Wzu0AIZi0rAlpDLmG8geabjM6eJPHiHccONA5wZyWotav79Y9TXIvS04utBY4dg6Fnh8bdEpXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkI80vV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkI80vV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E28C4AF0B;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=T/tjtljgzM6ONqM7zhOV7Yk4y75K/wRjyLKxDsGKFtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkI80vV6n8l3oW8lP1wSbfB0XPQ8C7wAan32GnKk0HvATwLICSCBRX2x6QZ/ajzb+
	 Ty5boZfyRuzsQg+Y9QsgOtZuDo4SUQr5lWk4jjwgPg7sc4Yav4O2DQJ9iZJgZRapyk
	 E5ybY6Y6tWdiOxZoq+qVgvQvlRKvEgzNJz4eQDcSIXQW6TG/N7AFZby0zH99zIjXPj
	 cIbzMxpTBUBrrG+nQMWj/sSNLVW4zVVo8sKcrA/2g7VEBI6B7QSnSTLv40mVqoilIe
	 VZoOB0MMKmay6en0IPHcwFqEkQReiNZw9dZhbf+SHLnfBetOI7e7/DCcZMYpMvEWr0
	 NYIjs6aVBSVBQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVki-31UN;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 15/41] docs: kdoc_re: properly handle strings and escape chars on it
Date: Sat, 31 Jan 2026 15:24:49 +0100
Message-ID: <6c8e7354e4aa7042daae46b8c778c4195de10df6.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
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
index a0402c065d3a..1861799f1966 100644
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

