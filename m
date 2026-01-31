Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8E3590D8;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=S3pwLa9O+qnPO16iR5XTJ/Ohc2pQilX0z+X63IlsPvv+sG0v6bEi7m7PtBgMPpHJZiw7oRLm/hDWUwfmbkVpRmqs08c4Vp0TFstZUBiQiWCDXzrJKnd1+dG2xiHvJiQl+4GKLYFy0UUzBBGwbfQaeMivpe5jDWeiGE4fxjiwGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=5oi2Tl2xWpO7qRnpBsDD+tLfzI2AZ4/vIG5DDw/7oQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcWhYShW0/zWvE4si87D3OSW7mgSrsEqoj728lkI4yHCa+Ja6se8vnxX2L8Z4ve0KuW5BcvG8KeLXWo3VfUTA+Uo2Xt2R/vDjWgJqn0kDhCCv16pz9O46UWsXRJHuf5MQGHVwjfo4Z1cxakr5RH0D3zOpOzF6r3vYCIXSf7eI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVDclQXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVDclQXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E27C4AF15;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=5oi2Tl2xWpO7qRnpBsDD+tLfzI2AZ4/vIG5DDw/7oQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVDclQXuAyozih8q+rZxUGbQC7kga7zXBPj1SQtLdXQMWOBq9vTCiHyP0yWfGjamY
	 5c5n6DO+c6X1qnQod2ReiapHWU7OxOmVYt1yuXnp0WNC+9oGBnyq9zGlHTcgZcar5j
	 0SXODn3RgFXvRob/iOywCjtwyB8TBH2hvU6xObs7hVKqsY7TCVlS8W5wptNwV48SEl
	 LB/revnYGsJYy2PvLk2+IewUIYMCB5CQfCr0XHcJxKnYVkRpk9DTdDSWdv1eQZMhfU
	 X6np2g1+sRpBF2X9ZiyfBre68WQvdaSntSCeTX96du5Ik58dbQUp3daI6QymqYeF/k
	 uAjDiHjtc7GYg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVlb-0LvG;
	Sat, 31 Jan 2026 15:25:20 +0100
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
Subject: [PATCH v4 28/41] docs: kdoc_re: prevent adding whitespaces on sub replacements
Date: Sat, 31 Jan 2026 15:25:02 +0100
Message-ID: <99fafea263739c19781c4e4d0dd2dbbd2c472df3.1769867953.git.mchehab+huawei@kernel.org>
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

When NestedMatch is used, blank whitespaces may be placed after
substitutions. As such spaces are part of the C syntax, we can
safelly drop them, improving the quality of the output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 294051dbc050..886e33ffd2b9 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -341,8 +341,12 @@ class NestedMatch:
 
         cur_pos = 0
         n = 0
+        l = len(line)
 
         for start, end, pos in self._search(line):
+            while cur_pos < l and line[cur_pos] == ' ':
+                cur_pos += 1
+
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
@@ -365,7 +369,9 @@ class NestedMatch:
                 break
 
         # Append the remaining string
-        l = len(line)
+        while cur_pos < l and line[cur_pos] == ' ':
+            cur_pos += 1
+
         out += line[cur_pos:l]
 
         return out
-- 
2.52.0

