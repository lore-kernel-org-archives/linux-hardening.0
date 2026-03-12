Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D43AD501;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=ZmxIUpFfj+SDzfQJRSmpaFcAj4NmXr9ksMwouS0vtTjbNJge6aPm4NFz3x9u+OZjnkWyoxsuys/6XSBj1xructbohKYu/GwnFg9dmhRsSmc+q3Gwt+y+JVKT13/S1NHVjoSfbD9JS/91ppev9FgKDi7mRO7lBrsxMIQIf/BZrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=q96dg3xXA0gtSY04mSMe+ccSIuGuzNeDMA5UaImmuRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTIWxSOEAVeX4MnByl4eZ8McXBa40Q0dHZtZ820KkMbkeeqjw7GkowzGAnE9EALcVjQ5pLeGJ4nRcOtGEdRoJlNYRw5gJD0tNFBXsoYL5QicDoyeuLOTVKghctgcr1/7K9Rs7ZTXvebdxyHB8Jz6hTQYC3tpQEIqH//zf9u/zTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHUTPRqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHUTPRqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB52C2BCB1;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=q96dg3xXA0gtSY04mSMe+ccSIuGuzNeDMA5UaImmuRg=;
	h=From:To:Cc:Subject:Date:From;
	b=SHUTPRqr3BoesL2+y6dC8owMnsIgoYkE9EqvJxUCin5OZODKd4X9D3+g7bnc1DHBW
	 8fBVHHj6xM04TZ5Yh24tnzQiyVn1/JOyQWrKe+lV0pEWOx9wOJH6Zpnh234SdM42N/
	 ZyyP/CXUpdPgH8JAoND/he9Es3ESeuygVwtI1K65HIzijNUIdz6bp11ckqRTBJ3mrV
	 xMLf0+zX05yh9kuccaWwQPanxnp/9zZWQIFDa+7lbKVQSCgPzvP5lUnNNPHtlVGgmj
	 6My7eiEn8YPtbCiOSstA2P6kzxh4OHhXCB8t/kO8N6OMP6WacLoHUumoRxHHiGQJCD
	 Ta9RfxqCyiVdQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077g1-1BU5;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 00/20] kernel-doc: use a C lexical tokenizer for transforms
Date: Thu, 12 Mar 2026 08:12:08 +0100
Message-ID: <cover.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

This patch series change how kdoc parser handles macro replacements.

Instead of heavily relying on regular expressions that can sometimes
be very complex, it uses a C lexical tokenizer. This ensures that
BEGIN/END blocks on functions and structs are properly handled,
even when nested.

Checking before/after the patch series, for both man pages and
rst only had:
    - whitespace differences;
    - struct_group macros now are shown as inner anonimous structs
      as it should be.

Also, I didn't notice any relevant change on the documentation build
time. With that regards, right now, every time a CMatch replacement
rule takes in place, it does:

    for each transform:
    - tokenizes the source code;
    - handle CMatch;
    - convert tokens back to a string.

A possible optimization would be to do, instead:

    - tokenizes source code;
    - for each transform handle CMatch;
    - convert tokens back to a string.

For now, I opted not do do it, because:

    - too much changes on a single row;
    - docs build time is taking ~3:30 minutes, which is
      about the same time it ws taken before the changes;
    - there is a very dirty hack inside function_xforms:
         (KernRe(r"_noprof"), ""). This is meant to change
      function prototypes instead of function arguments.

So, if ok for you, I would prefer to merge this one first. We can later
optimize kdoc_parser to avoid multiple token <-> string conversions.

-

One important aspect of this series is that it introduces unittests
for kernel-doc. I used it a lot during the development of this series,
to ensure that the changes I was doing were producing the expected
results. Tests are on two separate files that can be executed directly.

