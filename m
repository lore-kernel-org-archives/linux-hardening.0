Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D13F8806;
	Tue, 17 Mar 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770989; cv=none; b=fTvULSKAPNurHZcPqRGHx+TuboaLrdz6KRHhDwbb456+p4ph4SLFRvef8A5CLxfZ3Ehoox9PLfbUAN16v8837/pYnlUl0pcH0Ly2o0RLkJDbUPb7fejr05rM3D0MmOskDCrCnW5h9CD4AfWFLYRhU/DGeD/gADJ+nUXB1O5qUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770989; c=relaxed/simple;
	bh=PaOLRDk0iXEcEwnWCzqzsJpfgjdAgDVAImrhDci59t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW2MGxUxdvWTkSN8jdJDo4LPl5Z7qNSTV6EBQMUOI0eeH2rBL8yD4KA6J8taPz2WxTI43mf9EN0WQ8z+yXhEweLYfq08+C0jOOyCdMohZ3mQhb+bQ+ewaWR4+rE952EqbSW6DM22K5nrv7oXs6NJ5LjEO5jB+QYGqixsa0GgQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9nP3g5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9nP3g5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F02C2BCB1;
	Tue, 17 Mar 2026 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770988;
	bh=PaOLRDk0iXEcEwnWCzqzsJpfgjdAgDVAImrhDci59t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9nP3g5OeSEBpEAsa1hvwtaqPORS6dNbK9/Ndlw3rE0tptUCD1gEfVoduy1JEbmta
	 uEJneWemXulDiXVXrw6f7V+Z8++B4k66YF1AvyWc0mLLc0oSUe8gcwgcykLOHL00AY
	 2yNvLi4pjB3bn5xH24TMuzxAVS+U3037VSQ8uwD2KjdNSh3CFE1bJRkY4W8CB1cksV
	 sq7ja/N4bW1clvK/TGzzKdcGN/yomDYAfpLYQQjQPXw+V0QOvc9kWrxC68VVy56swg
	 ltTo38Z4huHtYV272vG8KrAmJ7LQ8xKyTxUA4hSWLRPxRq7xlDWonb+S+tNpftsCun
	 ZfMDgLVx4PSKA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrT-0000000H5PL-0Lt3;
	Tue, 17 Mar 2026 19:09:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/22] unittests: add a runner to execute all unittests
Date: Tue, 17 Mar 2026 19:09:29 +0100
Message-ID: <2d9dd14f03d3d6394346fdaceeb3167d54d1dd0c.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
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

