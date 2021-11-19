Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF23C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 06:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C802610A0
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 06:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhKSGMW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Nov 2021 01:12:22 -0500
Received: from verein.lst.de ([213.95.11.211]:49923 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhKSGMU (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Nov 2021 01:12:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C8F5668AFE; Fri, 19 Nov 2021 07:09:15 +0100 (CET)
Date:   Fri, 19 Nov 2021 07:09:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use "%lu" to format unsigned long
Message-ID: <20211119060915.GB15001@lst.de>
References: <20211118182621.1280983-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118182621.1280983-1-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
