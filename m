Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B3243367;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409598; cv=none; b=CwEkpIjOJTFjZiaqyQuUhbmiNwG22InREHFmYAz7YGt1kWEjm9KLrWte1EeW42oYT7dAsxf4lAfP8vw5nJWzjT0SyGizhusHSvjYO76Nw4o1hFeopJy0rCOyY9mroNtcsHFyKVccUllTN499UtLqzSuqym4r155JP1koaALn2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409598; c=relaxed/simple;
	bh=Mq94eCCs+RKATmleknUccsvrIqNogkHHQ1NGR1scPL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1/qi2ys5MVbobKuZKGlDi8C1+XNCa2m9lvM45+TjRQTR79+TSAS/CkHh70vxkmsRdpZuRNsVhrxtCmk2G3WZIpKbbK7nnDvj3+5fN3VBOZFrkaZPiQzOpr6pfvV4g3xnhuinOVypl8m87YdfUltr7ddhUdPV6bBzXJqyAIyFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+9PRPJS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+9PRPJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2914BC19425;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409598;
	bh=Mq94eCCs+RKATmleknUccsvrIqNogkHHQ1NGR1scPL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+9PRPJSkjz11xvjOQGqeiX1T1CMS1ZijJxTf/OBtdeedFvvTx/WzQJZCMtcnEGLN
	 oS7/wIqluqzChdEfIhT2PaNOIn4rle3aieEQKaqwQ1bos38Uz9YEhbr4GfYSJW0dIu
	 yTXZAaB5WnO9cismVDnyNRH7HN6DE7B4OID1PEOUgCxsrnG3SDecUr2ybtaiXWLEdU
	 Bi8UZNa3fBnmLnDcv3UMGGAKt9nnWjrreTjGradPefIWDS9W1uvq9Ag/6zA1D8pYFQ
	 bsTnUA9BN/6ZIUVuw3zq+Yb2xzyKGoNBt9jvPGGv8hCMq8neI7CvkQny/kLPbdSUOJ
	 iLqnG953iI+0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYW-00000000LKh-0WnY;
	Wed, 18 Feb 2026 11:13:16 +0100
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
Subject: [PATCH 01/38] docs: kdoc_re: add support for groups()
Date: Wed, 18 Feb 2026 11:12:31 +0100
Message-ID: <49b2f5bd2284b0685d8a8ab363d60f89d4d53935.1771408406.git.mchehab+huawei@kernel.org>
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

Add an equivalent to re groups() method.
This is useful on debug messages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 0bf9e01cdc57..774dd747ecb0 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -106,6 +106,13 @@ class KernRe:
 
         return self.last_match.group(num)
 
+    def groups(self):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.groups()
+
 
 class NestedMatch:
     """
-- 
2.52.0

