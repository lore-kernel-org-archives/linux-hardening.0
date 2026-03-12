Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E28372682;
	Thu, 12 Mar 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327297; cv=none; b=C48S1BMqDu3ZK+20XX/lFFFU/dqPDgNCOH0kB7S2uXXp1zWnYxBrCdXoW2634iixeVVcf17V+ahse7jMKdrOputtqWLGFYoSvVluwU2uqP0yrPhdu8QIkAEtw4zCH6V+JVUtoDjYexbGCZpRdsRxP3DCZ3Lq9GSVskt9XhcqIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327297; c=relaxed/simple;
	bh=VSfYVp9xilRiuMSqrxNUFgW7u9agCGt6O81gwpRuu04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfaEkSKne1GQzgE1xYnwbAJykNfLpb3U1euM1qxyYHCM9mciXVFUD8rnjnN9TKI0guAF6MywN0agWmWQcmO1KAkgABgdf9luPaJLQR88fdYckuPuUtOFtvICu76g6hGidRMMCYvIYO3HQ4F3xr8NY2cd+AuyorlJHlvDIuCbngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR1Np9P/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR1Np9P/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED63C4CEF7;
	Thu, 12 Mar 2026 14:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327297;
	bh=VSfYVp9xilRiuMSqrxNUFgW7u9agCGt6O81gwpRuu04=;
	h=From:To:Cc:Subject:Date:From;
	b=AR1Np9P/0JhRG/i5LoUBKkRWVeYMC1sd1duc0h3Jr09IYcy/tb2OBRHXlE+q6tLRZ
	 7aA4ZkEy+88x5SdHyr6/jPjbjdRzPrdZK0+F7Aqq0hyE50IWG5EhPYMuTFODWW73mt
	 qwlVqWDIxcmP3C4JqtLfmsAT7aTdzsAy2WwFzdgLsCeAhiWz5Pwku1FkHoeZB8V799
	 ffCgPlaIhYF0qRFGy2XAYEaPQ6KOkfCguIZvtiWQXEKvDVnqRqO3KdnLsxL7e4S0N3
	 mijnzCj3DpT78Rwc8VH+6XkhXJnmEZxfoIdmjlD9dv2YtMp3uboFWsYBZ6sAhqH9i8
	 MR1EO1KAxZ15w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hR9-00000008xkj-0zd3;
	Thu, 12 Mar 2026 15:54:55 +0100
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 00/28] kernel-doc: use a C lexical tokenizer for transforms
Date: Thu, 12 Mar 2026 15:54:20 +0100
Message-ID: <cover.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
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

Sorry for respamming this one too quick. It ends that v1 had some
bugs causing it to fail on several cases. I opted to add extra
patches in the end. This way, it better integrates with kdoc_re.
As part of it, now c_lex will output file name when reporting
errors. With that regards, only more serious errors will raise
an exception. They are meant to indicate problems at kernel-doc
itself. Parsing errors are now using the same warning approach
as kdoc_parser.

I also added a filter at Ctokenizer __str__() logic for the
string convertion to drop some weirdness whitespaces and uneeded
";" characters at the output.

Finally, v2 address the undefined behavior about private: comment
propagation.

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

  $ tools/unittests/run.py
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
          test_rise_early_greedy:                                      OK
          test_rise_multiple_greedy:                                   OK
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
  
  
  Ran 47 tests

PS.: This series contain the contents of the previous /8 series:
    https://lore.kernel.org/linux-doc/cover.1773074166.git.mchehab+huawei@kernel.org/

---

v2:
  - Added 8 more patches fixing several bugs and modifying unittests
    accordingly:
    - don't raise exceptions when not needed;
    - don't report errors reporting lack of END if there's no BEGIN
      at the last replacement string;
    - document private scope propagation;
    - some changes at unittests to reflect current status;
    - addition of two unittests to check error raise logic at c_lex.

Mauro Carvalho Chehab (28):
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
  docs: c_lex: add "@" operator
  docs: c_lex: don't exclude an extra token
  docs: c_lex: setup a logger to report tokenizer issues
  docs: unittests: add and adjust tests to check for errors
  docs: c_lex: better handle BEGIN/END at search
  docs: kernel-doc.rst: document private: scope propagation
  docs: c_lex: produce a cleaner str() representation
  unittests: test_cmatch: remove weird stuff from expected results

 Documentation/doc-guide/kernel-doc.rst |   6 +
 Documentation/tools/python.rst         |   2 +
 Documentation/tools/unittest.rst       |  24 +
 tools/lib/python/kdoc/c_lex.py         | 645 +++++++++++++++++++
 tools/lib/python/kdoc/kdoc_parser.py   |  29 +-
 tools/lib/python/kdoc/kdoc_re.py       | 201 ------
 tools/lib/python/kdoc/xforms_lists.py  | 209 +++----
 tools/lib/python/unittest_helper.py    | 353 +++++++++++
 tools/unittests/run.py                 |  17 +
 tools/unittests/test_cmatch.py         | 821 +++++++++++++++++++++++++
 tools/unittests/test_tokenizer.py      | 462 ++++++++++++++
 11 files changed, 2434 insertions(+), 335 deletions(-)
 create mode 100644 Documentation/tools/unittest.rst
 create mode 100644 tools/lib/python/kdoc/c_lex.py
 create mode 100755 tools/lib/python/unittest_helper.py
 create mode 100755 tools/unittests/run.py
 create mode 100755 tools/unittests/test_cmatch.py
 create mode 100755 tools/unittests/test_tokenizer.py

-- 
2.52.0