Alternatively, there is a run.py script that runs all of them (and
any other python script named  tools/unittests/test_*.py"):

  $ ./tools/unittests/run.py 

  test_cmatch:
    TestSearch:
        test_search_acquires_multiple:                               OK
        test_search_acquires_nested_paren:                           OK
        test_search_acquires_simple:                                 OK
        test_search_must_hold:                                       OK
        test_search_must_hold_shared:                                OK
        test_search_no_false_positive:                               OK
        test_search_no_function:                                     OK
        test_search_no_macro_remains:                                OK
    TestSubMultipleMacros:
        test_acquires_multiple:                                      OK
        test_acquires_nested_paren:                                  OK
        test_acquires_simple:                                        OK
        test_mixed_macros:                                           OK
        test_must_hold:                                              OK
        test_must_hold_shared:                                       OK
        test_no_false_positive:                                      OK
        test_no_function:                                            OK
        test_no_macro_remains:                                       OK
    TestSubSimple:
        test_strip_multiple_acquires:                                OK
        test_sub_count_parameter:                                    OK
        test_sub_mixed_placeholders:                                 OK
        test_sub_multiple_placeholders:                              OK
        test_sub_no_placeholder:                                     OK
        test_sub_single_placeholder:                                 OK
        test_sub_with_capture:                                       OK
        test_sub_zero_placeholder:                                   OK
    TestSubWithLocalXforms:
        test_functions_with_acquires_and_releases:                   OK
        test_raw_struct_group:                                       OK
        test_raw_struct_group_tagged:                                OK
        test_struct_group:                                           OK
        test_struct_group_attr:                                      OK
        test_struct_group_tagged_with_private:                       OK
        test_struct_kcov:                                            OK
        test_vars_stackdepot:                                        OK

  test_tokenizer:
    TestPublicPrivate:
        test_balanced_inner_private:                                 OK
        test_balanced_non_greddy_private:                            OK
        test_balanced_private:                                       OK
        test_no private:                                             OK
        test_unbalanced_inner_private:                               OK
        test_unbalanced_private:                                     OK
        test_unbalanced_struct_group_tagged_with_private:            OK
        test_unbalanced_two_struct_group_tagged_first_with_private:  OK
        test_unbalanced_without_end_of_line:                         OK
    TestTokenizer:
        test_basic_tokens:                                           OK
        test_depth_counters:                                         OK
        test_mismatch_error:                                         OK

  Ran 45 tests


PS.: This series contain the contents of the previous /8 series:
    https://lore.kernel.org/linux-doc/cover.1773074166.git.mchehab+huawei@kernel.org/

Mauro Carvalho Chehab (20):
  docs: python: add helpers to run unit tests
  unittests: add a testbench to check public/private kdoc comments
  docs: kdoc: don't add broken comments inside prototypes
  docs: kdoc: properly handle empty enum arguments
  docs: kdoc_re: add a C tokenizer
  docs: kdoc: use tokenizer to handle comments on structs
  docs: kdoc: move C Tokenizer to c_lex module
  unittests: test_private: modify it to use CTokenizer directly
  unittests: test_tokenizer: check if the tokenizer works
  unittests: add a runner to execute all unittests
  docs: kdoc: create a CMatch to match nested C blocks
  tools: unittests: add tests for CMatch
  docs: c_lex: properly implement a sub() method for CMatch
  unittests: test_cmatch: add tests for sub()
  docs: kdoc: replace NestedMatch with CMatch
  docs: kdoc_re: get rid of NestedMatch class
  docs: xforms_lists: handle struct_group directly
  docs: xforms_lists: better evaluate struct_group macros
  docs: c_lex: add support to work with pure name ids
  docs: xforms_lists: use CMatch for all identifiers

 Documentation/tools/python.rst        |   2 +
 Documentation/tools/unittest.rst      |  24 +
 tools/lib/python/kdoc/c_lex.py        | 593 +++++++++++++++++++
 tools/lib/python/kdoc/kdoc_parser.py  |  26 +-
 tools/lib/python/kdoc/kdoc_re.py      | 201 -------
 tools/lib/python/kdoc/xforms_lists.py | 209 +++----
 tools/lib/python/unittest_helper.py   | 353 +++++++++++
 tools/unittests/run.py                |  17 +
 tools/unittests/test_cmatch.py        | 812 ++++++++++++++++++++++++++
 tools/unittests/test_tokenizer.py     | 461 +++++++++++++++
 10 files changed, 2366 insertions(+), 332 deletions(-)
 create mode 100644 Documentation/tools/unittest.rst
 create mode 100644 tools/lib/python/kdoc/c_lex.py
 create mode 100755 tools/lib/python/unittest_helper.py
 create mode 100755 tools/unittests/run.py
 create mode 100755 tools/unittests/test_cmatch.py
 create mode 100755 tools/unittests/test_tokenizer.py

-- 
2.53.0

