Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3AD423A68;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469670; cv=none; b=kCayzYc80ElcN16j5Nnty1E9A9ag3rtjiRZToYStU7LX+LKe7yKXBmIG1RsqtAiYnUjVjbcH9OiHKZHNIkSS7AKzwGl66q7tUZT9oylugUirmiqzU2sbsiXDpNVCmeRk07SgaGxLeZGH2xjYpxLjFkKWOtShe9pluXvOK2xQ55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469670; c=relaxed/simple;
	bh=IanSHDFR27HztJ4b5ZTKzFpHQEo73fYniHq3F2749zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWpbWDuGuZZ5/8QE4E4WyTgaYZVJN6nZ1Ujlw5EnWg60aKbBo1YHkgKnGhQ4are26vBgh3iCI1HAbrCfafyIG0aZqhP/m4mI9XYlcweMZ0TdIEKQNT9ZWL09rVGxLa+bB7PQ5aV6IYXoQ1xfH72gQdK7VSbk2k8VQg6egcXrdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZT7+QTBe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZT7+QTBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FDAC4AF09;
	Mon,  2 Mar 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469670;
	bh=IanSHDFR27HztJ4b5ZTKzFpHQEo73fYniHq3F2749zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZT7+QTBeMyAWLn31f/3W88Q3jWyiihx9g3Jt+vWVBBGSKji6mumLsrKWpfqM6mZwn
	 6RxEFNInQCI8Hvr91pvHfU+J8KGVIK3ylP2LE7nYt5JIRInhdmWqGgqshsYlksSxZ4
	 UAYtv1czaqURVogAHWfh0XBE4BDPnwqutd3lbC+8fLX3h5uijX/4B/UN/tF8Y19FiO
	 jfEFzSriFXex1jc/lIRIK1lWfmm442a6p/ZpiOzjHjs11SFR1ZK/HX+f2rQMyl1q0t
	 k+ylNE5ZuVu2Fc9ti/P/4hJrbiELLpYK753jeRViGydSgLmDu/zZTgkCXx8hL1Y+Vu
	 ZVG2AlMP7UcPA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KS-00000000379-1mmd;
	Mon, 02 Mar 2026 17:41:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 09/18] docs: kdoc_parser: add support for LIST_HEAD
Date: Mon,  2 Mar 2026 17:40:52 +0100
Message-ID: <8bdfa6ba6002b0a73a83660f0ce7b40e30124552.1772469446.git.mchehab+huawei@kernel.org>
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

Convert LIST_HEAD into struct list_head when handling its
prototype.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 22a820d33dc8..1df869061bf3 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -198,6 +198,7 @@ function_xforms = [
 var_xforms = [
     (KernRe(r"__read_mostly"), ""),
     (KernRe(r"__ro_after_init"), ""),
+    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0

