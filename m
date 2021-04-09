Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FFDC433B4
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Apr 2021 07:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656E961105
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Apr 2021 07:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhDIHGt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:06:49 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.184]:30496 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231630AbhDIHGs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Apr 2021 03:06:48 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id ADD85E3D0C
        for <linux-hardening@vger.kernel.org>; Fri,  9 Apr 2021 02:06:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UlDulhKQM1cHeUlDulzDVI; Fri, 09 Apr 2021 02:06:34 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZRMcAGIPe1obJeBFs7JR9SCZ2PVn57pZPNClY3bv/8Y=; b=mFranNtuXSEBHSxKXXsC/vXZyD
        atnFGkfWxpfVTLPgODZM/MkyHFVWXcEjEQlDc0Jm+karysjAa9VZp2TgOfpyyu+x6hV/fEIT+qcBo
        9Hcok7mgnj2dIdwQW70q12GoBfXLL6bweJFWhf+nhZcK13hZdArS16Qpyv2yyQpHiSNJpHCp5OM6Q
        namqHXLVZBzxlDVfZGMhZQufUQvbA8rF90NUs4ddYtDWLmF0lrxSs7f2v9dmwPRW3tWAXpLXfGvZT
        iivzAiw3ycK6UMPbGYBJQB51eYc+9VIfcsDIPm5zZM/8UGzHOKu+3b173/HnPQu0krRUNd+nnKNLc
        ForhfLPQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:35400 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lUlDu-000jql-A7; Fri, 09 Apr 2021 02:06:34 -0500
Subject: Re: [PATCH][next] cifs: cifspdu.h: Replace one-element array with
 flexible-array member
To:     Steve French <smfrench@gmail.com>
Cc:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <20210326011117.GA46303@embeddedor> <877dltrjue.fsf@suse.com>
 <4def044f-4529-9e73-6d01-1a9751f6b09a@embeddedor.com>
 <CAH2r5muf-y5XDyickz9mEw7kTVSjKvK+4AspSPsySbY9ucix8w@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <732771c5-ab43-ad02-4a34-ef21bf5e8e69@embeddedor.com>
Date:   Fri, 9 Apr 2021 02:06:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAH2r5muf-y5XDyickz9mEw7kTVSjKvK+4AspSPsySbY9ucix8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lUlDu-000jql-A7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:35400
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 4/8/21 23:23, Steve French wrote:
> merged into cifs-2.6.git for-next

Great. :)

Thanks, Steve.

--
Gustavo
