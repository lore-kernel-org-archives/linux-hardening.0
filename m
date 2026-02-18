Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3834105D;
	Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409600; cv=none; b=K1nzeIROPCfVZKYnQFo82WesaHyTxXhfrD3rTiWKo/QI7s1W0BeNKaXDuDqMtS5OtLKHvqb2MC0mz2c7ln8wA95ChgsVcNN5siK+L9XYmYuu/7e75LGqRJPSg+lMRl3rcmw9JaB8lQytSQfDxUVWf+8qJkVXnXMKdQCZNqwgih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409600; c=relaxed/simple;
	bh=SOaPcpSwL2YOZCy5eFxw6vXlh6YPzp2zJBUs62B0pPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXaC9lZiwtVTXJVn+4ncDuYJ0c4Bl786Zf6Oy/j2iZcBNW16m5HcutgJ9TuOlBlavZJIcVKkTNHNNiNgTQLr54G4z+ilyPzjBb2D1RPgK9pTUXQrVb+fdW+j37EtvO+0Hwt+kNcOcKbWmnehHUEe12iaLWq/ZOqt+0eNKxThw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQKq7jXQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQKq7jXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AB1C19421;
	Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409600;
	bh=SOaPcpSwL2YOZCy5eFxw6vXlh6YPzp2zJBUs62B0pPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQKq7jXQAmnA1oi17FdW1WrT9lMnn/BxlrBnoB38O4kWhyj2xlLjtbM5SZFCp+kvw
	 nnhJlECeI4ozMfT81rso4oUW/f/vIAHy4h2Vdg/sDz1xSMGvwpmDfcGoe1u+S5NEqN
	 tPDK5O8K1r0+wDO/7rOmxS/ODjxxmVsa+CnhhUZpk/lHkJ5Mvr912Oz9Au/8FI8CNk
	 s+364r21AxnZXLoAaXjf3bWb1VOqXDdmkeRY2HOKIeehkAy/Od4ZJ0VJ+QRTLoZIkd
	 dogFzd2iBPNdPPLWXOkSm/0LZw4ek1MeGsLpDh099eFQsXCJklqXDA0YharYHMa4rw
	 gpnjrPPbhFwYw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYY-00000000LTL-3hcM;
	Wed, 18 Feb 2026 11:13:18 +0100
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
Subject: [PATCH 08/38] docs: kdoc_parser: fix the default_value logic for variables
Date: Wed, 18 Feb 2026 11:12:38 +0100
Message-ID: <6141a2f9378a79c76b3a8e860b82c46bc8bfb048.1771408406.git.mchehab+huawei@kernel.org>
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
index b63d91b7f79e..abfa693051cb 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1036,9 +1036,9 @@ class KernelDoc:
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

