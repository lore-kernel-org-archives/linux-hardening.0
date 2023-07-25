Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25AC0015E
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jul 2023 21:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGYVZb (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGYVZb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jul 2023 17:25:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFB1FE3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jul 2023 14:25:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840ea40c59so24833217b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jul 2023 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690320328; x=1690925128;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BncUN+zxsP5jL5qBPBFJiIzgW7UOfc4w8KYyzj3ScI=;
        b=QnwBoAOnhYZ7R8UVvGHqcCPy1vPb+326cnbSsoW+eyzwAp1kyyFf2dWTCh301GsO0y
         eg+XQAfZkVmwh7hK6uLYgDQXtcr3qALDorbc86Num/iM/d2mLNdAQVjatQQu27QuonEO
         cHfDnO2FbYZUE5OwnTdjqTEsLvU1hpYSn1HdstuDvGnRToxW3zkg28CYdnVeus/tCktl
         6nobV9L7yp7kfcq6xUDOq+zY4y3mD6u+KNDo+fKe0d41z7vbUppES+YSVmdNl+z8A5a2
         Nkek+41sNJ6KZZPX43KtYO55nZvg0qAiKUVJ8VP2v2eIVQPJR8pKlMOclG5wqFGBdItB
         kpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320328; x=1690925128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BncUN+zxsP5jL5qBPBFJiIzgW7UOfc4w8KYyzj3ScI=;
        b=RDb7ZW5fsOTYrxQRhSGGVF53SIlT81XaKIBbVTXhal7+6Dm/Pj7qhuTBPoxDwqlbMp
         yHaSWPKobn7F+wAYfOTOGZXwzQ8ZbdqOnMv6Ontzh0OH7kIOemIF42vEVkp9si6kBoIM
         n5PhngDSEvdkDj+pa5LxXHhJuebPR9rtzUAGLcGKM0LRF/oPnYYaICAUCDjYqgx+uBVa
         Np6AVEHKl106A129hzQWV2UMKEZJZEWu/BpARAIOuEuIu6jphF9jph9Q9nPMx8wFbGgD
         jVlftfMER2OQQu+0hBb23tfL8kfVjs0Gh8Toyo7zSUBEAVqPk5u+nC8Gw8uUmjNJK5/5
         e+AA==
X-Gm-Message-State: ABy/qLaNAnUdsjiFACrvS/6H6tntoVXfKFcbstNnQ9fcSGQhY1aS6KWT
        d0AleJfzNHm3kGc8vnJ+7SROFX290Q==
X-Google-Smtp-Source: APBJJlGjCCMA10e7CahKn3Uv2jbrI8fZUrnzONQDvt/eO6t0mDZDvfZsl4xMumEZoLlH9NnSSYnocYkdkA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:b71d:0:b0:579:e379:d5ab with SMTP id
 v29-20020a81b71d000000b00579e379d5abmr3453ywh.6.1690320328318; Tue, 25 Jul
 2023 14:25:28 -0700 (PDT)
Date:   Tue, 25 Jul 2023 21:25:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725212522.1622716-1-rmoar@google.com>
Subject: [PATCH v3 0/9] kunit: Add test attributes API
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello everyone,

This patch series adds a test attributes framework to KUnit.

There has been interest in filtering out "slow" KUnit tests. Most notably,
a new config, CONFIG_MEMCPY_SLOW_KUNIT_TEST, has been added to exclude a
particularly slow memcpy test
(https://lore.kernel.org/all/20230118200653.give.574-kees@kernel.org/).

This attributes framework can be used to save and access test associated
data, including whether a test is slow. These attributes are reportable
(via KTAP and command line output) and are also filterable.

This framework is designed to allow for the addition of other attributes in
the future. These attributes could include whether the test can be run
concurrently, test file path, etc.

To try out the framework I suggest running:
"./tools/testing/kunit/kunit.py run --filter speed!=slow"

This patch series was originally sent out as an RFC. Here is a link to the
RFC v2:
https://lore.kernel.org/all/20230707210947.1208717-1-rmoar@google.com/

Thanks!
Rae

Rae Moar (9):
  kunit: Add test attributes API structure
  kunit: Add speed attribute
  kunit: Add module attribute
  kunit: Add ability to filter attributes
  kunit: tool: Add command line interface to filter and report
    attributes
  kunit: memcpy: Mark tests as slow using test attributes
  kunit: time: Mark test as slow using test attributes
  kunit: add tests for filtering attributes
  kunit: Add documentation of KUnit test attributes

 Documentation/dev-tools/kunit/run_wrapper.rst |  12 +
 .../dev-tools/kunit/running_tips.rst          | 166 +++++++
 include/kunit/attributes.h                    |  50 +++
 include/kunit/test.h                          |  70 ++-
 kernel/time/time_test.c                       |   2 +-
 lib/Kconfig.debug                             |   3 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/attributes.c                        | 418 ++++++++++++++++++
 lib/kunit/executor.c                          | 114 ++++-
 lib/kunit/executor_test.c                     | 128 +++++-
 lib/kunit/kunit-example-test.c                |   9 +
 lib/kunit/test.c                              |  27 +-
 lib/memcpy_kunit.c                            |   8 +-
 tools/testing/kunit/kunit.py                  |  70 ++-
 tools/testing/kunit/kunit_kernel.py           |   8 +-
 tools/testing/kunit/kunit_parser.py           |  11 +-
 tools/testing/kunit/kunit_tool_test.py        |  39 +-
 17 files changed, 1062 insertions(+), 76 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
-- 
2.41.0.487.g6d72f3e995-goog

