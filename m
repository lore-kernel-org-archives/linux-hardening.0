Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2BC00528
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Jul 2023 16:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGXQa1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjGXQa0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Jul 2023 12:30:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE41712
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jul 2023 09:30:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cab7304dcccso5243532276.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jul 2023 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690216213; x=1690821013;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ELz6+MdFAwylMEzq57vnQLUyST7xKxQ3gFrQ4xet5oM=;
        b=BOuKpo28jYR0TEsF3UqCk6b9rkYbObdDcsJIOPy/T5B3QW/fTsV1V8pg6UsKAp4Auo
         tQct2po9F1GYuWOrgrBX78Slhb4boeo9R1H3dcxBBt+xbxgxQufkI15lvoAhW7QJQVNz
         Xgia7i3xcvOY3ceFl81PRkxmOsUXlox/ekcVwcgziBVgmT6X7s5nGzAvmvGIb5dBkCxF
         KeUOX5jQ+XsFJw9zhr7bi9viIsgkG6z0azx3U9Rle9Ndlf94FNikuAu1pMGMlKIE1AZL
         lRX/qFVIc5qxRf67DfVMy4hc5JXkD+OMHwpYJWInYQdyiJByR8eqL45UQemqnuPEN8r/
         TC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690216213; x=1690821013;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELz6+MdFAwylMEzq57vnQLUyST7xKxQ3gFrQ4xet5oM=;
        b=IJSFHsT6epBOLGnwk3on4VBzZcd6GatHeWTeGbx/Mlj22wqWGx+ywfp4DAsRQAgij8
         +vS+x5St5D/OUJy7sWGJP5Az4b1IsQRGO7g1tb97j+5isK5iezlv5fSnWxdrI9VGD5SK
         sc8DhyojGVPo67TxdQxhoAGtlYzJyXKlR4UqpNKTNDCSR+MIHhi2+vn+MJ1x+nympsoH
         w56yFPGJcJ7JgtjTLoMMuyZokNpce4jtcEX5HLkJ9p2gP1dUEQGgkY99P5RrJKIHUP1Q
         S+4CKB8D2fVFs98IBvbe+bgflNYsk5YJZ5ibEHyoc/TJNdJQTpMOaQXsHNl1DjqJU+v+
         EQNw==
X-Gm-Message-State: ABy/qLYZvkbfIUGNA22Mc4bQt+oM+q20O6oFuf42N79BRZzT1zuq2zfm
        oxV8SLjM6WbabPDjqZs0iIMH9ZAJEQ==
X-Google-Smtp-Source: APBJJlGtp5p2K9FdBn6pyk++nPqX3JkC9EH97uae7sq/bwcn6aiUH2AEtN05a6P4phxsPwUGKKlDDw6pbg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:d887:0:b0:d12:d6e4:a08d with SMTP id
 p129-20020a25d887000000b00d12d6e4a08dmr12086ybg.7.1690216213261; Mon, 24 Jul
 2023 09:30:13 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:28:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230724162834.1354164-1-rmoar@google.com>
Subject: [PATCH v2 0/9] kunit: Add test attributes API
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

 .../dev-tools/kunit/running_tips.rst          | 166 +++++++
 include/kunit/attributes.h                    |  50 +++
 include/kunit/test.h                          |  70 ++-
 kernel/time/time_test.c                       |   2 +-
 lib/Kconfig.debug                             |   3 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/attributes.c                        | 418 ++++++++++++++++++
 lib/kunit/executor.c                          | 115 ++++-
 lib/kunit/executor_test.c                     | 128 +++++-
 lib/kunit/kunit-example-test.c                |   9 +
 lib/kunit/test.c                              |  27 +-
 lib/memcpy_kunit.c                            |   8 +-
 tools/testing/kunit/kunit.py                  |  70 ++-
 tools/testing/kunit/kunit_kernel.py           |   8 +-
 tools/testing/kunit/kunit_parser.py           |  11 +-
 tools/testing/kunit/kunit_tool_test.py        |  39 +-
 16 files changed, 1051 insertions(+), 76 deletions(-)
 create mode 100644 include/kunit/attributes.h
 create mode 100644 lib/kunit/attributes.c


base-commit: 64bd4641310c41a1ecf07c13c67bc0ed61045dfd
-- 
2.41.0.487.g6d72f3e995-goog

