Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D313845A9;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327298; cv=none; b=d58PpeH+LDAQNhLGzsAAqPJ0XqQVYmdSeNrlJYKQFaheEtoTnj1ZrNJDjFcBgUbD1g9If/tTKyI3HYywOZGiz49G9yfFuyDy7aLf3+51Q6IF4G8HPsNAGcmRTPdJHccbpxViii03sdcEZhjejKTtWZKb+gAfwYgwxLlR4B1FBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327298; c=relaxed/simple;
	bh=eHzGH2dFBA+LBXeTjlUzB1uMOMkGk4BEFeYvd7f59mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgyWRJgiafoLNq6D/eXqNK8ZL6r4PVmSpHJlvI4mXcwCKFkLhaevTTq49KMU9yj0ArAzPn4keXqcrJSvOpTIz6LlviOsBLMYXa0Q0Y2pAqO4wTVA29Sh3sE+s348bQaUlLXWqfV77Xoo2mgCGuGahqCcx4HTTyK0myhn7czsFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNuXQxcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNuXQxcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F17C19424;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327298;
	bh=eHzGH2dFBA+LBXeTjlUzB1uMOMkGk4BEFeYvd7f59mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNuXQxcXlvpYWmKbSI41u5HJvcZ+LTZSSNRdIZJIxrum0KkjbkTDgYIEK6cr3a0pA
	 ikdMZBAVCqUgcBMraybxWTdUN/J5KAnteNWUPggBIaMZLwoLQTodMaVWatr8E5wJmH
	 iSX3XeLMlfiwYJ4SDUDLwZdBGfCuVNdAZzZYkYey7jpZkHW7eMAj7F66T2Sz3Vb4j0
	 uuaYwG74PLZd91pUyzyzLl8GWbmUC6FmHVl2uSepfjdbG6QU4Qm1WfcCYGvytBuKuI
	 8OyTbjrlBnhD1zWBq1Rbwkmtn5ZVAWrHsAwX+lLqmhJ3FP+NRfo1+bxR0t5J/0HTKW
	 gjxluBf/W/DCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRA-00000008xs8-24Z5;
	Thu, 12 Mar 2026 15:54:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 06/28] docs: kdoc: use tokenizer to handle comments on structs
Date: Thu, 12 Mar 2026 15:54:26 +0100
Message-ID: <37117386c8ec0918a1d3a967bd785827fa2c2a1f.1773326442.git.mchehab+huawei@kernel.org>
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

Better handle comments inside structs. After those changes,
all unittests now pass:

  test_private:
    TestPublicPrivate:
        test balanced_inner_private:                                 OK
        test balanced_non_greddy_private:                            OK
        test balanced_private:                                       OK
        test no private:                                             OK
        test unbalanced_inner_private:                               OK
        test unbalanced_private:                                     OK
        test unbalanced_struct_group_tagged_with_private:            OK
        test unbalanced_two_struct_group_tagged_first_with_private:  OK
        test unbalanced_without_end_of_line:                         OK

  Ran 9 tests

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <f83ee9e8c38407eaab6ad10d4ccf155fb36683cc.1773074166.git.mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 4b3c555e6c8e..6b181ead3175 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -13,7 +13,7 @@ import sys
 import re
 from pprint import pformat
 
-from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.kdoc_re import NestedMatch, KernRe, CTokenizer
 from kdoc.kdoc_item import KdocItem
 
 #
@@ -84,15 +84,9 @@ def trim_private_members(text):
     """
     Remove ``struct``/``enum`` members that have been marked "private".
     """
-    # First look for a "public:" block that ends a private region, then
-    # handle the "private until the end" case.
-    #
-    text = KernRe(r'/\*\s*private:.*?/\*\s*public:.*?\*/', flags=re.S).sub('', text)
-    text = KernRe(r'/\*\s*private:.*', flags=re.S).sub('', text)
-    #
-    # We needed the comments to do the above, but now we can take them out.
-    #
-    return KernRe(r'\s*/\*.*?\*/\s*', flags=re.S).sub('', text).strip()
+
+    tokens = CTokenizer(text)
+    return str(tokens)
 
 class state:
     """
-- 
2.52.0

