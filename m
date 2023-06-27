Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347BEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Jun 2023 06:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjF0GU7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Jun 2023 02:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjF0GUt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Jun 2023 02:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2768A1BEC;
        Mon, 26 Jun 2023 23:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9682261000;
        Tue, 27 Jun 2023 06:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C20C433C0;
        Tue, 27 Jun 2023 06:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687846846;
        bh=l4sdQVtdskG6Mkgh9MiE5yVwbijeefSmMiWzWt9R8T0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xwjehW9sN/yaLGYTWI0H8PfSePdWqrKHKAjdhM2tfthiD3b0xXOghBzzsZVnHE/s4
         oenOVg/oCpwrUopOhNf8LTDbPifAUKEoCV+tx9RN2fUZ/9SN+VMxMsn+QhOA0uE064
         ofiml2BLNPda9q+YYX1hYS7E38wCMFy2tVVs4KlQ=
Date:   Tue, 27 Jun 2023 08:20:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org,
        William Kennington <wak@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: support pmsg record size larger than kmalloc limitation
Message-ID: <2023062715-eldercare-washed-3c29@gregkh>
References: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jun 26, 2023 at 06:20:29PM -0700, Yuxiao Zhang wrote:
> @@ -730,7 +731,7 @@ static void decompress_record(struct pstore_record *record)
>   return;
> 
>   /* Swap out compressed contents with decompressed contents. */
> - kfree(record->buf);
> + kvfree(record->buf);
>   record->buf = unzipped;
>   record->size = unzipped_len;
>   record->compressed = false;
> @@ -783,7 +784,7 @@ void pstore_get_backend_records(struct pstore_info *psi,

Patch is corrupted and can not be applied at all, please fix up your
email client to not do this.

thanks,

greg k-h
