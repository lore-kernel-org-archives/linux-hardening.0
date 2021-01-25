Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC9C433DB
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 05:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979FF2223D
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Jan 2021 05:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbhAZFvm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbhAYMq6 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Jan 2021 07:46:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE3B322AAC;
        Mon, 25 Jan 2021 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611578774;
        bh=ls2cUHUbFUJZ5qjE5yPv0cWaPnFNVfjXn2kCI4yqF5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbt1781s8CYoMRuC3iRVY6S4Q8wyRMTGTV/uVaSH7xGTA7Sq50aR1Da+j0THyPwEN
         Lg/0vj9dgK/avaAqitMt7Qm3UQOBJe+fq8hL4781KwCvL0cW7we0f3l+LFO7hQ1MQ/
         Z1nuF1wO4CSzefOqzW9XkBzBbo/NcEQ6DRit4gPwwM+evLGoJk5uys201GYs72UuX8
         bOjzG5u/qjzWyf5WRdsybXJqkQ5QLrn5/8SByNFyiQ+VESNfqoNWsl04qhOXx1LKoW
         MM8LtQuNmCYfsCfwuFq46hHJJQlDsHsCspe8R+3y+6PI7RoPQGC9mSCq4sHqy2DUT5
         arOSNYiKNVM2A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [RFC 2/3] drivers/base: build kunit tests without structleak plugin
Date:   Mon, 25 Jan 2021 13:45:27 +0100
Message-Id: <20210125124533.101339-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125124533.101339-1-arnd@kernel.org>
References: <20210125124533.101339-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The structleak plugin causes the stack frame size to grow immensely:

drivers/base/test/property-entry-test.c: In function 'pe_test_reference':
drivers/base/test/property-entry-test.c:481:1: error: the frame size of 2640 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
  481 | }
      | ^
drivers/base/test/property-entry-test.c: In function 'pe_test_uints':
drivers/base/test/property-entry-test.c:99:1: error: the frame size of 2592 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/test/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 3ca56367c84b..2f15fae8625f 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
 
 obj-$(CONFIG_KUNIT_DRIVER_PE_TEST) += property-entry-test.o
+CFLAGS_REMOVE_property-entry-test.o += -fplugin-arg-structleak_plugin-byref -fplugin-arg-structleak_plugin-byref-all
-- 
2.29.2

