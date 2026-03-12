Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA43ACF16;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=PeBF/UA926XmYYrN0qcZBNXWimdEK3fW9OS4wS63GRN+FbCAZE9UDR9WQF61jZ83nt8yEHLlsrMfqI0BAN3XvmbyNNhPih+lOkVjIG8GRo4Bpbo8AQtocna/fkgItAyj+xl9hCi4CjynOMDDdMGRqNonlCOzryqanZjF4nYAp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=XQhCrlUmkD9zSOZhprhPJWsYbmUCBPONnwHs9Zlqn5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXE1EYsjSDUkPNeF700HT9qQijclRak7efIqMng4i1JgPyFcX8+4a3jAZpgHTNtThsDT1fw+3VP4STPH4GZgfQ+REL2M0wmq6rNIWrDGEAuY1XjnKRX1yvWsn72T8dJUAlNpIx+NJnBzpkvmlMYseTZoU+ZRw7awNOmD5kfCjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmSMOjp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmSMOjp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A054C2BCAF;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=XQhCrlUmkD9zSOZhprhPJWsYbmUCBPONnwHs9Zlqn5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmSMOjp7oksgvSaQuWzZ3dchGEkqhrk64yEV0l9a7X+pHVxohCBkFAYEGTaie/HNA
	 i+Pw9Z3qS+W4zu1TMGwMNmjFcy+wlsIg162nGQcy2b4GZmm1GdHSLH/4H0MRU9Tmw4
	 s8DWyR9EOtpv2ViHIPoHu0NqniUCwfa9Q2bOLT6EoNZHYTMFamQxySNADjYYkYwLRp
	 MYRpl5LhdjTaaYNP4wxqL27hs4jehH3fSMmD6o4/Dp5IqGp0mKiSj9ihnGjk/T3jf4
	 fajJP17BOqax227J4N/PGPAjmw35zY8JhUEVdEwv9QUgBS71NqKvZbzf1DlkMiTXs0
	 GUdpLhc81NUoA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077g8-1Q2J;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 02/20] unittests: add a testbench to check public/private kdoc comments
Date: Thu, 12 Mar 2026 08:12:10 +0100
Message-ID: <947d8827008a65f9c195163a9a5381efa4f29e20.1773297828.git.mchehab+huawei@kernel.org>
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

Add unit tests to check if the public/private and comments strip
is working properly.

Running it shows that, on several cases, public/private is not
doing what it is expected:

  test_private:
    TestPublicPrivate:
        test balanced_inner_private:                                 OK
        test balanced_non_greddy_private:                            OK
        test balanced_private:                                       OK
        test no private:                                             OK
        test unbalanced_inner_private:                               FAIL
        test unbalanced_private:                                     FAIL
        test unbalanced_struct_group_tagged_with_private:            FAIL
        test unbalanced_two_struct_group_tagged_first_with_private:  FAIL
        test unbalanced_without_end_of_line:                         FAIL

  Ran 9 tests

  FAILED (failures=5)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <144f4952e0cb74fe9c9adc117e9a21ec8aa1cc10.1773074166.git.mchehab+huawei@kernel.org>
---
 tools/unittests/test_private.py | 331 ++++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100755 tools/unittests/test_private.py

