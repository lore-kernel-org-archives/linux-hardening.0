Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2702C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Sep 2021 17:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6294603E7
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Sep 2021 17:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbhIMRlP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:15 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51319 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbhIMRlH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:07 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9065440005;
        Mon, 13 Sep 2021 17:39:49 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Len Baker <len.baker@gmx.com>, Nicolas Pitre <npitre@baylibre.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i3c@lists.infradead.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Prefer struct_size over open coded arithmetic
Date:   Mon, 13 Sep 2021 19:39:45 +0200
Message-Id: <163155475974.409020.647490102226402116.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210905144054.5124-1-len.baker@gmx.com>
References: <20210905144054.5124-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, 5 Sep 2021 16:40:54 +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> [...]

Applied, thanks!

[1/1] i3c/master/mipi-i3c-hci: Prefer struct_size over open coded arithmetic
      commit: 605fa23646dd9a86c4300e1719542a865111d1b6

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
