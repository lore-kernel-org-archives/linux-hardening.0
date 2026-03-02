Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FB42669B;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469671; cv=none; b=MSEdSTomSyOU+zUnyTK+Y6zgt1/IHz5iCUl5AZrigQvv8BtlA2gy23Q4g7tiDU6QG9GgyAmEY08MyfW5R5uSTiu36aotl75pSXjsYuBOFMBUb4UXTlHBhPLK20vSHnKWFBfV+AzQYgT8ZzbY1cnKU16qohldox9xeM5cv6/v8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469671; c=relaxed/simple;
	bh=tIjupFasOCXFkiwCnFBXnKQjfhLIL14356wka0J5sM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6UZ13PFv8bNSRzQgWmUZ3rK2L5hSfV8TXrxDlGq8ZCT2YBLbx8tLIA3rbTVKbu2Qb3i0EIu+lmiETAN4ON0PYfuNWvES+aBmZ4JeW11fY73HDRF3GC57XXT3Z53i1VPHtIP0xYkoQX2nxqV2gjoIHHTfTv8FibWOnia6sb6i8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avyhZL2M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avyhZL2M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB05C2BC87;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469671;
	bh=tIjupFasOCXFkiwCnFBXnKQjfhLIL14356wka0J5sM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avyhZL2M6cSOjYWN53N6mBqvDdLitmhqjYn4nG85pJY7VmYFS5rWRAHtDgW12MhiH
	 20fM7HSN10dc7pXotk87hmMC6QLLLK3Y2Gxty4apA+wzMuajAxi3RgcEffZdydTV/P
	 YGvMyGklwzHptJhS0G4JS9HmMQUW8Ihun7p8DTjO8CEKr5TY5pFC4MGdAysP5hEXAY
	 7yMJTmsHu74HkWtLuju4Yel1LiEdryoJ8kl2rLgdWaayok7KqRP3nJojOwWsghOe6+
	 72ZcMxbcdgm4SioYbMbRvSshhjWh8MqBr1wRl6EncrOE8YoJo0TEmNxRDQ7UUr74YY
	 ow2XUaWJE10CA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KT-000000003C0-0oZ7;
	Mon, 02 Mar 2026 17:41:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 13/18] docs: xforms_lists: ignore context analysis and lock attributes
Date: Mon,  2 Mar 2026 17:40:56 +0100
Message-ID: <3c7fdfc364a8920f92530b47bdbf4bb29a40371f.1772469446.git.mchehab+huawei@kernel.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

Drop context analysis and lock (tracking) attributes to avoid
kernel-doc warnings.

There are now lots of warnings like these:

    Documentation/core-api/kref:328: ../include/linux/kref.h:72: WARNING: Invalid C declaration: Expected end of definition. [error at 96]
      int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
      ------------------------------------------------------------------------------------------------^
    Documentation/core-api/kref:328: ../include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
      int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)
      --------------------------------------------------------------------------------------------^

The regex is suggested by Mauro; mine was too greedy. Thanks.
Updated context analysis and lock macros list provided by PeterZ. Thanks.

[mchehab: modified to be applied after xforms_lists split]

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20260107161548.45530e1c@canb.auug.org.au/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py  | 10 ++++++++++
 tools/lib/python/kdoc/xforms_lists.py |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index d7daf658e9d2..503a18212747 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -75,6 +75,16 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
 # is allowed.
 #
 struct_nested_prefixes = [
+    (re.compile(r"__cond_acquires\s*\("), ""),
+    (re.compile(r"__cond_releases\s*\("), ""),
+    (re.compile(r"__acquires\s*\("), ""),
+    (re.compile(r"__releases\s*\("), ""),
+    (re.compile(r"__must_hold\s*\("), ""),
+    (re.compile(r"__must_not_hold\s*\("), ""),
+    (re.compile(r"__must_hold_shared\s*\("), ""),
+    (re.compile(r"__cond_acquires_shared\s*\("), ""),
+    (re.compile(r"__acquires_shared\s*\("), ""),
+    (re.compile(r"__releases_shared\s*\("), ""),
     (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
 ]
 
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e6e0302e5dd0..1bda7c4634c3 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -22,6 +22,8 @@ class CTransforms:
         (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
         (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
         (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
+        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
         (KernRe(r'\s*__packed\s*', re.S), ' '),
         (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
         (KernRe(r'\s*__private', re.S), ' '),
@@ -120,6 +122,7 @@ class CTransforms:
         (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
         (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
         (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+        (KernRe(r"__no_context_analysis\s*"), ""),
         (KernRe(r"__attribute_const__ +"), ""),
         (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
     ]
@@ -128,6 +131,8 @@ class CTransforms:
     var_xforms = [
         (KernRe(r"__read_mostly"), ""),
         (KernRe(r"__ro_after_init"), ""),
+        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
+        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
         (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
         (KernRe(r"(?://.*)$"), ""),
         (KernRe(r"(?:/\*.*\*/)"), ""),
-- 
2.52.0

