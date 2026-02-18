Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8333F395;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409609; cv=none; b=iE/OHayV76cyXuUKaDFjarPZbyBB8gi16A+42M1cWAwhO8nbuqJ0YI0xbgJg+c59nRo5wRjPoKEj7nZd0rmVZqpI+a6nhV7c1NIEmjUt94bxwFbZYbOulO9xXb2e/6ei8QTJJHeZUvmZ2rNULxC299/1JcPo7gLC2U0qLUKBjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409609; c=relaxed/simple;
	bh=yQBydwNaRIYMlzU4Ubfa3gdUJcPIj4ppbNTFE+NM7Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqLA3auLJr8k9jxDJrL0NMybMItxBnRRnbFOSxHJj/XOl31TVK5PJ70zpj/WfM9s/57qFLUaN+7JZjyn86/9GH6JlBP8o7NyGkbZnHYnicIBPIsyckyNpAMxlOKs5br+tPuDQJGzuolj62S/kD/cylnePRXhSC+xlgz3rY4wCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYJ1wD6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYJ1wD6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39346C19421;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409609;
	bh=yQBydwNaRIYMlzU4Ubfa3gdUJcPIj4ppbNTFE+NM7Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYJ1wD6tseePJcKQKbRGVSxpEMfowqnIii6b7lTyIP7X3gOW6ouyFqT1d4g2obgZv
	 D9EJKHEKg0KjkEPQgzNK+VHrRWm1pRD14A1yuHHb7FuejYCUasnbNPvJg74BF6NDt0
	 dXFEtVaASa+GJ4ENq4tXcaAyeo4B/TGRDlH0lzvWf7fHgdZTwX99oitgxNz0WSoSKT
	 NUliYg2dFgzC/x+JPjBH55K/Th7gDFo71E9xxwtZAMfhu/xxLE7yCMJ4ZBrOSiCVQG
	 rDvH/6/76wu+waqE+8vV+xRu/447e+OIlRnu3w7/+UPaTT1Js5edtbT/Qx8ik1sIoI
	 67z4X3b9j1WXQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYh-00000000LsZ-1yLx;
	Wed, 18 Feb 2026 11:13:27 +0100
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
Subject: [PATCH 28/38] docs: kdoc_re: prevent adding whitespaces on sub replacements
Date: Wed, 18 Feb 2026 11:12:58 +0100
Message-ID: <24cce8e6d41b2f16698ac9f683b3f1df125e306e.1771408406.git.mchehab+huawei@kernel.org>
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

When NestedMatch is used, blank whitespaces may be placed after
substitutions. As such spaces are part of the C syntax, we can
safelly drop them, improving the quality of the output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index e3809aaa0310..44af43aa1e93 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -344,8 +344,12 @@ class NestedMatch:
 
         cur_pos = 0
         n = 0
+        l = len(line)
 
         for start, end, pos in self._search(line):
+            while cur_pos < l and line[cur_pos] == ' ':
+                cur_pos += 1
+
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
@@ -368,7 +372,9 @@ class NestedMatch:
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

