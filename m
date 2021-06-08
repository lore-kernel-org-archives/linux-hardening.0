Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E71C47082
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Jun 2021 16:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3BF6127A
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Jun 2021 16:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhFHQ7f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:59:35 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:57276 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhFHQ7f (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Jun 2021 12:59:35 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 12:59:34 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2237F20002B;
        Tue,  8 Jun 2021 16:52:20 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 64253210DA; Tue,  8 Jun 2021 18:50:56 +0200 (CEST)
Date:   Tue, 8 Jun 2021 18:50:56 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     keescook@chromium.org, andreyknvl@google.com
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, glider@google.com, vbabka@suse.cz
Subject: regresion v5.13-rc1+ - page_poison broken since 51cba1ebc60d
Message-ID: <YL+f8LKmLOb4iSeq@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees, Andrey,

a "git bisect" points to commit 51cba1ebc60d ("init_on_alloc: Optimize
static branches") as breaking page poisoning ("page_poison=on"). Starting
with this commit, booting -- with this option enabled on the kernel command
line -- hangs quite early, before anything meaningful is printed. Booting
51cba1ebc60d without this option proceeds just fine.

Since 1bb5eab30d68 ("kasan, mm: integrate page_alloc init with HW_TAGS") the
behaviour becomes different: Since that commit, booting with
"page_poison=on" and "slub_debug=P" continues up to the initramfs
stage, but then fails quite spectacularly with a large number of page
poisonings being reported.

While "page_poision=on slub_debug=P" doesn't seem to be necessary any longer
if CONFIG_INIT_ON_ALLOC_DEFAULT_ON and CONFIG_INIT_ON_FREE_DEFAULT_ON are
enabled[*], this still looks like a regression.

Thanks,
	Dominik

[*] https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings
