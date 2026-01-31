Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71143563FF;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869521; cv=none; b=QVqfnXvuz8yIaL/biFKzoL2ZTT9ahrAu4oUxpJDbo3Ycc48M17L5KNG3D/9FhaRbX5G6V+LOPLTDWMgrKT0TXSLMSi9gpr8Yh0+gtkjslCtNS2lozyZxm6/ezs4YdDJERLE+GML9yAxpajQrnTQ44xovLV2Gu8rlplu/8p6CV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869521; c=relaxed/simple;
	bh=jWm+CmUFkxoOutvSyo+VT0i3ZnquT0lXIxHybrc0xCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Np0Ud9z0vCVL/Gu/SlUtsakMyEb4HzjQea/d9hLjddk8Il8NtSIhvhHkxhpp4h7l7pRO7XJ01hAkvIEniBXJyCl0MwYAp7QbN1Gq62gXatkK5mOhim6fDFlGLtMSY41rXqtsAdu9OCtUxCMmSYKTJnQFQdyYa/Ha1y3uI5ILytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atoMH831; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atoMH831"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5DEC4CEF1;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=jWm+CmUFkxoOutvSyo+VT0i3ZnquT0lXIxHybrc0xCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atoMH831TdPUZHcjP/q4dYY6e2+IqK4edHjH2ZRrVXlZggeRNTRPCog3oTqIedFdg
	 mDj4doz0Iv2A8YixwYzdXWmMP40a9X6i5sQk9NxOFrQ5LX/8o6eb8FnrLjhCzonpFQ
	 kSghVv5EnmlEGGyBqvgSxpi3SGPF7MCrL4dl7OQAwzwb2S++G6V7/9sBvt5LsM+fKC
	 y0gd/npr001YUPZHMKaiGKBqx5LBTbah+at/heqTuVnv4wtBl9ba31vnbE72WZmFML
	 2FVvNSdaFjKDXhD/gJmu526yEByb4HOuV5GW0t4aEAEBWfgWU6YFjTY5xBhajSczYE
	 i0ODuqJQXaovg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkK-2K4i;
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
Subject: [PATCH v4 09/41] docs: kdoc_parser: add some debug for variable parsing
Date: Sat, 31 Jan 2026 15:24:43 +0100
Message-ID: <de3fbfe7a2602f5c4815f311460e87ba5c27a530.1769867953.git.mchehab+huawei@kernel.org>
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

This is a new parser that we're still fine-tuning. Add some
extra debug messages to help addressing issues over there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index cbfdaba39494..ccee4e0bcaab 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1033,11 +1033,19 @@ class KernelDoc:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
+
+            self.config.log.debug("Variable proto parser: %s from '%s'",
+                                  r.groups(), proto)
+
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
+
+        if default_val:
+            self.config.log.debug("default: '%s'", default_val)
+
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
@@ -1045,6 +1053,9 @@ class KernelDoc:
         if default_val:
             default_val = default_val.lstrip("=").strip()
 
+        self.config.log.debug("'%s' variable prototype: '%s', default: %s",
+                              declaration_name, proto, default_val)
+
         self.output_declaration("var", declaration_name,
                                 full_proto=full_proto,
                                 default_val=default_val,
-- 
2.52.0

