Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354D357727;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=NQKT00MXFVS0nx2xbg9SPGwEXJSIkLk8v+KprmqGkBchHQoGBIk9gsUKe/YyHvRBaA2uOA6I/L/4N0ZPluVUDWveDSfaXPkD45TMFHisJlYF+uL6NGxcx0gv254+Q44mQE+8JKxUzxe/N56jDe8LnKH6PTlXKZU3lJdGTve03pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=yw3wjIPht+uMyxqsB9EmBpUiGx/X/g23mgLbGJyQImE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjirLgvoVbhMZlAWNavGH9uKhMx932B/HBf8tBC7G+2w2mkPEy/F/1gfb9+eb73cvRhH97beb+k4hiAEio1b7BS5R0tDmb4UUh3LrxbcIH3uzUz5o5YnMIfBFe0ZuptpfbUeqsGZ177ReZ0uredlqwJIz/3fYneyzPx16+ow+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5Z/gI9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5Z/gI9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B32C2BCB1;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=yw3wjIPht+uMyxqsB9EmBpUiGx/X/g23mgLbGJyQImE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5Z/gI9w/dNIrHboFLisXZawZdYJCm74VxVYg4w4q1Qu+fC83gC/W5pOlE1WF8mmK
	 ruledqO1vY8jYQNRLqljrSHXzoB/DSmYLlYMejuDtnfe7m5bUH6a+f9VGzI3X0UwPD
	 70+jmg6i9sptleGFqnibQMLYIEF0qYgExkLZPhQO8I9Kf51M64EvwR6dKq72MTZ6On
	 Mbmwi9Stftnvj4QIdc7/vyKqL6i0YMcYAqxOuG1a8HXUjNHp4YQcp0G+5G/WextMQl
	 V2cSk/2g8Bp0Vm4oxKfKFL5E1P1ClhC1+Budz777dsY66KjWT666oVadQoAtpmbqcS
	 iskgN3KPz/FkA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkG-2Cuu;
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
Subject: [PATCH v4 08/41] docs: kdoc_parser: fix the default_value logic for variables
Date: Sat, 31 Jan 2026 15:24:42 +0100
Message-ID: <2940b90b1ce4b63af2ac813404512c62cfb505f0.1769867953.git.mchehab+huawei@kernel.org>
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
index 201c4f7298d7..cbfdaba39494 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1035,9 +1035,9 @@ class KernelDoc:
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

