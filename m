Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F3357725;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=GGOGEtWHz3j84JO5009ctcd4OrTWQtjru4Be5RQI5NO7/hDCUULYAD9gFzWM+k2eweXuNHrV3QBCPNGL0uR5YX6ii9+fYyQ9McoQgQ3o5avBhzC/Mfoy5XSKWEFp5BFJsw7xJFvpM/S+JlNZol+8jlzjqK+UIsfQJlwoaxS2TyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=k65ZRQ6nCC0QeSNdRmqS6WoUNEEbl9/G3ipKWB3BcN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4Lf6TT2QnsRAXYTwt0f19YnGv/1j+xScTDBf35Bd9HloiuY835q6e3gPzuub6DB+2TlzUlggBSc7sqaa6qCgQetkJ7xH+d/sab+3X9KOO0ft0uXM7Ir3tQA3EWGYY1cP+rqbwKHmTb/94ab+54vhtQ+nPQSTpKayAK4wCmXPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e63fBHEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e63fBHEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB10C2BC87;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=k65ZRQ6nCC0QeSNdRmqS6WoUNEEbl9/G3ipKWB3BcN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e63fBHEIkHV7gUbvSu0y+j59kfsYS+U2rp5MWNYp5NQ0g0JUfdEhh8zX9FFM/Kobt
	 /ihVs21vbRRyz69Q6p6+ahKpCiLT+GoqoAMnyBqQvjdGpLpbW1DwlHmRa4W1zbtY5Q
	 i9F1iQnfMkB9haZzKgJ3rwc+tQKXFlGksj9GPaw9N84mw2IdQKLAuONYFDmInekn3x
	 7f+7ujrpGZ8s2YBbjnNQFTS+qegSmz1cSeOCs0zaTLhGCg1sTbDlLHDvAor/RWFO4q
	 TprFa23N2XVs5qdpJER1yKLNqsWaWlHrqCLnmmM1h+3VfscA2EI5nVO6WUJM9EgsRn
	 sI6nVx08tDgDg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVk0-1jqe;
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
Subject: [PATCH v4 04/41] docs: kdoc_parser: don't mangle with function defines
Date: Sat, 31 Jan 2026 15:24:38 +0100
Message-ID: <40010f8fa7275d1be1287b26ac46fcd3c88e2b99.1769867953.git.mchehab+huawei@kernel.org>
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
index 0b68b140cd02..3ba2cda2487a 100644
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
@@ -1065,10 +1065,7 @@ class KernelDoc:
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
@@ -1087,6 +1084,11 @@ class KernelDoc:
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

