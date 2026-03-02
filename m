Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E7423A77;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469670; cv=none; b=U6+CB8iuf9iyfUiGLlp/9yFKToRheaGU7ZdWas+qqaBah5YlKyp0zUQwBBvsB99+VETBNSfVASba2yZiUl1KiWDHViquc2w5mrxicOJFy9l4TN6yFbESvC7z8qBUw69f6LJaSc81Y8inhuYuM3Pr3Jv3ttrew436gwicNS1F5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469670; c=relaxed/simple;
	bh=JFl/dLUF5g2ndZqfUyzTuu/xxP7qt+WvHToR++nCWEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHFG6oNqmK/TK/W1ga8lutnAg9lK9M+8BxnRk5p2irMJpLVFLyqMRTaBzVNz5IzrkX0FKbjH11NJR8uc4QXoTFL1/v1cQwZRvgUCOZmpCMsKpZNHkXFdh5N6ddRa56lQivaH/XV5QlF+ZyIHEW0XMHNtMsX3z5oEgMzeSsS/K5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A24yQteX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A24yQteX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B760C2BC87;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469670;
	bh=JFl/dLUF5g2ndZqfUyzTuu/xxP7qt+WvHToR++nCWEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A24yQteX5U1M5fNAhThvq+29qWdIp5RcIs/U8xTBS7BbN6IGm4HWGo3tgi3SFwz0i
	 NRdbldVsysOfYhiOhgFl773BTWvNPnRnOJmiZpMTUMDBoIkzGAYNPn+z6CnGLFu0qE
	 4sCSyR2C/mhTePb9OivF9qjq7vYfSNsc/ZJDDigBc/BYCgkEXxuBui0dSNJt9HXu+o
	 DNdZjBDIvPthIcqWY/q/Ch5Ko1AS4oNYwUx5V2kea6uVfvwJZyvn/KrxERk/j9BtQ/
	 2vrCGQ8lAX9sOcKirMXJlEyn4HkjqcLnrZjY4/lAzYoKa+qsZfELnRAPH07gzuTAC7
	 noL9RtqqJVIbQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KR-0000000033S-3anc;
	Mon, 02 Mar 2026 17:41:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 06/18] docs: kdoc_parser: fix the default_value logic for variables
Date: Mon,  2 Mar 2026 17:40:49 +0100
Message-ID: <681f18338abd6ae33cb9c15d72bb31a1cba75a9a.1772469446.git.mchehab+huawei@kernel.org>
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

The indentation is wrong for the second regex, which causes
problems on variables with defaults.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 9c9443281c40..4bf55244870f 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1027,9 +1027,9 @@ class KernelDoc:
             default_val = r.group(2)
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
-        if r.match(proto):
-            default_val = r.group(1)
 
+            if r.match(proto):
+                default_val = r.group(1)
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
-- 
2.52.0

