Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A43CC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 06:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3306F60E8C
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Oct 2021 06:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhJ0GKH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Oct 2021 02:10:07 -0400
Received: from verein.lst.de ([213.95.11.211]:36369 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238354AbhJ0GKH (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Oct 2021 02:10:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 49CDB67373; Wed, 27 Oct 2021 08:07:40 +0200 (CEST)
Date:   Wed, 27 Oct 2021 08:07:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Len Baker <len.baker@gmx.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over
 open coded arithmetic
Message-ID: <20211027060740.GB9949@lst.de>
References: <20211024172921.4110-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024172921.4110-1-len.baker@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks,

applied to nvme-5.16 with a fixed up subject.
