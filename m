Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2775C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Sep 2021 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839DF603E7
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Sep 2021 17:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbhIMRlM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Sep 2021 13:41:12 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59631 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbhIMRlE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Sep 2021 13:41:04 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B1470100008;
        Mon, 13 Sep 2021 17:39:46 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Len Baker <len.baker@gmx.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-i3c@lists.infradead.org, linux-hardening@vger.kernel.org,
        Nicolas Pitre <npitre@baylibre.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Prefer kcalloc over open coded arithmetic
Date:   Mon, 13 Sep 2021 19:39:44 +0200
Message-Id: <163155475974.409020.13481298120131222771.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210912155135.7541-1-len.baker@gmx.com>
References: <20210912155135.7541-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, 12 Sep 2021 17:51:35 +0200, Len Baker wrote:
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

[1/1] i3c/master/mipi-i3c-hci: Prefer kcalloc over open coded arithmetic
      commit: 41a0430dd5ca65afdecf10fb0b8b56966a1c5d04

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
