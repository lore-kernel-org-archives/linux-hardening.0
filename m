Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C99AC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5A561215
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJTVUL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhJTVUK (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 17:20:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FD43611ED;
        Wed, 20 Oct 2021 21:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634764675;
        bh=BnQTxtojjF/PTz3YMCCVZw9gPu66dJaMnfuhU/HD+pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgQtmmh1C7pd8EbySWe2vnurHbf5JFmTikQiLDgJjl0t3NdveIGTduAAHpVYzSdZV
         44MyNK0Fq6HD5GDxfjUD0qaSaLcBC3RD1FWA3Bpst9xFJ6x26l+WrF/Za3wETOmbKA
         w6tuCEZvFOmGiddpmWdwNqp3RU3MxK9xDECgyINQ=
Date:   Wed, 20 Oct 2021 14:17:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kasan: test: Consolidate workarounds for unwanted
 __alloc_size() protection
Message-Id: <20211020141753.6d1ac5ef251367bef260a3fc@linux-foundation.org>
In-Reply-To: <20211020193807.40684-1-keescook@chromium.org>
References: <20211020193807.40684-1-keescook@chromium.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 20 Oct 2021 12:38:07 -0700 Kees Cook <keescook@chromium.org> wrote:

> This fixes kasan-test-use-underlying-string-helpers.patch to avoid needing
> new helpers. As done in kasan-test-bypass-__alloc_size-checks.patch,
> just use OPTIMIZER_HIDE_VAR(). Additionally converts a use of
> "volatile", which was trying to work around similar detection.
> 
> ...
> 
> Can you please collapse this into your series?

Folding it into something else is messy, due to dependencies and
ordering/timing issues.  I queued it as a standalone thing.