diff --git a/tools/unittests/test_private.py b/tools/unittests/test_private.py
new file mode 100755
index 000000000000..eae245ae8a12
--- /dev/null
+++ b/tools/unittests/test_private.py
@@ -0,0 +1,331 @@
+#!/usr/bin/env python3
+
+"""
+Unit tests for struct/union member extractor class.
+"""
+
+
+import os
+import re
+import unittest
+import sys
+
+from unittest.mock import MagicMock
+
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, os.path.join(SRC_DIR, "../lib/python"))
+
+from kdoc.kdoc_parser import trim_private_members
+from unittest_helper import run_unittest
+
+#
+# List of tests.
+#
+# The code will dynamically generate one test for each key on this dictionary.
+#
+
+#: Tests to check if CTokenizer is handling properly public/private comments.
+TESTS_PRIVATE = {
+    #
+    # Simplest case: no private. Ensure that trimming won't affect struct
+    #
+    "no private": {
+        "source": """
+            struct foo {
+                int a;
+                int b;
+                int c;
+            };
+        """,
+        "trimmed": """
+            struct foo {
+                int a;
+                int b;
+                int c;
+            };
+        """,
+    },
+
+    #
+    # Play "by the books" by always having a public in place
+    #
+
+    "balanced_private": {
+        "source": """
+            struct foo {
+                int a;
+                /* private: */
+                int b;
+                /* public: */
+                int c;
+            };
+        """,
+        "trimmed": """
+            struct foo {
+                int a;
+                int c;
+            };
+        """,
+    },
+
+    "balanced_non_greddy_private": {
+        "source": """
+            struct foo {
+                int a;
+                /* private: */
+                int b;
+                /* public: */
+                int c;
+                /* private: */
+                int d;
+                /* public: */
+                int e;
+
+            };
+        """,
+        "trimmed": """
+            struct foo {
+                int a;
+                int c;
+                int e;
+            };
+        """,
+    },
+
+    "balanced_inner_private": {
+        "source": """
+            struct foo {
+                struct {
+                    int a;
+                    /* private: ignore below */
+                    int b;
+                /* public: but this should not be ignored */
+                };
+                int b;
+            };
+        """,
+        "trimmed": """
+            struct foo {
+                struct {
+                    int a;
+                };
+                int b;
+            };
+        """,
+    },
+
+    #
+    # Test what happens if there's no public after private place
+    #
+
+    "unbalanced_private": {
+        "source": """
+            struct foo {
+                int a;
+                /* private: */
+                int b;
+                int c;
+            };
+        """,
+        "trimmed": """
+            struct foo {
+                int a;
+            };
+        """,
+    },
+
+    "unbalanced_inner_private": {
+        "source": """
+            struct foo {
+                struct {
+                    int a;
+                    /* private: ignore below */
+                    int b;
+                /* but this should not be ignored */
+                };
+                int b;
+            };
+        """,
+        "trimmed": """
+            struct foo {
+                struct {
+                    int a;
+                };
+                int b;
+            };
+        """,
+    },
+
+    "unbalanced_struct_group_tagged_with_private": {
+        "source": """
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_fast, fast,
+                        unsigned int    order;
+                        unsigned int    pool_size;
+                        int             nid;
+                        struct device   *dev;
+                        struct napi_struct *napi;
+                        enum dma_data_direction dma_dir;
+                        unsigned int    max_len;
+                        unsigned int    offset;
+                };
+                struct_group_tagged(page_pool_params_slow, slow,
+                        struct net_device *netdev;
+                        unsigned int queue_idx;
+                        unsigned int    flags;
+                        /* private: used by test code only */
+                        void (*init_callback)(netmem_ref netmem, void *arg);
+                        void *init_arg;
+                };
+            };
+        """,
+        "trimmed": """
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_fast, fast,
+                        unsigned int    order;
+                        unsigned int    pool_size;
+                        int             nid;
+                        struct device   *dev;
+                        struct napi_struct *napi;
+                        enum dma_data_direction dma_dir;
+                        unsigned int    max_len;
+                        unsigned int    offset;
+                };
+                struct_group_tagged(page_pool_params_slow, slow,
+                        struct net_device *netdev;
+                        unsigned int queue_idx;
+                        unsigned int    flags;
+                };
+            };
+        """,
+    },
+
+    "unbalanced_two_struct_group_tagged_first_with_private": {
+        "source": """
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_slow, slow,
+                        struct net_device *netdev;
+                        unsigned int queue_idx;
+                        unsigned int    flags;
+                        /* private: used by test code only */
+                        void (*init_callback)(netmem_ref netmem, void *arg);
+                        void *init_arg;
+                };
+                struct_group_tagged(page_pool_params_fast, fast,
+                        unsigned int    order;
+                        unsigned int    pool_size;
+                        int             nid;
+                        struct device   *dev;
+                        struct napi_struct *napi;
+                        enum dma_data_direction dma_dir;
+                        unsigned int    max_len;
+                        unsigned int    offset;
+                };
+            };
+        """,
+        "trimmed": """
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_slow, slow,
+                        struct net_device *netdev;
+                        unsigned int queue_idx;
+                        unsigned int    flags;
+                };
+                struct_group_tagged(page_pool_params_fast, fast,
+                        unsigned int    order;
+                        unsigned int    pool_size;
+                        int             nid;
+                        struct device   *dev;
+                        struct napi_struct *napi;
+                        enum dma_data_direction dma_dir;
+                        unsigned int    max_len;
+                        unsigned int    offset;
+                };
+            };
+        """,
+    },
+    "unbalanced_without_end_of_line": {
+        "source": """ \
+            struct page_pool_params { \
+                struct_group_tagged(page_pool_params_slow, slow, \
+                        struct net_device *netdev; \
+                        unsigned int queue_idx; \
+                        unsigned int    flags;
+                        /* private: used by test code only */
+                        void (*init_callback)(netmem_ref netmem, void *arg); \
+                        void *init_arg; \
+                }; \
+                struct_group_tagged(page_pool_params_fast, fast, \
+                        unsigned int    order; \
+                        unsigned int    pool_size; \
+                        int             nid; \
+                        struct device   *dev; \
+                        struct napi_struct *napi; \
+                        enum dma_data_direction dma_dir; \
+                        unsigned int    max_len; \
+                        unsigned int    offset; \
+                }; \
+            };
+        """,
+        "trimmed": """
+            struct page_pool_params {
+                struct_group_tagged(page_pool_params_slow, slow,
+                        struct net_device *netdev;
+                        unsigned int queue_idx;
+                        unsigned int    flags;
+                };
+                struct_group_tagged(page_pool_params_fast, fast,
+                        unsigned int    order;
+                        unsigned int    pool_size;
+                        int             nid;
+                        struct device   *dev;
+                        struct napi_struct *napi;
+                        enum dma_data_direction dma_dir;
+                        unsigned int    max_len;
+                        unsigned int    offset;
+                };
+            };
+        """,
+    },
+}
+
+
+class TestPublicPrivate(unittest.TestCase):
+    """
+    Main test class. Populated dynamically at runtime.
+    """
+
+    def setUp(self):
+        self.maxDiff = None
+
+    def add_test(cls, name, source, trimmed):
+        """
+        Dynamically add a test to the class
+        """
+        def test(cls):
+            result = trim_private_members(source)
+
+            result = re.sub(r"\s++", " ", result).strip()
+            expected = re.sub(r"\s++", " ", trimmed).strip()
+
+            msg = f"failed when parsing this source:\n" + source
+
+            cls.assertEqual(result, expected, msg=msg)
+
+        test.__name__ = f'test {name}'
+
+        setattr(TestPublicPrivate, test.__name__, test)
+
+
+#
+# Populate TestPublicPrivate class
+#
+test_class = TestPublicPrivate()
+for name, test in TESTS_PRIVATE.items():
+    test_class.add_test(name, test["source"], test["trimmed"])
+
+
+#
+# main
+#
+if __name__ == "__main__":
+    run_unittest(__file__)
-- 
2.53.0

