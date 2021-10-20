Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3BC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B7C610EA
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 17:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJTR02 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:26:28 -0400
Received: from verein.lst.de ([213.95.11.211]:42982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhJTR01 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 13:26:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12F2D68BEB; Wed, 20 Oct 2021 19:24:11 +0200 (CEST)
Date:   Wed, 20 Oct 2021 19:24:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Len Baker <len.baker@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Message-ID: <20211020172410.GB4167@lst.de>
References: <20211017095650.3718-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017095650.3718-1-len.baker@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Thanks,

applied to nvme-5.16.
