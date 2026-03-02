Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C1421EEC;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469669; cv=none; b=P9nvy/Yofgz/d1mw9rL1VRieoQVkOQVFIpVWYUBPk+K8bFnUy5dVm9SQhsNXxm+RTmbAPCNqJyhaN6SVJanRGn59r55NxBVIwH5fyIkvPk/ae3U07YybncL+zPrlkm1E46OI0l0EI503N8wKBjC05uSc9lZa4FJEvsOp1GCqHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469669; c=relaxed/simple;
	bh=l1TnXg9K1HZGJE+MUFeDj5Ao7LGwzZBBWNXmq8OcdpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPju2sZdXjcTxx9YShOi3KJqqo5tI6VdqrXQFcpEi9oPBfgpdFDcT7vwF5apn+v6VjzzbPJjgGwjKRjYS7kPoEU/Tyk7Q5H2j6yriLYCBBNXs8vJ/3Y3qOZY0mk05MLCpPSeS2KTAjMaBsrWO6A4Nc8XD6S7417ny6JjkpdEJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRbrwor0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRbrwor0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF6FC2BC87;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469669;
	bh=l1TnXg9K1HZGJE+MUFeDj5Ao7LGwzZBBWNXmq8OcdpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRbrwor0sf65/BAVNyn5/8Bc4uF2uUGQDaoBNcIgYcQ3t1W6cGGfhcoTlPPu6d2l1
	 I6Tl1oLUwI5O+N/bO/jGoQmrYHR22Trnm32B7DH50NbkB7h/U7JuDBR6udpHM61v4L
	 hBoLwHOnH267kgi6NnM+uHI2QdnsWbE3iJu26qvI+fCquoVetlOv6cD+aiaJ8/M05a
	 s4f/TGhS7TwVTo5feNc+5jlwg4Z88sob3ZG9TSuxdH2zzQPiUZ4AZPh7GEyVKRSCDS
	 lIPLgKVSCocRVTWOXKopFMGyZZrHKIjn7cT4L9hdJVPN95cnsG/ftU80USShkFmSjs
	 jdIbyT2Wi1wxw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KR-00000000311-1z8t;
	Mon, 02 Mar 2026 17:41:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 04/18] docs: kdoc_parser: don't mangle with function defines
Date: Mon,  2 Mar 2026 17:40:47 +0100
Message-ID: <8f9854c8ca1c794b6a3fe418f7adbc32aa68b432.1772469446.git.mchehab+huawei@kernel.org>
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

Mangling with #defines is not nice, as we may end removing
the macro names, preventing several macros from being properly
documented.

Also, on defines, we have something like:

	#define foo(a1, a2, a3, ...)			 \
		/* some real implementation */

The prototype part (first line on this example) won't contain
any macros, so no need to apply any regexes on it.

With that, move the apply_transforms() logic to ensure that
it will be called only on functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 68a5aea9175d..9643ffb7584a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -163,7 +163,7 @@ struct_nested_prefixes = [
 #
 # Transforms for function prototypes
 #
-function_xforms  = [
+function_xforms = [
     (KernRe(r"^static +"), ""),
     (KernRe(r"^extern +"), ""),
     (KernRe(r"^asmlinkage +"), ""),
@@ -1066,10 +1066,7 @@ class KernelDoc:
         found = func_macro = False
         return_type = ''
         decl_type = 'function'
-        #
-        # Apply the initial transformations.
-        #
-        prototype = apply_transforms(function_xforms, prototype)
+
         #
         # If we have a macro, remove the "#define" at the front.
         #
@@ -1088,6 +1085,11 @@ class KernelDoc:
                 declaration_name = r.group(1)
                 func_macro = True
                 found = True
+        else:
+            #
+            # Apply the initial transformations.
+            #
+            prototype = apply_transforms(function_xforms, prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
-- 
2.52.0

