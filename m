Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36524389E16;
	Thu, 12 Mar 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327299; cv=none; b=locHk7aP8SODIY28Bk8/QJOgILmQZz4KMSJeLLhfihVz+cNQlJnwt2k5q+eyGJNqJOG3dSn/NegglAv1jpiEK7FLJtVzs7g55Jb+5SM3+7j1wUlS+eCE8Zms7Iblm+i01BkM+w1TmMNMP7YKPcvf8H8eWTD89LTVj5qATtZsxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327299; c=relaxed/simple;
	bh=PaOLRDk0iXEcEwnWCzqzsJpfgjdAgDVAImrhDci59t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aurb93eJ3dZRjCoLK0cN2iE/2l/cIKshk9kybl2H7QqB8I1trPEdUH6FaK8eltsakZKRcphHoQrwsO+OnDYr0C5Ldn67CBinIYzvnO811CnOu9ADmzFfRVk49+E1YOHuTY14NIuIuK6KHquDmSTYyPYfQnWaTaG7I1oF/ZUoUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxIVbJTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxIVbJTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162EEC2BC87;
	Thu, 12 Mar 2026 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327299;
	bh=PaOLRDk0iXEcEwnWCzqzsJpfgjdAgDVAImrhDci59t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxIVbJTpIRZrQcT3lAxZM7P5LfaKPUzvCM3GfGr+WEj9+h6qlu19Uc9iSbbf2Y2EB
	 V9+83zXFKZMiRrAfWG2oG16p3BLNbddc4gfV7/TT0FLCrq8JOIgMcpQpQP4ArERbl4
	 TpRrwYZu9VwgApr/OFD/1ons1hxBtCe2vEzP0OFfbsRfdi2GUAswfO11kI0heEDXp2
	 ahGUbKdLLc9knkJxjkLIhKaRJJm1knUMfxkvhmXU4L2oDRcvoiQrNXwPU+cuDtkIGT
	 /1GH1/Acrxllc8J9liZAYojcl5Mhg6BkGNi4SX2XGS7kzqlVoDDZXFmis1CE7+gnjA
	 xkSBAKEeF8Zvg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRB-00000008xxM-1ESP;
	Thu, 12 Mar 2026 15:54:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/28] unittests: add a runner to execute all unittests
Date: Thu, 12 Mar 2026 15:54:30 +0100
Message-ID: <fb0bcc317d30200b0e91a3c18150e7394844b6d8.1773326442.git.mchehab+huawei@kernel.org>
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

We'll soon have multiple unit tests, add a runner that will
discover all of them and execute all tests.

It was opted to discover only files that starts with "test",
as this way unittest discover won't try adding libraries or
other stuff that might not contain unittest classes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/unittests/run.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tools/unittests/run.py

diff --git a/tools/unittests/run.py b/tools/unittests/run.py
new file mode 100755
index 000000000000..8c19036d43a1
--- /dev/null
+++ b/tools/unittests/run.py
@@ -0,0 +1,17 @@
+#!/bin/env python3
+import os
+import unittest
+import sys
+
+TOOLS_DIR=os.path.join(os.path.dirname(os.path.realpath(__file__)), "..")
+sys.path.insert(0, TOOLS_DIR)
+
+from lib.python.unittest_helper import TestUnits
+
+if __name__ == "__main__":
+    loader = unittest.TestLoader()
+
+    suite = loader.discover(start_dir=os.path.join(TOOLS_DIR, "unittests"),
+                            pattern="test*.py")
+
+    TestUnits().run("", suite=suite)
-- 
2.52.0

