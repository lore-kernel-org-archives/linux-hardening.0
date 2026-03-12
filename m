Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2303AD506;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=qkoMlkBq4W/qp4DxhrL0PyQF+YLQ1dsuo1lT+nLqSjgUYmvLYZ86I2JD+duNXdR1u11aoGA1mz9mm48422MG1Yc2hkNkW1BidAlwH//8vUgQT6bR7kzVR4IbhLLBRQDhLrkansGOs/sGwgGguhc8Nkp4BJsymK2JpK+TUDzXd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=W96OAjKB97J1xqMhi+cvTRiL2/QBqbUoTe3vi3d5Tzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlK6HFnX5m6zR0JFHBbfyBxF2yVBSyxP8chpvA32gWNBpV0zYX9QOge/pSPy5rgOE8ILTn41MRU8yfJn4GAtm3N/Hsj010lSxTlizjSUT/mdti4kb18DuYpOzTHat3a1AIxPvwFOnmqHBFRkGzEfJPkcd9DRcIN6WsoGhXaktAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3yLNonJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3yLNonJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693DAC2BCB4;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=W96OAjKB97J1xqMhi+cvTRiL2/QBqbUoTe3vi3d5Tzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3yLNonJjnVHSI8xp/o9CqQfdBeRZL0XpKAhBwJpO+BFSU5s/C1zMyWhkq1XrtThR
	 0f8SoE6nIgSIxzJVQvBrN7soi5yP4fb/452HtZo2whWdMhinWRxvTKowFlQZc5DZcx
	 7/6XuAL6TEln5iKuTRyIHxmhgvWZIpPTyIwK4Djy974dD10FXJoFsxE/am7FTkNzbn
	 b2dH6+RODjhTU9c0P1GZ4oP/fVI1alfO8TGr1kTHLY7Du7oJ7czUbyNQqHoNdYVHNF
	 DecJVahFNXKHnP2cWAsTJLk9RUSpnvy22kfvEtUQ/uN1Oa2SMmrvi1K3D/WB/e1UNP
	 OPcetQ0C/KO4g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077ge-2LMt;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 10/20] unittests: add a runner to execute all unittests
Date: Thu, 12 Mar 2026 08:12:18 +0100
Message-ID: <fb0bcc317d30200b0e91a3c18150e7394844b6d8.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
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
2.53.0

