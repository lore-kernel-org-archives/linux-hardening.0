Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C63F0778;
	Tue, 17 Mar 2026 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770988; cv=none; b=uHvaBAYBdZed9+8CWdKVAUL94fFfioPiEvTuwaicmiRqrtN9SIi+oSBOc9cFtHSeLTshTO0UcZDS050j1a3+HLgnqfyFT21xsIxp8tDTPt32CKWnKwfHiqhmKxb4r8txTF21nGA5HWrOHq3NZB9uPmBMTWMdJpFhyQXh2CcW3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770988; c=relaxed/simple;
	bh=1uxfkQgXX2b/e92MF0mNuJcjR0VUeRhzcj4mkmRc5x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8A+pIBKjsEQAIG0A+iGjAnhNtzWC62S5dS6ntsu7wxJ32O0xq2lHCmDLg6kJeHT6R/y8d52uerur5mGF5mBCzzwj8o7f03tleDlOQnb9f4nv1j0DbhF9pONe9a84tA0YAS61iRT28o3YQ3eBjnbZ986MzMd5Esu3UTNZHNZUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh2+XJk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh2+XJk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3675C2BCB0;
	Tue, 17 Mar 2026 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770987;
	bh=1uxfkQgXX2b/e92MF0mNuJcjR0VUeRhzcj4mkmRc5x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nh2+XJk5rZtLdAPu9GLsX1AKYBAfq7aJ0h+1GczJKc8UkPxlwYep+j/OEwt1JYHLk
	 yX98iu9v9hriiTOAyh1Ol+VwuJGoBcE7UqFU3GdZsNIOEMmv39xCZpQ12vZVcA+EzP
	 shtkzFd031LvnK1UzYu5wViP1Nq7JYEL+lHp4J03N0QOToXX6rBsYq9GaW5uxu7Y66
	 6azcdqdg1tSahwP9q0ipfg9JfSi4ZMi/4polcFss9Entg/jnx8Asr7EyWaYtSAL8g0
	 Jx69/3mlXkJJWIvdY3/PFt+c/b5TS4ehE/mCJ9QkGtEpdg2AYP67wBdSmX2GcXH1Q/
	 WhES5y7ECvQcA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrR-0000000H5Gi-2xXp;
	Tue, 17 Mar 2026 19:09:45 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/22] unittests: add a testbench to check public/private kdoc comments
Date: Tue, 17 Mar 2026 19:09:22 +0100
Message-ID: <c1574b5b67b0442de3fab570fe6de9bc28b17a75.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
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
2.52.0

