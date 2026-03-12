Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5836C9E3;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=Nk8BSDoVcbS1YNSF/2W14q9K6RHjLvdUkzPsSRXxvEbK9ENQIHp/xw+se6gEZY3+juR+6QRzAqFW9R2zXyMYZWsQNlwjXtNwU6LSFBjCZ73qxAjHTwft9O1rS3rkPJzEeNSG6t7snkP1rqU5oK8ZF4BMVBQPwdDE6x6BhmcOoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=r7ZWNO+ghbGf9tKGR7rDEB46pt/FEZ69GWHK20SQis4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehxQbJ/WB9YPy0zxL0g58DOWt9ug6mFGMS/6kZy2ehulY+CE1++h1+aYfFLV2hlR6UqURHlZinurs2Fvx09YcFnXex56JhoFSMVLFQ2lOe1Fig9jSnfBCPHOSFMOqoqe0GmiGozH+8TnnN4INDeh3nXhiFbIj32vqQ5q0skCYPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E14ncgOj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E14ncgOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DA9C2BCB2;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=r7ZWNO+ghbGf9tKGR7rDEB46pt/FEZ69GWHK20SQis4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E14ncgOjKLkgw64H+fWmzUQYizwUaLsQJzglUTFTaY+qFb8x2f2Pdjr7QOgsX0dTJ
	 IfxvyfjG94ZoCAeKlBnVsnfyFgzudGKfHJflA+cb4pw5aOe0JJ95x8c8aEprxB+dsb
	 Y5YNvMH9Hn+1MKWM7uT7+w9O2s0AYKPG02CLK4sKUW6g+N/HvmXS6ywbx2TwWTHOrQ
	 hUOFk+0x6jb1YqnaavIbnprDSO1VYw2ZLNJAEVCvw1hEF7c0P+twaQRjm/RDbMyRgZ
	 SxDhgbZ8yY+fmq/m2o2IO54m03nqd0V2G6TxinMJrKaX9JERC436NDGr50TdyEWYEG
	 wCNjLX+0rPDGg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077gG-1e5M;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 04/20] docs: kdoc: properly handle empty enum arguments
Date: Thu, 12 Mar 2026 08:12:12 +0100
Message-ID: <abcc260f770c4fcb2ae40be58bd8eea5e44bf697.1773297828.git.mchehab+huawei@kernel.org>
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

Depending on how the enum proto is written, a comma at the end
may incorrectly make kernel-doc parse an arg like " ".

Strip spaces before checking if arg is empty.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <4182bfb7e5f5b4bbaf05cee1bede691e56247eaf.1773074166.git.mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 086579d00b5c..4b3c555e6c8e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -810,9 +810,10 @@ class KernelDoc:
         member_set = set()
         members = KernRe(r'\([^;)]*\)').sub('', members)
         for arg in members.split(','):
-            if not arg:
-                continue
             arg = KernRe(r'^\s*(\w+).*').sub(r'\1', arg)
+            if not arg.strip():
+                continue
+
             self.entry.parameterlist.append(arg)
             if arg not in self.entry.parameterdescs:
                 self.entry.parameterdescs[arg] = self.undescribed
-- 
2.53.0

